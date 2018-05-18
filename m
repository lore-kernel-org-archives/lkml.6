Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeERKdB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:33:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38565 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbeERKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:59 -0400
X-Google-Smtp-Source: AB8JxZq7mpM973JWrWfZxrFD1GsHz4vCBEQ6o2rdyZ/tLmF2MV4ZidskyfEYzlHs0uv7qZ2Ai2/B8Q==
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
Subject: [PATCH 8/9] PM / Domains: Add support for multi PM domains per device to genpd
Date: Fri, 18 May 2018 12:31:29 +0200
Message-Id: <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support devices being partitioned across multiple PM domains, let's
start by extending genpd to cope with these configurations.

More precisely, add a new exported function, genpd_dev_pm_attach_by_id(),
similar to genpd_dev_pm_attach(), but the new function also allows the
caller to provide an index to what PM domain it wants to attach.

Furthermore, let genpd register a new virtual struct device via calling
device_register() and attach it to the corresponding PM domain, which is
looked up via calling the existing genpd OF functions. Note that the new
device is needed, because only one PM domain can be attached per device. At
successful attachment, genpd_dev_pm_attach_by_id() returns the new device,
allowing the caller to operate on it to deal with power management.

To deal with detaching of a PM domain for multiple PM domain case, we can
still re-use the existing genpd_dev_pm_detach() function, although we need
to extend it to cover cleanup of the earlier registered device, via calling
device_unregister().

An important note, genpd_dev_pm_attach_by_id() shall only be called by the
driver core / PM core, similar to how genpd_dev_pm_attach() is used.
Following changes deploys this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 +++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d538640..ffeb6ea 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2171,6 +2171,15 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_genpd_remove_last);
 
+static void genpd_release_dev(struct device *dev)
+{
+	kfree(dev);
+}
+
+static struct bus_type genpd_bus_type = {
+	.name		= "genpd",
+};
+
 /**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
@@ -2208,6 +2217,10 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	/* Check if PM domain can be powered off after removing this device. */
 	genpd_queue_power_off_work(pd);
+
+	/* Unregister the device if it was created by genpd. */
+	if (dev->bus == &genpd_bus_type)
+		device_unregister(dev);
 }
 
 static void genpd_dev_pm_sync(struct device *dev)
@@ -2298,6 +2311,66 @@ int genpd_dev_pm_attach(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
+/**
+ * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
+ * @dev: Device to attach.
+ * @index: The index of the PM domain.
+ *
+ * Parse device's OF node to find a PM domain specifier at the provided @index.
+ * If such is found, allocates a new device and attaches it to retrieved
+ * pm_domain ops.
+ *
+ * Returns the allocated device if successfully attached PM domain, NULL when
+ * the device don't need a PM domain or have a single PM domain, else PTR_ERR()
+ * in case of failures. Note that if a power-domain exists for the device, but
+ * cannot be found or turned on, then return PTR_ERR(-EPROBE_DEFER) to ensure
+ * that the device is not probed and to re-try again later.
+ */
+struct device *genpd_dev_pm_attach_by_id(struct device *dev,
+					 unsigned int index)
+{
+	struct device *genpd_dev;
+	int num_domains;
+	int ret;
+
+	if (!dev->of_node)
+		return NULL;
+
+	/* Deal only with devices using multiple PM domains. */
+	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
+						 "#power-domain-cells");
+	if (num_domains < 2 || index >= num_domains)
+		return NULL;
+
+	/* Allocate and register device on the genpd bus. */
+	genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
+	if (!genpd_dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
+	genpd_dev->bus = &genpd_bus_type;
+	genpd_dev->release = genpd_release_dev;
+
+	ret = device_register(genpd_dev);
+	if (ret) {
+		kfree(genpd_dev);
+		return ERR_PTR(ret);
+	}
+
+	/* Try to attach the device to the PM domain at the specified index. */
+	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
+	if (ret < 1) {
+		device_unregister(genpd_dev);
+		return ret ? ERR_PTR(ret) : NULL;
+	}
+
+	pm_runtime_set_active(genpd_dev);
+	pm_runtime_enable(genpd_dev);
+
+	return genpd_dev;
+}
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
@@ -2456,6 +2529,12 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
 
+static int __init genpd_bus_init(void)
+{
+	return bus_register(&genpd_bus_type);
+}
+core_initcall(genpd_bus_init);
+
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 42e0d64..82458e8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -237,6 +237,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 				struct device_node *opp_node);
 
 int genpd_dev_pm_attach(struct device *dev);
+struct device *genpd_dev_pm_attach_by_id(struct device *dev,
+					 unsigned int index);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -282,6 +284,12 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 	return 0;
 }
 
+static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
+						       unsigned int index)
+{
+	return NULL;
+}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
2.7.4
