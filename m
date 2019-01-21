Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BCDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314120989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079350;
	bh=H+SSyBwjKxYmN4LkbQhMamFdI5ICfg6iiTTJUcjxshU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qgyFE8DFoG59GJ3w45NILY30NOrhi0NVyQgwhp6KHsivBnRJYRTuu8qAxF9aY/lKd
	 /LSQo7YEBpyG9lF6tRkaJmY0oBxRkKoaLK8iUFR5Saaz97jC6gyHuMBHMqcdb5Hb6e
	 QWnUvXiy6uElTT5dPcv/RBLeAF7bid4rZAhBt2JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfAUOC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732794AbfAUOC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C00A2089F;
        Mon, 21 Jan 2019 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079345;
        bh=H+SSyBwjKxYmN4LkbQhMamFdI5ICfg6iiTTJUcjxshU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeWElrjTnvHuDzOwd5H4nnSOM5RmcOY9RJQv/f0XD75yPdHMQglEzyhOuHonr8vK6
         mKMULIORCIHfFMYKeTtm5sj6Gf3OxMwRAoKeqpOZ98J1Du8JD0TyQzzvN5TAmyEWXP
         0CI7wIDGoHjsp6OgTlgXaE3ehGhEsCKcR4ZEZmR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 93/99] loop: Fix deadlock when calling blkdev_reread_part()
Date:   Mon, 21 Jan 2019 14:49:25 +0100
Message-Id: <20190121134918.866879956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 0da03cab87e6323ff2e05b14bc7d5c6fcc531efd upstream.

Calling blkdev_reread_part() under loop_ctl_mutex causes lockdep to
complain about circular lock dependency between bdev->bd_mutex and
lo->lo_ctl_mutex. The problem is that on loop device open or close
lo_open() and lo_release() get called with bdev->bd_mutex held and they
need to acquire loop_ctl_mutex. OTOH when loop_reread_partitions() is
called with loop_ctl_mutex held, it will call blkdev_reread_part() which
acquires bdev->bd_mutex. See syzbot report for details [1].

Move call to blkdev_reread_part() in __loop_clr_fd() from under
loop_ctl_mutex to finish fixing of the lockdep warning and the possible
deadlock.

[1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d1588

Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1031,12 +1031,14 @@ loop_init_xfer(struct loop_device *lo, s
 	return err;
 }
 
-static int __loop_clr_fd(struct loop_device *lo)
+static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
 	int err = 0;
+	bool partscan = false;
+	int lo_number;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
@@ -1089,7 +1091,15 @@ static int __loop_clr_fd(struct loop_dev
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev) {
+	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
+	lo_number = lo->lo_number;
+	lo->lo_flags = 0;
+	if (!part_shift)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	loop_unprepare_queue(lo);
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
+	if (partscan) {
 		/*
 		 * bd_mutex has been held already in release path, so don't
 		 * acquire it if this function is called in such case.
@@ -1098,21 +1108,15 @@ static int __loop_clr_fd(struct loop_dev
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!atomic_read(&lo->lo_refcnt))
+		if (release)
 			err = __blkdev_reread_part(bdev);
 		else
 			err = blkdev_reread_part(bdev);
 		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-			__func__, lo->lo_number, err);
+			__func__, lo_number, err);
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
-	lo->lo_flags = 0;
-	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
-	loop_unprepare_queue(lo);
-out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
@@ -1153,7 +1157,7 @@ static int loop_clr_fd(struct loop_devic
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&loop_ctl_mutex);
 
-	return __loop_clr_fd(lo);
+	return __loop_clr_fd(lo, false);
 }
 
 static int
@@ -1714,7 +1718,7 @@ static void lo_release(struct gendisk *d
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo);
+		__loop_clr_fd(lo, true);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*


