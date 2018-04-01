Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeDABmO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:14 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47370 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbeDABlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:08 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <98a06aa971599e04715a718abdd83eb5742a36da.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 05/12] block/swim: Use HEDSEL bit in ISM mode register
Date: Sat, 31 Mar 2018 21:41:05 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The floppy drive 'HEDSEL' line is normally connected to VIA1 but some
models don't do this. According to 'The Guide to Macintosh Family
Hardware', on the Mac IIfx the SWIM device has to generate this
signal.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c  |  1 +
 drivers/block/swim.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 7864dcca5891..23cf89da0c2d 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -130,6 +130,7 @@
 /* Non-zero if the IOPs are present */
 
 int iop_scc_present, iop_ism_present;
+EXPORT_SYMBOL(iop_ism_present);
 
 /* structure for tracking channel listeners */
 
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index ef4361dc5b26..3e3e72b141d3 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/mac_via.h>
+#include <asm/mac_iop.h>
 
 #define CARDNAME "swim"
 
@@ -135,7 +136,8 @@ struct iwm {
 
 /* bits in setup register */
 
-#define S_INV_WDATA	0x01
+#define S_Q3_OUTPUT	0x01 /* SWIM */
+#define S_INV_WDATA	0x01 /* SWIM 2 */
 #define S_3_5_SELECT	0x02
 #define S_GCR		0x04
 #define S_FCLK_DIV2	0x08
@@ -273,8 +275,13 @@ static inline void swim_select(struct swim __iomem *base, int sel)
 {
 	swim_write(base, phase, RELAX);
 
-	via1_set_head(sel & 0x100);
-
+	if (iop_ism_present) {
+		if (sel & 0x100)
+			swim_write(base, mode1, HEDSEL);
+		else
+			swim_write(base, mode0, HEDSEL);
+	} else
+		via1_set_head(sel & 0x100);
 	swim_write(base, phase, sel & CA_MASK);
 }
 
@@ -644,7 +651,12 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	else
 		fs->ref_count++;
 
-	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
+	if (iop_ism_present)
+		swim_write(base, setup, S_IBM_DRIVE | S_FCLK_DIV2 |
+			   S_Q3_OUTPUT);
+	else
+		swim_write(base, setup, S_IBM_DRIVE | S_FCLK_DIV2);
+
 	udelay(10);
 	swim_drive(base, INTERNAL_DRIVE);
 	swim_motor(base, ON);
-- 
2.16.1
