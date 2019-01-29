Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F9C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4941620989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfA2Qz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:55:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfA2Qym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDFC43DE0E;
        Tue, 29 Jan 2019 16:54:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1FCA103BAB6;
        Tue, 29 Jan 2019 16:54:40 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 03/10] mm/hmm: improve and rename hmm_vma_get_pfns() to hmm_range_snapshot()
Date:   Tue, 29 Jan 2019 11:54:21 -0500
Message-Id: <20190129165428.3931-4-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 16:54:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Rename for consistency between code, comments and documentation. Also
improves the comments on all the possible returns values. Improve the
function by returning the number of populated entries in pfns array.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h |  4 ++--
 mm/hmm.c            | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index bd6e058597a6..ddf49c1b1f5e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -365,11 +365,11 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
  * table invalidation serializes on it.
  *
  * YOU MUST CALL hmm_vma_range_done() ONCE AND ONLY ONCE EACH TIME YOU CALL
- * hmm_vma_get_pfns() WITHOUT ERROR !
+ * hmm_range_snapshot() WITHOUT ERROR !
  *
  * IF YOU DO NOT FOLLOW THE ABOVE RULE THE SNAPSHOT CONTENT MIGHT BE INVALID !
  */
-int hmm_vma_get_pfns(struct hmm_range *range);
+long hmm_range_snapshot(struct hmm_range *range);
 bool hmm_vma_range_done(struct hmm_range *range);
 
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 74d69812d6be..0d9ecd3337e5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -706,23 +706,19 @@ static void hmm_pfns_special(struct hmm_range *range)
 }
 
 /*
- * hmm_vma_get_pfns() - snapshot CPU page table for a range of virtual addresses
- * @range: range being snapshotted
+ * hmm_range_snapshot() - snapshot CPU page table for a range
+ * @range: range
  * Returns: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
- *          vma permission, 0 success
+ *          permission (for instance asking for write and range is read only),
+ *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
+ *          vma or it is illegal to access that range), number of valid pages
+ *          in range->pfns[] (from range start address).
  *
  * This snapshots the CPU page table for a range of virtual addresses. Snapshot
  * validity is tracked by range struct. See hmm_vma_range_done() for further
  * information.
- *
- * The range struct is initialized here. It tracks the CPU page table, but only
- * if the function returns success (0), in which case the caller must then call
- * hmm_vma_range_done() to stop CPU page table update tracking on this range.
- *
- * NOT CALLING hmm_vma_range_done() IF FUNCTION RETURNS 0 WILL LEAD TO SERIOUS
- * MEMORY CORRUPTION ! YOU HAVE BEEN WARNED !
  */
-int hmm_vma_get_pfns(struct hmm_range *range)
+long hmm_range_snapshot(struct hmm_range *range)
 {
 	struct vm_area_struct *vma = range->vma;
 	struct hmm_vma_walk hmm_vma_walk;
@@ -776,6 +772,7 @@ int hmm_vma_get_pfns(struct hmm_range *range)
 	hmm_vma_walk.fault = false;
 	hmm_vma_walk.range = range;
 	mm_walk.private = &hmm_vma_walk;
+	hmm_vma_walk.last = range->start;
 
 	mm_walk.vma = vma;
 	mm_walk.mm = vma->vm_mm;
@@ -792,9 +789,9 @@ int hmm_vma_get_pfns(struct hmm_range *range)
 	 * function return 0).
 	 */
 	range->hmm = hmm;
-	return 0;
+	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
-EXPORT_SYMBOL(hmm_vma_get_pfns);
+EXPORT_SYMBOL(hmm_range_snapshot);
 
 /*
  * hmm_vma_range_done() - stop tracking change to CPU page table over a range
-- 
2.17.2

