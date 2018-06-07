Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YP3HCAZzGVvdVAAAmS7hNA
	; Thu, 07 Jun 2018 18:14:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DDEBC6089E; Thu,  7 Jun 2018 18:14:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47A0E605A2;
	Thu,  7 Jun 2018 18:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47A0E605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936003AbeFGSOt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:14:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42360 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934504AbeFGSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:09 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so6629995pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNTPVOc9itsgSGXJtTCwKhZik/oC0KXvCOU82jh0Sag=;
        b=WN1ZM/wxx0K8i4ENn0154Xc9eSKD0qwXFGBsv3ZuMgXzw0qTwmSu94DJpNXsJ4aNfl
         pFWqqSAkm+UgVmoZ4M3rdjtD4tue9ouetusZND7fkagMk6oQx0MPUTyuHtb5/DQ7cV2G
         O4738+D9dcudSXLm/XlSYjO54c1BcOZ7bBE9sJMLZ13UzDSCjAbpoMQWeXwchs5G0Plp
         Ag7goRyK00jX/agmkbOn7CgIl8nkyxT8fYsUh+5jxcsXDzKlAhbPKKWgxvxmGp+HF/dQ
         R8LTnXicvI3gChNUbuOFXcCcgaQ2c5gthI8iKEljXjpUH27/5j7CcRON3c0AlP7vt7yu
         rJiA==
X-Gm-Message-State: APt69E10T0llxI//jfeGVGrx80fl0a3cEEtHueonqnPpEAvT9UPmuLCg
        lDDM3SFWfmZ1+s5XAMaDANTTgw==
X-Google-Smtp-Source: ADUXVKJmSi2pmqwPqO9jyFwKIogQQcJZlX/BELdGceJVIiPoVGjjYoI4OopvrSvpanmx4+T8Aj+1Bg==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1-v6mr3080106plt.91.1528395188432;
        Thu, 07 Jun 2018 11:13:08 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:07 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 11/11] misc: throttler: Add Chrome OS EC throttler
Date: Thu,  7 Jun 2018 11:12:14 -0700
Message-Id: <20180607181214.30338-12-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver subscribes to throttling events from the Chrome OS
embedded controller and enables/disables system throttling based
on these events.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes in v2:
- added SPDX line instead of license boiler-plate
- use macro to avoid splitting line
- changed variable name for throttler from 'cte' to 'ce_thr'
- formatting fixes
- Kconfig: removed odd dashes around 'help'
- added 'Reviewed-by' tag

Note: I finally decided to keep 'Chrome OS' instead of changing it
to 'ChromeOS'. Both are currently used in the kernel, the latter is
currently more prevalent, however the official name is 'Chrome OS',
so there is no good reason to keep introducing the 'alternative' name.

 drivers/misc/throttler/Kconfig             |  14 +++
 drivers/misc/throttler/Makefile            |   1 +
 drivers/misc/throttler/cros_ec_throttler.c | 116 +++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c

diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
index e561f1df5085..da6fb70b96d9 100644
--- a/drivers/misc/throttler/Kconfig
+++ b/drivers/misc/throttler/Kconfig
@@ -12,3 +12,17 @@ menuconfig THROTTLER
 	  Note that you also need a event monitor module usually called
 	  *_throttler.
 
+if THROTTLER
+
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
index 000000000000..432135c55600
--- /dev/null
+++ b/drivers/misc/throttler/cros_ec_throttler.c
@@ -0,0 +1,116 @@
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
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np) {
+		/* should never happen */
+		return -EINVAL;
+	}
+
+	ce_thr = devm_kzalloc(dev, sizeof(*ce_thr), GFP_KERNEL);
+	if (!ce_thr)
+		return -ENOMEM;
+
+	ce_thr->ec = dev_get_drvdata(pdev->dev.parent);
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
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_throttler_of_match[] = {
+	{ .compatible = "google,cros-ec-throttler" },
+	{ /* sentinel */ }
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
2.18.0.rc1.242.g61856ae69a-goog
