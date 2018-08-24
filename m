Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F1C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FFD2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FFD2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeHXXCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:02:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727355AbeHXXBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBB8E804B9F4;
        Fri, 24 Aug 2018 19:25:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81A972026D6D;
        Fri, 24 Aug 2018 19:25:54 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 5/7] mm/hmm: use a structure for update callback parameters
Date:   Fri, 24 Aug 2018 15:25:47 -0400
Message-Id: <20180824192549.30844-6-jglisse@redhat.com>
In-Reply-To: <20180824192549.30844-1-jglisse@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 19:25:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 19:25:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Use a structure to gather all the parameters for the update callback.
This make it easier when adding new parameters by avoiding having to
update all callback function signature.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h | 25 +++++++++++++++++--------
 mm/hmm.c            | 27 ++++++++++++++-------------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 1ff4bae7ada7..a7f7600b6bb0 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -274,13 +274,26 @@ static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
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
+ */
+struct hmm_update {
+	unsigned long start;
+	unsigned long end;
+	enum hmm_update_event event;
+};
+
 /*
  * struct hmm_mirror_ops - HMM mirror device operations callback
  *
@@ -300,9 +313,7 @@ struct hmm_mirror_ops {
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
-	 * @update_type: type of update that occurred to the CPU page table
-	 * @start: virtual start address of the range to update
-	 * @end: virtual end address of the range to update
+	 * @update: update informations (see struct hmm_update)
 	 *
 	 * This callback ultimately originates from mmu_notifiers when the CPU
 	 * page table is updated. The device driver must update its page table
@@ -314,9 +325,7 @@ struct hmm_mirror_ops {
 	 * synchronous call.
 	 */
 	void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-					   enum hmm_update_type update_type,
-					   unsigned long start,
-					   unsigned long end);
+					  const struct hmm_update *update);
 };
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 659efc9aada6..debd2f734ab5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -127,9 +127,7 @@ void hmm_mm_destroy(struct mm_struct *mm)
 }
 
 static void hmm_invalidate_range(struct hmm *hmm,
-				 enum hmm_update_type action,
-				 unsigned long start,
-				 unsigned long end)
+				const struct hmm_update *update)
 {
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
@@ -138,21 +136,20 @@ static void hmm_invalidate_range(struct hmm *hmm,
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
 	list_for_each_entry(mirror, &hmm->mirrors, list)
-		mirror->ops->sync_cpu_device_pagetables(mirror, action,
-							start, end);
+		mirror->ops->sync_cpu_device_pagetables(mirror, update);
 	up_read(&hmm->mirrors_sem);
 }
 
@@ -183,10 +180,10 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 
 static int hmm_invalidate_range_start(struct mmu_notifier *mn,
-				       struct mm_struct *mm,
-				       unsigned long start,
-				       unsigned long end,
-				       bool blockable)
+				      struct mm_struct *mm,
+				      unsigned long start,
+				      unsigned long end,
+				      bool blockable)
 {
 	struct hmm *hmm = mm->hmm;
 
@@ -202,11 +199,15 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
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
+	hmm_invalidate_range(hmm, &update);
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
-- 
2.17.1

