Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC6FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC3A208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC3A208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeGFFvY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeGFFvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:21 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6E2786A;
        Fri,  6 Jul 2018 05:51:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Shaohua Li <shli@fb.com>,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.14 36/61] md: move suspend_hi/lo handling into core md code
Date:   Fri,  6 Jul 2018 07:47:00 +0200
Message-Id: <20180706054713.722729881@linuxfoundation.org>
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

commit b3143b9a38d5039bcd1f2d1c94039651bfba8043 upstream.

responding to ->suspend_lo and ->suspend_hi is similar
to responding to ->suspended.  It is best to wait in
the common core code without incrementing ->active_io.
This allows mddev_suspend()/mddev_resume() to work while
requests are waiting for suspend_lo/hi to change.
This is will be important after a subsequent patch
which uses mddev_suspend() to synchronize updating for
suspend_lo/hi.

So move the code for testing suspend_lo/hi out of raid1.c
and raid5.c, and place it in md.c

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c    |   29 +++++++++++++++++++++++------
 drivers/md/raid1.c |   14 +++++---------
 drivers/md/raid5.c |   22 ----------------------
 3 files changed, 28 insertions(+), 37 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -266,16 +266,31 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
  * call has finished, the bio has been linked into some internal structure
  * and so is visible to ->quiesce(), so we don't need the refcount any more.
  */
+static bool is_suspended(struct mddev *mddev, struct bio *bio)
+{
+	if (mddev->suspended)
+		return true;
+	if (bio_data_dir(bio) != WRITE)
+		return false;
+	if (mddev->suspend_lo >= mddev->suspend_hi)
+		return false;
+	if (bio->bi_iter.bi_sector >= mddev->suspend_hi)
+		return false;
+	if (bio_end_sector(bio) < mddev->suspend_lo)
+		return false;
+	return true;
+}
+
 void md_handle_request(struct mddev *mddev, struct bio *bio)
 {
 check_suspended:
 	rcu_read_lock();
-	if (mddev->suspended) {
+	if (is_suspended(mddev, bio)) {
 		DEFINE_WAIT(__wait);
 		for (;;) {
 			prepare_to_wait(&mddev->sb_wait, &__wait,
 					TASK_UNINTERRUPTIBLE);
-			if (!mddev->suspended)
+			if (!is_suspended(mddev, bio))
 				break;
 			rcu_read_unlock();
 			schedule();
@@ -4849,10 +4864,11 @@ suspend_lo_store(struct mddev *mddev, co
 		goto unlock;
 	old = mddev->suspend_lo;
 	mddev->suspend_lo = new;
-	if (new >= old)
+	if (new >= old) {
 		/* Shrinking suspended region */
+		wake_up(&mddev->sb_wait);
 		mddev->pers->quiesce(mddev, 2);
-	else {
+	} else {
 		/* Expanding suspended region - need to wait */
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
@@ -4892,10 +4908,11 @@ suspend_hi_store(struct mddev *mddev, co
 		goto unlock;
 	old = mddev->suspend_hi;
 	mddev->suspend_hi = new;
-	if (new <= old)
+	if (new <= old) {
 		/* Shrinking suspended region */
+		wake_up(&mddev->sb_wait);
 		mddev->pers->quiesce(mddev, 2);
-	else {
+	} else {
 		/* Expanding suspended region - need to wait */
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1298,11 +1298,9 @@ static void raid1_write_request(struct m
 	 */
 
 
-	if ((bio_end_sector(bio) > mddev->suspend_lo &&
-	    bio->bi_iter.bi_sector < mddev->suspend_hi) ||
-	    (mddev_is_clustered(mddev) &&
+	if (mddev_is_clustered(mddev) &&
 	     md_cluster_ops->area_resyncing(mddev, WRITE,
-		     bio->bi_iter.bi_sector, bio_end_sector(bio)))) {
+		     bio->bi_iter.bi_sector, bio_end_sector(bio))) {
 
 		/*
 		 * As the suspend_* range is controlled by userspace, we want
@@ -1313,12 +1311,10 @@ static void raid1_write_request(struct m
 			sigset_t full, old;
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_INTERRUPTIBLE);
-			if ((bio_end_sector(bio) <= mddev->suspend_lo ||
-			     bio->bi_iter.bi_sector >= mddev->suspend_hi) &&
-			    (!mddev_is_clustered(mddev) ||
-			     !md_cluster_ops->area_resyncing(mddev, WRITE,
+			if (!mddev_is_clustered(mddev) ||
+			    !md_cluster_ops->area_resyncing(mddev, WRITE,
 							bio->bi_iter.bi_sector,
-							bio_end_sector(bio))))
+							bio_end_sector(bio)))
 				break;
 			sigfillset(&full);
 			sigprocmask(SIG_BLOCK, &full, &old);
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5686,28 +5686,6 @@ static bool raid5_make_request(struct md
 				goto retry;
 			}
 
-			if (rw == WRITE &&
-			    logical_sector >= mddev->suspend_lo &&
-			    logical_sector < mddev->suspend_hi) {
-				raid5_release_stripe(sh);
-				/* As the suspend_* range is controlled by
-				 * userspace, we want an interruptible
-				 * wait.
-				 */
-				prepare_to_wait(&conf->wait_for_overlap,
-						&w, TASK_INTERRUPTIBLE);
-				if (logical_sector >= mddev->suspend_lo &&
-				    logical_sector < mddev->suspend_hi) {
-					sigset_t full, old;
-					sigfillset(&full);
-					sigprocmask(SIG_BLOCK, &full, &old);
-					schedule();
-					sigprocmask(SIG_SETMASK, &old, NULL);
-					do_prepare = true;
-				}
-				goto retry;
-			}
-
 			if (test_bit(STRIPE_EXPANDING, &sh->state) ||
 			    !add_stripe_bio(sh, bi, dd_idx, rw, previous)) {
 				/* Stripe is busy expanding or


