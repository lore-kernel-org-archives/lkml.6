Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE4C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3801D21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079398;
	bh=rCbwB7vVAtEaRAzs8l7W6vU0J1n3cvQJ54V51eC9XqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b/NzW/Q5l9fanNGtfSWAu/NsRDMbzNx8UfJNm8XbdE65hKC7/GpN7rABMrOn7fqTc
	 jqBPtXASTYZ5ktxVl4f2squkqvbe6MNSopG1bOr4i+1KzuFuBDOHzS9iJ8Q6CydVri
	 6eTxb+vbTKyKwwCuSlXm5i1LvpJTyRdPAsYA0wys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfAUODK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732919AbfAUODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:03:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9BC22089F;
        Mon, 21 Jan 2019 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079384;
        bh=rCbwB7vVAtEaRAzs8l7W6vU0J1n3cvQJ54V51eC9XqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+QKpdqh/deg1fZ3mAH+ckHnGZqymgfdPKq+ytS+FRZCc6XwzBlR78DcqodPk3tKC
         LZxD9TN38JmMOsiVFd0JCYSAiamBwKsfkEoAFNCeJ+PXrmO6EahiQRCzGopWuu9i59
         safW7eUXUo0ZUek2znm2KQUmT1ateLRFwQdNI8Qc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 86/99] loop: Push loop_ctl_mutex down into loop_clr_fd()
Date:   Mon, 21 Jan 2019 14:49:18 +0100
Message-Id: <20190121134917.434547729@linuxfoundation.org>
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

commit 7ccd0791d98531df7cd59e92d55e4f063d48a070 upstream.

loop_clr_fd() has a weird locking convention that is expects
loop_ctl_mutex held, releases it on success and keeps it on failure.
Untangle the mess by moving locking of loop_ctl_mutex into
loop_clr_fd().

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1028,15 +1028,22 @@ loop_init_xfer(struct loop_device *lo, s
 
 static int __loop_clr_fd(struct loop_device *lo)
 {
-	struct file *filp = lo->lo_backing_file;
+	struct file *filp = NULL;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
+	int err = 0;
 
-	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown))
-		return -ENXIO;
+	mutex_lock(&loop_ctl_mutex);
+	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
 
-	if (filp == NULL)
-		return -EINVAL;
+	filp = lo->lo_backing_file;
+	if (filp == NULL) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -1083,6 +1090,7 @@ static int __loop_clr_fd(struct loop_dev
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
+out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
@@ -1090,14 +1098,22 @@ static int __loop_clr_fd(struct loop_dev
 	 * lock dependency possibility warning as fput can take
 	 * bd_mutex which is usually taken before loop_ctl_mutex.
 	 */
-	fput(filp);
-	return 0;
+	if (filp)
+		fput(filp);
+	return err;
 }
 
 static int loop_clr_fd(struct loop_device *lo)
 {
-	if (lo->lo_state != Lo_bound)
+	int err;
+
+	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (err)
+		return err;
+	if (lo->lo_state != Lo_bound) {
+		mutex_unlock(&loop_ctl_mutex);
 		return -ENXIO;
+	}
 	/*
 	 * If we've explicitly asked to tear down the loop device,
 	 * and it has an elevated reference count, set it for auto-teardown when
@@ -1114,6 +1130,7 @@ static int loop_clr_fd(struct loop_devic
 		return 0;
 	}
 	lo->lo_state = Lo_rundown;
+	mutex_unlock(&loop_ctl_mutex);
 
 	return __loop_clr_fd(lo);
 }
@@ -1448,14 +1465,7 @@ static int lo_ioctl(struct block_device
 		mutex_unlock(&loop_ctl_mutex);
 		break;
 	case LOOP_CLR_FD:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		/* loop_clr_fd would have unlocked loop_ctl_mutex on success */
-		err = loop_clr_fd(lo);
-		if (err)
-			mutex_unlock(&loop_ctl_mutex);
-		break;
+		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
@@ -1691,7 +1701,6 @@ out:
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err;
 
 	mutex_lock(&loop_ctl_mutex);
 	lo = disk->private_data;
@@ -1702,13 +1711,13 @@ static void lo_release(struct gendisk *d
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
+		mutex_unlock(&loop_ctl_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		err = __loop_clr_fd(lo);
-		if (!err)
-			return;
+		__loop_clr_fd(lo);
+		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,


