Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BF8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A1320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A1320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLIVzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72r-0002io-06; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hI-LH; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "kbuild test robot" <fengguang.wu@intel.com>,
        "Brian Norris" <computersforpeace@gmail.com>,
        "Han Xu" <b45815@freescale.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.561614094@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 320/328] mtd: fsl-quadspi: fix macro collision
 problems with READ/WRITE
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Han Xu <b45815@freescale.com>

commit 04850c4d8613127a9b488321c0ad83bff7519311 upstream.

Change the READ/WRITE to FSL_READ/FSL_WRITE to resolve any possible
namespace collisions with READ/WRITE macros (e.g., from <linux/fs.h>).

Problems have been seen, for example, on mips:

>> drivers/mtd/spi-nor/fsl-quadspi.c:186:5: error: 'LUT_0' undeclared (first use in this function)
      ((LUT_##ins) << INSTR0_SHIFT))
        ^
>> drivers/mtd/spi-nor/fsl-quadspi.c:188:30: note: in expansion of macro 'LUT0'

On SPARC:

drivers/mtd/spi-nor/fsl-quadspi.c: In function 'fsl_qspi_init_lut':
drivers/mtd/spi-nor/fsl-quadspi.c:369:1: error: 'LUT_0' undeclared (first use in this function)
drivers/mtd/spi-nor/fsl-quadspi.c:418:1: error: pasting "LUT_" and "(" does not give a valid preprocessing token
drivers/mtd/spi-nor/fsl-quadspi.c:418:2: error: implicit declaration of function 'LUT_'

And surely on others.

Fixes: d26a22d06708 ("mtd: fsl-quadspi: allow building for other ARCHes with COMPILE_TEST")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Han Xu <b45815@freescale.com>
[Brian: rewrote commit description]
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -138,15 +138,15 @@
 #define LUT_MODE		4
 #define LUT_MODE2		5
 #define LUT_MODE4		6
-#define LUT_READ		7
-#define LUT_WRITE		8
+#define LUT_FSL_READ		7
+#define LUT_FSL_WRITE		8
 #define LUT_JMP_ON_CS		9
 #define LUT_ADDR_DDR		10
 #define LUT_MODE_DDR		11
 #define LUT_MODE2_DDR		12
 #define LUT_MODE4_DDR		13
-#define LUT_READ_DDR		14
-#define LUT_WRITE_DDR		15
+#define LUT_FSL_READ_DDR		14
+#define LUT_FSL_WRITE_DDR		15
 #define LUT_DATA_LEARN		16
 
 /*
@@ -306,7 +306,7 @@ static void fsl_qspi_init_lut(struct fsl
 
 	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(READ, PAD4, rxfifo),
+	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(FSL_READ, PAD4, rxfifo),
 			base + QUADSPI_LUT(lut_base + 1));
 
 	/* Write enable */
@@ -327,11 +327,11 @@ static void fsl_qspi_init_lut(struct fsl
 
 	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
+	writel(LUT0(FSL_WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
 
 	/* Read Status */
 	lut_base = SEQID_RDSR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDSR) | LUT1(READ, PAD1, 0x1),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDSR) | LUT1(FSL_READ, PAD1, 0x1),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Erase a sector */
@@ -356,17 +356,17 @@ static void fsl_qspi_init_lut(struct fsl
 
 	/* READ ID */
 	lut_base = SEQID_RDID * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDID) | LUT1(READ, PAD1, 0x8),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDID) | LUT1(FSL_READ, PAD1, 0x8),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Write Register */
 	lut_base = SEQID_WRSR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_WRSR) | LUT1(WRITE, PAD1, 0x2),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_WRSR) | LUT1(FSL_WRITE, PAD1, 0x2),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Read Configuration Register */
 	lut_base = SEQID_RDCR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDCR) | LUT1(READ, PAD1, 0x1),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDCR) | LUT1(FSL_READ, PAD1, 0x1),
 			base + QUADSPI_LUT(lut_base));
 
 	/* Write disable */

