Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB9C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C993321473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ExJOmNFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C993321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJDSFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39156 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeJDSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:36 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BChOF025698;
        Thu, 4 Oct 2018 06:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651563;
        bh=gSiiSenYlRgUGWBAfqKK9LZnMSt1kNgCwLYq/p2FUNM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ExJOmNFqDE0adxmeLgpSImZIUNCNxcRJx9ynjMfHv8IVlSQDIPxX7orOB4aI2XHZs
         M4Ds6nAfoi0qnlSr4webT1UwSWfeFndNY4KlchXKfBpP1HNrm9k1286njc1g/IEsNb
         lKDg4mUsC3OXZHxdg2ZD4PzxhnHRG2VM0qEJMzPM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BChnT016217;
        Thu, 4 Oct 2018 06:12:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:12:43 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:12:43 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCSLe027478;
        Thu, 4 Oct 2018 06:12:40 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <faiz_abbas@ti.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>,
        <adrian.hunter@intel.com>
Subject: [PATCH 4/6] mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map
Date:   Thu, 4 Oct 2018 16:44:49 +0530
Message-ID: <20181004111451.9539-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver passes platform data as a global structure
and uses the .data of of_device_id to pass the soc_ctl_map. To
make the implementation more flexible add a single data structure
that incorporates both of the above and pass it in the .data of
of_device_id.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 47 ++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b806b24a3e5f..c9e3e050ccc8 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -107,6 +107,11 @@ struct sdhci_arasan_data {
 #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
 };
 
+struct sdhci_arasan_of_data {
+	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	const struct sdhci_pltfm_data *pdata;
+};
+
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
 	.clockmultiplier = { .reg = 0xf02c, .width = 8, .shift = 0},
@@ -307,6 +312,10 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
+static struct sdhci_arasan_of_data sdhci_arasan_data = {
+	.pdata = &sdhci_arasan_pdata,
+};
+
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -363,6 +372,11 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
+	.soc_ctl_map = &rk3399_soc_ctl_map,
+	.pdata = &sdhci_arasan_cqe_pdata,
+};
+
 #ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
@@ -462,14 +476,21 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* SoC-specific compatible strings w/ soc_ctl_map */
 	{
 		.compatible = "rockchip,rk3399-sdhci-5.1",
-		.data = &rk3399_soc_ctl_map,
+		.data = &sdhci_arasan_rk3399_data,
 	},
-
 	/* Generic compatible below here */
-	{ .compatible = "arasan,sdhci-8.9a" },
-	{ .compatible = "arasan,sdhci-5.1" },
-	{ .compatible = "arasan,sdhci-4.9a" },
-
+	{
+		.compatible = "arasan,sdhci-8.9a",
+		.data = &sdhci_arasan_data,
+	},
+	{
+		.compatible = "arasan,sdhci-5.1",
+		.data = &sdhci_arasan_data,
+	},
+	{
+		.compatible = "arasan,sdhci-4.9a",
+		.data = &sdhci_arasan_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
@@ -707,14 +728,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
-	const struct sdhci_pltfm_data *pdata;
-
-	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-5.1"))
-		pdata = &sdhci_arasan_cqe_pdata;
-	else
-		pdata = &sdhci_arasan_pdata;
+	const struct sdhci_arasan_of_data *data;
 
-	host = sdhci_pltfm_init(pdev, pdata, sizeof(*sdhci_arasan));
+	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
+	data = match->data;
+	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
 	if (IS_ERR(host))
 		return PTR_ERR(host);
@@ -723,8 +741,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	sdhci_arasan->host = host;
 
-	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
-	sdhci_arasan->soc_ctl_map = match->data;
+	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
 
 	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
 	if (node) {
-- 
2.18.0

