Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E54C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1820861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F1820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbeIMTQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731264AbeIMTQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42169D3A;
        Thu, 13 Sep 2018 14:06:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.18 194/197] kvm: x86: Set highest physical address bits in non-present/reserved SPTEs
Date:   Thu, 13 Sep 2018 15:32:23 +0200
Message-Id: <20180913131849.318409403@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junaid Shahid <junaids@google.com>

commit 28a1f3ac1d0c8558ee4453d9634dad891a6e922e upstream.

Always set the 5 upper-most supported physical address bits to 1 for SPTEs
that are marked as non-present or reserved, to make them unusable for
L1TF attacks from the guest. Currently, this just applies to MMIO SPTEs.
(We do not need to mark PTEs that are completely 0 as physical page 0
is already reserved.)

This allows mitigation of L1TF without disabling hyper-threading by using
shadow paging mode instead of EPT.

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.c |    8 ++++++--
 2 files changed, 44 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -221,6 +221,17 @@ static const u64 shadow_acc_track_saved_
 						    PT64_EPT_EXECUTABLE_MASK;
 static const u64 shadow_acc_track_saved_bits_shift = PT64_SECOND_AVAIL_BITS_SHIFT;
 
+/*
+ * This mask must be set on all non-zero Non-Present or Reserved SPTEs in order
+ * to guard against L1TF attacks.
+ */
+static u64 __read_mostly shadow_nonpresent_or_rsvd_mask;
+
+/*
+ * The number of high-order 1 bits to use in the mask above.
+ */
+static const u64 shadow_nonpresent_or_rsvd_mask_len = 5;
+
 static void mmu_spte_set(u64 *sptep, u64 spte);
 
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
@@ -308,9 +319,13 @@ static void mark_mmio_spte(struct kvm_vc
 {
 	unsigned int gen = kvm_current_mmio_generation(vcpu);
 	u64 mask = generation_mmio_spte_mask(gen);
+	u64 gpa = gfn << PAGE_SHIFT;
 
 	access &= ACC_WRITE_MASK | ACC_USER_MASK;
-	mask |= shadow_mmio_value | access | gfn << PAGE_SHIFT;
+	mask |= shadow_mmio_value | access;
+	mask |= gpa | shadow_nonpresent_or_rsvd_mask;
+	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
+		<< shadow_nonpresent_or_rsvd_mask_len;
 
 	trace_mark_mmio_spte(sptep, gfn, access, gen);
 	mmu_spte_set(sptep, mask);
@@ -323,8 +338,14 @@ static bool is_mmio_spte(u64 spte)
 
 static gfn_t get_mmio_spte_gfn(u64 spte)
 {
-	u64 mask = generation_mmio_spte_mask(MMIO_GEN_MASK) | shadow_mmio_mask;
-	return (spte & ~mask) >> PAGE_SHIFT;
+	u64 mask = generation_mmio_spte_mask(MMIO_GEN_MASK) | shadow_mmio_mask |
+		   shadow_nonpresent_or_rsvd_mask;
+	u64 gpa = spte & ~mask;
+
+	gpa |= (spte >> shadow_nonpresent_or_rsvd_mask_len)
+	       & shadow_nonpresent_or_rsvd_mask;
+
+	return gpa >> PAGE_SHIFT;
 }
 
 static unsigned get_mmio_spte_access(u64 spte)
@@ -381,7 +402,7 @@ void kvm_mmu_set_mask_ptes(u64 user_mask
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_mask_ptes);
 
-static void kvm_mmu_clear_all_pte_masks(void)
+static void kvm_mmu_reset_all_pte_masks(void)
 {
 	shadow_user_mask = 0;
 	shadow_accessed_mask = 0;
@@ -391,6 +412,18 @@ static void kvm_mmu_clear_all_pte_masks(
 	shadow_mmio_mask = 0;
 	shadow_present_mask = 0;
 	shadow_acc_track_mask = 0;
+
+	/*
+	 * If the CPU has 46 or less physical address bits, then set an
+	 * appropriate mask to guard against L1TF attacks. Otherwise, it is
+	 * assumed that the CPU is not vulnerable to L1TF.
+	 */
+	if (boot_cpu_data.x86_phys_bits <
+	    52 - shadow_nonpresent_or_rsvd_mask_len)
+		shadow_nonpresent_or_rsvd_mask =
+			rsvd_bits(boot_cpu_data.x86_phys_bits -
+				  shadow_nonpresent_or_rsvd_mask_len,
+				  boot_cpu_data.x86_phys_bits - 1);
 }
 
 static int is_cpuid_PSE36(void)
@@ -5500,7 +5533,7 @@ int kvm_mmu_module_init(void)
 {
 	int ret = -ENOMEM;
 
-	kvm_mmu_clear_all_pte_masks();
+	kvm_mmu_reset_all_pte_masks();
 
 	pte_list_desc_cache = kmem_cache_create("pte_list_desc",
 					    sizeof(struct pte_list_desc),
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6506,8 +6506,12 @@ static void kvm_set_mmio_spte_mask(void)
 	 * Set the reserved bits and the present bit of an paging-structure
 	 * entry to generate page fault with PFER.RSV = 1.
 	 */
-	 /* Mask the reserved physical address bits. */
-	mask = rsvd_bits(maxphyaddr, 51);
+
+	/*
+	 * Mask the uppermost physical address bit, which would be reserved as
+	 * long as the supported physical address width is less than 52.
+	 */
+	mask = 1ull << 51;
 
 	/* Set the present bit. */
 	mask |= 1ull;


