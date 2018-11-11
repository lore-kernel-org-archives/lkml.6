Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6042084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXQom0Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6042084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeKLKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbeKLIQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:58 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 277CB214F1;
        Sun, 11 Nov 2018 22:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975223;
        bh=9swfgSmAHjZZyr+P/Ut6mXdgQdBN/ToIzj/STWHgm7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXQom0KqglSKNx6CRNN66LYKmWx9t0BzEXpDC37YdQe6eoFovFSo4ZpR4uKJoKq89
         7JshJv0j4G9jvatExt1jbXQYCy/h3CV1mvbja8hxx41UHT0CrfWP42oR5y9WvLUsrL
         SFFmmfxRUrwaoyWQh5ay59/L2ymPBYmsUMsvQnU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 008/361] mtd: spi-nor: fsl-quadspi: Dont let -EINVAL on the bus
Date:   Sun, 11 Nov 2018 14:15:55 -0800
Message-Id: <20181111221621.132095362@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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


