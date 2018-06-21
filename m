Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5892C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E47220837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E47220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeFUByO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:54:14 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40941 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbeFUBxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so684116pfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uuTfTEyH7xqA35vIsTTQ8TYa2L1PgTCJf5g9yX7aHnU=;
        b=QLhioQrrvWmhvifTp1cMrKgtZ85kjXW1tTa9dsJpq751PMt9Y2ysGW71DdqIQEHqp3
         EmahTeWbLO0d2tdoxPNB29/nyeVUlmMFxMVxQARngoBFNZEgdr8sUMaDsYvQtnmqsvrg
         a6vybQi+hDP6XGUXYSz+rltaB8vm22ZLghKzYqX3cYJ6bh5VrA3BF6a7cmTGcOY6qDa0
         xjEg1LZFaUdppzFJGkzmmGeWRbKdO4tHy0j0SMC701m9Nc1eL1cPiyaAyJpYd5uS2b5q
         NlwnsmNFXo7x2vzB/n43bO69VDbKzBWpqbMyqifAlkkGiG3zLSQc4Y1bJSl+/XlS+QI8
         iRwg==
X-Gm-Message-State: APt69E0Z1kEPaOxlauvM6DgGizxQoiUPOn+Yl1IaZbLa3rllC6gzNoTX
        W4IjW62d7CSozkSRFNMyDok6rw==
X-Google-Smtp-Source: ADUXVKIUiwAos+STz3nAXeVJAG0OrEWYe8G74hD4vWnNqmu3l0aSjJ8PpY6zmC9eVBhXq/1Nc6coeA==
X-Received: by 2002:a62:6141:: with SMTP id v62-v6mr25164748pfb.197.1529545990064;
        Wed, 20 Jun 2018 18:53:10 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:53:09 -0700 (PDT)
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
Subject: [PATCH v4 11/12] misc: throttler: Add Chrome OS EC throttler
Date:   Wed, 20 Jun 2018 18:52:36 -0700
Message-Id: <20180621015237.100100-12-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
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
2.18.0.rc2.346.g013aa6912e-goog

