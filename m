Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754901AbeBOGEi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 01:04:38 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:36971 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754886AbeBOGEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 01:04:35 -0500
From: Keerthy <j-keerthy@ti.com>
To: <daniel.lezcano@linaro.org>, <thierry.reding@gmail.com>,
        <tony@atomide.com>, <aaro.koskinen@iki.fi>
CC: <j-keerthy@ti.com>, <Claudiu.Beznea@microchip.com>,
        <narmstrong@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <ladis@linux-mips.org>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sebastian.reichel@collabora.co.uk>, <linux-omap@vger.kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <grygorii.strashko@ti.com>
Subject: [PATCH v11 08/10] clocksource: timer-ti-dm: Hook device platform data if not already assigned
Date: Thu, 15 Feb 2018 11:31:49 +0530
Message-ID: <1518674511-26421-9-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladislav Michl <ladis@linux-mips.org>

In the case of device tree boot the device platform data is usually
NULL so hook the platform data obtained from the match.
As part of un-constify the platform_data pointer.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/clocksource/timer-ti-dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 864019d..c5a49a3 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -806,14 +806,16 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	struct omap_dm_timer *timer;
 	struct resource *mem, *irq;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
 
-	match = of_match_device(of_match_ptr(omap_timer_match), dev);
-	pdata = match ? match->data : dev->platform_data;
+	pdata = of_device_get_match_data(dev);
+	if (!pdata)
+		pdata = dev_get_platdata(dev);
+	else
+		dev->platform_data = (void *)pdata;
 
-	if (!pdata && !dev->of_node) {
+	if (!pdata) {
 		dev_err(dev, "%s: no platform data.\n", __func__);
 		return -ENODEV;
 	}
-- 
1.9.1
