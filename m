Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeEaLA7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:00:59 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38362 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754583AbeEaLAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:00:12 -0400
X-Google-Smtp-Source: ADUXVKLrSr5wyw2yMUlV9FRYkbooKC5gewusQUuJJVyOmDsfgiaIpf6BJyC9wZByqujKM8zCb5Q1uA==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/5] PM / Domains: Split genpd_dev_pm_attach()
Date: Thu, 31 May 2018 12:59:57 +0200
Message-Id: <20180531105959.14843-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531105959.14843-1-ulf.hansson@linaro.org>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To extend genpd to deal with allowing multiple PM domains per device, some
of the code in genpd_dev_pm_attach() can be re-used. Let's prepare for this
by moving some of the code into a sub-function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 908c44779ae7..b1fcbf917974 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2221,38 +2221,15 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-/**
- * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
- * @dev: Device to attach.
- *
- * Parse device's OF node to find a PM domain specifier. If such is found,
- * attaches the device to retrieved pm_domain ops.
- *
- * Returns 1 on successfully attached PM domain, 0 when the device don't need a
- * PM domain or when multiple power-domains exists for it, else a negative error
- * code. Note that if a power-domain exists for the device, but it cannot be
- * found or turned on, then return -EPROBE_DEFER to ensure that the device is
- * not probed and to re-try again later.
- */
-int genpd_dev_pm_attach(struct device *dev)
+static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
+				 unsigned int index)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
 	int ret;
 
-	if (!dev->of_node)
-		return 0;
-
-	/*
-	 * Devices with multiple PM domains must be attached separately, as we
-	 * can only attach one PM domain per device.
-	 */
-	if (of_count_phandle_with_args(dev->of_node, "power-domains",
-				       "#power-domain-cells") != 1)
-		return 0;
-
-	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
-					"#power-domain-cells", 0, &pd_args);
+	ret = of_parse_phandle_with_args(np, "power-domains",
+				"#power-domain-cells", index, &pd_args);
 	if (ret < 0)
 		return ret;
 
@@ -2290,6 +2267,35 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	return ret ? -EPROBE_DEFER : 1;
 }
+
+/**
+ * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
+ * @dev: Device to attach.
+ *
+ * Parse device's OF node to find a PM domain specifier. If such is found,
+ * attaches the device to retrieved pm_domain ops.
+ *
+ * Returns 1 on successfully attached PM domain, 0 when the device don't need a
+ * PM domain or when multiple power-domains exists for it, else a negative error
+ * code. Note that if a power-domain exists for the device, but it cannot be
+ * found or turned on, then return -EPROBE_DEFER to ensure that the device is
+ * not probed and to re-try again later.
+ */
+int genpd_dev_pm_attach(struct device *dev)
+{
+	if (!dev->of_node)
+		return 0;
+
+	/*
+	 * Devices with multiple PM domains must be attached separately, as we
+	 * can only attach one PM domain per device.
+	 */
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") != 1)
+		return 0;
+
+	return __genpd_dev_pm_attach(dev, dev->of_node, 0);
+}
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
 static const struct of_device_id idle_state_match[] = {
-- 
2.17.0
