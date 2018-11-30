Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBBDC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98832206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98832206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeK3TRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:5240 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:09:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="96176535"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 00:09:06 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 0CA42580460;
        Fri, 30 Nov 2018 00:09:03 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 07/11] KVM: VMX: Added handle of SPP write protection fault.
Date:   Fri, 30 Nov 2018 16:08:48 +0800
Message-Id: <b77f9e8df8c587d78c680ee49d447f56f206de70.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A control bit in EPT leaf paging-structure entries is defined as
“Sub-Page Permission” (SPP bit). The bit position is 61

While hardware walking the SPP page table, If the sub-page
region write permission bit is set, the write is allowed,
else the write is disallowed and results in an EPT violation.

we need peek this case in EPT violation handler, and trigger
a user-space exit, return the write protected address(GPA)
to user(qemu).

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 arch/x86/kvm/mmu.c       | 19 +++++++++++++++++++
 arch/x86/kvm/mmu.h       |  1 +
 include/uapi/linux/kvm.h |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d1f1fe1..d077693 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3378,6 +3378,21 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gva_t gva, int level,
 		if ((error_code & PFERR_WRITE_MASK) &&
 		    spte_can_locklessly_be_made_writable(spte))
 		{
+			/*
+			 * Record write protect fault caused by
+			 * Sub-page Protection
+			 */
+			if (spte & PT_SPP_MASK) {
+				fault_handled = true;
+
+				vcpu->run->exit_reason = KVM_EXIT_SPP;
+				vcpu->run->spp.addr = gva;
+				kvm_skip_emulated_instruction(vcpu);
+
+				/* Let QEMU decide how to handle this. */
+				break;
+			}
+
 			new_spte |= PT_WRITABLE_MASK;
 
 			/*
@@ -5343,6 +5358,10 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 		r = vcpu->arch.mmu->page_fault(vcpu, cr2,
 					       lower_32_bits(error_code),
 					       false);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_SPP)
+			return 0;
+
 		WARN_ON(r == RET_PF_INVALID);
 	}
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b3331..b41e9e9 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -26,6 +26,7 @@
 #define PT_PAGE_SIZE_MASK (1ULL << PT_PAGE_SIZE_SHIFT)
 #define PT_PAT_MASK (1ULL << 7)
 #define PT_GLOBAL_MASK (1ULL << 8)
+#define PT_SPP_MASK (1ULL << 61)
 #define PT64_NX_SHIFT 63
 #define PT64_NX_MASK (1ULL << PT64_NX_SHIFT)
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652..01174f8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -235,6 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_SPP              28
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -390,6 +391,10 @@ struct kvm_run {
 		struct {
 			__u8 vector;
 		} eoi;
+		/* KVM_EXIT_SPP */
+		struct {
+			__u64 addr;
+		} spp;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
 		/* Fix the size of the union. */
-- 
2.7.4

