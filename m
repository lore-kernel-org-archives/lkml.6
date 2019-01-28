Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D16C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F7A20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FUL4cGIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfA1KUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:20:32 -0500
Received: from mout02.posteo.de ([185.67.36.66]:50333 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfA1KUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:20:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 372012400FB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:20:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548670828; bh=R2SL3qXPRrTk5inyV+kmoVKVzKoBzirKte3NylclSkY=;
        h=From:To:Cc:Subject:Date:From;
        b=FUL4cGIP5kOvXbqr6X9wEmCXPGQmSukbLd76m5DpKSxFYCmb1e1yJMl/oWEimP6MC
         wRF6/rhvOMpudAX9gOoM4NeOh/DSJjINTQlBd0xZM8V55iq6v7fg/Tltf0M+7ltsRJ
         EjVcZztNLQ5e+QZbsG9kcdD8Vhm6GcW/J+eG1nLgB29Ep7NFlZ9XI+dMKaYAxT9xRP
         VVIOR6IsUQC1fs0GqlSez2rHt97qUusOi6zBX0kJ4wR/zesLLq2xg41oXUaFtSyUN9
         kKXX6NZGITHsv2henaEVjZ2T+zI/xPnzGjnUcMbfBV+KCHJEEZYMBSG8D1bkcRQyyi
         /8QNLMoDVNJ1A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43p5HF6Kdfz9rxb;
        Mon, 28 Jan 2019 11:20:25 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robin@protonic.nl, ulf.hansson@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Date:   Mon, 28 Jan 2019 11:20:22 +0100
Message-Id: <20190128102022.1880-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
doesn't turn off the VMMC regulator which leads to hangs when loading firmware.

Tested on i.MX28.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

again, this isn't new. it's (rebased and simplified)
https://patchwork.kernel.org/patch/4365751/

Thanks Robin for your input!

revision history
----------------
v1: was just a question why this hasn't gone in earlier.


 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..fdaca0fcec99 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -66,11 +66,13 @@ struct mxs_mmc_host {
 	struct mmc_request		*mrq;
 	struct mmc_command		*cmd;
 	struct mmc_data			*data;
+	struct regulator		*vmmc;
 
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	bool				broken_cd;
+	unsigned char			power_mode;
 };
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -517,6 +519,24 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (host->vmmc && ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (regulator_disable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			break;
+		case MMC_POWER_UP:
+			if (regulator_enable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
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

