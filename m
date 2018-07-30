Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D0EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8A520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8A520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeG3Jpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:45:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeG3Jpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:45:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 752C427E230
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, robin.murphy@arm.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/8] devfreq: rk3399_dmc / clk: rockchip: Sync with vblank in the kernel for DDRfreq.
Date:   Mon, 30 Jul 2018 10:11:20 +0200
Message-Id: <20180730081124.30698-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730081124.30698-1-enric.balletbo@collabora.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This changes the kernel to sync with vblank for the display in the
kernel. This was done in Trusted Firmware-A (TF-A) before, but that locks
up one CPU for up to one display frame (1/60 second). That's bad for
performance and power, so this moves waiting to the kernel where the
waiting thread can properly wait on a completion.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v1: None

 drivers/clk/rockchip/clk-ddr.c    | 142 +++++++++++++++++++++++++-----
 drivers/clk/rockchip/clk.c        |   2 +-
 drivers/clk/rockchip/clk.h        |   3 +-
 drivers/devfreq/rk3399_dmc.c      | 125 ++++++++++++++++++++------
 drivers/devfreq/rk3399_dmc_priv.h |  15 ++++
 include/soc/rockchip/rk3399_dmc.h |  42 +++++++++
 6 files changed, 277 insertions(+), 52 deletions(-)
 create mode 100644 drivers/devfreq/rk3399_dmc_priv.h
 create mode 100644 include/soc/rockchip/rk3399_dmc.h

diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index e8075359366b..707be1bd8910 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -17,7 +17,9 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/ktime.h>
 #include <linux/slab.h>
+#include <soc/rockchip/rk3399_dmc.h>
 #include <soc/rockchip/rockchip_sip.h>
 #include "clk.h"
 
@@ -30,39 +32,104 @@ struct rockchip_ddrclk {
 	int		div_shift;
 	int		div_width;
 	int		ddr_flag;
-	spinlock_t	*lock;
+	unsigned long	cached_rate;
+	struct work_struct set_rate_work;
+	struct mutex	lock;
+	struct raw_notifier_head sync_chain;
 };
 
 #define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk, hw)
+#define DMC_DEFAULT_TIMEOUT_NS		NSEC_PER_SEC
+#define DDRCLK_SET_RATE_MAX_RETRIES	3
 
-static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
-					unsigned long prate)
+static void rockchip_ddrclk_set_rate_func(struct work_struct *work)
 {
-	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
-	unsigned long flags;
+	struct rockchip_ddrclk *ddrclk = container_of(work,
+			struct rockchip_ddrclk, set_rate_work);
+	ktime_t timeout = ktime_add_ns(ktime_get(), DMC_DEFAULT_TIMEOUT_NS);
 	struct arm_smccc_res res;
+	int ret, i;
+
+	mutex_lock(&ddrclk->lock);
+	for (i = 0; i < DDRCLK_SET_RATE_MAX_RETRIES; i++) {
+		ret = raw_notifier_call_chain(&ddrclk->sync_chain, 0, &timeout);
+		if (ret == NOTIFY_BAD)
+			goto out;
+
+		/*
+		 * Check the timeout with irqs disabled. This is so we don't get
+		 * preempted after checking the timeout. That could cause things
+		 * like garbage values for the display if we change the DDR rate
+		 * at the wrong time.
+		 */
+		local_irq_disable();
+		if (ktime_after(ktime_add_ns(ktime_get(), DMC_MIN_VBLANK_NS),
+				timeout)) {
+			local_irq_enable();
+			continue;
+		}
+
+		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, ddrclk->cached_rate, 0,
+			      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
+			      0, 0, 0, 0, &res);
+		local_irq_enable();
+		break;
+	}
+out:
+	mutex_unlock(&ddrclk->lock);
+}
 
-	spin_lock_irqsave(ddrclk->lock, flags);
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, drate, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
-		      0, 0, 0, 0, &res);
-	spin_unlock_irqrestore(ddrclk->lock, flags);
+int rockchip_ddrclk_register_sync_nb(struct clk *clk, struct notifier_block *nb)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct rockchip_ddrclk *ddrclk;
+	int ret;
 
