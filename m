Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192D220866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BBp/Ak++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192D220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJPXCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:02:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32995 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJPXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:02:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so11187664plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fz6+Ol5ZSatidKaKx9LojXU48NY3UoX2kR/N1/Y+SYU=;
        b=BBp/Ak++RF8CGKZScahU6sG9f+vFyYT3YTD5e+7A16/jqb2+VFUhahuCP4MdES9lN3
         z61gki4PZ4ny/RSzSkQYYBzuAo6vV7cX1PWWj5CfNj40LNmuhLBwZnt7tIFbwho7L85k
         UaoGZoh+QijjC6h3ETscozY7pJR88Ozph3TBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fz6+Ol5ZSatidKaKx9LojXU48NY3UoX2kR/N1/Y+SYU=;
        b=A/Lwz3elFdGIhNE6LT7L6QAP3q8UROvwwbF1JFWoz178w6bcoRKs28Mz7tyFOrVZoD
         YtwluG9uddIGq5PRcGu/eYXWwgBRE999ubvPqob42EL6T/ycMbgOU5cjPe7h25jq+bQ/
         Dl6/x0TpzCxTt6LTGBhiSvYzIFeGDn/AQ614d134HwCeJrMBT6TfUFx6MtayD1Mj01vj
         7BUamK878HxBiwAIWcUihbSjsY8ENzPaSsMyRnSKjh/zMbOveodJ855duxzAInLruOtM
         7wZm0bOWym4ZqufqeDNXPObjzCVnNv7ersBgNizHiI6v1Mm4RJvuR6t7Imhn+aOXky8i
         PiCQ==
X-Gm-Message-State: ABuFfojZZYzGWQV1PgKbQhoqxs/OJ0edj7j9f6x6mw0kJOnk20ctIRyu
        akCjNt7yq1bP6GqyrnfSFS9E6A==
X-Google-Smtp-Source: ACcGV60/N8JQWIVv7nhW+HijFaH1m7CRW3iWnMIi9MGiK6lmwVXHxw7aQqXYJwRhDzNL7eVAeW0IDA==
X-Received: by 2002:a17:902:7045:: with SMTP id h5-v6mr10674907plt.211.1539702703552;
        Tue, 16 Oct 2018 08:11:43 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i29-v6sm24227122pfj.82.2018.10.16.08.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 08:11:42 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 2/3] thermal: broadcom: Add Stingray thermal driver
Date:   Tue, 16 Oct 2018 20:41:19 +0530
Message-Id: <1539702680-3746-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/thermal/broadcom/sr-thermal.c | 138 ++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
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
index 0000000..f45e12e
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,138 @@
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
+		dev_info(dev, "thermal sensor %d registered\n", i);
+	}
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+}
+
+static int sr_thermal_remove(struct platform_device *pdev)
+{
+	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
+	unsigned int i;
+	struct sr_tmon *tmon;
+
+	tmon = sr_thermal->tmon;
+	for (i = 0; i < SR_TMON_MAX_LIST; i++, tmon++)
+		if (tmon->tz)
+			devm_thermal_zone_of_sensor_unregister(&pdev->dev,
+							       tmon->tz);
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

