Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ADC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DA20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9DA20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJAWdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:33:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51788 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbeJAWdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:33:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ABB918A;
        Mon,  1 Oct 2018 08:55:15 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC16B3F5D3;
        Mon,  1 Oct 2018 08:55:14 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Christoffer Dall <christoffer.dall@arm.com>,
        stable@vger.kernel.org
Subject: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for adjustment
Date:   Mon,  1 Oct 2018 16:54:35 +0100
Message-Id: <20181001155443.23032-2-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181001155443.23032-1-punit.agrawal@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageTransCompoundMap() returns true for hugetlbfs and THP
hugepages. This behaviour incorrectly leads to stage 2 faults for
unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
treated as THP faults.

Tighten the check to filter out hugetlbfs pages. This also leads to
consistently mapping all unsupported hugepage sizes as PTE level
entries at stage 2.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: stable@vger.kernel.org # v4.13+
---
 virt/kvm/arm/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 7e477b3cae5b..c23a1b323aad 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1231,8 +1231,14 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
 {
 	kvm_pfn_t pfn = *pfnp;
 	gfn_t gfn = *ipap >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(pfn);
 
-	if (PageTransCompoundMap(pfn_to_page(pfn))) {
+	/*
+	 * PageTransCompoungMap() returns true for THP and
+	 * hugetlbfs. Make sure the adjustment is done only for THP
+	 * pages.
+	 */
+	if (!PageHuge(page) && PageTransCompoundMap(page)) {
 		unsigned long mask;
 		/*
 		 * The address we faulted on is backed by a transparent huge
-- 
2.18.0

