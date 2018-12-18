Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A438A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeLRAeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:34:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbeLRAeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:34:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07439E86E;
        Tue, 18 Dec 2018 00:34:20 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A00608C2;
        Tue, 18 Dec 2018 00:34:19 +0000 (UTC)
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs
Date:   Mon, 17 Dec 2018 22:34:18 -0200
Message-Id: <20181218003418.30144-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 18 Dec 2018 00:34:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some guests OSes (including Windows 10) write to MSR 0xc001102c
on some cases (possibly while trying to apply a CPU errata).
Make KVM ignore reads and writes to that MSR, so the guest won't
crash.

The MSR is documented as "Execution Unit Configuration (EX_CFG)",
at AMD's "BIOS and Kernel Developer's Guide (BKDG) for AMD Family
15h Models 00h-0Fh Processors".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/x86.c               | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c8f73efb4ece..9e39cc8bd989 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -390,6 +390,7 @@
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
 #define MSR_F15H_PTSC			0xc0010280
 #define MSR_F15H_IC_CFG			0xc0011021
+#define MSR_F15H_EX_CFG			0xc001102c
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9cbce3ec84ec..69f822165fe2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2429,6 +2429,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		break;
 
 	case MSR_IA32_UCODE_REV:
@@ -2724,6 +2725,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;
 	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
-- 
2.18.0.rc1.1.g3f1ff2140

