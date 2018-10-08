Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F5C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8414214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Ul6COg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8414214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeJICAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeJICAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4DB2064A;
        Mon,  8 Oct 2018 18:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024454;
        bh=VReCybSeXXMV5o9rfd/idaZ8B6dU0Vcy1GT7ChqDifQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Ul6COg9FYTEiZvrArtNcNf/HRn0g3j1JxnMbdTOUJBMGD5Eqw8HX2bk2xi3vUYK+
         zt8CkiuW6C0IjUpGM9xUaUb/UineZ04yNX4aNRKJn7aysTi845pZNNx8dsxM5ouAsN
         pDEkvKKeD4W+jlaR9VvEeJ1Lh+N54yl1z8X1yp4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 045/168] Revert "blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()"
Date:   Mon,  8 Oct 2018 20:30:25 +0200
Message-Id: <20181008175621.768097658@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

[ Upstream commit 6b06546206868f723f2061d703a3c3c378dcbf4c ]

This reverts commit 4c6994806f708559c2812b73501406e21ae5dcd0.

Destroying blkgs is tricky because of the nature of the relationship. A
blkg should go away when either a blkcg or a request_queue goes away.
However, blkg's pin the blkcg to ensure they remain valid. To break this
cycle, when a blkcg is offlined, blkgs put back their css ref. This
eventually lets css_free() get called which frees the blkcg.

The above commit (4c6994806f70) breaks this order of events by trying to
destroy blkgs in css_free(). As the blkgs still hold references to the
blkcg, css_free() is never called.

The race between blkcg_bio_issue_check() and cgroup_rmdir() will be
addressed in the following patch by delaying destruction of a blkg until
all writeback associated with the blkcg has been finished.

Fixes: 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-cgroup.c         |   78 +++++++++------------------------------------
 include/linux/blk-cgroup.h |    1 
 2 files changed, 16 insertions(+), 63 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -307,28 +307,11 @@ struct blkcg_gq *blkg_lookup_create(stru
 	}
 }
 
-static void blkg_pd_offline(struct blkcg_gq *blkg)
-{
-	int i;
-
-	lockdep_assert_held(blkg->q->queue_lock);
-	lockdep_assert_held(&blkg->blkcg->lock);
-
-	for (i = 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol = blkcg_policy[i];
-
-		if (blkg->pd[i] && !blkg->pd[i]->offline &&
-		    pol->pd_offline_fn) {
-			pol->pd_offline_fn(blkg->pd[i]);
-			blkg->pd[i]->offline = true;
-		}
-	}
-}
-
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
 	struct blkcg_gq *parent = blkg->parent;
+	int i;
 
 	lockdep_assert_held(blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
@@ -337,6 +320,13 @@ static void blkg_destroy(struct blkcg_gq
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
 	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
 
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (blkg->pd[i] && pol->pd_offline_fn)
+			pol->pd_offline_fn(blkg->pd[i]);
+	}
+
 	if (parent) {
 		blkg_rwstat_add_aux(&parent->stat_bytes, &blkg->stat_bytes);
 		blkg_rwstat_add_aux(&parent->stat_ios, &blkg->stat_ios);
@@ -379,7 +369,6 @@ static void blkg_destroy_all(struct requ
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
-		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
 	}
@@ -1006,54 +995,21 @@ static struct cftype blkcg_legacy_files[
  * @css: css of interest
  *
  * This function is called when @css is about to go away and responsible
- * for offlining all blkgs pd and killing all wbs associated with @css.
- * blkgs pd offline should be done while holding both q and blkcg locks.
- * As blkcg lock is nested inside q lock, this function performs reverse
- * double lock dancing.
+ * for shooting down all blkgs associated with @css.  blkgs should be
+ * removed while holding both q and blkcg locks.  As blkcg lock is nested
+ * inside q lock, this function performs reverse double lock dancing.
  *
  * This is the blkcg counterpart of ioc_release_fn().
  */
 static void blkcg_css_offline(struct cgroup_subsys_state *css)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
 
 	spin_lock_irq(&blkcg->lock);
 
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct request_queue *q = blkg->q;
-
-		if (spin_trylock(q->queue_lock)) {
-			blkg_pd_offline(blkg);
-			spin_unlock(q->queue_lock);
-		} else {
-			spin_unlock_irq(&blkcg->lock);
-			cpu_relax();
-			spin_lock_irq(&blkcg->lock);
-		}
-	}
-
-	spin_unlock_irq(&blkcg->lock);
-
-	wb_blkcg_offline(blkcg);
-}
-
-/**
- * blkcg_destroy_all_blkgs - destroy all blkgs associated with a blkcg
- * @blkcg: blkcg of interest
- *
- * This function is called when blkcg css is about to free and responsible for
- * destroying all blkgs associated with @blkcg.
- * blkgs should be removed while holding both q and blkcg locks. As blkcg lock
- * is nested inside q lock, this function performs reverse double lock dancing.
- */
-static void blkcg_destroy_all_blkgs(struct blkcg *blkcg)
-{
-	spin_lock_irq(&blkcg->lock);
 	while (!hlist_empty(&blkcg->blkg_list)) {
 		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						    struct blkcg_gq,
-						    blkcg_node);
+						struct blkcg_gq, blkcg_node);
 		struct request_queue *q = blkg->q;
 
 		if (spin_trylock(q->queue_lock)) {
@@ -1065,7 +1021,10 @@ static void blkcg_destroy_all_blkgs(stru
 			spin_lock_irq(&blkcg->lock);
 		}
 	}
+
 	spin_unlock_irq(&blkcg->lock);
+
+	wb_blkcg_offline(blkcg);
 }
 
 static void blkcg_css_free(struct cgroup_subsys_state *css)
@@ -1073,8 +1032,6 @@ static void blkcg_css_free(struct cgroup
 	struct blkcg *blkcg = css_to_blkcg(css);
 	int i;
 
-	blkcg_destroy_all_blkgs(blkcg);
-
 	mutex_lock(&blkcg_pol_mutex);
 
 	list_del(&blkcg->all_blkcgs_node);
@@ -1412,11 +1369,8 @@ void blkcg_deactivate_policy(struct requ
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		if (blkg->pd[pol->plid]) {
-			if (!blkg->pd[pol->plid]->offline &&
-			    pol->pd_offline_fn) {
+			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
-				blkg->pd[pol->plid]->offline = true;
-			}
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -88,7 +88,6 @@ struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
-	bool				offline;
 };
 
 /*


