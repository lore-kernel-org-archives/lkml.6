Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE68C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6ED214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079347;
	bh=zIPpn21egJuWOIqBggnzXGrNNGl/ihuC4Vqo6gkTAmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azVAl2i2QvdvAvb9bR7RpEgHMuBYRiwqjFzA/zUeUtsiYq6zHdQhYT/+WSZjmvI/L
	 6IX60kLMQXfbhWry3KBB/7dxos18/TBye5fsAZ2I8DIsHkQFwekYR6HH1THAmmolSG
	 m6FiNHSzQRscdeh2MyTUGpfBh/8Hm7+1pgm81++w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfAUOC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732785AbfAUOCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839B72089F;
        Mon, 21 Jan 2019 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079343;
        bh=zIPpn21egJuWOIqBggnzXGrNNGl/ihuC4Vqo6gkTAmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmao1wq6cJfZwg4h+MfCVoFJHs/BcHC2N6JVMUWjGHN1jZIJCFEHwqRWLc/ImMpff
         NbLnMrodrbvwWkUs8vb1VznPlKntmZxA9jO32MsSaKxnTwsgeuiSvG8w9yR7PIWXdI
         hih4HuWO/n1Qs+IYa2NJ2aANmNWHgRbMRCaBTmRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 92/99] loop: Move loop_reread_partitions() out of loop_ctl_mutex
Date:   Mon, 21 Jan 2019 14:49:24 +0100
Message-Id: <20190121134918.446576812@linuxfoundation.org>
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
@@ -680,6 +680,7 @@ static int loop_change_fd(struct loop_de
 {
 	struct file	*file, *old_file;
 	int		error;
+	bool		partscan;
 
 	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (error)
@@ -721,9 +722,10 @@ static int loop_change_fd(struct loop_de
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
@@ -904,6 +906,7 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
+	bool		partscan;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -970,14 +973,15 @@ static int loop_set_fd(struct loop_devic
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
@@ -1158,6 +1162,8 @@ loop_set_status(struct loop_device *lo,
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
+	struct block_device *bdev;
+	bool partscan = false;
 
 	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (err)
@@ -1246,10 +1252,13 @@ out_unfreeze:
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


