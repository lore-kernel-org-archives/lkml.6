Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeBWKYU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37201 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeBWKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:16 -0500
X-Google-Smtp-Source: AH8x224MfuNNd9hrGE7GKK/AdBRHB1vjfILD+9Lm6D7S72FogwvBJ3mGBKqWN+YWbQCjGUvjOTuoNw==
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
Subject: [PATCH V7 04/13] boot_constraint: Add support for supply constraints
Date: Fri, 23 Feb 2018 15:53:43 +0530
Message-Id: <4425c187bddde1baf7a17cb52e36aae746626add.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the first constraint type: power-supply.

The constraint is set by enabling the regulator and setting a voltage
range (if required) for the respective regulator device, which will be
honored by the regulator core even if more users turn up. Once the
device is probed, the regulator is released and the constraint is
removed.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/bootconstraint/Makefile |  2 +-
 drivers/bootconstraint/core.c   |  4 ++
 drivers/bootconstraint/core.h   |  5 +++
 drivers/bootconstraint/supply.c | 95 +++++++++++++++++++++++++++++++++++++++++
 include/linux/boot_constraint.h | 17 +++++++-
 5 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bootconstraint/supply.c

diff --git a/drivers/bootconstraint/Makefile b/drivers/bootconstraint/Makefile
index 0f2680177974..a45616f0c3b0 100644
--- a/drivers/bootconstraint/Makefile
+++ b/drivers/bootconstraint/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := core.o
+obj-y := core.o supply.o
diff --git a/drivers/bootconstraint/core.c b/drivers/bootconstraint/core.c
index a9f38a0febb3..2973f8dd9094 100644
--- a/drivers/bootconstraint/core.c
+++ b/drivers/bootconstraint/core.c
@@ -91,6 +91,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case DEV_BOOT_CONSTRAINT_SUPPLY:
+		add = constraint_supply_add;
+		remove = constraint_supply_remove;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/bootconstraint/core.h b/drivers/bootconstraint/core.h
index d04bd484b2a7..44c219716be5 100644
--- a/drivers/bootconstraint/core.h
+++ b/drivers/bootconstraint/core.h
@@ -27,4 +27,9 @@ struct constraint {
 	void (*remove)(struct constraint *constraint);
 	void *private;
 };
+
+/* Forward declarations of constraint specific callbacks */
+int constraint_supply_add(struct constraint *constraint, void *data);
+void constraint_supply_remove(struct constraint *constraint);
+
 #endif /* _CORE_H */
diff --git a/drivers/bootconstraint/supply.c b/drivers/bootconstraint/supply.c
new file mode 100644
index 000000000000..352ded92d057
--- /dev/null
+++ b/drivers/bootconstraint/supply.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+struct constraint_supply {
+	struct dev_boot_constraint_supply_info supply;
+	struct regulator *reg;
+};
+
+int constraint_supply_add(struct constraint *constraint, void *data)
+{
+	struct dev_boot_constraint_supply_info *supply = data;
+	struct constraint_supply *csupply;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	csupply = kzalloc(sizeof(*csupply), GFP_KERNEL);
+	if (!csupply)
+		return -ENOMEM;
+
+	csupply->reg = regulator_get(dev, supply->name);
+	if (IS_ERR(csupply->reg)) {
+		ret = PTR_ERR(csupply->reg);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "regulator_get() failed for %s (%d)\n",
+				supply->name, ret);
+		}
+		goto free;
+	}
+
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0) {
+		ret = regulator_set_voltage(csupply->reg, supply->u_volt_min,
+					    supply->u_volt_max);
+		if (ret) {
+			dev_err(dev, "regulator_set_voltage %s failed (%d)\n",
+				supply->name, ret);
+			goto free_regulator;
+		}
+	}
+
+	ret = regulator_enable(csupply->reg);
+	if (ret) {
+		dev_err(dev, "regulator_enable %s failed (%d)\n",
+			supply->name, ret);
+		goto remove_voltage;
+	}
+
+	memcpy(&csupply->supply, supply, sizeof(*supply));
+	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
+	constraint->private = csupply;
+
+	return 0;
+
+remove_voltage:
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0)
+		regulator_set_voltage(csupply->reg, 0, INT_MAX);
+free_regulator:
+	regulator_put(csupply->reg);
+free:
+	kfree(csupply);
+
+	return ret;
+}
+
+void constraint_supply_remove(struct constraint *constraint)
+{
+	struct constraint_supply *csupply = constraint->private;
+	struct dev_boot_constraint_supply_info *supply = &csupply->supply;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	kfree_const(supply->name);
+
+	ret = regulator_disable(csupply->reg);
+	if (ret)
+		dev_err(dev, "regulator_disable failed (%d)\n", ret);
+
+	if (supply->u_volt_min != 0 && supply->u_volt_max != 0) {
+		ret = regulator_set_voltage(csupply->reg, 0, INT_MAX);
+		if (ret)
+			dev_err(dev, "regulator_set_voltage failed (%d)\n",
+				ret);
+	}
+
+	regulator_put(csupply->reg);
+	kfree(csupply);
+}
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index d56e33f3f921..736fe09a8589 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -16,9 +16,24 @@ struct device;
 /**
  * enum dev_boot_constraint_type - This defines different boot constraint types.
  *
+ * @DEV_BOOT_CONSTRAINT_SUPPLY: This represents a power supply boot constraint.
  */
 enum dev_boot_constraint_type {
-	DEV_BOOT_CONSTRAINT_NONE,
+	DEV_BOOT_CONSTRAINT_SUPPLY,
+};
+
+/**
+ * struct dev_boot_constraint_supply_info - Power supply boot constraint
+ * information.
+ *
+ * @name: This must match the power supply name for the device.
+ * @u_volt_min: This is the minimum microvolts value supported by the device.
+ * @u_volt_max: This is the maximum microvolts value supported by the device.
+ */
+struct dev_boot_constraint_supply_info {
+	const char *name;
+	unsigned int u_volt_min;
+	unsigned int u_volt_max;
 };
 
 /**
-- 
2.15.0.194.g9af6a3dea062
