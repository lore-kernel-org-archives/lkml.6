Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC11DC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F70E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079376;
	bh=T8o6FXSSGQzID59L3D/GnhK0DN5sZuXAwXiXuAz5nrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6bjPAHwq5U1rPasGfjCUUt9cJbZgCeXCQQrS4AeHs7NpzVdYGO/NivCSIDgaCtme
	 Tr2OL31jn4pet6pMuvQvdY4X1wtuonD1Cj164U4tL/Af8tdxcW6MmZ6QfCxYlJ872N
	 cC7Tc0P6I6lp+FB18oCu+OT4x2pERnEs7O7+KbiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfAUOCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732888AbfAUOCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FCE2089F;
        Mon, 21 Jan 2019 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079370;
        bh=T8o6FXSSGQzID59L3D/GnhK0DN5sZuXAwXiXuAz5nrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EibaSY9zLC3hZMsqIiiT3RvojMxhLt4Qli319QsDW7zYW3Y0RlSLK9ja4NAT2tgvQ
         niOymmtsuxfktpL36Mx4YFMXpuF92b25g5cY+iPa7LwtUMK1uXDCyBgQrHoI4xkq6T
         8i/iGyMtC6WfGbjUitfI1MXte591G56mXhYYDacE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 81/99] block/loop: Use global lock for ioctl() operation.
Date:   Mon, 21 Jan 2019 14:49:13 +0100
Message-Id: <20190121134917.176870782@linuxfoundation.org>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 310ca162d779efee8a2dc3731439680f3e9c1e86 upstream.

syzbot is reporting NULL pointer dereference [1] which is caused by
race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
loop devices at loop_validate_file() without holding corresponding
lo->lo_ctl_mutex locks.

Since ioctl() request on loop devices is not frequent operation, we don't
need fine grained locking. Let's use global lock in order to allow safe
traversal at loop_validate_file().

Note that syzbot is also reporting circular locking dependency between
bdev->bd_mutex and lo->lo_ctl_mutex [2] which is caused by calling
blkdev_reread_part() with lock held. This patch does not address it.

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   58 +++++++++++++++++++++++++--------------------------
 drivers/block/loop.h |    1 
 2 files changed, 29 insertions(+), 30 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -84,6 +84,7 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_index_mutex);
+static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
 static int part_shift;
@@ -1047,7 +1048,7 @@ static int loop_clr_fd(struct loop_devic
 	 */
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return 0;
 	}
 
@@ -1100,12 +1101,12 @@ static int loop_clr_fd(struct loop_devic
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	/*
-	 * Need not hold lo_ctl_mutex to fput backing file.
-	 * Calling fput holding lo_ctl_mutex triggers a circular
+	 * Need not hold loop_ctl_mutex to fput backing file.
+	 * Calling fput holding loop_ctl_mutex triggers a circular
 	 * lock dependency possibility warning as fput can take
-	 * bd_mutex which is usually taken before lo_ctl_mutex.
+	 * bd_mutex which is usually taken before loop_ctl_mutex.
 	 */
 	fput(filp);
 	return 0;
@@ -1210,7 +1211,7 @@ loop_get_status(struct loop_device *lo,
 	int ret;
 
 	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -ENXIO;
 	}
 
@@ -1229,10 +1230,10 @@ loop_get_status(struct loop_device *lo,
 		       lo->lo_encrypt_key_size);
 	}
 
-	/* Drop lo_ctl_mutex while we call into the filesystem. */
+	/* Drop loop_ctl_mutex while we call into the filesystem. */
 	path = lo->lo_backing_file->f_path;
 	path_get(&path);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
@@ -1324,7 +1325,7 @@ loop_get_status_old(struct loop_device *
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1342,7 +1343,7 @@ loop_get_status64(struct loop_device *lo
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1400,7 +1401,7 @@ static int lo_ioctl(struct block_device
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (err)
 		goto out_unlocked;
 
@@ -1412,7 +1413,7 @@ static int lo_ioctl(struct block_device
 		err = loop_change_fd(lo, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		/* loop_clr_fd would have unlocked lo_ctl_mutex on success */
+		/* loop_clr_fd would have unlocked loop_ctl_mutex on success */
 		err = loop_clr_fd(lo);
 		if (!err)
 			goto out_unlocked;
@@ -1425,7 +1426,7 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
+		/* loop_get_status() unlocks loop_ctl_mutex */
 		goto out_unlocked;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
@@ -1435,7 +1436,7 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
+		/* loop_get_status() unlocks loop_ctl_mutex */
 		goto out_unlocked;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
@@ -1455,7 +1456,7 @@ static int lo_ioctl(struct block_device
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 out_unlocked:
 	return err;
@@ -1572,7 +1573,7 @@ loop_get_status_compat(struct loop_devic
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1589,19 +1590,19 @@ static int lo_compat_ioctl(struct block_
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		err = mutex_lock_killable(&loop_ctl_mutex);
 		if (!err) {
 			err = loop_set_status_compat(lo,
 						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		err = mutex_lock_killable(&loop_ctl_mutex);
 		if (!err) {
 			err = loop_get_status_compat(lo,
 						     (struct compat_loop_info __user *)arg);
-			/* loop_get_status() unlocks lo_ctl_mutex */
+			/* loop_get_status() unlocks loop_ctl_mutex */
 		}
 		break;
 	case LOOP_SET_CAPACITY:
@@ -1648,7 +1649,7 @@ static void __lo_release(struct loop_dev
 	if (atomic_dec_return(&lo->lo_refcnt))
 		return;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1666,7 +1667,7 @@ static void __lo_release(struct loop_dev
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -1712,10 +1713,10 @@ static int unregister_transfer_cb(int id
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 }
 
@@ -1896,7 +1897,6 @@ static int loop_add(struct loop_device *
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
-	mutex_init(&lo->lo_ctl_mutex);
 	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2009,21 +2009,21 @@ static long loop_control_ioctl(struct fi
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&lo->lo_ctl_mutex);
+		ret = mutex_lock_killable(&loop_ctl_mutex);
 		if (ret)
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -54,7 +54,6 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct mutex		lo_ctl_mutex;
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;


