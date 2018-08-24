Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A58C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC3D208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC3D208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHXXBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:01:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbeHXXBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76972402332F;
        Fri, 24 Aug 2018 19:25:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8572026D6D;
        Fri, 24 Aug 2018 19:25:55 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/7] mm/hmm: invalidate device page table at start of invalidation
Date:   Fri, 24 Aug 2018 15:25:48 -0400
Message-Id: <20180824192549.30844-7-jglisse@redhat.com>
In-Reply-To: <20180824192549.30844-1-jglisse@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 24 Aug 2018 19:25:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 24 Aug 2018 19:25:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Invalidate device page table at start of invalidation and invalidate
in progress CPU page table snapshooting at both start and end of any
invalidation.

This is helpful when device need to dirty page because the device page
table report the page as dirty. Dirtying page must happen in the start
mmu notifier callback and not in the end one.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h |  2 +-
 mm/hmm.c            | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index a7f7600b6bb0..064924bce75c 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -325,7 +325,7 @@ struct hmm_mirror_ops {
 	 * synchronous call.
 	 */
 	void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
-					  const struct hmm_update *update);
+					   const struct hmm_update *update);
 };
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index debd2f734ab5..6fe31e2bfa1e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -43,7 +43,6 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
  *
  * @mm: mm struct this HMM struct is bound to
  * @lock: lock protecting ranges list
- * @sequence: we track updates to the CPU page table with a sequence number
  * @ranges: list of range being snapshotted
  * @mirrors: list of mirrors for this mm
  * @mmu_notifier: mmu notifier to track updates to CPU page table
@@ -52,7 +51,6 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 struct hmm {
 	struct mm_struct	*mm;
 	spinlock_t		lock;
-	atomic_t		sequence;
 	struct list_head	ranges;
 	struct list_head	mirrors;
 	struct mmu_notifier	mmu_notifier;
@@ -85,7 +83,6 @@ static struct hmm *hmm_register(struct mm_struct *mm)
 		return NULL;
 	INIT_LIST_HEAD(&hmm->mirrors);
 	init_rwsem(&hmm->mirrors_sem);
-	atomic_set(&hmm->sequence, 0);
 	hmm->mmu_notifier.ops = NULL;
 	INIT_LIST_HEAD(&hmm->ranges);
 	spin_lock_init(&hmm->lock);
@@ -126,8 +123,8 @@ void hmm_mm_destroy(struct mm_struct *mm)
 	kfree(mm->hmm);
 }
 
-static void hmm_invalidate_range(struct hmm *hmm,
-				const struct hmm_update *update)
+static void hmm_invalidate_range(struct hmm *hmm, bool device,
+				 const struct hmm_update *update)
 {
 	struct hmm_mirror *mirror;
 	struct hmm_range *range;
@@ -147,6 +144,9 @@ static void hmm_invalidate_range(struct hmm *hmm,
 	}
 	spin_unlock(&hmm->lock);
 
+	if (!device)
+		return;
+
 	down_read(&hmm->mirrors_sem);
 	list_for_each_entry(mirror, &hmm->mirrors, list)
 		mirror->ops->sync_cpu_device_pagetables(mirror, update);
@@ -185,11 +185,18 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 				      unsigned long end,
 				      bool blockable)
 {
+	struct hmm_update update;
 	struct hmm *hmm = mm->hmm;
 
+	if (!blockable)
+		return -EAGAIN;
+
 	VM_BUG_ON(!hmm);
 
-	atomic_inc(&hmm->sequence);
+	update.start = start;
+	update.end = end;
+	update.event = HMM_UPDATE_INVALIDATE;
+	hmm_invalidate_range(hmm, true, &update);
 
 	return 0;
 }
@@ -207,7 +214,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 	update.start = start;
 	update.end = end;
 	update.event = HMM_UPDATE_INVALIDATE;
-	hmm_invalidate_range(hmm, &update);
+	hmm_invalidate_range(hmm, false, &update);
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
-- 
2.17.1

