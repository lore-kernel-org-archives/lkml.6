Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA1C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB25620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB25620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeJNXYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36981 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:31 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMH-0004cf-IN; Sun, 14 Oct 2018 16:31:09 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLO-0000BO-An; Sun, 14 Oct 2018 16:30:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Fabio Estevam" <fabio.estevam@nxp.com>,
        "Mikhail Lappo" <mikhail.lappo@esrlabs.com>,
        "Dong Aisheng" <aisheng.dong@nxp.com>,
        "Zhang Rui" <rui.zhang@intel.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.493199865@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 037/366] thermal: imx: Fix race condition in
 imx_thermal_probe()
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

From: Mikhail Lappo <mikhail.lappo@esrlabs.com>

commit cf1ba1d73a33944d8c1a75370a35434bf146b8a7 upstream.

When device boots with T > T_trip_1 and requests interrupt,
the race condition takes place. The interrupt comes before
THERMAL_DEVICE_ENABLED is set. This leads to an attempt to
reading sensor value from irq and disabling the sensor, based on
the data->mode field, which expected to be THERMAL_DEVICE_ENABLED,
but still stays as THERMAL_DEVICE_DISABLED. Afher this issue
sensor is never re-enabled, as the driver state is wrong.

Fix this problem by setting the 'data' members prior to
requesting the interrupts.

Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm interrupt handling")
Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/thermal/imx_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -484,6 +484,9 @@ static int imx_thermal_probe(struct plat
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -495,9 +498,6 @@ static int imx_thermal_probe(struct plat
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 

