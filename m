Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF35C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA321533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA321533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeI0EXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:18 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:55253 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0EXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:17 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBs86MPhz1qtPb;
        Thu, 27 Sep 2018 00:08:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBs84wh0z1qqkx;
        Thu, 27 Sep 2018 00:08:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fJ9kkklT1FUg; Thu, 27 Sep 2018 00:08:10 +0200 (CEST)
X-Auth-Info: G1LAftSGVrkM3pbRMIXCVGXxxhH75Q8HzephrSM4QBQ=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:08:10 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 6/9] mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and QUAD
Date:   Thu, 27 Sep 2018 00:07:36 +0200
Message-Id: <20180926220739.620-7-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit not only provides the DUAL and QUAD read capability for QSPI
controller, but also resets the AHB pointer sequence (as recommended) and
makes sure that AHB - not IP - mode is used for reading SPI-NOR data to
internal buffer.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 0c381cdfb39f..97546fa70b79 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -119,6 +119,10 @@
 #define QUADSPI_FR			0x160
 #define QUADSPI_FR_TFF_MASK		0x1
 
+#define QUADSPI_SPTRCLR                 0x16c
+#define QUADSPI_SPTRCLR_BFPTRC_SHIFT    0
+#define QUADSPI_SPTRCLR_BFPTRC_MASK     (0x1 << QUADSPI_SPTRCLR_BFPTRC_SHIFT)
+
 #define QUADSPI_SFA1AD			0x180
 #define QUADSPI_SFA2AD			0x184
 #define QUADSPI_SFB1AD			0x188
@@ -903,6 +907,22 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 {
 	struct fsl_qspi *q = nor->priv;
 	u8 cmd = nor->read_opcode;
+	int seqid;
+
+	/* Set the actual lut sequence for AHB Read from the considered nor. */
+	seqid = fsl_qspi_get_seqid(q, nor->read_opcode);
+	if (seqid < 0)
+		return seqid;
+
+	qspi_writel(q, seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
+		    q->iobase + QUADSPI_BFGENCR);
+
+	/* Reset the AHB sequence pointer */
+	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC_MASK,
+		    q->iobase + QUADSPI_SPTRCLR);
+
+	/* make sure the Rx buffer is read through AHB, not IP */
+	qspi_writel(q, QUADSPI_RBCT_WMRK_MASK, q->iobase + QUADSPI_RBCT);
 
 	/* if necessary,ioremap buffer before AHB read, */
 	if (!q->ahb_addr) {
-- 
2.11.0

