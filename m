Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203DFC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34872087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078800;
	bh=3iXaa/HpYIWJjeTHQFNDe5iZ4+aNf+ycgickMFjvU+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7aNVBmZPHGW7WTsBv3NxVECaxuoCqLiBmE+YKgZEaVTD/BqiinoNcniOurfRAO3X
	 cAVeNoUPnyWBzAttCQ8pj3ona4PnVQlU3LYhvgcaYUoG0DYDOCiGJBaIMl9G8q0kkg
	 hnJypZWQ6c9U49ZJnEwSR4wl4l1NJNMF5f8TPqRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfAUNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfAUNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD46A2084C;
        Mon, 21 Jan 2019 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078794;
        bh=3iXaa/HpYIWJjeTHQFNDe5iZ4+aNf+ycgickMFjvU+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YA57Mmp5V6M9Amwbw7O98PWjgoRLs1C9Vtu6yPn/BXmhIfwn+q1SQTVd9cULv2r5B
         MHMBADOmFeY2N2DSDh5kGi2hkOQTPC+Ob+eUj1BqnKr+m91LXrR4OgUhnZkJPzq1h5
         fNJCVJKoLgJ9KXGR+MR83fADzD9ldA/ORd2qYrRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 46/59] blockdev: Fix livelocks on loop device
Date:   Mon, 21 Jan 2019 14:44:11 +0100
Message-Id: <20190121122501.891916403@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -116,6 +116,20 @@ void invalidate_bdev(struct block_device
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
@@ -1393,18 +1407,9 @@ EXPORT_SYMBOL(check_disk_change);
 
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
 
@@ -1482,8 +1487,10 @@ static int __blkdev_get(struct block_dev
 				}
 			}
 
-			if (!ret)
+			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
+				set_init_blocksize(bdev);
+			}
 
 			/*
 			 * If the device is invalidated, rescan partition
@@ -1518,6 +1525,7 @@ static int __blkdev_get(struct block_dev
 				goto out_clear;
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
+			set_init_blocksize(bdev);
 		}
 
 		if (bdev->bd_bdi == &noop_backing_dev_info)


