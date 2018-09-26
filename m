Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA210C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604E821564
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604E821564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0EXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59627 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeI0EXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:13 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBs42lZWz1qtP7;
        Thu, 27 Sep 2018 00:08:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBs41Dskz1qqkx;
        Thu, 27 Sep 2018 00:08:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tOchIFRPIMRU; Thu, 27 Sep 2018 00:08:06 +0200 (CEST)
X-Auth-Info: Wxfm2S9qmloT8Vy+aKMyypntjCdysvVnKakzALTAo+U=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:08:06 +0200 (CEST)
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
Subject: [RFC/RFT PATCH v1 4/9] mtd: spi: Modify the HW capability mask according to supported RX lanes
Date:   Thu, 27 Sep 2018 00:07:34 +0200
Message-Id: <20180926220739.620-5-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may happen that we got two identical SPI devices connected to the QSPI
controller with asymmetrical number of RX lanes. Due to PCB constraints,
one can work as DUAL and second as QUAD.

For such scenario we do need support for setting different read commands.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index ad951a46a628..4f0c78ba6fcb 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -977,7 +977,7 @@ static void fsl_qspi_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
 
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
+	struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ_1_1_4 |
 			SNOR_HWCAPS_PP,
 	};
@@ -987,7 +987,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct spi_nor *nor;
 	struct mtd_info *mtd;
-	int ret, i = 0;
+	int ret, i = 0, width;
 
 	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
 	if (!q)
@@ -1104,6 +1104,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto mutex_failed;
 
+		if (!of_property_read_u32(np, "spi-rx-bus-width", &width)) {
+			if (width == 2) {
+				hwcaps.mask &= ~SNOR_HWCAPS_READ_QUAD;
+				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
+			} else if (width != 4)
+				return -EINVAL;
+		}
+
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
-- 
2.11.0

