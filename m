Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B35C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED70520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079029;
	bh=FfH7sJJcjvBg/s9hb1q6gILAcYyBIl/JGM7qheNnK1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyQBGsvbn3FzK6nl7hHAjU3D8gTpR/w5jaQM7n/z0uPVqOMvIAY6QF4fpa1Qg1kGv
	 xhTMAkuisqSaGjoNGggZdZHbA3LjqtFrBF6CzyS3v98Q/+JJfcnBT+jHrkBOC9cZQp
	 fBFqoREy3DLqVYo4of36d5xHmxImjqjjkQbhMtAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfAUN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731957AbfAUN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945182084C;
        Mon, 21 Jan 2019 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078995;
        bh=FfH7sJJcjvBg/s9hb1q6gILAcYyBIl/JGM7qheNnK1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etKuTBRp/SwFLCZWtjMWjq7wGpcer4srLZGONq6BX902838PEOo7EfJjSsqxqbONS
         +85fd+fq8IkmqF5hnacy9YlzdZv0DoVP2ARILxWNcdKH2eYoY9HH75XnpA8VqballJ
         8FA7pUDePEZYFfJOMwDsTwO3TjAKix6Oa96+Y20E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 39/51] blockdev: Fix livelocks on loop device
Date:   Mon, 21 Jan 2019 14:44:35 +0100
Message-Id: <20190121122457.524242671@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 04906b2f542c23626b0ef6219b808406f8dddbe9 upstream.

bd_set_size() updates also block device's block size. This is somewhat
unexpected from its name and at this point, only blkdev_open() uses this
functionality. Furthermore, this can result in changing block size under
a filesystem mounted on a loop device which leads to livelocks inside
__getblk_gfp() like:

Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10863 Comm: syz-executor0 Not tainted 4.18.0-rc5+ #151
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x50 kernel/kcov.c:106
...
Call Trace:
 init_page_buffers+0x3e2/0x530 fs/buffer.c:904
 grow_dev_page fs/buffer.c:947 [inline]
 grow_buffers fs/buffer.c:1009 [inline]
 __getblk_slow fs/buffer.c:1036 [inline]
 __getblk_gfp+0x906/0xb10 fs/buffer.c:1313
 __bread_gfp+0x2d/0x310 fs/buffer.c:1347
 sb_bread include/linux/buffer_head.h:307 [inline]
 fat12_ent_bread+0x14e/0x3d0 fs/fat/fatent.c:75
 fat_ent_read_block fs/fat/fatent.c:441 [inline]
 fat_alloc_clusters+0x8ce/0x16e0 fs/fat/fatent.c:489
 fat_add_cluster+0x7a/0x150 fs/fat/inode.c:101
 __fat_get_block fs/fat/inode.c:148 [inline]
...

Trivial reproducer for the problem looks like:

truncate -s 1G /tmp/image
losetup /dev/loop0 /tmp/image
mkfs.ext4 -b 1024 /dev/loop0
mount -t ext4 /dev/loop0 /mnt
losetup -c /dev/loop0
l /mnt

Fix the problem by moving initialization of a block device block size
into a separate function and call it when needed.

Thanks to Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> for help with
debugging the problem.

Reported-by: syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/block_dev.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -114,6 +114,20 @@ void invalidate_bdev(struct block_device
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
+static void set_init_blocksize(struct block_device *bdev)
+{
+	unsigned bsize = bdev_logical_block_size(bdev);
+	loff_t size = i_size_read(bdev->bd_inode);
+
+	while (bsize < PAGE_SIZE) {
+		if (size & bsize)
+			break;
+		bsize <<= 1;
+	}
+	bdev->bd_block_size = bsize;
+	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+}
+
 int set_blocksize(struct block_device *bdev, int size)
 {
 	/* Size must be a power of two, and between 512 and PAGE_SIZE */
@@ -1209,18 +1223,9 @@ EXPORT_SYMBOL(check_disk_change);
 
 void bd_set_size(struct block_device *bdev, loff_t size)
 {
-	unsigned bsize = bdev_logical_block_size(bdev);
-
 	inode_lock(bdev->bd_inode);
 	i_size_write(bdev->bd_inode, size);
 	inode_unlock(bdev->bd_inode);
-	while (bsize < PAGE_SIZE) {
-		if (size & bsize)
-			break;
-		bsize <<= 1;
-	}
-	bdev->bd_block_size = bsize;
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
 EXPORT_SYMBOL(bd_set_size);
 
@@ -1297,8 +1302,10 @@ static int __blkdev_get(struct block_dev
 				}
 			}
 
-			if (!ret)
+			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
+				set_init_blocksize(bdev);
+			}
 
 			/*
 			 * If the device is invalidated, rescan partition
@@ -1333,6 +1340,7 @@ static int __blkdev_get(struct block_dev
 				goto out_clear;
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
+			set_init_blocksize(bdev);
 		}
 	} else {
 		if (bdev->bd_contains == bdev) {


