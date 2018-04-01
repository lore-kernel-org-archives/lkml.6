Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeDABmK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47382 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeDABlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:08 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <803fabab1f0349bafe52b5589eff3edc077eee2d.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/12] block/swim: Don't log an error message for an invalid
 ioctl
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'eject' shell command may send various different ioctl commands.
This leads to error messages on the console even though the FDEJECT
ioctl succeeds.

~# eject floppy
SWIM floppy_ioctl: unknown cmd 21257
SWIM floppy_ioctl: unknown cmd 1

Don't log an error message for an invalid ioctl, just do as the
swim3 driver does and return -ENOTTY.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 19d7d27468c7..8be0d92bc431 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -739,14 +739,9 @@ static int floppy_ioctl(struct block_device *bdev, fmode_t mode,
 		if (copy_to_user((void __user *) param, (void *) &floppy_type,
 				 sizeof(struct floppy_struct)))
 			return -EFAULT;
-		break;
-
-	default:
-		printk(KERN_DEBUG "SWIM floppy_ioctl: unknown cmd %d\n",
-		       cmd);
-		return -ENOSYS;
+		return 0;
 	}
-	return 0;
+	return -ENOTTY;
 }
 
 static int floppy_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
2.16.1
