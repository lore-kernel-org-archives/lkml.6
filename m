Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbeEIM7B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:59:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934884AbeEIM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:58:00 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event.
Date: Wed,  9 May 2018 14:57:45 +0200
Message-Id: <20180509125749.31318-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already wait dcf done in ATF, so don't need wait dcf irq
in kernel, besides, clear dcf irq in kernel will import competiton
between kernel and ATF, only handle dcf irq in ATF is a better way.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- [3/6] Add Reviewed-by Chanwoo Choi

 drivers/devfreq/rk3399_dmc.c | 53 +-----------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5dfbfa3cc878..44a379657cd5 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -68,15 +68,6 @@ struct rk3399_dmcfreq {
 	struct devfreq_event_dev *edev;
 	struct mutex lock;
 	struct dram_timing timing;
-
-	/*
-	 * DDR Converser of Frequency (DCF) is used to implement DDR frequency
-	 * conversion without the participation of CPU, we will implement and
-	 * control it in arm trust firmware.
-	 */
-	wait_queue_head_t	wait_dcf_queue;
-	int irq;
-	int wait_dcf_flag;
 	struct regulator *vdd_center;
 	unsigned long rate, target_rate;
 	unsigned long volt, target_volt;
@@ -117,7 +108,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 			goto out;
 		}
 	}
-	dmcfreq->wait_dcf_flag = 1;
 
 	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
 	if (err) {
@@ -128,14 +118,6 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		goto out;
 	}
 
-	/*
-	 * Wait until bcf irq happen, it means freq scaling finish in
-	 * arm trust firmware, use 100ms as timeout time.
-	 */
-	if (!wait_event_timeout(dmcfreq->wait_dcf_queue,
-				!dmcfreq->wait_dcf_flag, HZ / 10))
-		dev_warn(dev, "Timeout waiting for dcf interrupt\n");
-
 	/*
 	 * Check the dpll rate,
 	 * There only two result we will get,
@@ -241,22 +223,6 @@ static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
 			 rk3399_dmcfreq_resume);
 
-static irqreturn_t rk3399_dmc_irq(int irq, void *dev_id)
-{
-	struct rk3399_dmcfreq *dmcfreq = dev_id;
-	struct arm_smccc_res res;
-
-	dmcfreq->wait_dcf_flag = 0;
-	wake_up(&dmcfreq->wait_dcf_queue);
-
-	/* Clear the DCF interrupt */
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ,
-		      0, 0, 0, 0, &res);
-
-	return IRQ_HANDLED;
-}
-
 static int of_get_ddr_timings(struct dram_timing *timing,
 			      struct device_node *np)
 {
@@ -330,16 +296,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct rk3399_dmcfreq *data;
-	int ret, irq, index, size;
+	int ret, index, size;
 	uint32_t *timing;
 	struct dev_pm_opp *opp;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Cannot get the dmc interrupt resource: %d\n", irq);
-		return irq;
-	}
 	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -358,17 +318,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(data->dmc_clk);
 	};
 
-	data->irq = irq;
-	ret = devm_request_irq(dev, irq, rk3399_dmc_irq, 0,
-			       dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Failed to request dmc irq: %d\n", ret);
-		return ret;
-	}
-
-	init_waitqueue_head(&data->wait_dcf_queue);
-	data->wait_dcf_flag = 0;
-
 	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(data->edev))
 		return -EPROBE_DEFER;
-- 
2.17.0
