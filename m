Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeE2KF1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:05:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51669 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbeE2KEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:44 -0400
X-Google-Smtp-Source: AB8JxZpdKnqoAWTu+BP+iszsxtDqrRYbPFEHVsqKwfrR620KrIjmigbhfpmoIg+HE8fwIvl1uRExAg==
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
Subject: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM domains
Date: Tue, 29 May 2018 12:04:21 +0200
Message-Id: <20180529100421.31022-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
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

Changes in v2:
	- Fixed comments from Jon. Clarified function descriptions/changelog and
	return ERR_PTR(-EEXIST) in case a PM domain is already assigned.
	- Fix build error when CONFIG_PM is unset.

---
 drivers/base/power/common.c | 43 ++++++++++++++++++++++++++++++++++---
 include/linux/pm_domain.h   |  7 ++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 7ae62b6355b8..5e5ea0c239de 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -116,14 +116,51 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
 
+/**
+ * dev_pm_domain_attach_by_id - Attach a device to one of its PM domains.
+ * @dev: Device to attach.
+ * @index: The index of the PM domain.
+ *
+ * As @dev may only be attached to a single PM domain, the backend PM domain
+ * provider creates a virtual device to attach instead. If attachment succeeds,
+ * the ->detach() callback in the struct dev_pm_domain are assigned by the
+ * corresponding backend attach function, as to deal with detaching of the
+ * created virtual device.
+ *
+ * This function should typically be invoked by a driver during the probe phase,
+ * in case its device requires power management through multiple PM domains. The
+ * driver may benefit from using the received device, to configure device-links
+ * towards its original device. Depending on the use-case and if needed, the
+ * links may be dynamically changed by the driver, which allows it to control
+ * the power to the PM domains independently from each other.
+ *
+ * Callers must ensure proper synchronization of this function with power
+ * management callbacks.
+ *
+ * Returns the virtual created device when successfully attached to its PM
+ * domain, NULL in case @dev don't need a PM domain, else an ERR_PTR().
+ * Note that, to detach the returned virtual device, the driver shall call
+ * dev_pm_domain_detach() on it, typically during the remove phase.
+ */
+struct device *dev_pm_domain_attach_by_id(struct device *dev,
+					  unsigned int index)
+{
+	if (dev->pm_domain)
+		return ERR_PTR(-EEXIST);
+
+	return genpd_dev_pm_attach_by_id(dev, index);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
+
 /**
  * dev_pm_domain_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Used to indicate whether we should power off the device.
  *
- * This functions will reverse the actions from dev_pm_domain_attach() and thus
- * try to detach the @dev from its PM domain. Typically it should be invoked
- * from subsystem level code during the remove phase.
+ * This functions will reverse the actions from dev_pm_domain_attach() and
+ * dev_pm_domain_attach_by_id(), thus it detaches @dev from its PM domain.
+ * Typically it should be invoked during the remove phase, either from
+ * subsystem level code or from drivers.
  *
  * Callers must ensure proper synchronization of this function with power
  * management callbacks.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 82458e8e2e01..9206a4fef9ac 100644
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
+							unsigned int index)
+{
+	return NULL;
+}
 static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
-- 
2.17.0
