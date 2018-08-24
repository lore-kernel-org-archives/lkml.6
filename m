Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35AFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956F208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956F208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHXXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:01:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727507AbeHXXBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B0564023475;
        Fri, 24 Aug 2018 19:25:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF432026D6D;
        Fri, 24 Aug 2018 19:25:55 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 7/7] mm/hmm: proper support for blockable mmu_notifier
Date:   Fri, 24 Aug 2018 15:25:49 -0400
Message-Id: <20180824192549.30844-8-jglisse@redhat.com>
In-Reply-To: <20180824192549.30844-1-jglisse@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 24 Aug 2018 19:25:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 24 Aug 2018 19:25:56 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When mmu_notifier calls invalidate_range_start callback with blockable
set to false we should not sleep. Properly propagate this to HMM users.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h | 12 +++++++++---
 mm/hmm.c            | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 064924bce75c..c783916f8732 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -287,11 +287,13 @@ enum hmm_update_event {
  * @start: virtual start address of the range to update
  * @end: virtual end address of the range to update
  * @event: event triggering the update (what is happening)
+ * @blockable: can the callback block/sleep ?
  */
 struct hmm_update {
 	unsigned long start;
 	unsigned long end;
 	enum hmm_update_event event;
+	bool blockable;
 };
 
 /*
@@ -314,6 +316,8 @@ struct hmm_mirror_ops {
 	 *
 	 * @mirror: pointer to struct hmm_mirror
 	 * @update: update informations (see struct hmm_update)
+	 * Returns: -EAGAIN if update.blockable false and callback need to
+	 *          block, 0 otherwise.
 	 *
 	 * This callback ultimately originates from mmu_notifiers when the CPU
 	 * page table is updated. The device driver must update its page table
@@ -322,10 +326,12 @@ struct hmm_mirror_ops {
 	 *
 	 * The device driver must not return from this callback until the device
 	 * page tables are completely updated (TLBs flushed, etc); this is a
-	 * synchronous call.
+	 * synchronous call. If driver need to sleep and update->blockable is
+	 * false then you need to abort (do not do anything that would sleep or
+	 * block) and return -EAGAIN.
 	 */
-	void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-					   const struct hmm_update *update);
+	int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
+					  const struct hmm_update *update);
 };
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 6fe31e2bfa1e..1d8fcaa0606f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -123,12 +123,18 @@ void hmm_mm_destroy(struct mm_struct *mm)
 	kfree(mm->hmm);
 }
 
-static void hmm_invalidate_range(struct hmm *hmm, bool device,
-				 const struct hmm_update *update)
+static int hmm_invalidate_range(struct hmm *hmm, bool device,
+				const struct hmm_update *update)
 {
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
 
+	/*
+	 * It is fine to wait on lock here even if update->blockable is false
+	 * as the hmm->lock is only held for short period of time (when adding
+	 * or walking the ranges list). We could also convert the range list
+	 * into a lru list and avoid the spinlock all together.
+	 */
 	spin_lock(&hmm->lock);
 	list_for_each_entry(range, &hmm->ranges, list) {
 		unsigned long addr, idx, npages;
@@ -145,12 +151,26 @@ static void hmm_invalidate_range(struct hmm *hmm, bool device,
 	spin_unlock(&hmm->lock);
 
 	if (!device)
-		return;
+		return 0;
 
+	/*
+	 * It is fine to wait on mirrors_sem here even if update->blockable is
+	 * false as this semaphore is only taken in write mode for short period
+	 * when adding a new mirror to the list.
+	 */
 	down_read(&hmm->mirrors_sem);
-	list_for_each_entry(mirror, &hmm->mirrors, list)
-		mirror->ops->sync_cpu_device_pagetables(mirror, update);
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
@@ -188,17 +208,13 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 	struct hmm_update update;
 	struct hmm *hmm = mm->hmm;
 
-	if (!blockable)
-		return -EAGAIN;
-
 	VM_BUG_ON(!hmm);
 
 	update.start = start;
 	update.end = end;
 	update.event = HMM_UPDATE_INVALIDATE;
-	hmm_invalidate_range(hmm, true, &update);
-
-	return 0;
+	update.blockable = blockable;
+	return hmm_invalidate_range(hmm, true, &update);
 }
 
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
@@ -214,6 +230,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 	update.start = start;
 	update.end = end;
 	update.event = HMM_UPDATE_INVALIDATE;
+	update.blockable = true;
 	hmm_invalidate_range(hmm, false, &update);
 }
 
-- 
2.17.1

