Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeDABld (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:41:33 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47454 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeDABlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:10 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <eada494d870cf0c71479cf48927b4a95c64a1062.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 11/12] block/swim: Fix IO error at end of medium
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading to the end of a 720K disk results in an IO error instead of EOF
because the block layer thinks the disk has 2880 sectors. (Partly this
is a result of inverted logic of the ONEMEG_MEDIA bit that's now fixed.)

Initialize the density and head count in swim_add_floppy() to agree
with the device size passed to set_capacity() during drive probe.

Call set_capacity() again upon device open, after refreshing the density
and head count values.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6e3ebf5519e3..c4eb54575574 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -619,7 +619,6 @@ static void setup_medium(struct floppy_state *fs)
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
@@ -627,6 +626,9 @@ static void setup_medium(struct floppy_state *fs)
 
 		swim_track00(base);
 
+		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
+			HD_MEDIA : DD_MEDIA;
+		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
 		get_floppy_geometry(fs, 0, &g);
 		fs->total_secs = g->size;
 		fs->secpercyl = g->head * g->sect;
@@ -668,6 +670,8 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
+	set_capacity(fs->disk, fs->total_secs);
+
 	if (mode & FMODE_NDELAY)
 		return 0;
 
@@ -820,10 +824,9 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	swim_motor(base, OFF);
 
-	if (swim_readbit(base, SINGLE_SIDED))
-		fs->head_number = 1;
-	else
-		fs->head_number = 2;
+	fs->type = HD_MEDIA;
+	fs->head_number = 2;
+
 	fs->ref_count = 0;
 	fs->ejected = 1;
 
-- 
2.16.1