-	return res.a0;
+	if (!hw || !nb)
+		return -EINVAL;
+
+	ddrclk = to_rockchip_ddrclk_hw(hw);
+	if (!ddrclk)
+		return -EINVAL;
+
+	mutex_lock(&ddrclk->lock);
+	ret = raw_notifier_chain_register(&ddrclk->sync_chain, nb);
+	mutex_unlock(&ddrclk->lock);
+
+	return ret;
 }
+EXPORT_SYMBOL_GPL(rockchip_ddrclk_register_sync_nb);
 
-static unsigned long
-rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
-				unsigned long parent_rate)
+int rockchip_ddrclk_unregister_sync_nb(struct clk *clk,
+				       struct notifier_block *nb)
 {
-	struct arm_smccc_res res;
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct rockchip_ddrclk *ddrclk;
+	int ret;
 
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
-		      0, 0, 0, 0, &res);
+	if (!hw || !nb)
+		return -EINVAL;
 
-	return res.a0;
+	ddrclk = to_rockchip_ddrclk_hw(hw);
+	if (!ddrclk)
+		return -EINVAL;
+
+	mutex_lock(&ddrclk->lock);
+	ret = raw_notifier_chain_unregister(&ddrclk->sync_chain, nb);
+	mutex_unlock(&ddrclk->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_ddrclk_unregister_sync_nb);
+
+void rockchip_ddrclk_wait_set_rate(struct clk *clk)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+
+	flush_work(&ddrclk->set_rate_work);
 }
+EXPORT_SYMBOL_GPL(rockchip_ddrclk_wait_set_rate);
 
 static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
 					   unsigned long rate,
@@ -77,6 +144,30 @@ static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
 	return res.a0;
 }
 
+static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	long rate;
+
+	rate = rockchip_ddrclk_sip_round_rate(hw, drate, &prate);
+	if (rate < 0)
+		return rate;
+
+	ddrclk->cached_rate = rate;
+	queue_work(system_highpri_wq, &ddrclk->set_rate_work);
+	return 0;
+}
+
+static unsigned long
+rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+
+	return ddrclk->cached_rate;
+}
+
 static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
 {
 	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
@@ -105,12 +196,12 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 					 u8 num_parents, int mux_offset,
 					 int mux_shift, int mux_width,
 					 int div_shift, int div_width,
-					 int ddr_flag, void __iomem *reg_base,
-					 spinlock_t *lock)
+					 int ddr_flag, void __iomem *reg_base)
 {
 	struct rockchip_ddrclk *ddrclk;
 	struct clk_init_data init;
 	struct clk *clk;
+	struct arm_smccc_res res;
 
 	ddrclk = kzalloc(sizeof(*ddrclk), GFP_KERNEL);
 	if (!ddrclk)
@@ -134,7 +225,6 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 	}
 
 	ddrclk->reg_base = reg_base;
-	ddrclk->lock = lock;
 	ddrclk->hw.init = &init;
 	ddrclk->mux_offset = mux_offset;
 	ddrclk->mux_shift = mux_shift;
@@ -142,6 +232,14 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 	ddrclk->div_shift = div_shift;
 	ddrclk->div_width = div_width;
 	ddrclk->ddr_flag = ddr_flag;
+	mutex_init(&ddrclk->lock);
+	INIT_WORK(&ddrclk->set_rate_work, rockchip_ddrclk_set_rate_func);
+	RAW_INIT_NOTIFIER_HEAD(&ddrclk->sync_chain);
+
+	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
+		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
+		      0, 0, 0, 0, &res);
+	ddrclk->cached_rate = res.a0;
 
 	clk = clk_register(NULL, &ddrclk->hw);
 	if (IS_ERR(clk))
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 326b3fa44f5d..1b7775aff191 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -541,7 +541,7 @@ void __init rockchip_clk_register_branches(
 				list->muxdiv_offset, list->mux_shift,
 				list->mux_width, list->div_shift,
 				list->div_width, list->div_flags,
-				ctx->reg_base, &ctx->lock);
+				ctx->reg_base);
 			break;
 		}
 
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index ef601dded32c..5e4ce49ef337 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -326,8 +326,7 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 					 u8 num_parents, int mux_offset,
 					 int mux_shift, int mux_width,
 					 int div_shift, int div_width,
