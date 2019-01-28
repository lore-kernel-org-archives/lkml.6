Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB32C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DFF2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C31ZumDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA1Fsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:48:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55924 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA1Fsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:48:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0S5mf4F005721;
        Sun, 27 Jan 2019 23:48:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548654521;
        bh=KK01tLeo1wnuqXlbcK1QwtqAIlEyKApp9qRygZsj9/U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C31ZumDmm6Z0zaodWKt33uplQ9gJhY3ZC5B+mlg/LxDxO6e4aWumy1VrZAnkdIFMF
         N2GtwAQvjYHRiO6mP31KeNkAjLsJ3CngMAmP0zBPlr3gHhbWzxJoGjsldc3Z3wo3E/
         q8yC4XDoNnakDgTEJfhtOBJpcJofrzo5/cqCq8MI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0S5mfC0005278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 27 Jan 2019 23:48:41 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 27
 Jan 2019 23:48:40 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 27 Jan 2019 23:48:41 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0S5mW5Q020800;
        Sun, 27 Jan 2019 23:48:38 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        <Tudor.Ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v5 2/2] mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller
Date:   Mon, 28 Jan 2019 11:19:35 +0530
Message-ID: <20190128054935.4972-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128054935.4972-1-vigneshr@ti.com>
References: <20190128054935.4972-1-vigneshr@ti.com>
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---

v5:
s/cqsi_base_hwcaps_mask/CQSPI_BASE_HWCAPS_MASK/g
Add back cqspi_driver_platdata definition for base compatible.

v4: Fix comments by Tudor on v3
v3: No changes
v2: Declare Octal mode capability based on compatible.

 drivers/mtd/spi-nor/cadence-quadspi.c | 58 +++++++++++++++++++++------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 04cedd3a2bf6..c8113ebe44fd 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -44,6 +44,12 @@
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 
+/* Capabilities mask */
+#define CQSPI_BASE_HWCAPS_MASK					\
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
+		hwcaps.mask = CQSPI_BASE_HWCAPS_MASK;
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
 
@@ -1460,14 +1476,32 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
 #define CQSPI_DEV_PM_OPS	NULL
 #endif
 
+static const struct cqspi_driver_platdata cdns_qspi = {
+	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
+};
+
+static const struct cqspi_driver_platdata k2g_qspi = {
+	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
+static const struct cqspi_driver_platdata am654_ospi = {
+	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK | SNOR_HWCAPS_READ_1_1_8,
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
-		.data = (void *)0,
+		.data = &cdns_qspi,
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

