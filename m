Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B751C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D151C20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D151C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeICVMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeICVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:47 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 452F7CEE;
        Mon,  3 Sep 2018 16:51:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suzuki Poulose <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 3.18 41/56] KVM: arm/arm64: Skip updating PMD entry if no change
Date:   Mon,  3 Sep 2018 18:49:31 +0200
Message-Id: <20180903164926.098664138@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Punit Agrawal <punit.agrawal@arm.com>

commit 86658b819cd0a9aa584cd84453ed268a6f013770 upstream.

Contention on updating a PMD entry by a large number of vcpus can lead
to duplicate work when handling stage 2 page faults. As the page table
update follows the break-before-make requirement of the architecture,
it can lead to repeated refaults due to clearing the entry and
flushing the tlbs.

This problem is more likely when -

* there are large number of vcpus
* the mapping is large block mapping

such as when using PMD hugepages (512MB) with 64k pages.

Fix this by skipping the page table update if there is no change in
the entry being updated.

Cc: stable@vger.kernel.org
Fixes: ad361f093c1e ("KVM: ARM: Support hugetlbfs backed huge pages")
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm/kvm/mmu.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -841,19 +841,35 @@ static int stage2_set_pmd_huge(struct kv
 	pmd = stage2_get_pmd(kvm, cache, addr);
 	VM_BUG_ON(!pmd);
 
-	/*
-	 * Mapping in huge pages should only happen through a fault.  If a
-	 * page is merged into a transparent huge page, the individual
-	 * subpages of that huge page should be unmapped through MMU
-	 * notifiers before we get here.
-	 *
-	 * Merging of CompoundPages is not supported; they should become
-	 * splitting first, unmapped, merged, and mapped back in on-demand.
-	 */
-	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
-
 	old_pmd = *pmd;
 	if (pmd_present(old_pmd)) {
+		/*
+		 * Multiple vcpus faulting on the same PMD entry, can
+		 * lead to them sequentially updating the PMD with the
+		 * same value. Following the break-before-make
+		 * (pmd_clear() followed by tlb_flush()) process can
+		 * hinder forward progress due to refaults generated
+		 * on missing translations.
+		 *
+		 * Skip updating the page table if the entry is
+		 * unchanged.
+		 */
+		if (pmd_val(old_pmd) == pmd_val(*new_pmd))
+			return 0;
+
+		/*
+		 * Mapping in huge pages should only happen through a
+		 * fault.  If a page is merged into a transparent huge
+		 * page, the individual subpages of that huge page
+		 * should be unmapped through MMU notifiers before we
+		 * get here.
+		 *
+		 * Merging of CompoundPages is not supported; they
+		 * should become splitting first, unmapped, merged,
+		 * and mapped back in on-demand.
+		 */
+		VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
+
 		pmd_clear(pmd);
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {


