Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF3FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931DD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfA2QzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:55:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31941 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfA2Qyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C76D680F79;
        Tue, 29 Jan 2019 16:54:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1EC4102BCEB;
        Tue, 29 Jan 2019 16:54:45 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 06/10] mm/hmm: add default fault flags to avoid the need to pre-fill pfns arrays.
Date:   Tue, 29 Jan 2019 11:54:24 -0500
Message-Id: <20190129165428.3931-7-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 16:54:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

The HMM mirror API can be use in two fashions. The first one where the HMM
user coalesce multiple page faults into one request and set flags per pfns
for of those faults. The second one where the HMM user want to pre-fault a
range with specific flags. For the latter one it is a waste to have the user
pre-fill the pfn arrays with a default flags value.

This patch adds a default flags value allowing user to set them for a range
without having to pre-fill the pfn array.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h |  7 +++++++
 mm/hmm.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 93dc88edc293..4263f8fb32e5 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -165,6 +165,8 @@ enum hmm_pfn_value_e {
  * @pfns: array of pfns (big enough for the range)
  * @flags: pfn flags to match device driver page table
  * @values: pfn value for some special case (none, special, error, ...)
+ * @default_flags: default flags for the range (write, read, ...)
+ * @pfn_flags_mask: allows to mask pfn flags so that only default_flags matter
  * @pfn_shifts: pfn shift value (should be <= PAGE_SHIFT)
  * @valid: pfns array did not change since it has been fill by an HMM function
  */
@@ -177,6 +179,8 @@ struct hmm_range {
 	uint64_t		*pfns;
 	const uint64_t		*flags;
 	const uint64_t		*values;
+	uint64_t		default_flags;
+	uint64_t		pfn_flags_mask;
 	uint8_t			pfn_shift;
 	bool			valid;
 };
@@ -521,6 +525,9 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 {
 	long ret;
 
+	range->default_flags = 0;
+	range->pfn_flags_mask = -1UL;
+
 	ret = hmm_range_register(range, range->vma->vm_mm,
 				 range->start, range->end);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index 860ebe5d4b07..0a4ff31e9d7a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -423,6 +423,18 @@ static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 	if (!hmm_vma_walk->fault)
 		return;
 
+	/*
+	 * So we not only consider the individual per page request we also
+	 * consider the default flags requested for the range. The API can
+	 * be use in 2 fashions. The first one where the HMM user coalesce
+	 * multiple page fault into one request and set flags per pfns for
+	 * of those faults. The second one where the HMM user want to pre-
+	 * fault a range with specific flags. For the latter one it is a
+	 * waste to have the user pre-fill the pfn arrays with a default
+	 * flags value.
+	 */
+	pfns = (pfns & range->pfn_flags_mask) | range->default_flags;
+
 	/* We aren't ask to do anything ... */
 	if (!(pfns & range->flags[HMM_PFN_VALID]))
 		return;
-- 
2.17.2

