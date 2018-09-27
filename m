Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09545C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524B216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3oF5V66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524B216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeI0V5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:57:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37322 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeI0V5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:57:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so3130211wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+VQx26+WehPGhqiTvgVaYLO1y1dGBz5FgCKDOJ85Tk=;
        b=T3oF5V66i3HAOpqiaBHSUOUToIax5RWeg0DiMWzuV3eYqd8nWgQvuwDuHRPfDF7Qqi
         fIFX0DGsY5PuMquD84FROEEu0Oapjd75iMS3w0Kezt7xk9hi/GKGOHXuGrgF0RijvkNl
         7L+J8sHkHj4Axy8MdcwwY7wb7X/HL+My+Y4Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+VQx26+WehPGhqiTvgVaYLO1y1dGBz5FgCKDOJ85Tk=;
        b=Gtz3nSGNGFcoI85U/zUTgo01tCQteSw5rqqsxFkOXIAiKEWg4m9h5GjUBdd6Y/rnye
         T3zKWtr+2xqG59F4U01ZZzt9rauIy7xzz/K0CwbcMppgMdOcJapzlpek60e5xrZFFu91
         YxS2jb7SW+ivG5M9LK8qQeJAlqeofLR14gNZj+hFv8t+9mcaSNyXR27Ok9qxJ5Ksu+5C
         FuK9HFB1cGlC62JvV94VZAbkDAbrNiKqXvsc79IAb6q/qoMh1INNVOkAbRuJg1N8IWEO
         GwyWlx2dFq7fKRmp56GnDJXy4Jo5K4AoFy5/UPDV3/MkSfCBK08rEnh8OvWyGF68u5gS
         FTTw==
X-Gm-Message-State: ABuFfogkGjhPHg8VUJqbdnd41JWaaIP/TyPzAjKh2bi4brspb22JCi0C
        LwXgcWPFUs0jqOUl4t+MgdRIpw==
X-Google-Smtp-Source: ACcGV62J6ZhvJ0QrLFIZu1MsVHAV4ZEkU16f8nXpavqL/1viu7XRP/znZVp4QQPC4j5ud3EvO9qLJg==
X-Received: by 2002:adf:b34e:: with SMTP id k14-v6mr9336582wrd.207.1538062697604;
        Thu, 27 Sep 2018 08:38:17 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2520033wrd.74.2018.09.27.08.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 08:38:16 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 3/3] thermal: broadcom: Add Stingray thermal driver
Date:   Thu, 27 Sep 2018 21:06:43 +0530
Message-Id: <1538062603-7490-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/thermal/broadcom/Kconfig      |   9 ++
 drivers/thermal/broadcom/Makefile     |   1 +
 drivers/thermal/broadcom/sr-thermal.c | 203 ++++++++++++++++++++++++++++++++++
 4 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e69edc..5f9f070 100644
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
index 0000000..df91055
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,203 @@
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
+static const char * const sr_tmon_names[] = {
+	"sr_tmon_ihost0",
+	"sr_tmon_ihost1",
+	"sr_tmon_ihost2",
+	"sr_tmon_ihost3",
+	"sr_tmon_crmu",
+	"sr_tmon_nitro",
+};
+
+#define SR_TMON_MAX_LIST	ARRAY_SIZE(sr_tmon_names)
+#define MAX_NUMBER_OF_TRIPS	1
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
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct sr_tmon *tmon = tz->devdata;
+	struct sr_thermal *sr_thermal = tmon->priv;
+
+	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
+
+	return 0;
+}
+
+static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
+					enum thermal_trip_type *type)
+{
+	if (trip >= MAX_NUMBER_OF_TRIPS)
+		return -EINVAL;
+
+	*type = THERMAL_TRIP_CRITICAL;
+
+	return 0;
+}
+
+static int sr_get_trip_temp(struct thermal_zone_device *tz, int trip, int *temp)
+{
+	struct sr_tmon *tmon = tz->devdata;
+
+	if (trip >= MAX_NUMBER_OF_TRIPS)
+		return -EINVAL;
+
+	*temp = tmon->crit_temp;
+
+	return 0;
+}
+
+static int sr_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+{
+	struct sr_tmon *tmon = tz->devdata;
+	struct sr_thermal *sr_thermal = tmon->priv;
+
+	if (trip >= MAX_NUMBER_OF_TRIPS)
+		return -EINVAL;
+
+	if (temp > sr_thermal->max_crit_temp)
+		return -EINVAL;
+
+	tmon->crit_temp = temp;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops sr_thermal_ops = {
+	.get_temp = sr_get_temp,
+	.get_trip_type = sr_get_trip_type,
+	.get_trip_temp = sr_get_trip_temp,
+	.set_trip_temp = sr_set_trip_temp,
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
+					 resource_size(res), MEMREMAP_WB);
+	if (IS_ERR(sr_thermal->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(sr_thermal->regs);
+	}
+
+	ret = device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_list);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev, "brcm,max-crit-temp",
+				       &sr_thermal->max_crit_temp);
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
+		tmon->crit_temp = sr_thermal->max_crit_temp;
+		tmon->tmon_id = i;
+		tmon->priv = sr_thermal;
+		tmon->tz = thermal_zone_device_register(sr_tmon_names[i],
+				MAX_NUMBER_OF_TRIPS, 1,
+				tmon,
+				&sr_thermal_ops,
+				NULL, 1000, 1000);
+		if (IS_ERR(tmon->tz))
+			goto err_exit;
+
+		dev_info(dev, "%s: registered\n", sr_tmon_names[i]);
+	}
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+
+err_exit:
+	while (--i >= 0) {
+		if (sr_thermal->tmon[i].tz)
+			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
+	}
+
+	return PTR_ERR(tmon->tz);
+}
+
+static int sr_thermal_remove(struct platform_device *pdev)
+{
+	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < SR_TMON_MAX_LIST; i++)
+		if (sr_thermal->tmon[i].tz)
+			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
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
+	.remove		= sr_thermal_remove,
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

