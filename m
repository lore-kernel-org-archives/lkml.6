Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeBWK0e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:26:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34613 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBWKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:19 -0500
X-Google-Smtp-Source: AH8x226s00Ruy5ATRXY04jAvA5aOkqI1EddqdkqEAfJVNsSIL1B3AnnsnJToXo/T+WaJBnaNu7T4Hg==
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
Subject: [PATCH V7 05/13] boot_constraint: Add support for clk constraints
Date: Fri, 23 Feb 2018 15:53:44 +0530
Message-Id: <dd89f2db943280098b7cec1ef0055520bb3a6858.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the clk constraint type.

The constraint is set by enabling the clk for the device. Once the
device is probed, the clk is disabled and the constraint is removed.

We may want to do clk_set_rate() from here, but lets wait for some real
users that really want it.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/bootconstraint/Makefile |  2 +-
 drivers/bootconstraint/clk.c    | 67 +++++++++++++++++++++++++++++++++++++++++
 drivers/bootconstraint/core.c   |  4 +++
 drivers/bootconstraint/core.h   |  3 ++
 include/linux/boot_constraint.h | 11 +++++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bootconstraint/clk.c

diff --git a/drivers/bootconstraint/Makefile b/drivers/bootconstraint/Makefile
index a45616f0c3b0..3424379fd1e4 100644
--- a/drivers/bootconstraint/Makefile
+++ b/drivers/bootconstraint/Makefile
@@ -1,3 +1,3 @@
 # Makefile for device boot constraints
 
-obj-y := core.o supply.o
+obj-y := clk.o core.o supply.o
diff --git a/drivers/bootconstraint/clk.c b/drivers/bootconstraint/clk.c
new file mode 100644
index 000000000000..90262fe9057c
--- /dev/null
+++ b/drivers/bootconstraint/clk.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "core.h"
+
+struct constraint_clk {
+	struct dev_boot_constraint_clk_info clk_info;
+	struct clk *clk;
+};
+
+int constraint_clk_add(struct constraint *constraint, void *data)
+{
+	struct dev_boot_constraint_clk_info *clk_info = data;
+	struct constraint_clk *cclk;
+	struct device *dev = constraint->cdev->dev;
+	int ret;
+
+	cclk = kzalloc(sizeof(*cclk), GFP_KERNEL);
+	if (!cclk)
+		return -ENOMEM;
+
+	cclk->clk = clk_get(dev, clk_info->name);
+	if (IS_ERR(cclk->clk)) {
+		ret = PTR_ERR(cclk->clk);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "clk_get() failed for %s (%d)\n",
+				clk_info->name, ret);
+		}
+		goto free;
+	}
+
+	ret = clk_prepare_enable(cclk->clk);
+	if (ret) {
+		dev_err(dev, "clk_prepare_enable() %s failed (%d)\n",
+			clk_info->name, ret);
+		goto put_clk;
+	}
+
+	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
+	constraint->private = cclk;
+
+	return 0;
+
+put_clk:
+	clk_put(cclk->clk);
+free:
+	kfree(cclk);
+
+	return ret;
+}
+
+void constraint_clk_remove(struct constraint *constraint)
+{
+	struct constraint_clk *cclk = constraint->private;
+
+	kfree_const(cclk->clk_info.name);
+	clk_disable_unprepare(cclk->clk);
+	clk_put(cclk->clk);
+	kfree(cclk);
+}
diff --git a/drivers/bootconstraint/core.c b/drivers/bootconstraint/core.c
index 2973f8dd9094..a73744c5d599 100644
--- a/drivers/bootconstraint/core.c
+++ b/drivers/bootconstraint/core.c
@@ -91,6 +91,10 @@ static struct constraint *constraint_allocate(struct constraint_dev *cdev,
 	void (*remove)(struct constraint *constraint);
 
 	switch (type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		add = constraint_clk_add;
+		remove = constraint_clk_remove;
+		break;
 	case DEV_BOOT_CONSTRAINT_SUPPLY:
 		add = constraint_supply_add;
 		remove = constraint_supply_remove;
diff --git a/drivers/bootconstraint/core.h b/drivers/bootconstraint/core.h
index 44c219716be5..09a6176541d7 100644
--- a/drivers/bootconstraint/core.h
+++ b/drivers/bootconstraint/core.h
@@ -29,6 +29,9 @@ struct constraint {
 };
 
 /* Forward declarations of constraint specific callbacks */
+int constraint_clk_add(struct constraint *constraint, void *data);
+void constraint_clk_remove(struct constraint *constraint);
+
 int constraint_supply_add(struct constraint *constraint, void *data);
 void constraint_supply_remove(struct constraint *constraint);
 
diff --git a/include/linux/boot_constraint.h b/include/linux/boot_constraint.h
index 736fe09a8589..4685ff55fff8 100644
--- a/include/linux/boot_constraint.h
+++ b/include/linux/boot_constraint.h
@@ -16,12 +16,23 @@ struct device;
 /**
  * enum dev_boot_constraint_type - This defines different boot constraint types.
  *
+ * @DEV_BOOT_CONSTRAINT_CLK: This represents a clock boot constraint.
  * @DEV_BOOT_CONSTRAINT_SUPPLY: This represents a power supply boot constraint.
  */
 enum dev_boot_constraint_type {
+	DEV_BOOT_CONSTRAINT_CLK,
 	DEV_BOOT_CONSTRAINT_SUPPLY,
 };
 
+/**
+ * struct dev_boot_constraint_clk_info - Clock boot constraint information.
+ *
+ * @name: This must match the connection-id of the clock for the device.
+ */
+struct dev_boot_constraint_clk_info {
+	const char *name;
+};
+
 /**
  * struct dev_boot_constraint_supply_info - Power supply boot constraint
  * information.
-- 
2.15.0.194.g9af6a3dea062
