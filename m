Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeDABlN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:41:13 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47332 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbeDABlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:41:07 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8b6687388074cd4be70b625f874292cd062e0b04.1522546571.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 04/12] m68k/mac: Place ISM IOP in bypass mode
Date: Sat, 31 Mar 2018 21:41:04 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Mac models have an IOP for offloading floppy disk IO. Linux once
had a driver for that but it got removed in commit b21a323710e7
("[PATCH] remove the broken BLK_DEV_SWIM_IOP driver").

Put the ISM IOP into bypass mode so that the existing 'swim_mod' driver
can access the controller directly. Use the appropriate macros for the
flag bits.

Cc: Laurent Vivier <lvivier@redhat.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 9bfa17015768..7864dcca5891 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -234,6 +234,7 @@ static struct iop_msg *iop_get_unused_msg(void)
  * is to find and initialize the IOPs early in the boot sequence, so that
  * the serial IOP can be placed into bypass mode _before_ we try to
  * initialize the serial console.
+ * The ISM IOP is put into bypass mode for compatibility with the swim driver.
  */
 
 void __init iop_preinit(void)
@@ -244,7 +245,8 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_SCC] = (struct mac_iop *) SCC_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_SCC]->status_ctrl = 0x87;
+		iop_base[IOP_NUM_SCC]->status_ctrl = IOP_BYPASS | IOP_AUTOINC |
+						     IOP_RUN | IOP_DMAINACTIVE;
 		iop_scc_present = 1;
 	} else {
 		iop_base[IOP_NUM_SCC] = NULL;
@@ -256,7 +258,8 @@ void __init iop_preinit(void)
 		} else {
 			iop_base[IOP_NUM_ISM] = (struct mac_iop *) ISM_IOP_BASE_QUADRA;
 		}
-		iop_base[IOP_NUM_ISM]->status_ctrl = 0;
+		iop_base[IOP_NUM_ISM]->status_ctrl = IOP_BYPASS | IOP_AUTOINC |
+						     IOP_RUN | IOP_DMAINACTIVE;
 		iop_ism_present = 1;
 	} else {
 		iop_base[IOP_NUM_ISM] = NULL;
-- 
2.16.1
