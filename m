Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBWKYL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39195 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:08 -0500
X-Google-Smtp-Source: AH8x22621bYZ3ZKghUlZn1GVm8lfP4caKLiiUa33jOTWcFR00jIeSYSQ5oPFACAMJ5qm9AvpIIfUjw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 01/13] of: platform: Add of_find_any_device_by_node()
Date: Fri, 23 Feb 2018 15:53:40 +0530
Message-Id: <483bc64db23821497d0634a86e801510e439fe3d.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This creates a new helper that returns the struct device corresponding
to a struct device_node. This currently works only for amba and platform
devices, but can be easily extended to include other bus types.

This also creates an internal of_find_amba_device_by_node() helper,
which isn't exported as of now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_platform.h |  5 +++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..72853f9043e6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -55,6 +55,61 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+#ifdef CONFIG_ARM_AMBA
+/**
+ * of_find_amba_device_by_node - Find the amba_device associated with a node
+ * @np: Pointer to device tree node
+ *
+ * Takes a reference to the embedded struct device which needs to be dropped
+ * after use.
+ *
+ * Returns amba_device pointer, or NULL if not found
+ */
+static struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
+	return dev ? to_amba_device(dev) : NULL;
+}
+#else
+static inline struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * of_find_any_device_by_node - Find the struct device associated with a node
+ * @np: Pointer to device tree node
+ *
+ * Takes a reference to the embedded struct device which needs to be dropped
+ * after use.
+ *
+ * This currently supports only AMBA and platform devices.
+ *
+ * Returns struct device pointer, or NULL if not found
+ */
+struct device *of_find_any_device_by_node(struct device_node *np)
+{
+	struct device *dev = NULL;
+
+	if (of_device_is_compatible(np, "arm,primecell")) {
+		struct amba_device *adev = of_find_amba_device_by_node(np);
+
+		if (adev)
+			dev = &adev->dev;
+	} else {
+		struct platform_device *pdev = of_find_device_by_node(np);
+
+		if (pdev)
+			dev = &pdev->dev;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(of_find_any_device_by_node);
+
 #ifdef CONFIG_OF_ADDRESS
 /*
  * The following routines scan a subtree and registers a device for
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..5fb20afaf895 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -54,11 +54,16 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 struct device *parent);
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
+extern struct device *of_find_any_device_by_node(struct device_node *np);
 #else
 static inline struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	return NULL;
 }
+static inline struct device *of_find_any_device_by_node(struct device_node *np)
+{
+	return NULL;
+}
 #endif
 
 /* Platform devices and busses creation */
-- 
2.15.0.194.g9af6a3dea062
