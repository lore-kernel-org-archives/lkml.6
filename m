Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE866247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE866247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeGCXsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:48:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37754 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753667AbeGCXrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id n15-v6so1646503pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evgsf5Vq1O4jyiTSQjyAxO4d4xwVuctkoeX7GhDuJA4=;
        b=UsYUL0nA8M22MW46wL0su9h175Y/9e7TxdT7KmDIfs+VGVsmRG3+oEd/FG3J2BUG6w
         f+Y3lcE4MvX1oyd5cSl8B3mKLw/gIwAjYlvyg+Zs82lndc7EsxpChxutgRfZjZHhN+FK
         kcRp8AdCF7qD8JTWcqAyys1Wjndbquralf1dPBVuTIM7Igx0dLInj/G06LNfBpOq7LNi
         vUhAOSWzpzOjia7ChcRWw7u5GTLnB12ZiU3Kx5NrnqWaopy9aqWQuVGgjgmXYg32bnNl
         2CQzWpSxYTFA2rYfyioiP1ryeMyRhmPP8vEvHxoxBvCkT6ZRpajE+fXSgzSGPsdn3UIi
         RGZA==
X-Gm-Message-State: APt69E1l5Lkzv9EibLthOyDMSYVCPJPZcb/ESRAs1gQ/DSy0/dY6jTAx
        sj4xzAnOxUxudyvQAyNdpMC5ww==
X-Google-Smtp-Source: ADUXVKLhkZC9eW4caWohFeHUzRLm85ApWJDHLm8jT0Q3fSNQC/tBOyD20ZpkVwAV770ImSSBc2nowg==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr26943834pgo.378.1530661659339;
        Tue, 03 Jul 2018 16:47:39 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:38 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 11/12] misc: throttler: Add Chrome OS EC throttler
Date:   Tue,  3 Jul 2018 16:47:04 -0700
Message-Id: <20180703234705.227473-12-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver subscribes to throttling events from the Chrome OS
embedded controller and enables/disables system throttling based
on these events.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- adapt to parent being struct cros_ec_dev instead of struct
  cros_ec_device
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- change module license to GPL v2 as in the SPDX identifier
- don't instantiate the throttler through the DT (instantiation
  by CrOS EC MFD in a separate patch)

Changes in v2:
- added SPDX line instead of license boiler-plate
- use macro to avoid splitting line
- changed variable name for throttler from 'cte' to 'ce_thr'
- formatting fixes
- Kconfig: removed odd dashes around 'help'
- added 'Reviewed-by' tag
---
 drivers/misc/throttler/Kconfig             |  10 ++
 drivers/misc/throttler/Makefile            |   1 +
 drivers/misc/throttler/cros_ec_throttler.c | 111 +++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c

diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
index 8b2e63b2ef48..ef984c96f67b 100644
--- a/drivers/misc/throttler/Kconfig
+++ b/drivers/misc/throttler/Kconfig
@@ -20,4 +20,14 @@ menuconfig THROTTLER_DEBUG
 
 	  Choose N unless you want to debug throttler drivers.
 
+config CROS_EC_THROTTLER
+	tristate "Throttler event monitor for the Chrome OS Embedded Controller"
+	depends on MFD_CROS_EC
+	help
+	  This driver adds support to throttle the system in reaction to
+	  Chrome OS EC events.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_throttler.
+
 endif # THROTTLER
diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
index c8d920cee315..d9b2a77dabc9 100644
--- a/drivers/misc/throttler/Makefile
+++ b/drivers/misc/throttler/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_THROTTLER)		+= core.o
+obj-$(CONFIG_CROS_EC_THROTTLER)	+= cros_ec_throttler.o
diff --git a/drivers/misc/throttler/cros_ec_throttler.c b/drivers/misc/throttler/cros_ec_throttler.c
new file mode 100644
index 000000000000..82a25415a264
--- /dev/null
+++ b/drivers/misc/throttler/cros_ec_throttler.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for throttling triggered by events from the Chrome OS Embedded
+ * Controller.
+ *
+ * Copyright (C) 2018 Google, Inc.
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
+#define nb_to_ce_thr(nb) container_of(nb, struct cros_ec_throttler, nb)
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
+	struct cros_ec_throttler *ce_thr = nb_to_ce_thr(nb);
+	u32 host_event;
+
+	host_event = cros_ec_get_host_event(ce_thr->ec);
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_START)) {
+		throttler_set_level(ce_thr->throttler, 1);
+
+		return NOTIFY_OK;
+	} else if (host_event &
+		   EC_HOST_EVENT_MASK(EC_HOST_EVENT_THROTTLE_STOP)) {
+		throttler_set_level(ce_thr->throttler, 0);
+
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int cros_ec_throttler_probe(struct platform_device *pdev)
+{
+	struct cros_ec_throttler *ce_thr;
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec;
+	int ret;
+
+	ce_thr = devm_kzalloc(dev, sizeof(*ce_thr), GFP_KERNEL);
+	if (!ce_thr)
+		return -ENOMEM;
+
+	ec = dev_get_drvdata(pdev->dev.parent);
+	ce_thr->ec = ec->ec_dev;
+
+	/*
+	 * The core code uses the DT node of the throttler to identify its
+	 * throttling devices and rates. The CrOS EC throttler is a sub-device
+	 * of the CrOS EC MFD device and doesn't have its own device node. Use
+	 * the node of the MFD device instead.
+	 */
+	dev->of_node = ce_thr->ec->dev->of_node;
+
+	ce_thr->throttler = throttler_setup(dev);
+	if (IS_ERR(ce_thr->throttler))
+		return PTR_ERR(ce_thr->throttler);
+
+	dev_set_drvdata(dev, ce_thr);
+
+	ce_thr->nb.notifier_call = cros_ec_throttler_event;
+	ret = blocking_notifier_chain_register(&ce_thr->ec->event_notifier,
+					       &ce_thr->nb);
+	if (ret < 0) {
+		dev_err(dev, "failed to register notifier\n");
+		throttler_teardown(ce_thr->throttler);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_ec_throttler_remove(struct platform_device *pdev)
+{
+	struct cros_ec_throttler *ce_thr = platform_get_drvdata(pdev);
+
+	blocking_notifier_chain_unregister(&ce_thr->ec->event_notifier,
+					   &ce_thr->nb);
+
+	throttler_teardown(ce_thr->throttler);
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_throttler_driver = {
+	.driver = {
+		.name = "cros-ec-throttler",
+	},
+	.probe		= cros_ec_throttler_probe,
+	.remove		= cros_ec_throttler_remove,
+};
+
+module_platform_driver(cros_ec_throttler_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Chrome OS EC Throttler");
-- 
2.18.0.203.gfac676dfb9-goog

