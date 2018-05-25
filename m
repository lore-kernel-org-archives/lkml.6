Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030350AbeEYUbk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:31:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42321 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030260AbeEYUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:32 -0400
X-Google-Smtp-Source: AB8JxZoGEy63cYxthRtOL3w0xmJank9Nb3AADmbLSpmwpBbA9aOhNZNQsC7MStCt+ZlBmWF4e+QprQ==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 11/11] misc/throttler: Add Chrome OS EC throttler
Date: Fri, 25 May 2018 13:30:43 -0700
Message-Id: <20180525203043.249193-12-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver subscribes to throttling events from the Chrome OS
embedded controller and enables/disables system throttling based
on these events.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/misc/throttler/Kconfig             |  15 +++
 drivers/misc/throttler/Makefile            |   1 +
 drivers/misc/throttler/cros_ec_throttler.c | 122 +++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c

diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
index ef8388f6bc0a..652b6817b75c 100644
--- a/drivers/misc/throttler/Kconfig
+++ b/drivers/misc/throttler/Kconfig
@@ -11,3 +11,18 @@ menuconfig THROTTLER
 	  Note that you also need a event monitor module usually called
 	  *_throttler.
 
+if THROTTLER
+
+config CROS_EC_THROTTLER
+	tristate "Throttler event monitor for the Chrome OS Embedded Controller"
+	default n
+	depends on MFD_CROS_EC
+	---help---
+	  This driver adds support to throttle the system in reaction to
+	  Chrome OS EC events.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_throttler.
+
+endif # THROTTLER
+
diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
index c8d920cee315..d9b2a77dabc9 100644
--- a/drivers/misc/throttler/Makefile
+++ b/drivers/misc/throttler/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_THROTTLER)		+= core.o
+obj-$(CONFIG_CROS_EC_THROTTLER)	+= cros_ec_throttler.o
diff --git a/drivers/misc/throttler/cros_ec_throttler.c b/drivers/misc/throttler/cros_ec_throttler.c
new file mode 100644
index 000000000000..ea6bc002d49c
--- /dev/null
+++ b/drivers/misc/throttler/cros_ec_throttler.c
@@ -0,0 +1,122 @@
+/*
+ * Driver for throttling triggered by EC events.
+ *
+ * Copyright (C) 2018 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/throttler.h>
+
+struct cros_ec_throttler {
+	struct cros_ec_device *ec;
+	struct throttler *throttler;
+	struct notifier_block nb;
+};
+
+static int cros_ec_throttler_event(struct notifier_block *nb,
+	unsigned long queued_during_suspend, void *_notify)
+{
+	struct cros_ec_throttler *cte =
+		container_of(nb, struct cros_ec_throttler, nb);
+	u32 host_event;
+
+	host_event = cros_ec_get_host_event(cte->ec);
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_START)) {
+		throttler_set_level(cte->throttler, 1);
+
+		return NOTIFY_OK;
+	} else if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_STOP)) {
+		throttler_set_level(cte->throttler, 0);
+
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int cros_ec_throttler_probe(struct platform_device *pdev)
+{
+	struct cros_ec_throttler *cte;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np) {
+		/* should never happen */
+		return -EINVAL;
+	}
+
+	cte = devm_kzalloc(dev, sizeof(*cte), GFP_KERNEL);
+	if (!cte)
+		return -ENOMEM;
+
+	cte->ec = dev_get_drvdata(pdev->dev.parent);
+
+	cte->throttler = throttler_setup(dev);
+	if (IS_ERR(cte->throttler))
+		return PTR_ERR(cte->throttler);
+
+	dev_set_drvdata(dev, cte);
+
+	cte->nb.notifier_call = cros_ec_throttler_event;
+	ret = blocking_notifier_chain_register(&cte->ec->event_notifier,
+					       &cte->nb);
+	if (ret < 0) {
+		dev_err(dev, "failed to register notifier\n");
+		throttler_teardown(cte->throttler);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_ec_throttler_remove(struct platform_device *pdev)
+{
+	struct cros_ec_throttler *cte = platform_get_drvdata(pdev);
+
+	blocking_notifier_chain_unregister(&cte->ec->event_notifier,
+					   &cte->nb);
+
+	throttler_teardown(cte->throttler);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_throttler_of_match[] = {
+        { .compatible = "google,cros-ec-throttler" },
+        { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cros_ec_throttler_of_match);
+#endif /* CONFIG_OF */
+
+static struct platform_driver cros_ec_throttler_driver = {
+	.driver = {
+		.name = "cros-ec-throttler",
+		.of_match_table = of_match_ptr(cros_ec_throttler_of_match),
+	},
+	.probe		= cros_ec_throttler_probe,
+	.remove		= cros_ec_throttler_remove,
+};
+
+module_platform_driver(cros_ec_throttler_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Chrome OS EC Throttler");
-- 
2.17.0.921.gf22659ad46-goog
