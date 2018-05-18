Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeERKeL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:34:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46493 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeERKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:51 -0400
X-Google-Smtp-Source: AB8JxZrBvFRNg3Bh/JNsQLtIhPmiYn7cpO3FRnyTqs5tj2c5eZHv2zm6Qe64JwBRGHy380U6qOwofw==
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
Subject: [PATCH 2/9] PM / Domains: Drop __pm_genpd_add_device()
Date: Fri, 18 May 2018 12:31:23 +0200
Message-Id: <1526639490-12167-3-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still a few non-DT existing users of genpd, however neither of
them uses __pm_genpd_add_device(), hence let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 ++++------
 include/linux/pm_domain.h   | 14 +++-----------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da6c886..d58aee3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1414,23 +1414,21 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 }
 
 /**
- * __pm_genpd_add_device - Add a device to an I/O PM domain.
+ * pm_genpd_add_device - Add a device to an I/O PM domain.
  * @genpd: PM domain to add the device to.
  * @dev: Device to be added.
- * @td: Set of PM QoS timing parameters to attach to the device.
  */
-int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
-			  struct gpd_timing_data *td)
+int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 {
 	int ret;
 
 	mutex_lock(&gpd_list_lock);
-	ret = genpd_add_device(genpd, dev, td);
+	ret = genpd_add_device(genpd, dev, NULL);
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
+EXPORT_SYMBOL_GPL(pm_genpd_add_device);
 
 static int genpd_remove_device(struct generic_pm_domain *genpd,
 			       struct device *dev)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c847e9a..79888fb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -143,8 +143,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
-int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
-			  struct gpd_timing_data *td);
+int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
 int pm_genpd_remove_device(struct generic_pm_domain *genpd, struct device *dev);
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *new_subdomain);
@@ -163,9 +162,8 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
 }
-static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
-					struct device *dev,
-					struct gpd_timing_data *td)
+static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
+				      struct device *dev)
 {
 	return -ENOSYS;
 }
@@ -204,12 +202,6 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
 
-static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-				      struct device *dev)
-{
-	return __pm_genpd_add_device(genpd, dev, NULL);
-}
-
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
 void pm_genpd_syscore_poweroff(struct device *dev);
 void pm_genpd_syscore_poweron(struct device *dev);
-- 
2.7.4
