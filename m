Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeERKcV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:32:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34866 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeERKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:32:01 -0400
X-Google-Smtp-Source: AB8JxZon1aIya6jSBJzU5mKTem807xN1/o7m1G6xeqQKKjiIDloQLl2HRjnxC44xXsTrdBKzbIT0GA==
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
Subject: [PATCH 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM domains
Date: Fri, 18 May 2018 12:31:30 +0200
Message-Id: <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing dev_pm_domain_attach() function, allows a single PM domain to
be attached per device. To be able to support devices that are partitioned
across multiple PM domains, let's introduce a new interface,
dev_pm_domain_attach_by_id().

The dev_pm_domain_attach_by_id() returns a new allocated struct device with
the corresponding attached PM domain. This enables for example a driver to
operate on the new device from a power management point of view. The driver
may then also benefit from using the received device, to set up so called
device-links towards its original device. Depending on the situation, these
links may then be dynamically changed.

The new interface is typically called by drivers during their probe phase,
in case they manages devices which uses multiple PM domains. If that is the
case, the driver also becomes responsible of managing the detaching of the
PM domains, which typically should be done at the remove phase. Detaching
is done by calling the existing dev_pm_domain_detach() function and for
each of the received devices from dev_pm_domain_attach_by_id().

Note, currently its only genpd that supports multiple PM domains per
device, but dev_pm_domain_attach_by_id() can easily by extended to cover
other PM domain types, if/when needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 33 ++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  7 +++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 7ae62b6..d3db974 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -117,13 +117,44 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
 
 /**
+ * dev_pm_domain_attach_by_id - Attach a device to one of its PM domains.
+ * @index: The index of the PM domain.
+ * @dev: Device to attach.
+ *
+ * As @dev may only be attached to a single PM domain, the backend PM domain
+ * provider should create a virtual device to attach instead. As attachment
+ * succeeds, the ->detach() callback in the struct dev_pm_domain should be
+ * assigned by the corresponding backend attach function.
+ *
+ * This function should typically be invoked from drivers during probe phase.
+ * Especially for those that manages devices which requires power management
+ * through more than one PM domain.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns the virtual attached device in case successfully attached PM domain,
+ * NULL in case @dev don't need a PM domain, else a PTR_ERR().
+ */
+struct device *dev_pm_domain_attach_by_id(struct device *dev,
+					  unsigned int index)
+{
+	if (dev->pm_domain)
+		return NULL;
+
+	return genpd_dev_pm_attach_by_id(dev, index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
+
+/**
  * dev_pm_domain_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Used to indicate whether we should power off the device.
  *
  * This functions will reverse the actions from dev_pm_domain_attach() and thus
  * try to detach the @dev from its PM domain. Typically it should be invoked
- * from subsystem level code during the remove phase.
+ * during the remove phase, either from subsystem level code or from drivers in
+ * case attaching was done through dev_pm_domain_attach_by_id.
  *
  * Callers must ensure proper synchronization of this function with power
  * management callbacks.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 82458e8..493ce67 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -299,6 +299,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 
 #ifdef CONFIG_PM
 int dev_pm_domain_attach(struct device *dev, bool power_on);
+struct device *dev_pm_domain_attach_by_id(struct device *dev,
+					  unsigned int index);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
@@ -306,6 +308,11 @@ static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
+							unsigned int index);
+{
+	return NULL;
+}
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
-- 
2.7.4
