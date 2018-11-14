Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7819722360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7819722360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbeKOETi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:19:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43216 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbeKOETh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:19:37 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ifs4bUYlW6Sp; Wed, 14 Nov 2018 19:15:20 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A0DD1EC037D;
        Wed, 14 Nov 2018 19:15:20 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] x86/kvm: Implement MSR_HWCR support
Date:   Wed, 14 Nov 2018 19:15:07 +0100
Message-Id: <20181114181507.6037-3-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114181507.6037-1-bp@alien8.de>
References: <20181114181507.6037-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The hardware configuration register has some useful bits which can be
used by guests. Implement McStatusWrEn which can be used by guests when
injecting MCEs with the in-kernel mce-inject module.

For that, we need to set bit 18 - McStatusWrEn - first, before writing
the MCi_STATUS registers (otherwise we #GP).

Add the required machinery to do so.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kvm/svm.c | 12 +++++++++---
 arch/x86/kvm/x86.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 5c9c26dc7d84..db8e943f7576 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -251,6 +251,9 @@ struct vcpu_svm {
 
 	/* which host CPU was used for running this vcpu */
 	unsigned int last_cpu;
+
+	/* MSRC001_0015 Hardware Configuration */
+	u64 msr_hwcr;
 };
 
 /*
@@ -4155,7 +4158,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = svm->msr_decfg;
 		break;
 	case MSR_K7_HWCR:
-		msr_info->data = 0;
+		msr_info->data = svm->msr_hwcr;
 		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
@@ -4365,8 +4368,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		data &= ~(u64)0x40;	/* ignore flush filter disable */
 		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
 		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
-		if (data != 0) {
+
+		/* Handle McStatusWrEn */
+		if (data == BIT_ULL(18)) {
+			svm->msr_hwcr = data;
+		} else if (data != 0) {
 			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
 				    data);
 			return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9abbe24deb5..607fe883113c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2262,6 +2262,30 @@ static void kvmclock_sync_fn(struct work_struct *work)
 					KVMCLOCK_SYNC_PERIOD);
 }
 
+/*
+ * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
+ */
+static bool __set_mci_status(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	if (guest_cpuid_is_amd(vcpu)) {
+		struct msr_data tmp;
+
+		tmp.index = MSR_K7_HWCR;
+
+		if (kvm_x86_ops->get_msr(vcpu, &tmp))
+			return false;
+
+		/* McStatusWrEn enabled? */
+		if (tmp.data & BIT_ULL(18))
+			return true;
+	}
+
+	if (msr_info->data != 0)
+		return false;
+
+	return true;
+}
+
 static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u64 mcg_cap = vcpu->arch.mcg_cap;
@@ -2293,9 +2317,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			if ((offset & 0x3) == 0 &&
 			    data != 0 && (data | (1 << 10)) != ~(u64)0)
 				return -1;
-			if (!msr_info->host_initiated &&
-				(offset & 0x3) == 1 && data != 0)
-				return -1;
+
+			/* MCi_STATUS */
+			if ((offset & 0x3) == 1 && !msr_info->host_initiated) {
+				if (!__set_mci_status(vcpu, msr_info))
+						return -1;
+			}
+
 			vcpu->arch.mce_banks[offset] = data;
 			break;
 		}
-- 
2.19.1

