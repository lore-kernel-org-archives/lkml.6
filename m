Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeFCMBY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:01:24 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:49430 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeFCMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:01:23 -0400
From: Martin Kaiser <martin@kaiser.cx>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>, stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: mxc: set spare area size register explicitly
Date: Sun,  3 Jun 2018 13:31:35 +0200
Message-Id: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v21 version of the NAND flash controller contains a Spare Area Size
Register (SPAS) at offset 0x10. Its setting defaults to the maximum
spare area size of 218 bytes. The size that is set in this register is
used by the controller when it calculates the ECC bytes internally in
hardware.

Usually, this register is updated from settings in the IIM fuses when
the system is booting from nand flash. For other boot media, however,
the SPAS register remains at the default setting, which may not work for
the particular flash chip on the board. The same goes for flash chips
whose configuration cannot be set in the IIM fuses (e.g. chips with 2k
sector size and 128 bytes spare area size can't be configured in the IIM
fuses on imx25 systems).

Set the SPAS register explicitly during the preset operation. Derive the
register value from mtd->oobsize that was detected during probe by
decoding the flash chip's ID bytes.

While at it, rename the define for the spare area register's offset to
NFC_V21_RSLTSPARE_AREA. The register at offset 0x10 on v1 controllers is
different from the register on v21 controllers.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Cc: stable@vger.kernel.org
---
 drivers/mtd/nand/raw/mxc_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 45786e7..c2f8572 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -48,7 +48,7 @@
 #define NFC_V1_V2_CONFIG		(host->regs + 0x0a)
 #define NFC_V1_V2_ECC_STATUS_RESULT	(host->regs + 0x0c)
 #define NFC_V1_V2_RSLTMAIN_AREA		(host->regs + 0x0e)
-#define NFC_V1_V2_RSLTSPARE_AREA	(host->regs + 0x10)
+#define NFC_V21_RSLTSPARE_AREA		(host->regs + 0x10)
 #define NFC_V1_V2_WRPROT		(host->regs + 0x12)
 #define NFC_V1_UNLOCKSTART_BLKADDR	(host->regs + 0x14)
 #define NFC_V1_UNLOCKEND_BLKADDR	(host->regs + 0x16)
@@ -1274,6 +1274,9 @@ static void preset_v2(struct mtd_info *mtd)
 	writew(config1, NFC_V1_V2_CONFIG1);
 	/* preset operation */
 
+	/* spare area size in 16bit words */
+	writew(mtd->oobsize >> 1, NFC_V21_RSLTSPARE_AREA);
+
 	/* Unlock the internal RAM Buffer */
 	writew(0x2, NFC_V1_V2_CONFIG);
 
-- 
2.1.4
