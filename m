Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEEJfc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:35:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeEEJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:35:06 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 5/5] devfreq: rk3399_dmc: do not print error when get supply and clk defer.
Date: Sat,  5 May 2018 11:34:50 +0200
Message-Id: <20180505093450.17327-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180505093450.17327-1-enric.balletbo@collabora.com>
References: <20180505093450.17327-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

We just return -EPROBE_DEFER error code to caller and do not
print error message when try to get center logic regulator
and DMC clock defer.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---

Changes in v3: None
Changes in v2:
- [5/6] Add Acked-by MyungJoo Ham.
- [5/6] Add Reviewed-by Chanwoo Choi.

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
