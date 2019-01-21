Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232EC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B26120989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079387;
	bh=7zT/euG6yS3IjVSjKvqghx8mU+n3ZWN84I2P0YRGeII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evWXqnYNKdyNPv9uvjJeR725c+8Rn9VJCLdEiFrLeho8Zmb1u5F3dYOedlWik4Sek
	 jSLzhnDDqG2PpNPknVC4ZvM8xcbSCBfNEJrAQis+ipUVPFNygmyLXx3sbL9iXBAJl4
	 IwMdCsUIeTI36PkBMQcxfzH4MNwrNYGobTMrnwno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfAUODF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbfAUODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:03:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A026A2089F;
        Mon, 21 Jan 2019 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079381;
        bh=7zT/euG6yS3IjVSjKvqghx8mU+n3ZWN84I2P0YRGeII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrunLQ3pgt/F0NUX3kepg0Ot20TOU1rDLoFCXrYzU4uA90ek7VjPSD55MQKVAMx6L
         pyizCDyDN8ROmzd9tzsXpAqnsfAjy/Lqn1IXcQf4MY6B0pugGnS5/gtMwKket3GRI/
         mnHyl2AhqSlGQbY7lXv0YNPvZc+1AUWOtCGFdjI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 85/99] loop: Split setting of lo_state from loop_clr_fd
Date:   Mon, 21 Jan 2019 14:49:17 +0100
Message-Id: <20190121134917.361471897@linuxfoundation.org>
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

commit a2505b799a496b7b84d9a4a14ec870ff9e42e11b upstream.

Move setting of lo_state to Lo_rundown out into the callers. That will
allow us to unlock loop_ctl_mutex while the loop device is protected
from other changes by its special state.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   52 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -976,7 +976,7 @@ static int loop_set_fd(struct loop_devic
 		loop_reread_partitions(lo, bdev);
 
 	/* Grab the block_device to prevent its destruction after we
-	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
+	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
 	return 0;
@@ -1026,31 +1026,15 @@ loop_init_xfer(struct loop_device *lo, s
 	return err;
 }
 
-static int loop_clr_fd(struct loop_device *lo)
+static int __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp = lo->lo_backing_file;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
 
-	if (lo->lo_state != Lo_bound)
+	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown))
 		return -ENXIO;
 
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&loop_ctl_mutex);
-		return 0;
-	}
-
 	if (filp == NULL)
 		return -EINVAL;
 
@@ -1058,7 +1042,6 @@ static int loop_clr_fd(struct loop_devic
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	spin_lock_irq(&lo->lo_lock);
-	lo->lo_state = Lo_rundown;
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
@@ -1111,6 +1094,30 @@ static int loop_clr_fd(struct loop_devic
 	return 0;
 }
 
+static int loop_clr_fd(struct loop_device *lo)
+{
+	if (lo->lo_state != Lo_bound)
+		return -ENXIO;
+	/*
+	 * If we've explicitly asked to tear down the loop device,
+	 * and it has an elevated reference count, set it for auto-teardown when
+	 * the last reference goes away. This stops $!~#$@ udev from
+	 * preventing teardown because it decided that it needs to run blkid on
+	 * the loopback device whenever they appear. xfstests is notorious for
+	 * failing tests because blkid via udev races with a losetup
+	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
+	 * command to fail with EBUSY.
+	 */
+	if (atomic_read(&lo->lo_refcnt) > 1) {
+		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
+		mutex_unlock(&loop_ctl_mutex);
+		return 0;
+	}
+	lo->lo_state = Lo_rundown;
+
+	return __loop_clr_fd(lo);
+}
+
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
@@ -1692,11 +1699,14 @@ static void lo_release(struct gendisk *d
 		goto out_unlock;
 
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
+		if (lo->lo_state != Lo_bound)
+			goto out_unlock;
+		lo->lo_state = Lo_rundown;
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		err = loop_clr_fd(lo);
+		err = __loop_clr_fd(lo);
 		if (!err)
 			return;
 	} else if (lo->lo_state == Lo_bound) {


