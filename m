Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1203020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3LfJsMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1203020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbeKLITJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387485AbeKLITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54B221527;
        Sun, 11 Nov 2018 22:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975352;
        bh=Sji0nT6a9wI+3u/08+fj2goju6675y6+bnFi1DpeWr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3LfJsMT8r/AmPQyfrutADt/v7fRI71Jeu/Shl6A4uWrCHZHz2AaHFxgnx5YPWvmz
         CzxK9Ig23HnIF96yVbqc5oRv+F0maT5ADdQc15yB+SekQeqNzKocoqC+VXhZETRJ7e
         GrY//I0mMcG7s2SrRFxVpLWI42gA6cYisClPpRq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 004/350] mtd: spi-nor: fsl-quadspi: Dont let -EINVAL on the bus
Date:   Sun, 11 Nov 2018 14:17:48 -0800
Message-Id: <20181111221707.277048061@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/fsl-quadspi.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -544,6 +544,9 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 c
 
 	/* trigger the LUT now */
 	seqid = fsl_qspi_get_seqid(q, cmd);
+	if (seqid < 0)
+		return seqid;
+
 	qspi_writel(q, (seqid << QUADSPI_IPCR_SEQID_SHIFT) | len,
 			base + QUADSPI_IPCR);
 
@@ -672,7 +675,7 @@ static void fsl_qspi_set_map_addr(struct
  * causes the controller to clear the buffer, and use the sequence pointed
  * by the QUADSPI_BFGENCR[SEQID] to initiate a read from the flash.
  */
-static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
+static int fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	int seqid;
@@ -697,8 +700,13 @@ static void fsl_qspi_init_ahb_read(struc
 
 	/* Set the default lut sequence for AHB Read. */
 	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
+	if (seqid < 0)
+		return seqid;
+
 	qspi_writel(q, seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
 		q->iobase + QUADSPI_BFGENCR);
+
+	return 0;
 }
 
 /* This function was used to prepare and enable QSPI clock */
@@ -806,9 +814,7 @@ static int fsl_qspi_nor_setup_last(struc
 	fsl_qspi_init_lut(q);
 
 	/* Init for AHB read */
-	fsl_qspi_init_ahb_read(q);
-
-	return 0;
+	return fsl_qspi_init_ahb_read(q);
 }
 
 static const struct of_device_id fsl_qspi_dt_ids[] = {


