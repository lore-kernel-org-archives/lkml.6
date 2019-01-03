Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A020883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XtPMTN70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfACI4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:56:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33886 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfACIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:55:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so15744193pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 00:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4GYe5BpuCzl66iZjcA33AeUfezru5psM9UkhsJsXCg=;
        b=XtPMTN70hQeNn1bW5fb176J2wkClrz8pQPqh7v4nsXDMvbsrMT7LXfyvYjF9aJRrjf
         onhqpJayoV/LyHKmmBxzVo4eRbNXDAscp9DBxm+IHeQyOx/XjCA7FjIeEWCibpymrRVj
         6jeLRucXvOT97uSzuSYeZaBRhgOU8APSfT8wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m4GYe5BpuCzl66iZjcA33AeUfezru5psM9UkhsJsXCg=;
        b=XZtHmGcBreCV0aCXCw20imbrEE8/5qFlNY9zxA4iW742Zh7zsNgC1n1Ps1mcuMKwF7
         74geiOBgM5RqOmCd+IUXBO1JMq4VVKiGTxnj0xMSbAGfqVKLHi5sE+VKvGs7onzPfK2O
         SUDjMRprsgRYIc8AZTYtOiffy/mal1lE2DBz6d0TK8bW83AhJUHhkyvMhoHPspcDqqo9
         6+xcROzLOCCqsBBLePEYBiorkh5oOKmBCinrR36XtFnmmoXvYQM8pxsOAlfWpeIwWEkT
         34/H1kcGCc0trhZ86+gBYv5pamgEre9aQFNcfNW3lr/jNGJJ/PjtMdMwNTi8fjn8pD8o
         IaVA==
X-Gm-Message-State: AJcUukcYI4m1o3+jxyjKkV3VBnEXJpixA3xRmH+J38ckXSxiLeP/sX6X
        xyc+qfRRBqKCZyfpX7t3uvmLRg==
X-Google-Smtp-Source: ALg8bN4xHH+b2cmWb0SrM5kfpQZ/K1L1iLuJLY3anz14AyRy//YC9rgNZ9LqhttkYUppqxqP51tfDw==
X-Received: by 2002:a63:680a:: with SMTP id d10mr16435562pgc.396.1546505755901;
        Thu, 03 Jan 2019 00:55:55 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s190sm78189727pfb.103.2019.01.03.00.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 00:55:55 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 2/3] thermal: broadcom: Add Stingray thermal driver
Date:   Thu,  3 Jan 2019 14:25:33 +0530
Message-Id: <1546505734-24527-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Stingray SoC has six temperature sensor and those are
configured, controlled and accessed to read temperature
and update in DDR memory using m0 firmware.
All six sensors has been given 4 bytes of memory in DDR
to write temperature in millivolts.

This thermal driver read temperature values from DDR
because no direct access to sensors.
Like this all temparature sensors are monitored and
trips at critical temperature.

If driver can't handle thermal runaways because of
any unknown reason, then firmware in m0 Processor
will handle.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/thermal/Kconfig               |   3 +-
 drivers/thermal/broadcom/Kconfig      |   9 +++
 drivers/thermal/broadcom/Makefile     |   1 +
 drivers/thermal/broadcom/sr-thermal.c | 122 ++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5422523..60e884e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -416,7 +416,8 @@ config MTK_THERMAL
 	  controller present in Mediatek SoCs
 
 menu "Broadcom thermal drivers"
-depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM_IPROC || \
+		COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index c106a15..dc9a9bd 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -22,3 +22,12 @@ config BCM_NS_THERMAL
 	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
 	  Management Unit) block with a thermal sensor that allows checking CPU
 	  temperature.
+
+config BCM_SR_THERMAL
+	tristate "Stingray thermal driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
+	help
+	  Support for the Stingray family of SoCs. Its different blocks like
+	  iHost, CRMU and NITRO has thermal sensor that allows checking its
+	  temperature.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
index fae10ec..79df69e 100644
--- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
 obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
+obj-$(CONFIG_BCM_SR_THERMAL)		+= sr-thermal.o
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
new file mode 100644
index 0000000..fcb0cc2
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+/*
+ * In stingray thermal IO memory,
+ * Total Number of available TMONs MASK is at offset 0
+ * temperature registers BASE is at 4 byte offset.
+ * Each TMON temperature register size is 4.
+ */
+#define SR_TMON_TEMP_BASE(id)   ((id) * 0x4)
+
+#define SR_TMON_MAX_LIST        6
+
+struct sr_tmon {
+	struct thermal_zone_device *tz;
+	unsigned int crit_temp;
+	unsigned int tmon_id;
+	struct sr_thermal *priv;
+};
+
+struct sr_thermal {
+	void __iomem *regs;
+	unsigned int max_crit_temp;
+	struct sr_tmon tmon[SR_TMON_MAX_LIST];
+};
+
+static int sr_get_temp(void *data, int *temp)
+{
+	struct sr_tmon *tmon = data;
+	struct sr_thermal *sr_thermal = tmon->priv;
+
+	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sr_tz_ops = {
+	.get_temp = sr_get_temp,
+};
+
+static int sr_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sr_thermal *sr_thermal;
+	struct sr_tmon *tmon;
+	struct resource *res;
+	uint32_t sr_tmon_list = 0;
+	unsigned int i;
+	int ret;
+
+	sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
+	if (!sr_thermal)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sr_thermal->regs = (void __iomem *)devm_memremap(&pdev->dev, res->start,
+							 resource_size(res),
+							 MEMREMAP_WB);
+	if (IS_ERR(sr_thermal->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(sr_thermal->regs);
+	}
+
+	ret = device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_list);
+	if (ret)
+		return ret;
+
+	tmon = sr_thermal->tmon;
+	for (i = 0; i < SR_TMON_MAX_LIST; i++, tmon++) {
+
+		if (!(sr_tmon_list & BIT(i)))
+			continue;
+
+		/* Flush temperature registers */
+		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
+		tmon->tmon_id = i;
+		tmon->priv = sr_thermal;
+		tmon->tz = devm_thermal_zone_of_sensor_register(dev, i, tmon,
+								&sr_tz_ops);
+		if (IS_ERR(tmon->tz))
+			return PTR_ERR(tmon->tz);
+
+		dev_dbg(dev, "thermal sensor %d registered\n", i);
+	}
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+}
+
+static const struct of_device_id sr_thermal_of_match[] = {
+	{ .compatible = "brcm,sr-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
+
+static const struct acpi_device_id sr_thermal_acpi_ids[] = {
+	{ .id = "BRCM0500" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
+
+static struct platform_driver sr_thermal_driver = {
+	.probe		= sr_thermal_probe,
+	.driver = {
+		.name = "sr-thermal",
+		.of_match_table = sr_thermal_of_match,
+		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
+	},
+};
+module_platform_driver(sr_thermal_driver);
+
+MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
+MODULE_DESCRIPTION("Stingray thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

