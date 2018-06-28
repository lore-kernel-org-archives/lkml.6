Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B8BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422EA27754
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422EA27754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030339AbeF1Ri4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:38:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37060 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967553AbeF1RiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:38:18 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rikyp9sJ7Nb2; Thu, 28 Jun 2018 19:38:16 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD08A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F2651EC03AD;
        Thu, 28 Jun 2018 19:38:16 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] kvm/x86: Move MSR_K7_HWCR to svm.c
Date:   Thu, 28 Jun 2018 19:38:07 +0200
Message-Id: <20180628173808.25885-2-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
In-Reply-To: <20180628173808.25885-1-bp@alien8.de>
References: <20180628173808.25885-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This is an AMD-specific MSR. Put it where it belongs.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kvm/svm.c | 14 ++++++++++++++
 arch/x86/kvm/x86.c | 12 ------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f059a73f0fd0..72e60daf3ab8 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4153,6 +4153,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_F10H_DECFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+	case MSR_K7_HWCR:
+		msr_info->data = 0;
+		break;
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -4357,6 +4360,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->msr_decfg = data;
 		break;
 	}
+	case MSR_K7_HWCR:
+		data &= ~(u64)0x40;	/* ignore flush filter disable */
+		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
+		data &= ~(u64)0x8;	/* ignore TLB cache disable */
+		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
+		if (data != 0) {
+			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
+				    data);
+			return 1;
+		}
+		break;
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa70205a..3bf721c22124 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2317,17 +2317,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
-	case MSR_K7_HWCR:
-		data &= ~(u64)0x40;	/* ignore flush filter disable */
-		data &= ~(u64)0x100;	/* ignore ignne emulation enable */
-		data &= ~(u64)0x8;	/* ignore TLB cache disable */
-		data &= ~(u64)0x40000;  /* ignore Mc status write enable */
-		if (data != 0) {
-			vcpu_unimpl(vcpu, "unimplemented HWCR wrmsr: 0x%llx\n",
-				    data);
-			return 1;
-		}
-		break;
 	case MSR_FAM10H_MMIO_CONF_BASE:
 		if (data != 0) {
 			vcpu_unimpl(vcpu, "unimplemented MMIO_CONF_BASE wrmsr: "
@@ -2597,7 +2586,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_K8_SYSCFG:
 	case MSR_K8_TSEG_ADDR:
 	case MSR_K8_TSEG_MASK:
-	case MSR_K7_HWCR:
 	case MSR_VM_HSAVE_PA:
 	case MSR_K8_INT_PENDING_MSG:
 	case MSR_AMD64_NB_CFG:
-- 
2.17.0.582.gccdcbd54c

