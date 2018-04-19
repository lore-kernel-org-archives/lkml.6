Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDSKli (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:41:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeDSKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:40:56 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        dianders@google.com, groek@google.com, kernel@collabora.com,
        Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get supply and clk defer.
Date: Thu, 19 Apr 2018 12:40:18 +0200
Message-Id: <20180419104019.24406-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419104019.24406-1-enric.balletbo@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

We just return -EPROBE_DEFER error code to caller and do not
print error message when try to get center logic regulator
and DMC clock defer.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/devfreq/rk3399_dmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 44a379657cd5..5bfca028eaaf 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -308,12 +308,18 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	data->vdd_center = devm_regulator_get(dev, "center");
 	if (IS_ERR(data->vdd_center)) {
+		if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		dev_err(dev, "Cannot get the regulator \"center\"\n");
 		return PTR_ERR(data->vdd_center);
 	}
 
 	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
 	if (IS_ERR(data->dmc_clk)) {
+		if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->dmc_clk);
 	};
-- 
2.17.0
