Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A40C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8786B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="NJR5ZwPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1N5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:57:06 -0500
Received: from mout01.posteo.de ([185.67.36.65]:52572 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfA1N5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:57:06 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 666D016005D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 14:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548683823; bh=g6yNiMWn6EjFFGIM7uaWlBOhraSmLS6EY9e6o02kLro=;
        h=From:To:Cc:Subject:Date:From;
        b=NJR5ZwPnwhvcne+2mzo4wqPIPdaE3etkl6NWzvprvfGlzYe/sBEI3I43U6wdSEg7+
         SpavZhcEcZlQEU4d2GL/GFH822tBHg0cH/auRz9zk3JWtb4tyXmxAljfx1+udJJMDf
         0pS8yW0zh+ab4UrlCMhhuRSOasD1bghlYMl2apiRRRSFhioSQDfYS18icIxnVWLQo7
         c1hItkPbq4Yf7oErB++gtsxmWorDv48bdyzqrNqa3FQvv/Uy8i2a5eaNNZXTUwUZl8
         hIWTM+ZpCVwa7O3ULyfs+ZPQ33E8RSXPjNy9a2wWuE9R1j5SdfWuNvaQmdRUEaNnq7
         wfDFlZniuEoqw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pB5748rCz6tmG;
        Mon, 28 Jan 2019 14:56:59 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robin@protonic.nl, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v3] mmc: mxs-mmc: Introduce regulator support
Date:   Mon, 28 Jan 2019 14:56:47 +0100
Message-Id: <20190128135647.20121-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 WL1271 wifi controllers on imx28.

While the wifi's vmmc-supply regulator can be configured in devicetree,
"ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
to hangs when loading firmware, for example.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Thanks Ulf for your review and keeping this up with the current API.            
                                                                                
                            martin                                              
                                                                                
                                                                                
revision history                                                                
----------------                                                                
v3: improve API usage as suggested by Ulf
v2: tested patch with changes suggested by Robin                                
v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in



 drivers/mmc/host/mxs-mmc.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..af6068152929 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,27 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (host->mmc->supply.vmmc &&
+	    ios->power_mode != host->mmc->ios.power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (mmc_regulator_set_ocr(host->mmc,
+						  host->mmc->supply.vmmc, 0))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			break;
+		case MMC_POWER_UP:
+			if (mmc_regulator_set_ocr(host->mmc,
+						  host->mmc->supply.vmmc,
+						  ios->vdd))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -588,7 +609,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores;
 	int ret = 0, irq_err;
-	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
 	irq_err = platform_get_irq(pdev, 0);
@@ -614,15 +634,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
 
-	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
-	}
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret)
+		goto out_mmc_free;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
2.20.1

