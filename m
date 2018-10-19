Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E1ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A8121470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A8121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJTALi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeJTALh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D10E30014A1;
        Fri, 19 Oct 2018 16:04:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-124-217.rdu2.redhat.com [10.10.124.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D2465949;
        Fri, 19 Oct 2018 16:04:52 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 5/6] mm/hmm: use a structure for update callback parameters v2
Date:   Fri, 19 Oct 2018 12:04:41 -0400
Message-Id: <20181019160442.18723-6-jglisse@redhat.com>
In-Reply-To: <20181019160442.18723-1-jglisse@redhat.com>
References: <20181019160442.18723-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 19 Oct 2018 16:04:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Use a structure to gather all the parameters for the update callback.
This make it easier when adding new parameters by avoiding having to
update all callback function signature.

The hmm_update structure is always associated with a mmu_notifier
callbacks so we are not planing on grouping multiple updates together.
Nor do we care about page size for the range as range will over fully
cover the page being invalidated (this is a mmu_notifier property).

Changed since v1:
    - support for blockable mmu_notifier flags
    - improved commit log

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h | 31 ++++++++++++++++++++++---------
 mm/hmm.c            | 33 ++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 1ff4bae7ada7..afc04dbbaf2f 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -274,13 +274,28 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
 struct hmm_mirror;
 
 /*
- * enum hmm_update_type - type of update
+ * enum hmm_update_event - type of update
  * @HMM_UPDATE_INVALIDATE: invalidate range (no indication as to why)
  */
-enum hmm_update_type {
+enum hmm_update_event {
 	HMM_UPDATE_INVALIDATE,
 };
 
+/*
+ * struct hmm_update - HMM update informations for callback
+ *
+ * @start: virtual start address of the range to update
+ * @end: virtual end address of the range to update
+ * @event: event triggering the update (what is happening)
+ * @blockable: can the callback block/sleep ?
+ */
+struct hmm_update {
+	unsigned long start;
+	unsigned long end;
+	enum hmm_update_event event;
+	bool blockable;
+};
+
 /*
  * struct hmm_mirror_ops - HMM mirror device operations callback
  *
@@ -300,9 +315,9 @@ struct hmm_mirror_ops {
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
-	 * @update_type: type of update that occurred to the CPU page table
-	 * @start: virtual start address of the range to update
-	 * @end: virtual end address of the range to update
+	 * @update: update informations (see struct hmm_update)
+	 * Returns: -EAGAIN if update.blockable false and callback need to
+	 *          block, 0 otherwise.
 	 *
 	 * This callback ultimately originates from mmu_notifiers when the CPU
 	 * page table is updated. The device driver must update its page table
@@ -313,10 +328,8 @@ struct hmm_mirror_ops {
 	 * page tables are completely updated (TLBs flushed, etc); this is a
 	 * synchronous call.
 	 */
-	void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-					   enum hmm_update_type update_type,
-					   unsigned long start,
-					   unsigned long end);
+	int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
+					  const struct hmm_update *update);
 };
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index a7aff319bc5a..0eacf9627bc9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -126,10 +126,8 @@ void hmm_mm_destroy(struct mm_struct *mm)
 	kfree(mm->hmm);
 }
 
-static void hmm_invalidate_range(struct hmm *hmm,
-				 enum hmm_update_type action,
-				 unsigned long start,
-				 unsigned long end)
+static int hmm_invalidate_range(struct hmm *hmm,
+				const struct hmm_update *update)
 {
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
@@ -138,22 +136,30 @@ static void hmm_invalidate_range(struct hmm *hmm,
 	list_for_each_entry(range, &hmm->ranges, list) {
 		unsigned long addr, idx, npages;
 
-		if (end < range->start || start >= range->end)
+		if (update->end < range->start || update->start >= range->end)
 			continue;
 
 		range->valid = false;
-		addr = max(start, range->start);
+		addr = max(update->start, range->start);
 		idx = (addr - range->start) >> PAGE_SHIFT;
-		npages = (min(range->end, end) - addr) >> PAGE_SHIFT;
+		npages = (min(range->end, update->end) - addr) >> PAGE_SHIFT;
 		memset(&range->pfns[idx], 0, sizeof(*range->pfns) * npages);
 	}
 	spin_unlock(&hmm->lock);
 
 	down_read(&hmm->mirrors_sem);
-	list_for_each_entry(mirror, &hmm->mirrors, list)
-		mirror->ops->sync_cpu_device_pagetables(mirror, action,
-							start, end);
+	list_for_each_entry(mirror, &hmm->mirrors, list) {
+		int ret;
+
+		ret = mirror->ops->sync_cpu_device_pagetables(mirror, update);
+		if (!update->blockable && ret == -EAGAIN) {
+			up_read(&hmm->mirrors_sem);
+			return -EAGAIN;
+		}
+	}
 	up_read(&hmm->mirrors_sem);
+
+	return 0;
 }
 
 static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -202,11 +208,16 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 				     unsigned long start,
 				     unsigned long end)
 {
+	struct hmm_update update;
 	struct hmm *hmm = mm->hmm;
 
 	VM_BUG_ON(!hmm);
 
-	hmm_invalidate_range(mm->hmm, HMM_UPDATE_INVALIDATE, start, end);
+	update.start = start;
+	update.end = end;
+	update.event = HMM_UPDATE_INVALIDATE;
+	update.blockable = true;
+	hmm_invalidate_range(hmm, &update);
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
-- 
2.17.2

