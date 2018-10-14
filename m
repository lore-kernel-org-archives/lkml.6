Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88EC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B6320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B6320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeJNX0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:26:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37133 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbeJNX0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:26:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMH-0004cg-Kk; Sun, 14 Oct 2018 16:31:09 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000BJ-9T; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bai Ping" <b51503@freescale.com>,
        "Eduardo Valentin" <edubezval@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.57065549@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 036/366] thermal: imx: register irq handler later in
 probe
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bai Ping <b51503@freescale.com>

commit 84866ee5818e95f6e97194656777c10ac24cb9d3 upstream.

The irq handler should be registered after the tempmon
module has been initialized in a known state and the
thermal_zone and cpu_cooling device have been registered
successfully. Otherwise, if the irq is triggled earlier
before thermal probe has been finished, it may lead to
'NULL' pointer kernel panic.

Signed-off-by: Bai Ping <b51503@freescale.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/thermal/imx_thermal.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -422,14 +422,6 @@ static int imx_thermal_probe(struct plat
 	if (data->irq < 0)
 		return data->irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, data);
 
 	ret = imx_get_sensor_data(pdev);
@@ -492,6 +484,17 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
+			0, "imx_thermal", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		clk_disable_unprepare(data->thermal_clk);
+		thermal_zone_device_unregister(data->tz);
+		cpufreq_cooling_unregister(data->cdev);
+		return ret;
+	}
+
 	data->irq_enabled = true;
 	data->mode = THERMAL_DEVICE_ENABLED;
 

