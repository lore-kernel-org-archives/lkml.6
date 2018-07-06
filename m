Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7450C20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7450C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeGFF7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:59:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbeGFFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:15 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B15F986A;
        Fri,  6 Jul 2018 05:51:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Shaohua Li <shli@fb.com>,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 34/61] md: always hold reconfig_mutex when calling mddev_suspend()
Date:   Fri,  6 Jul 2018 07:46:58 +0200
Message-Id: <20180706054713.643779676@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.com>

commit 4d5324f760aacaefeb721b172aa14bf66045c332 upstream.

Most often mddev_suspend() is called with
reconfig_mutex held.  Make this a requirement in
preparation a subsequent patch.  Also require
reconfig_mutex to be held for mddev_resume(),
partly for symmetry and partly to guarantee
no races with incr/decr of mddev->suspend.

Taking the mutex in r5c_disable_writeback_async() is
a little tricky as this is called from a work queue
via log->disable_writeback_work, and flush_work()
is called on that while holding ->reconfig_mutex.
If the work item hasn't run before flush_work()
is called, the work function will not be able to
get the mutex.

So we use mddev_trylock() inside the wait_event() call, and have that
abort when conf->log is set to NULL, which happens before
flush_work() is called.
We wait in mddev->sb_wait and ensure this is woken
when any of the conditions change.  This requires
waking mddev->sb_wait in mddev_unlock().  This is only
like to trigger extra wake_ups of threads that needn't
be woken when metadata is being written, and that
doesn't happen often enough that the cost would be
noticeable.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-raid.c     |   10 ++++++++--
 drivers/md/md.c          |    3 +++
 drivers/md/raid5-cache.c |   18 +++++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3637,8 +3637,11 @@ static void raid_postsuspend(struct dm_t
 {
 	struct raid_set *rs = ti->private;
 
-	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
+		mddev_lock_nointr(&rs->md);
 		mddev_suspend(&rs->md);
+		mddev_unlock(&rs->md);
+	}
 
 	rs->md.ro = 1;
 }
@@ -3898,8 +3901,11 @@ static void raid_resume(struct dm_target
 	if (!(rs->ctr_flags & RESUME_STAY_FROZEN_FLAGS))
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
+		mddev_lock_nointr(mddev);
 		mddev_resume(mddev);
+		mddev_unlock(mddev);
+	}
 }
 
 static struct target_type raid_target = {
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -344,6 +344,7 @@ static blk_qc_t md_make_request(struct r
 void mddev_suspend(struct mddev *mddev)
 {
 	WARN_ON_ONCE(mddev->thread && current == mddev->thread->tsk);
+	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (mddev->suspended++)
 		return;
 	synchronize_rcu();
@@ -357,6 +358,7 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
 
 void mddev_resume(struct mddev *mddev)
 {
+	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (--mddev->suspended)
 		return;
 	wake_up(&mddev->sb_wait);
@@ -663,6 +665,7 @@ void mddev_unlock(struct mddev *mddev)
 	 */
 	spin_lock(&pers_lock);
 	md_wakeup_thread(mddev->thread);
+	wake_up(&mddev->sb_wait);
 	spin_unlock(&pers_lock);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -693,6 +693,8 @@ static void r5c_disable_writeback_async(
 	struct r5l_log *log = container_of(work, struct r5l_log,
 					   disable_writeback_work);
 	struct mddev *mddev = log->rdev->mddev;
+	struct r5conf *conf = mddev->private;
+	int locked = 0;
 
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH)
 		return;
@@ -701,11 +703,15 @@ static void r5c_disable_writeback_async(
 
 	/* wait superblock change before suspend */
 	wait_event(mddev->sb_wait,
-		   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
-
-	mddev_suspend(mddev);
-	log->r5c_journal_mode = R5C_JOURNAL_MODE_WRITE_THROUGH;
-	mddev_resume(mddev);
+		   conf->log == NULL ||
+		   (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) &&
+		    (locked = mddev_trylock(mddev))));
+	if (locked) {
+		mddev_suspend(mddev);
+		log->r5c_journal_mode = R5C_JOURNAL_MODE_WRITE_THROUGH;
+		mddev_resume(mddev);
+		mddev_unlock(mddev);
+	}
 }
 
 static void r5l_submit_current_io(struct r5l_log *log)
@@ -3161,6 +3167,8 @@ void r5l_exit_log(struct r5conf *conf)
 	conf->log = NULL;
 	synchronize_rcu();
 
+	/* Ensure disable_writeback_work wakes up and exits */
+	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
 	md_unregister_thread(&log->reclaim_thread);
 	mempool_destroy(log->meta_pool);


