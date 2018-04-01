Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDABmI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:08 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47388 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeDABlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:08 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6b8e15516afd2179cdc1073793d22a7bdb04e32f.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 10/12] block/swim: Check drive type
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SWIM chip is compatible with GCR-mode Sony 400K/800K drives but
this driver only supports MFM mode. Therefore only Sony FDHD drives
are supported. Skip incompatible drives.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/block/swim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index d69cc5dadbfc..6e3ebf5519e3 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -841,10 +841,12 @@ static int swim_floppy_init(struct swim_priv *swd)
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, INTERNAL_DRIVE);
 	swim_drive(base, EXTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
 
 	/* register floppy drives */
-- 
2.16.1
