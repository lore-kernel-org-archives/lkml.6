Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062EEECDE48
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED9720869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED9720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJTALj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbeJTALi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:11:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82A9A30020AB;
        Fri, 19 Oct 2018 16:04:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-124-217.rdu2.redhat.com [10.10.124.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B073D65949;
        Fri, 19 Oct 2018 16:04:53 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 6/6] mm/hmm: invalidate device page table at start of invalidation
Date:   Fri, 19 Oct 2018 12:04:42 -0400
Message-Id: <20181019160442.18723-7-jglisse@redhat.com>
In-Reply-To: <20181019160442.18723-1-jglisse@redhat.com>
References: <20181019160442.18723-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 19 Oct 2018 16:04:54 +0000 (UTC)
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
 mm/hmm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 0eacf9627bc9..1aecf7c08cff 100644
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
@@ -126,7 +123,7 @@ void hmm_mm_destroy(struct mm_struct *mm)
 	kfree(mm->hmm);
 }
 
-static int hmm_invalidate_range(struct hmm *hmm,
+static int hmm_invalidate_range(struct hmm *hmm, bool device,
 				const struct hmm_update *update)
 {
 	struct hmm_mirror *mirror;
@@ -147,6 +144,9 @@ static int hmm_invalidate_range(struct hmm *hmm,
 	}
 	spin_unlock(&hmm->lock);
 
+	if (!device)
+		return 0;
+
 	down_read(&hmm->mirrors_sem);
 	list_for_each_entry(mirror, &hmm->mirrors, list) {
 		int ret;
@@ -189,18 +189,21 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
+	struct hmm_update update;
 	struct hmm *hmm = mm->hmm;
 
 	VM_BUG_ON(!hmm);
 
-	atomic_inc(&hmm->sequence);
-
-	return 0;
+	update.start = start;
+	update.end = end;
+	update.event = HMM_UPDATE_INVALIDATE;
+	update.blockable = blockable;
+	return hmm_invalidate_range(hmm, true, &update);
 }
 
 static void hmm_invalidate_range_end(struct mmu_notifier *mn,
@@ -217,7 +220,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 	update.end = end;
 	update.event = HMM_UPDATE_INVALIDATE;
 	update.blockable = true;
-	hmm_invalidate_range(hmm, &update);
+	hmm_invalidate_range(hmm, false, &update);
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
-- 
2.17.2

