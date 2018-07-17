Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BCE206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BCE206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGQRCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:02:16 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39151 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeGQRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:02:15 -0400
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="16346073"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 09:28:48 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 09:28:47 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anuragku@xilinx.com>,
        <cyrille.pitchen@microchip.com>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 3/3] mtd: spi-nor: add support for Microchip SST26 QSPI flash memories
Date:   Tue, 17 Jul 2018 19:28:31 +0300
Message-ID: <20180717162831.17947-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180717162831.17947-1-tudor.ambarus@microchip.com>
References: <20180717162831.17947-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash memories are write-protected by default at power-on and
must be unlocked first, before being erased, then programmed.

The erase block sizes are not uniform. The memory layout is uniform
just for the 4K sector blocks.

Based on initial work done by Cyrille Pitchen.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index eddf09f..06d7023 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1164,10 +1164,30 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
 	{
+		"sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
+		"sst26vf032b", INFO(0xbf2642, 0, 64 * 1024, 64,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
 		"sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			UNLOCK_GLOBAL_BLOCK)
 	},
+	{
+		"sst26vf040b", INFO(0xbf2654, 0, 64 * 1024, 8,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
+	{
+		"sst26vf080b", INFO(0xbf2658, 0, 64 * 1024, 16,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			UNLOCK_GLOBAL_BLOCK)
+	},
 
 	/* ST Microelectronics -- newer production may have feature updates */
 	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
-- 
2.9.4

