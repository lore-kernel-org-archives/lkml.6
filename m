Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A242087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="LL/nI9BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA1Old (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:41:33 -0500
Received: from mout02.posteo.de ([185.67.36.66]:51841 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1Olc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:41:32 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6D6BB2400FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:41:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548686489; bh=78zSCAFqEXwMnvzKrGeKAP95cmc72vwf2d7Yy5hAJDg=;
        h=From:To:Cc:Subject:Date:From;
        b=LL/nI9BAFu0W+CakexYe5nqPEM99XYnrcOMihXm2BrYlKz6rLGKCfVm14oczgRjPK
         3kelN6OLAi/Jxr1O6IQMA5JFApTHSSDXI6cxZX3JhJqgyVq9B6Nt3BWhnyuj7q/SHu
         s6por0RLnsSxVL33ivRkB+m94Bu+1xnJd9pBdv3OCqXpnk5Pki9iB/fLU/JFk1Ns2+
         jiCp5gQJsF3ucb46WIgCdyra2U5CBgEdraKLVqoWpjmH0ubLLA0mP06HiOo6XFua9b
         DJ22vImXreJMmV97fQ4ImvZy+9fAQd1tYTUVEmsAA/2Fz98JmZm4l8W+IJc+Cmm68T
         Drd8vDkwhU3kg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pC4R2Hpyz9rxB;
        Mon, 28 Jan 2019 15:41:27 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robin@protonic.nl
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Date:   Mon, 28 Jan 2019 15:41:19 +0100
Message-Id: <20190128144119.10092-1-martink@posteo.de>
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


revision history                                                               
----------------                                                               
v4: re-added forgotten regulator_enable() during probe
v3: improve API usage as suggested by Ulf
v2: tested patch with changes suggested by Robin                               
v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in


 drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..23d275269d61 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc, 0);
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc,
+					      ios->vdd);
+		break;
+	default:
+		break;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores;
 	int ret = 0, irq_err;
-	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
 	irq_err = platform_get_irq(pdev, 0);
@@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
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
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto out_mmc_free;
+
+	ret = regulator_enable(mmc->supply.vmmc);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable vmmc regulator: %d\n", ret);
+		goto out_mmc_free;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.20.1

