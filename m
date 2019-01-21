Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBDDC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2320989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079413;
	bh=v1nieTBXuQ8t1CiAZHAun7B58d33N/oKTFfp7SDlIuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IrFIvBBE2amoSkZmJILtJfbN4lUe5q+cni/GPxnVjgJmP6J+FqsZT2cBEhlXYXHid
	 Zk7/sjwDzdI4hBfFML4MhWWSDkw9eHJEAKqbhXAj0Az3R/GPc8IOeLwcWq8NwvV1fX
	 YiThDM3Zz7EDop2E+DIJ8yHtjLQnsitOJcr5DSFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbfAUODb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfAUOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6282089F;
        Mon, 21 Jan 2019 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079378;
        bh=v1nieTBXuQ8t1CiAZHAun7B58d33N/oKTFfp7SDlIuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDcLKoYE2fdxGp32A1AhRGkYTZZL3Xt2kBbTUzCrwSrK4NUCQwINWQSYGSLorjL18
         Xz4IOLT+li/BXfz6/pp/XKS165nZVkfTTIg8tvDkpJuaborg2qT6l2zRaXpb4s253k
         Np9tvwslh/7SrYHQ0GAJSbi4qrqOiAPZawLrUDCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 84/99] loop: Push lo_ctl_mutex down into individual ioctls
Date:   Mon, 21 Jan 2019 14:49:16 +0100
Message-Id: <20190121134917.299674203@linuxfoundation.org>
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

commit a13165441d58b216adbd50252a9cc829d78a6bce upstream.

Push acquisition of lo_ctl_mutex down into individual ioctl handling
branches. This is a preparatory step for pushing the lock down into
individual ioctl handling functions so that they can release the lock as
they need it. We also factor out some simple ioctl handlers that will
not need any special handling to reduce unnecessary code duplication.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   88 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 25 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1394,70 +1394,108 @@ static int loop_set_block_size(struct lo
 	return 0;
 }
 
-static int lo_ioctl(struct block_device *bdev, fmode_t mode,
-	unsigned int cmd, unsigned long arg)
+static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
+			   unsigned long arg)
 {
-	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
 	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (err)
-		goto out_unlocked;
+		return err;
+	switch (cmd) {
+	case LOOP_SET_CAPACITY:
+		err = loop_set_capacity(lo);
+		break;
+	case LOOP_SET_DIRECT_IO:
+		err = loop_set_dio(lo, arg);
+		break;
+	case LOOP_SET_BLOCK_SIZE:
+		err = loop_set_block_size(lo, arg);
+		break;
+	default:
+		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
+	}
+	mutex_unlock(&loop_ctl_mutex);
+	return err;
+}
+
+static int lo_ioctl(struct block_device *bdev, fmode_t mode,
+	unsigned int cmd, unsigned long arg)
+{
+	struct loop_device *lo = bdev->bd_disk->private_data;
+	int err;
 
 	switch (cmd) {
 	case LOOP_SET_FD:
+		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+		if (err)
+			return err;
 		err = loop_set_fd(lo, mode, bdev, arg);
+		mutex_unlock(&loop_ctl_mutex);
 		break;
 	case LOOP_CHANGE_FD:
+		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+		if (err)
+			return err;
 		err = loop_change_fd(lo, bdev, arg);
+		mutex_unlock(&loop_ctl_mutex);
 		break;
 	case LOOP_CLR_FD:
+		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+		if (err)
+			return err;
 		/* loop_clr_fd would have unlocked loop_ctl_mutex on success */
 		err = loop_clr_fd(lo);
-		if (!err)
-			goto out_unlocked;
+		if (err)
+			mutex_unlock(&loop_ctl_mutex);
 		break;
 	case LOOP_SET_STATUS:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+			if (err)
+				return err;
 			err = loop_set_status_old(lo,
 					(struct loop_info __user *)arg);
+			mutex_unlock(&loop_ctl_mutex);
+		}
 		break;
 	case LOOP_GET_STATUS:
+		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+		if (err)
+			return err;
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
 		/* loop_get_status() unlocks loop_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
+		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+			if (err)
+				return err;
 			err = loop_set_status64(lo,
 					(struct loop_info64 __user *) arg);
+			mutex_unlock(&loop_ctl_mutex);
+		}
 		break;
 	case LOOP_GET_STATUS64:
+		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+		if (err)
+			return err;
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
 		/* loop_get_status() unlocks loop_ctl_mutex */
-		goto out_unlocked;
-	case LOOP_SET_CAPACITY:
-		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_capacity(lo);
 		break;
+	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
-		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_dio(lo, arg);
-		break;
 	case LOOP_SET_BLOCK_SIZE:
-		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_block_size(lo, arg);
-		break;
+		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/* Fall through */
 	default:
-		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
+		err = lo_simple_ioctl(lo, cmd, arg);
+		break;
 	}
-	mutex_unlock(&loop_ctl_mutex);
 
-out_unlocked:
 	return err;
 }
 


