Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VowY2zFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfAVGlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:41:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33088 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:41:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0M6f1Di069824;
        Tue, 22 Jan 2019 00:41:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548139261;
        bh=TyVw+AaXUyxDY23EjMXkc8cZKyg7IQIhvG1BoIMxjP8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VowY2zFfd/zfBEGQvEvVdh+J4W0ZzOwGJcWXkPEw1hPVK+6bAha47/cxvwgvgeUoA
         z3B4nRLV5VT5pcbVuIS9hiprYui+VKAcNVjdz0wge5jHvMlea0HURGx23WXujxTGeW
         Gzw/ZYnc/90phXaV+SuxQ42uxtqTTN5d0llepJMw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0M6f1JN029537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 00:41:01 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 22
 Jan 2019 00:41:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 22 Jan 2019 00:41:00 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0M6eqrt019930;
        Tue, 22 Jan 2019 00:40:58 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        <Tudor.Ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4 2/2] mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller
Date:   Tue, 22 Jan 2019 12:11:37 +0530
Message-ID: <20190122064137.17114-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122064137.17114-1-vigneshr@ti.com>
References: <20190122064137.17114-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence OSPI controller IP supports Octal IO (x8 IO lines),
It also has an integrated PHY. IP register layout is very
similar to existing QSPI IP except for additional bits to support Octal
and Octal DDR mode. Therefore, extend current driver to support Octal
mode. Only Octal SDR read (1-1-8)mode is supported for now.

Tested with mt35xu512aba Octal flash on TI's AM654 EVM.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v4: Fix comments by Tudor on v3
v3: No changes
v2: Declare Octal mode capability based on compatible.

 drivers/mtd/spi-nor/cadence-quadspi.c | 53 +++++++++++++++++++++------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 04cedd3a2bf6..2091addc45a3 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -44,6 +44,12 @@
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 
+/* Capabilities mask */
+#define cqspi_base_hwcaps_mask					\
+	(SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |		\
+	SNOR_HWCAPS_READ_1_1_2 | SNOR_HWCAPS_READ_1_1_4 |	\
+	SNOR_HWCAPS_PP)
+
 struct cqspi_st;
 
 struct cqspi_flash_pdata {
@@ -93,6 +99,11 @@ struct cqspi_st {
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
 };
 
+struct cqspi_driver_platdata {
+	u32 hwcaps_mask;
+	u8 quirks;
+};
+
 /* Operation timeout value */
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
@@ -101,6 +112,7 @@ struct cqspi_st {
 #define CQSPI_INST_TYPE_SINGLE			0
 #define CQSPI_INST_TYPE_DUAL			1
 #define CQSPI_INST_TYPE_QUAD			2
+#define CQSPI_INST_TYPE_OCTAL			3
 
 #define CQSPI_DUMMY_CLKS_PER_BYTE		8
 #define CQSPI_DUMMY_BYTES_MAX			4
@@ -911,6 +923,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
 		case SNOR_PROTO_1_1_4:
 			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
 			break;
+		case SNOR_PROTO_1_1_8:
+			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1213,21 +1228,22 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 {
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_READ_1_1_2 |
-			SNOR_HWCAPS_READ_1_1_4 |
-			SNOR_HWCAPS_PP,
-	};
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
+	const struct cqspi_driver_platdata *ddata;
+	struct spi_nor_hwcaps hwcaps;
 	struct cqspi_flash_pdata *f_pdata;
 	struct spi_nor *nor;
 	struct mtd_info *mtd;
 	unsigned int cs;
 	int i, ret;
 
+	ddata = of_device_get_match_data(dev);
+	if (!ddata)
+		hwcaps.mask = cqspi_base_hwcaps_mask;
+	else
+		hwcaps.mask = ddata->hwcaps_mask;
+
 	/* Get flash device data */
 	for_each_available_child_of_node(dev->of_node, np) {
 		ret = of_property_read_u32(np, "reg", &cs);
@@ -1310,7 +1326,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	struct cqspi_st *cqspi;
 	struct resource *res;
 	struct resource *res_ahb;
-	unsigned long data;
+	const struct cqspi_driver_platdata *ddata;
 	int ret;
 	int irq;
 
@@ -1377,8 +1393,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
-	data  = (unsigned long)of_device_get_match_data(dev);
-	if (data & CQSPI_NEEDS_WR_DELAY)
+	ddata  = of_device_get_match_data(dev);
+	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
 		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
 						   cqspi->master_ref_clk_hz);
 
@@ -1460,14 +1476,27 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
 #define CQSPI_DEV_PM_OPS	NULL
 #endif
 
+static const struct cqspi_driver_platdata k2g_qspi = {
+	.hwcaps_mask = cqspi_base_hwcaps_mask,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
+static const struct cqspi_driver_platdata am654_ospi = {
+	.hwcaps_mask = cqspi_base_hwcaps_mask | SNOR_HWCAPS_READ_1_1_8,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
-		.data = (void *)0,
 	},
 	{
 		.compatible = "ti,k2g-qspi",
-		.data = (void *)CQSPI_NEEDS_WR_DELAY,
+		.data = &k2g_qspi,
+	},
+	{
+		.compatible = "ti,am654-ospi",
+		.data = &am654_ospi,
 	},
 	{ /* end of table */ }
 };
-- 
2.20.1

