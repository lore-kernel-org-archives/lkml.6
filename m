Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D8C677FE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4824121476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiQRFEvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4824121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeJKXOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BE7213A2;
        Thu, 11 Oct 2018 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272786;
        bh=l3stj+o57SubcEgGWasAKfC7PPLWZ/JDfqq8X6Cg06w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiQRFEvvzGaWbrsTsIUqRJazAzCxQuqqvaJiK3XV3yc6G8zMt8zkcfaywJ0CMO587
         rR1jhHaPQpItnXTfW/nzTPxl4Mnuw9f4mavIV2Tyju72YAhb/zb+RJECdX2F08zeQM
         B0G4zJIUWQsQkHqXWQhDgEyr+xaVfRXyrVohdFcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 05/45] KVM: x86: fix L1TFs MMIO GFN calculation
Date:   Thu, 11 Oct 2018 17:39:32 +0200
Message-Id: <20181011152509.092819524@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit daa07cbc9ae3da2d61b7ce900c0b9107d134f2c1 upstream.

One defense against L1TF in KVM is to always set the upper five bits
of the *legal* physical address in the SPTEs for non-present and
reserved SPTEs, e.g. MMIO SPTEs.  In the MMIO case, the GFN of the
MMIO SPTE may overlap with the upper five bits that are being usurped
to defend against L1TF.  To preserve the GFN, the bits of the GFN that
overlap with the repurposed bits are shifted left into the reserved
bits, i.e. the GFN in the SPTE will be split into high and low parts.
When retrieving the GFN from the MMIO SPTE, e.g. to check for an MMIO
access, get_mmio_spte_gfn() unshifts the affected bits and restores
the original GFN for comparison.  Unfortunately, get_mmio_spte_gfn()
neglects to mask off the reserved bits in the SPTE that were used to
store the upper chunk of the GFN.  As a result, KVM fails to detect
MMIO accesses whose GPA overlaps the repurprosed bits, which in turn
causes guest panics and hangs.

Fix the bug by generating a mask that covers the lower chunk of the
GFN, i.e. the bits that aren't shifted by the L1TF mitigation.  The
alternative approach would be to explicitly zero the five reserved
bits that are used to store the upper chunk of the GFN, but that
requires additional run-time computation and makes an already-ugly
bit of code even more inscrutable.

I considered adding a WARN_ON_ONCE(low_phys_bits-1 <= PAGE_SHIFT) to
warn if GENMASK_ULL() generated a nonsensical value, but that seemed
silly since that would mean a system that supports VMX has less than
18 bits of physical address space...

Reported-by: Sakari Ailus <sakari.ailus@iki.fi>
Fixes: d9b47449c1a1 ("kvm: x86: Set highest physical address bits in non-present/reserved SPTEs")
Cc: Junaid Shahid <junaids@google.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Junaid Shahid <junaids@google.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -231,6 +231,17 @@ static u64 __read_mostly shadow_nonprese
  */
 static const u64 shadow_nonpresent_or_rsvd_mask_len = 5;
 
+/*
+ * In some cases, we need to preserve the GFN of a non-present or reserved
+ * SPTE when we usurp the upper five bits of the physical address space to
+ * defend against L1TF, e.g. for MMIO SPTEs.  To preserve the GFN, we'll
+ * shift bits of the GFN that overlap with shadow_nonpresent_or_rsvd_mask
+ * left into the reserved bits, i.e. the GFN in the SPTE will be split into
+ * high and low parts.  This mask covers the lower bits of the GFN.
+ */
+static u64 __read_mostly shadow_nonpresent_or_rsvd_lower_gfn_mask;
+
+
 static void mmu_spte_set(u64 *sptep, u64 spte);
 static void mmu_free_roots(struct kvm_vcpu *vcpu);
 
@@ -338,9 +349,7 @@ static bool is_mmio_spte(u64 spte)
 
 static gfn_t get_mmio_spte_gfn(u64 spte)
 {
-	u64 mask = generation_mmio_spte_mask(MMIO_GEN_MASK) | shadow_mmio_mask |
-		   shadow_nonpresent_or_rsvd_mask;
-	u64 gpa = spte & ~mask;
+	u64 gpa = spte & shadow_nonpresent_or_rsvd_lower_gfn_mask;
 
 	gpa |= (spte >> shadow_nonpresent_or_rsvd_mask_len)
 	       & shadow_nonpresent_or_rsvd_mask;
@@ -404,6 +413,8 @@ EXPORT_SYMBOL_GPL(kvm_mmu_set_mask_ptes)
 
 static void kvm_mmu_reset_all_pte_masks(void)
 {
+	u8 low_phys_bits;
+
 	shadow_user_mask = 0;
 	shadow_accessed_mask = 0;
 	shadow_dirty_mask = 0;
@@ -418,12 +429,17 @@ static void kvm_mmu_reset_all_pte_masks(
 	 * appropriate mask to guard against L1TF attacks. Otherwise, it is
 	 * assumed that the CPU is not vulnerable to L1TF.
 	 */
+	low_phys_bits = boot_cpu_data.x86_phys_bits;
 	if (boot_cpu_data.x86_phys_bits <
-	    52 - shadow_nonpresent_or_rsvd_mask_len)
+	    52 - shadow_nonpresent_or_rsvd_mask_len) {
 		shadow_nonpresent_or_rsvd_mask =
 			rsvd_bits(boot_cpu_data.x86_phys_bits -
 				  shadow_nonpresent_or_rsvd_mask_len,
 				  boot_cpu_data.x86_phys_bits - 1);
+		low_phys_bits -= shadow_nonpresent_or_rsvd_mask_len;
+	}
+	shadow_nonpresent_or_rsvd_lower_gfn_mask =
+		GENMASK_ULL(low_phys_bits - 1, PAGE_SHIFT);
 }
 
 static int is_cpuid_PSE36(void)


