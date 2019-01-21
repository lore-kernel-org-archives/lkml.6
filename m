Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEBB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078650;
	bh=nMufYHimURNM0a2ygK9zj2a1Rx0UIlmdCViloquPmzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cuObKM+bvMFmvLGSbpYRWnwzK2YcmI/xzRVj53TLhuNFa9zxkPrrTetIf8LQdiOx7
	 UowMYrCbwqqOw6QmGJdggEF4c32UBp5phhL797mn6tx2k/NH6GDZpXg9bvgjCjzCwE
	 q+4FV8Ip/DGMtogX5lSYYG9RNoHXYWuOzromJlWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfAUNut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfAUNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67ED12089F;
        Mon, 21 Jan 2019 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078644;
        bh=nMufYHimURNM0a2ygK9zj2a1Rx0UIlmdCViloquPmzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXWbKfELnB8v+51De5agcLoT6a7BDpxrmXW557gB7iTJJmKoH6iR2gTgYYtZ2jNSh
         bSKZk6PaeTq0aTGp1IAs2RYUXvixUu6qRVw+CBqfa7tBjz3ofg46XvGBIHjE1X/fSm
         vvRk5xtsU5GlUxSBq6SRQrxc/ayVDtrVsBQkK8DM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 105/111] loop: Move loop_reread_partitions() out of loop_ctl_mutex
Date:   Mon, 21 Jan 2019 14:43:39 +0100
Message-Id: <20190121122506.870485377@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 85b0a54a82e4fbceeb1aebb7cb6909edd1a24668 upstream.

Calling loop_reread_partitions() under loop_ctl_mutex causes lockdep to
complain about circular lock dependency between bdev->bd_mutex and
lo->lo_ctl_mutex. The problem is that on loop device open or close
lo_open() and lo_release() get called with bdev->bd_mutex held and they
need to acquire loop_ctl_mutex. OTOH when loop_reread_partitions() is
called with loop_ctl_mutex held, it will call blkdev_reread_part() which
acquires bdev->bd_mutex. See syzbot report for details [1].

Move all calls of loop_rescan_partitions() out of loop_ctl_mutex to
avoid lockdep warning and fix deadlock possibility.

[1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d1588

Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -679,6 +679,7 @@ static int loop_change_fd(struct loop_de
 {
 	struct file	*file, *old_file;
 	int		error;
+	bool		partscan;
 
 	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (error)
@@ -720,9 +721,10 @@ static int loop_change_fd(struct loop_de
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	fput(old_file);
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		loop_reread_partitions(lo, bdev);
+	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	mutex_unlock(&loop_ctl_mutex);
+	if (partscan)
+		loop_reread_partitions(lo, bdev);
 	return 0;
 
 out_putf:
@@ -903,6 +905,7 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
+	bool		partscan;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -969,14 +972,15 @@ static int loop_set_fd(struct loop_devic
 	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		loop_reread_partitions(lo, bdev);
+	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 
 	/* Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
+	if (partscan)
+		loop_reread_partitions(lo, bdev);
 	return 0;
 
 out_unlock:
@@ -1157,6 +1161,8 @@ loop_set_status(struct loop_device *lo,
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
+	struct block_device *bdev;
+	bool partscan = false;
 
 	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (err)
@@ -1245,10 +1251,13 @@ out_unfreeze:
 	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		loop_reread_partitions(lo, lo->lo_device);
+		bdev = lo->lo_device;
+		partscan = true;
 	}
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+	if (partscan)
+		loop_reread_partitions(lo, bdev);
 
 	return err;
 }


