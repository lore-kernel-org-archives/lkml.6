Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CD266C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820592088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820592088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965719AbeFOPM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:12:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34510 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFOPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:12:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1558F288237
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
Date:   Fri, 15 Jun 2018 17:12:17 +0200
Message-Id: <20180615151217.29872-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opp table is not removed when the driver is unloaded neither when
there is an error within probe, so if the driver is reloaded the opp
core shows the following warning:

  rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
               200000000, volt: 900000, enabled: 1. New: freq: 200000000,
               volt: 900000, enabled: 1
  rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
               400000000, volt: 900000, enabled: 1. New: freq: 400000000,
               volt: 900000, enabled: 1
  rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
               666000000, volt: 900000, enabled: 1. New: freq: 666000000,
               volt: 900000, enabled: 1
  rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
               800000000, volt: 900000, enabled: 1. New: freq: 800000000,
               volt: 900000, enabled: 1
  rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
               928000000, volt: 900000, enabled: 1. New: freq: 928000000,
               volt: 900000, enabled: 1

This patch fixes the error path in the probe function and adds a .remove
function to properly cleanup the opp table on unloading.

Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index d5c03e5abe13..e795ad2b3f6b 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	data->rate = clk_get_rate(data->dmc_clk);
 
 	opp = devfreq_recommended_opp(dev, &data->rate, 0);
-	if (IS_ERR(opp))
-		return PTR_ERR(opp);
+	if (IS_ERR(opp)) {
+		ret = PTR_ERR(opp);
+		goto err_free_opp;
+	}
 
 	data->rate = dev_pm_opp_get_freq(opp);
 	data->volt = dev_pm_opp_get_voltage(opp);
@@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 					   &rk3399_devfreq_dmc_profile,
 					   DEVFREQ_GOV_SIMPLE_ONDEMAND,
 					   &data->ondemand_data);
-	if (IS_ERR(data->devfreq))
-		return PTR_ERR(data->devfreq);
+	if (IS_ERR(data->devfreq)) {
+		ret = PTR_ERR(data->devfreq);
+		goto err_free_opp;
+	}
+
 	devm_devfreq_register_opp_notifier(dev, data->devfreq);
 
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
+	return 0;
+
+err_free_opp:
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	return ret;
+}
+
+static int rk3399_dmcfreq_remove(struct platform_device *pdev)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
+
+	/*
+	 * Before remove the opp table we need to unregister the opp notifier.
+	 */
+	devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
+	dev_pm_opp_of_remove_table(dmcfreq->dev);
+
 	return 0;
 }
 
@@ -406,6 +428,7 @@ MODULE_DEVICE_TABLE(of, rk3399dmc_devfreq_of_match);
 
 static struct platform_driver rk3399_dmcfreq_driver = {
 	.probe	= rk3399_dmcfreq_probe,
+	.remove = rk3399_dmcfreq_remove,
 	.driver = {
 		.name	= "rk3399-dmc-freq",
 		.pm	= &rk3399_dmcfreq_pm,
-- 
2.17.1

