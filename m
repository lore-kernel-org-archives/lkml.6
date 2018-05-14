Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeENVQm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:16:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeENVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:16:38 -0400
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
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 04/10] devfreq: rk3399_dmc / rockchip: pm_domains: Register notify to DMC driver.
Date: Mon, 14 May 2018 23:16:04 +0200
Message-Id: <20180514211610.26618-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

The DMC (Dynamic Memory Interface) controller does a SiP call to the
Trusted Firmware-A (TF-A) to change the DDR clock frequency. When this
happens the TF-A writes to the PMU bus idle request register
(PMU_BUS_IDLE_REQ) but at the same time it is possible that the Rockchip
power domain driver writes to the same register. So, add a notification
mechanism to ensure that the DMC and the PD driver does not access to this
register at the same time.

Signed-off-by: Lin Huang <hl@rock-chips.com>
[rewrite commit message]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
As I explained in the cover letter I have doubts regarding this patch
but I did not find another way to do it. So I will appreciate any
feedback on this.

 drivers/devfreq/rk3399_dmc.c      |  7 ++++++
 drivers/soc/rockchip/pm_domains.c | 36 +++++++++++++++++++++++++++++++
 include/soc/rockchip/rk3399_dmc.h | 14 ++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 include/soc/rockchip/rk3399_dmc.h

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index cc1bbca3fb15..2c4985a501cb 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -28,6 +28,7 @@
 #include <linux/rwsem.h>
 #include <linux/suspend.h>
 
+#include <soc/rockchip/rk3399_dmc.h>
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
@@ -443,6 +444,12 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	data->dev = dev;
 	platform_set_drvdata(pdev, data);
 
+	rockchip_pm_register_dmcfreq_notifier(data->devfreq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register dmcfreq notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 53efc386b1ad..b0e66f24b3e3 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/devfreq.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/err.h>
@@ -76,9 +77,13 @@ struct rockchip_pmu {
 	const struct rockchip_pmu_info *info;
 	struct mutex mutex; /* mutex lock for pmu */
 	struct genpd_onecell_data genpd_data;
+	struct devfreq *devfreq;
+	struct notifier_block dmc_nb;
 	struct generic_pm_domain *domains[];
 };
 
+static struct rockchip_pmu *dmc_pmu;
+
 #define to_rockchip_pd(gpd) container_of(gpd, struct rockchip_pm_domain, genpd)
 
 #define DOMAIN(pwr, status, req, idle, ack, wakeup)	\
@@ -601,6 +606,35 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 	return error;
 }
 
+static int rk3399_dmcfreq_notify(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	if (event == DEVFREQ_PRECHANGE)
+		mutex_lock(&dmc_pmu->mutex);
+	else if (event == DEVFREQ_POSTCHANGE)
+		mutex_unlock(&dmc_pmu->mutex);
+
+	return NOTIFY_OK;
+}
+
+int rockchip_pm_register_dmcfreq_notifier(struct devfreq *devfreq)
+{
+	int ret;
+
+	if (!dmc_pmu)
+		return -EPROBE_DEFER;
+
+	dmc_pmu->devfreq = devfreq;
+	dmc_pmu->dmc_nb.notifier_call = rk3399_dmcfreq_notify;
+	ret = devm_devfreq_register_notifier(devfreq->dev.parent,
+					     dmc_pmu->devfreq,
+					     &dmc_pmu->dmc_nb,
+					     DEVFREQ_TRANSITION_NOTIFIER);
+
+	return ret;
+}
+EXPORT_SYMBOL(rockchip_pm_register_dmcfreq_notifier);
+
 static int rockchip_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -694,6 +728,8 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	dmc_pmu = pmu;
+
 	return 0;
 
 err_out:
diff --git a/include/soc/rockchip/rk3399_dmc.h b/include/soc/rockchip/rk3399_dmc.h
new file mode 100644
index 000000000000..031a62607f61
--- /dev/null
+++ b/include/soc/rockchip/rk3399_dmc.h
@@ -0,0 +1,14 @@
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
+
+int rockchip_pm_register_dmcfreq_notifier(struct devfreq *devfreq);
+
+#endif
-- 
2.17.0