-					 int ddr_flags, void __iomem *reg_base,
-					 spinlock_t *lock);
+					 int ddr_flags, void __iomem *reg_base);
 
 #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
 
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index c619dc4ac620..b4ac9ee605be 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -28,9 +28,12 @@
 #include <linux/rwsem.h>
 #include <linux/suspend.h>
 
+#include <soc/rockchip/rk3399_dmc.h>
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
+#include "rk3399_dmc_priv.h"
+
 struct dram_timing {
 	unsigned int ddr3_speed_bin;
 	unsigned int pd_idle;
@@ -70,6 +73,7 @@ struct rk3399_dmcfreq {
 	struct clk *dmc_clk;
 	struct devfreq_event_dev *edev;
 	struct mutex lock;
+	struct mutex en_lock;
 	struct dram_timing timing;
 	struct regulator *vdd_center;
 	struct regmap *regmap_pmu;
@@ -77,6 +81,8 @@ struct rk3399_dmcfreq {
 	unsigned long volt, target_volt;
 	unsigned int odt_dis_freq;
 	int odt_pd_arg0, odt_pd_arg1;
+	int num_sync_nb;
+	int disable_count;
 };
 
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
@@ -139,6 +145,13 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		goto out;
 	}
 
+	/*
+	 * Setting the dpll is asynchronous since clk_set_rate grabs a global
+	 * common clk lock and set_rate for the dpll takes up to one display
+	 * frame to complete. We still need to wait for the set_rate to complete
+	 * here, though, before we change voltage.
+	 */
+	rockchip_ddrclk_wait_set_rate(dmcfreq->dmc_clk);
 	/*
 	 * Check the dpll rate,
 	 * There only two result we will get,
@@ -205,40 +218,15 @@ static struct devfreq_dev_profile rk3399_devfreq_dmc_profile = {
 static __maybe_unused int rk3399_dmcfreq_suspend(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
-	int ret = 0;
-
-	ret = devfreq_event_disable_edev(dmcfreq->edev);
-	if (ret < 0) {
-		dev_err(dev, "failed to disable the devfreq-event devices\n");
-		return ret;
-	}
 
-	ret = devfreq_suspend_device(dmcfreq->devfreq);
-	if (ret < 0) {
-		dev_err(dev, "failed to suspend the devfreq devices\n");
-		return ret;
-	}
-
-	return 0;
+	return rockchip_dmcfreq_block(dmcfreq->devfreq);
 }
 
 static __maybe_unused int rk3399_dmcfreq_resume(struct device *dev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(dev);
-	int ret = 0;
 
-	ret = devfreq_event_enable_edev(dmcfreq->edev);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable the devfreq-event devices\n");
-		return ret;
-	}
-
-	ret = devfreq_resume_device(dmcfreq->devfreq);
-	if (ret < 0) {
-		dev_err(dev, "failed to resume the devfreq devices\n");
-		return ret;
-	}
-	return ret;
+	return rockchip_dmcfreq_unblock(dmcfreq->devfreq);
 }
 
 static SIMPLE_DEV_PM_OPS(rk3399_dmcfreq_pm, rk3399_dmcfreq_suspend,
@@ -311,6 +299,88 @@ static int of_get_ddr_timings(struct dram_timing *timing,
 	return ret;
 }
 
+int rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
+					struct notifier_block *nb)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
+	int ret;
+
+	mutex_lock(&dmcfreq->en_lock);
+	/*
+	 * We have a short amount of time (~1ms or less typically) to run
+	 * dmcfreq after we sync with the notifier, so syncing with more than
+	 * one notifier is not generally possible. Thus, if more than one sync
+	 * notifier is registered, disable dmcfreq.
+	 */
+	if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+		devfreq_suspend_device(devfreq);
+
+	ret = rockchip_ddrclk_register_sync_nb(dmcfreq->dmc_clk, nb);
+	if (ret == 0)
+		dmcfreq->num_sync_nb++;
+	else if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+		devfreq_resume_device(devfreq);
+
+	mutex_unlock(&dmcfreq->en_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmcfreq_register_clk_sync_nb);
+
+int rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
+					  struct notifier_block *nb)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
+	int ret;
+
+	mutex_lock(&dmcfreq->en_lock);
+	ret = rockchip_ddrclk_unregister_sync_nb(dmcfreq->dmc_clk, nb);
+	if (ret == 0) {
+		dmcfreq->num_sync_nb--;
+		if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+			devfreq_resume_device(devfreq);
+	}
+
+	mutex_unlock(&dmcfreq->en_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmcfreq_unregister_clk_sync_nb);
+
+int rockchip_dmcfreq_block(struct devfreq *devfreq)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
+
+	mutex_lock(&dmcfreq->en_lock);
+	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count <= 0)
+		ret = devfreq_suspend_device(devfreq);
+
+	if (!ret)
+		dmcfreq->disable_count++;
+	mutex_unlock(&dmcfreq->en_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmcfreq_block);
+
+int rockchip_dmcfreq_unblock(struct devfreq *devfreq)
+{
+	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
+
+	mutex_lock(&dmcfreq->en_lock);
+	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count == 1)
+		ret = devfreq_resume_device(devfreq);
+
+	if (!ret)
+		dmcfreq->disable_count--;
+	WARN_ON(dmcfreq->disable_count < 0);
+	mutex_unlock(&dmcfreq->en_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_dmcfreq_unblock);
+
 static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 {
 	struct arm_smccc_res res;
@@ -328,6 +398,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mutex_init(&data->lock);
+	mutex_init(&data->en_lock);
 
 	data->vdd_center = devm_regulator_get(dev, "center");
 	if (IS_ERR(data->vdd_center)) {
diff --git a/drivers/devfreq/rk3399_dmc_priv.h b/drivers/devfreq/rk3399_dmc_priv.h
new file mode 100644
index 000000000000..8ac0340a4990
--- /dev/null
+++ b/drivers/devfreq/rk3399_dmc_priv.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2018 Google, Inc.
+ * Author: Derek Basehore <dbasehore@chromium.org>
+ */
+
+#ifndef __RK3399_DMC_PRIV_H
+#define __RK3399_DMC_PRIV_H
+
+void rockchip_ddrclk_wait_set_rate(struct clk *clk);
+int rockchip_ddrclk_register_sync_nb(struct clk *clk,
+				     struct notifier_block *nb);
+int rockchip_ddrclk_unregister_sync_nb(struct clk *clk,
+				       struct notifier_block *nb);
+#endif
diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
new file mode 100644
index 000000000000..8b28563710d1
--- /dev/null
+++ b/include/soc/rockchip/rk3399_dmc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
+ * Author: Lin Huang <hl@rock-chips.com>
+ */
+
+#ifndef __SOC_RK3399_DMC_H
+#define __SOC_RK3399_DMC_H
+
+#include <linux/devfreq.h>
+#include <linux/notifier.h>
+
+#define DMC_MIN_SET_RATE_NS	(250 * NSEC_PER_USEC)
+#define DMC_MIN_VBLANK_NS	(DMC_MIN_SET_RATE_NS + 50 * NSEC_PER_USEC)
+
+#if IS_ENABLED(CONFIG_ARM_RK3399_DMC_DEVFREQ)
+int rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
+					  struct notifier_block *nb);
+
+int rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
+					    struct notifier_block *nb);
+
+int rockchip_dmcfreq_block(struct devfreq *devfreq);
+
+int rockchip_dmcfreq_unblock(struct devfreq *devfreq);
+#else
+static inline int
+rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
+				      struct notifier_block *nb)
+{ return 0; }
+
+static inline int
+rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
+					struct notifier_block *nb)
+{ return 0; }
+
+static inline int rockchip_dmcfreq_block(struct devfreq *devfreq) { return 0; }
+
+static inline int rockchip_dmcfreq_unblock(struct devfreq *devfreq)
+{ return 0; }
+#endif
+#endif
-- 
2.18.0

