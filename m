Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbeGTN0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:26:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbeGTN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:26:47 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 860FFBD4;
        Fri, 20 Jul 2018 12:34:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 67/92] bdi: Fix another oops in wb_workfn()
Date:   Fri, 20 Jul 2018 14:14:11 +0200
Message-Id: <20180720121421.635085895@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 3ee7e8697d5860b173132606d80a9cd35e7113ee upstream.

syzbot is reporting NULL pointer dereference at wb_workfn() [1] due to
wb->bdi->dev being NULL. And Dmitry confirmed that wb->state was
WB_shutting_down after wb->bdi->dev became NULL. This indicates that
unregister_bdi() failed to call wb_shutdown() on one of wb objects.

The problem is in cgwb_bdi_unregister() which does cgwb_kill() and thus
drops bdi's reference to wb structures before going through the list of
wbs again and calling wb_shutdown() on each of them. This way the loop
iterating through all wbs can easily miss a wb if that wb has already
passed through cgwb_remove_from_bdi_list() called from wb_shutdown()
from cgwb_release_workfn() and as a result fully shutdown bdi although
wb_workfn() for this wb structure is still running. In fact there are
also other ways cgwb_bdi_unregister() can race with
cgwb_release_workfn() leading e.g. to use-after-free issues:

CPU1                            CPU2
                                cgwb_bdi_unregister()
                                  cgwb_kill(*slot);

cgwb_release()
  queue_work(cgwb_release_wq, &wb->release_work);
cgwb_release_workfn()
                                  wb = list_first_entry(&bdi->wb_list, ...)
                                  spin_unlock_irq(&cgwb_lock);
  wb_shutdown(wb);
  ...
  kfree_rcu(wb, rcu);
                                  wb_shutdown(wb); -> oops use-after-free

We solve these issues by synchronizing writeback structure shutdown from
cgwb_bdi_unregister() with cgwb_release_workfn() using a new mutex. That
way we also no longer need synchronization using WB_shutting_down as the
mutex provides it for CONFIG_CGROUP_WRITEBACK case and without
CONFIG_CGROUP_WRITEBACK wb_shutdown() can be called only once from
bdi_unregister().

Reported-by: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/backing-dev-defs.h |    2 +-
 mm/backing-dev.c                 |   20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -22,7 +22,6 @@ struct dentry;
  */
 enum wb_state {
 	WB_registered,		/* bdi_register() was done */
-	WB_shutting_down,	/* wb_shutdown() in progress */
 	WB_writeback_running,	/* Writeback is in progress */
 	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
 };
@@ -165,6 +164,7 @@ struct backing_dev_info {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct rb_root cgwb_congested_tree; /* their congested states */
+	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
 #else
 	struct bdi_writeback_congested *wb_congested;
 #endif
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -356,15 +356,8 @@ static void wb_shutdown(struct bdi_write
 	spin_lock_bh(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
 		spin_unlock_bh(&wb->work_lock);
-		/*
-		 * Wait for wb shutdown to finish if someone else is just
-		 * running wb_shutdown(). Otherwise we could proceed to wb /
-		 * bdi destruction before wb_shutdown() is finished.
-		 */
-		wait_on_bit(&wb->state, WB_shutting_down, TASK_UNINTERRUPTIBLE);
 		return;
 	}
-	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
 
 	cgwb_remove_from_bdi_list(wb);
@@ -376,12 +369,6 @@ static void wb_shutdown(struct bdi_write
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
-	/*
-	 * Make sure bit gets cleared after shutdown is finished. Matches with
-	 * the barrier provided by test_and_clear_bit() above.
-	 */
-	smp_wmb();
-	clear_and_wake_up_bit(WB_shutting_down, &wb->state);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
@@ -505,10 +492,12 @@ static void cgwb_release_workfn(struct w
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
 
+	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
@@ -694,6 +683,7 @@ static int cgwb_bdi_init(struct backing_
 
 	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
 	bdi->cgwb_congested_tree = RB_ROOT;
+	mutex_init(&bdi->cgwb_release_mutex);
 
 	ret = wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (!ret) {
@@ -714,7 +704,10 @@ static void cgwb_bdi_unregister(struct b
 	spin_lock_irq(&cgwb_lock);
 	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
 		cgwb_kill(*slot);
+	spin_unlock_irq(&cgwb_lock);
 
+	mutex_lock(&bdi->cgwb_release_mutex);
+	spin_lock_irq(&cgwb_lock);
 	while (!list_empty(&bdi->wb_list)) {
 		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
 				      bdi_node);
@@ -723,6 +716,7 @@ static void cgwb_bdi_unregister(struct b
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
+	mutex_unlock(&bdi->cgwb_release_mutex);
 }
 
 /**


