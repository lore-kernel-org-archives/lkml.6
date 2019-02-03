Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBB0C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2573A2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfBCOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:19:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55136 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728187AbfBCOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:45 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIca-000621-2X; Sun, 03 Feb 2019 14:19:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006ss-AN; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.224107255@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 071/305] mtd: spi-nor: fsl-quadspi: Don't let -EINVAL
 on the bus
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit 000412276370a9bcfec73b3752ceefd9a927f1db upstream.

fsl_qspi_get_seqid() may return -EINVAL, but fsl_qspi_init_ahb_read()
doesn't check for error codes with the result that -EINVAL could find
itself signalled over the bus.

In conjunction with the LS1046A SoC's A-009283 errata
("Illegal accesses to SPI flash memory can result in a system hang")
this illegal access to SPI flash memory results in a system hang
if userspace attempts reading later on.

Avoid this by always checking fsl_qspi_get_seqid()'s return value
and bail out otherwise.

Fixes: e46ecda764dc ("mtd: spi-nor: Add Freescale QuadSPI driver")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -451,6 +451,9 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 c
 
 	/* trigger the LUT now */
 	seqid = fsl_qspi_get_seqid(q, cmd);
+	if (seqid < 0)
+		return seqid;
+
 	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len, base + QUADSPI_IPCR);
 
 	/* Wait for the interrupt. */
@@ -574,7 +577,7 @@ static void fsl_qspi_set_map_addr(struct
  * causes the controller to clear the buffer, and use the sequence pointed
  * by the QUADSPI_BFGENCR[SEQID] to initiate a read from the flash.
  */
-static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
+static int fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	int seqid;
@@ -592,8 +595,13 @@ static void fsl_qspi_init_ahb_read(struc
 
 	/* Set the default lut sequence for AHB Read. */
 	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
+	if (seqid < 0)
+		return seqid;
+
 	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
 		q->iobase + QUADSPI_BFGENCR);
+
+	return 0;
 }
 
 /* We use this function to do some basic init for spi_nor_scan(). */
@@ -647,9 +655,7 @@ static int fsl_qspi_nor_setup_last(struc
 	fsl_qspi_init_lut(q);
 
 	/* Init for AHB read */
-	fsl_qspi_init_ahb_read(q);
-
-	return 0;
+	return fsl_qspi_init_ahb_read(q);
 }
 
 static struct of_device_id fsl_qspi_dt_ids[] = {

