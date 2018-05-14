Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeENVRs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:17:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeENVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:16:41 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 06/10] devfreq: rk3399_dmc / clk: rockchip: Disable DDR clk timeout on suspend.
Date: Mon, 14 May 2018 23:16:06 +0200
Message-Id: <20180514211610.26618-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This disables the timeout for the DDR clk when the governor is
suspended or stopped. This makes sure that the suspend frequency is
set. It also makes sure that the userspace governor will be able to
change the frequency without failing.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/clk/rockchip/clk-ddr.c    | 21 ++++++++++++++++++---
 drivers/devfreq/rk3399_dmc.c      | 20 +++++++++++++++-----
 drivers/devfreq/rk3399_dmc_priv.h |  1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index 707be1bd8910..de00590af167 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -32,6 +32,7 @@ struct rockchip_ddrclk {
 	int		div_shift;
 	int		div_width;
 	int		ddr_flag;
+	bool		timeout_en;
 	unsigned long	cached_rate;
 	struct work_struct set_rate_work;
 	struct mutex	lock;
@@ -52,8 +53,9 @@ static void rockchip_ddrclk_set_rate_func(struct work_struct *work)
 
 	mutex_lock(&ddrclk->lock);
 	for (i = 0; i < DDRCLK_SET_RATE_MAX_RETRIES; i++) {
-		ret = raw_notifier_call_chain(&ddrclk->sync_chain, 0, &timeout);
-		if (ret == NOTIFY_BAD)
+		ret = raw_notifier_call_chain(&ddrclk->sync_chain, 0,
+					      &timeout);
+		if (ddrclk->timeout_en && ret == NOTIFY_BAD)
 			goto out;
 
 		/*
@@ -63,7 +65,8 @@ static void rockchip_ddrclk_set_rate_func(struct work_struct *work)
 		 * at the wrong time.
 		 */
 		local_irq_disable();
-		if (ktime_after(ktime_add_ns(ktime_get(), DMC_MIN_VBLANK_NS),
+		if (ddrclk->timeout_en &&
+		    ktime_after(ktime_add_ns(ktime_get(), DMC_MIN_VBLANK_NS),
 				timeout)) {
 			local_irq_enable();
 			continue;
@@ -79,6 +82,17 @@ static void rockchip_ddrclk_set_rate_func(struct work_struct *work)
 	mutex_unlock(&ddrclk->lock);
 }
 
+void rockchip_ddrclk_set_timeout_en(struct clk *clk, bool enable)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+
+	mutex_lock(&ddrclk->lock);
+	ddrclk->timeout_en = enable;
+	mutex_unlock(&ddrclk->lock);
+}
+EXPORT_SYMBOL(rockchip_ddrclk_set_timeout_en);
+
 int rockchip_ddrclk_register_sync_nb(struct clk *clk, struct notifier_block *nb)
 {
 	struct clk_hw *hw = __clk_get_hw(clk);
@@ -232,6 +246,7 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 	ddrclk->div_shift = div_shift;
 	ddrclk->div_width = div_width;
 	ddrclk->ddr_flag = ddr_flag;
+	ddrclk->timeout_en = true;
 	mutex_init(&ddrclk->lock);
 	INIT_WORK(&ddrclk->set_rate_work, rockchip_ddrclk_set_rate_func);
 	RAW_INIT_NOTIFIER_HEAD(&ddrclk->sync_chain);
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index c174d13afe92..2fa4ab653c35 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -308,14 +308,18 @@ int rockchip_dmcfreq_register_clk_sync_nb(struct devfreq *devfreq,
 	 * one notifier is not generally possible. Thus, if more than one sync
 	 * notifier is registered, disable dmcfreq.
 	 */
-	if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+	if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0) {
+		rockchip_ddrclk_set_timeout_en(dmcfreq->dmc_clk, false);
 		devfreq_suspend_device(devfreq);
+	}
 
 	ret = rockchip_ddrclk_register_sync_nb(dmcfreq->dmc_clk, nb);
 	if (ret == 0)
 		dmcfreq->num_sync_nb++;
-	else if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+	else if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0) {
+		rockchip_ddrclk_set_timeout_en(dmcfreq->dmc_clk, true);
 		devfreq_resume_device(devfreq);
+	}
 
 	mutex_unlock(&dmcfreq->en_lock);
 	return ret;
@@ -332,8 +336,10 @@ int rockchip_dmcfreq_unregister_clk_sync_nb(struct devfreq *devfreq,
 	ret = rockchip_ddrclk_unregister_sync_nb(dmcfreq->dmc_clk, nb);
 	if (ret == 0) {
 		dmcfreq->num_sync_nb--;
-		if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0)
+		if (dmcfreq->num_sync_nb == 1 && dmcfreq->disable_count <= 0) {
+			rockchip_ddrclk_set_timeout_en(dmcfreq->dmc_clk, true);
 			devfreq_resume_device(devfreq);
+		}
 	}
 
 	mutex_unlock(&dmcfreq->en_lock);
@@ -348,8 +354,10 @@ int rockchip_dmcfreq_block(struct devfreq *devfreq)
 	int ret = 0;
 
 	mutex_lock(&dmcfreq->en_lock);
-	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count <= 0)
+	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count <= 0) {
+		rockchip_ddrclk_set_timeout_en(dmcfreq->dmc_clk, false);
 		ret = devfreq_suspend_device(devfreq);
+	}
 
 	if (!ret)
 		dmcfreq->disable_count++;
@@ -365,8 +373,10 @@ int rockchip_dmcfreq_unblock(struct devfreq *devfreq)
 	int ret = 0;
 
 	mutex_lock(&dmcfreq->en_lock);
-	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count == 1)
+	if (dmcfreq->num_sync_nb <= 1 && dmcfreq->disable_count == 1) {
+		rockchip_ddrclk_set_timeout_en(dmcfreq->dmc_clk, true);
 		ret = devfreq_resume_device(devfreq);
+	}
 
 	if (!ret)
 		dmcfreq->disable_count--;
diff --git a/drivers/devfreq/rk3399_dmc_priv.h b/drivers/devfreq/rk3399_dmc_priv.h
index 8ac0340a4990..1ad46f4b15cc 100644
--- a/drivers/devfreq/rk3399_dmc_priv.h
+++ b/drivers/devfreq/rk3399_dmc_priv.h
@@ -7,6 +7,7 @@
 #ifndef __RK3399_DMC_PRIV_H
 #define __RK3399_DMC_PRIV_H
 
+void rockchip_ddrclk_set_timeout_en(struct clk *clk, bool enable);
 void rockchip_ddrclk_wait_set_rate(struct clk *clk);
 int rockchip_ddrclk_register_sync_nb(struct clk *clk,
 				     struct notifier_block *nb);
-- 
2.17.0
