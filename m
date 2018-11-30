Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46869C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1729F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1729F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeK3TRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:50708 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeK3TRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="117325047"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2018 00:08:49 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 65FA3580460;
        Fri, 30 Nov 2018 00:08:47 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 05/11] KVM: VMX: Write the SPPTP to VMCS area.
Date:   Fri, 30 Nov 2018 16:08:32 +0800
Message-Id: <11d0e5ff60c3e0cdac90872217299735e3ca8234.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as EPT page table, We initialized the SPPT,
and write the SPPT point into VMCS field.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/vmx.c         | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 2aa088f..bd4ec8a 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -217,6 +217,8 @@ enum vmcs_field {
 	XSS_EXIT_BITMAP_HIGH            = 0x0000202D,
 	ENCLS_EXITING_BITMAP		= 0x0000202E,
 	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
+	SPPT_POINTER			= 0x00002030,
+	SPPT_POINTER_HIGH		= 0x00002031,
 	TSC_MULTIPLIER                  = 0x00002032,
 	TSC_MULTIPLIER_HIGH             = 0x00002033,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f76d3fb..e96b4c7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -600,6 +600,7 @@ struct __packed vmcs12 {
 	u16 host_gs_selector;
 	u16 host_tr_selector;
 	u16 guest_pml_index;
+	u64 sppt_pointer;
 };
 
 /*
@@ -1158,6 +1159,7 @@ static const unsigned short vmcs_field_to_offset_table[] = {
 	FIELD64(VMREAD_BITMAP, vmread_bitmap),
 	FIELD64(VMWRITE_BITMAP, vmwrite_bitmap),
 	FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
+	FIELD64(SPPT_POINTER, sppt_pointer),
 	FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
 	FIELD64(VMCS_LINK_POINTER, vmcs_link_pointer),
 	FIELD64(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl),
@@ -5348,11 +5350,17 @@ static u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
 	return eptp;
 }
 
+static inline u64 construct_spptp(unsigned long root_hpa)
+{
+	return root_hpa & PAGE_MASK;
+}
+
 static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long guest_cr3;
 	u64 eptp;
+	u64 spptp;
 
 	guest_cr3 = cr3;
 	if (enable_ept) {
@@ -5375,6 +5383,13 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 		ept_load_pdptrs(vcpu);
 	}
 
+	if (vcpu->arch.mmu->sppt_root != INVALID_PAGE &&
+	    enable_ept_spp) {
+		spptp = construct_spptp(vcpu->arch.mmu->sppt_root);
+		vmcs_write64(SPPT_POINTER, spptp);
+		vmx_flush_tlb(vcpu, true);
+	}
+
 	vmcs_writel(GUEST_CR3, guest_cr3);
 }
 
@@ -10505,6 +10520,8 @@ static void dump_vmcs(void)
 		pr_err("PostedIntrVec = 0x%02x\n", vmcs_read16(POSTED_INTR_NV));
 	if ((secondary_exec_control & SECONDARY_EXEC_ENABLE_EPT))
 		pr_err("EPT pointer = 0x%016llx\n", vmcs_read64(EPT_POINTER));
+	if ((secondary_exec_control & SECONDARY_EXEC_ENABLE_SPP))
+		pr_err("SPPT pointer = 0x%016llx\n", vmcs_read64(SPPT_POINTER));
 	n = vmcs_read32(CR3_TARGET_COUNT);
 	for (i = 0; i + 1 < n; i += 4)
 		pr_err("CR3 target%u=%016lx target%u=%016lx\n",
-- 
2.7.4

