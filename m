Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeFBLLs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:11:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44162 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbeFBLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:11:42 -0400
X-Google-Smtp-Source: ADUXVKKqc4KPVAICIi2HetBdE0YRINO9roJQPj9uw/LfcNjYAuzt/1azqZ+8GeMU1/jj0AImIC0pKQ==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal: tsens: Add support for SDM845 platform
Date: Sat,  2 Jun 2018 14:11:12 +0300
Message-Id: <7a0f33cff94f41110bdbff14d28d36074fae2a7d.1527937396.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527937396.git.amit.kucheria@linaro.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1527937396.git.amit.kucheria@linaro.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two tsens blocks on the SDM845. These will be configured through
the devicetree.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-sdm845.c                | 98 ++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c                       |  3 +
 drivers/thermal/qcom/tsens.h                       |  1 +
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 292ed89..8652499 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -5,6 +5,7 @@ Required properties:
  - "qcom,msm8916-tsens" : For 8916 Family of SoCs
  - "qcom,msm8974-tsens" : For 8974 Family of SoCs
  - "qcom,msm8996-tsens" : For 8996 Family of SoCs
+ - "qcom,sdm845-tsens"  : For SDM845 Family of SoCs
 
 - reg: Address range of the thermal registers
 - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 2cc2193..dc9f169 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o tsens-sdm845.o
diff --git a/drivers/thermal/qcom/tsens-sdm845.c b/drivers/thermal/qcom/tsens-sdm845.c
new file mode 100644
index 0000000..5d78f0b
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-sdm845.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include "tsens.h"
+
+#define CNTL_OFFSET	4
+/* CNTL_OFFSET bitmasks */
+#define EN		BIT(0)
+#define SW_RST		BIT(1)
+
+#define SENSOR0_SHIFT	3
+
+#define TRDY_OFFSET     0xe4
+#define TRDY_READY_BIT  BIT(1)
+
+#define STATUS_OFFSET	0xa0
+#define LAST_TEMP_MASK	0xfff
+#define STATUS_VALID_BIT	BIT(21)
+#define CODE_SIGN_BIT		BIT(11)
+
+static int get_temp_sdm845(struct tsens_device *tmdev, int id, int *temp)
+{
+	struct tsens_sensor *s = &tmdev->sensor[id];
+	u32 code;
+	unsigned int sensor_addr;
+	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+
+	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
+	if (ret)
+		return ret;
+	if (code & TRDY_READY_BIT)
+		return -ENODATA;
+
+	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	last_temp = code & LAST_TEMP_MASK;
+	if (code & STATUS_VALID_BIT)
+		goto done;
+
+	/* Try a second time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp2 = code & LAST_TEMP_MASK;
+	}
+
+	/* Try a third/last time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp3 = code & LAST_TEMP_MASK;
+	}
+
+	if (last_temp == last_temp2)
+		last_temp = last_temp2;
+	else if (last_temp2 == last_temp3)
+		last_temp = last_temp3;
+done:
+	/* Code sign bit is the sign extension for a negative value */
+	if (last_temp & CODE_SIGN_BIT)
+		last_temp |= ~CODE_SIGN_BIT;
+
+	/* Temperatures are in deciCelicius */
+	*temp = last_temp * 100;
+
+	return 0;
+}
+
+static const struct regmap_config tsens_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+
+static const struct tsens_ops ops_sdm845 = {
+  	.init		= init_common,
+	.get_temp	= get_temp_sdm845,
+};
+
+const struct tsens_data data_sdm845 = {
+	.ops		= &ops_sdm845,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3f9fe6a..314a20f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,sdm845-tsens",
+		.data = &data_sdm845,
 	},
 	{}
 };
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 911c197..f15660d 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -90,5 +90,6 @@ int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
 
 extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
+extern const struct tsens_data data_sdm845;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.7.4
