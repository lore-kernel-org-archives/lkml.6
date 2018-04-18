Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeDRJeG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:34:06 -0400
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:32814 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeDRJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:34:04 -0400
From: Luca Ellero <luca.ellero@brickedbrain.com>
Cc: Luca Ellero <luca.ellero@brickedbrain.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: dataflash: replace msleep with usleep_range
Date: Wed, 18 Apr 2018 11:26:26 +0200
Message-Id: <1524043588-25816-1-git-send-email-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since msleep is based on jiffies, this 3 ms sleep becomes actually 20 ms.
Worst of all, since this sleep is used in a loop when writing, a single page
write (256 to 1024 bytes) causes 17 ms extra time.
When writing large files (for example u-boot is usually 512 KB) this delay
adds up to minutes.
See Documentation/timers/timers-howto.txt "Why not msleep for (1ms - 20ms)".

Signed-off-by: Luca Ellero <luca.ellero@brickedbrain.com>
---
 drivers/mtd/devices/mtd_dataflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index aaaeaae..3a6f450 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -140,7 +140,7 @@ static int dataflash_waitready(struct spi_device *spi)
 		if (status & (1 << 7))	/* RDY/nBSY */
 			return status;
 
-		msleep(3);
+		usleep_range(3000, 4000);
 	}
 }
 
-- 
2.7.4
