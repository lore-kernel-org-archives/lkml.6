Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A59C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665420870
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="D8t3fjzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYLe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:34:58 -0500
Received: from mout02.posteo.de ([185.67.36.66]:50287 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAYLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:34:58 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D7CEE2400E5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548416095; bh=oYyYmFp2j7XGH9Jl+ZPXOSkTm9PnOf7BpMey+cN1jYE=;
        h=From:To:Cc:Subject:Date:From;
        b=D8t3fjzzT0QkhfzehvTZIktnXG27YNJFGN9h/KU7GPNNvbONqQOSrQZqBCaRxvHdX
         98KCkTlCiAp9u7cCq3FxB6AQiGghNT/puenTAWwB5pZj0QsHD3gsQqDCgv10oq7wR/
         tOfX/Vh6HRFazT1XyCrFGhx9TrHXy2si9TDXG10zmk6EfqNqs6yJutWVaK3F3buIYr
         +7i+oOyUr0wPuGKGLO0szpTLrkfL4oXRU3Bt4WOg3cpnPmJfJSrHkUL7PfPWzvJ0ex
         zmvTzDATYIJxj+DRimrcXMxZm1apkDrfxIMDCvbaSAMIVkjIYYkWWuYrhIKwc5BxST
         gA+czcEwF+HOg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43mH4Z0Gx9z9rxh;
        Fri, 25 Jan 2019 12:34:53 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robin@protonic.nl
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH] mmc: mxs-mmc: Introduce regulator support
Date:   Fri, 25 Jan 2019 12:34:49 +0100
Message-Id: <20190125113449.10128-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

This is not my patch. It's taken from https://patchwork.kernel.org/patch/4365751/
rebased and minimally changed; but we use this.

Are there any objections to this?

Robin, can I still add your Signed-off-by to this? Also, should I set you
as the author?

thanks,

                                martin

 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..e3c19fabb723 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,26 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if ((host->vmmc) && regulator_disable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			}
+			break;
+		case MMC_POWER_UP:
+			if ((host->vmmc) && regulator_enable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			}
+			break;
+		default:
+			break;
+		}
+		host->power_mode = ios->power_mode;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
+	host->power_mode = MMC_POWER_OFF;
 
 	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
-	}
+	if (!IS_ERR(reg_vmmc))
+		host->vmmc = reg_vmmc;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
2.20.1

