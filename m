Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537BAC004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F95D21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F95D21536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeI0EXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:11 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36015 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeI0EXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBs20MwMz1r8Sj;
        Thu, 27 Sep 2018 00:08:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBs15th9z1qqkx;
        Thu, 27 Sep 2018 00:08:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id VY_CAiFV086f; Thu, 27 Sep 2018 00:08:03 +0200 (CEST)
X-Auth-Info: pmJFyPFt2hlWNGS/bJUrr4wHGs+Ay2NFmUGNaeDRlj4=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:08:03 +0200 (CEST)
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
Subject: [RFC/RFT PATCH v1 3/9] mtd: spi: Do not setup the default seqid as we got it set for DUAL and QUAD
Date:   Thu, 27 Sep 2018 00:07:33 +0200
Message-Id: <20180926220739.620-4-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 2ef5bfc41d32..ad951a46a628 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -686,7 +686,6 @@ static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
 static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
-	int seqid;
 	u32 buf3cr;
 
 	/* AHB configuration for access buffer 0/1/2 .*/
@@ -708,11 +707,6 @@ static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 	qspi_writel(q, 0, base + QUADSPI_BUF0IND);
 	qspi_writel(q, 0, base + QUADSPI_BUF1IND);
 	qspi_writel(q, 0, base + QUADSPI_BUF2IND);
-
-	/* Set the default lut sequence for AHB Read. */
-	seqid = fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
-	qspi_writel(q, seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
-		q->iobase + QUADSPI_BFGENCR);
 }
 
 /* This function was used to prepare and enable QSPI clock */
-- 
2.11.0

