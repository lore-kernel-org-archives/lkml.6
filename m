Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeBWKYb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41751 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeBWKYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:24 -0500
X-Google-Smtp-Source: AH8x227OsK6g3K2arfxyMStbmWMLFFQ74gMKFENa0B01nOwnzLkwAiYBY9DLSBYu+SUbLuTpKArPKA==
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
Subject: [PATCH V7 07/13] boot_constraint: Add debugfs support
Date: Fri, 23 Feb 2018 15:53:46 +0530
Message-Id: <745f7dea835174ff837af39a2ae6e9f2b8b94cc0.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds debugfs support for boot constraints. This is how it
looks for a "vmmc-supply" constraint for the MMC device.

$ ls -R /sys/kernel/debug/boot_constraints/
/sys/kernel/debug/boot_constraints/:
f723d000.dwmmc0

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
clk-ciu  pm-domain  supply-vmmc  supply-vmmcaux

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/clk-ciu:

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/pm-domain:

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
u_volt_max  u_volt_min

/sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmcaux:
u_volt_max  u_volt_min

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/bootconstraint/clk.c    |  3 +++
 drivers/bootconstraint/core.c   | 59 +++++++++++++++++++++++++++++++++++++++++
 drivers/bootconstraint/core.h   |  6 +++++
 drivers/bootconstraint/pm.c     | 11 ++++++--
 drivers/bootconstraint/supply.c |  9 +++++++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/bootconstraint/clk.c b/drivers/bootconstraint/clk.c
index 90262fe9057c..1ee8ab1978a5 100644
--- a/drivers/bootconstraint/clk.c
+++ b/drivers/bootconstraint/clk.c
@@ -46,6 +46,8 @@ int constraint_clk_add(struct constraint *constraint, void *data)
 	cclk->clk_info.name = kstrdup_const(clk_info->name, GFP_KERNEL);
 	constraint->private = cclk;
 
+	constraint_add_debugfs(constraint, clk_info->name);
+
 	return 0;
 
 put_clk:
@@ -60,6 +62,7 @@ void constraint_clk_remove(struct constraint *constraint)
 {
 	struct constraint_clk *cclk = constraint->private;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(cclk->clk_info.name);
 	clk_disable_unprepare(cclk->clk);
 	clk_put(cclk->clk);
diff --git a/drivers/bootconstraint/core.c b/drivers/bootconstraint/core.c
index a6148b625b48..5a6984276139 100644
--- a/drivers/bootconstraint/core.c
+++ b/drivers/bootconstraint/core.c
@@ -21,6 +21,63 @@
 static LIST_HEAD(constraint_devices);
 static DEFINE_MUTEX(constraint_devices_mutex);
 
+/* Debugfs */
+
+static struct dentry *rootdir;
+
+static void constraint_device_add_debugfs(struct constraint_dev *cdev)
+{
+	struct device *dev = cdev->dev;
+
+	cdev->dentry = debugfs_create_dir(dev_name(dev), rootdir);
+}
+
+static void constraint_device_remove_debugfs(struct constraint_dev *cdev)
+{
+	debugfs_remove_recursive(cdev->dentry);
+}
+
+void constraint_add_debugfs(struct constraint *constraint, const char *suffix)
+{
+	struct device *dev = constraint->cdev->dev;
+	const char *prefix;
+	char name[NAME_MAX];
+
+	switch (constraint->type) {
+	case DEV_BOOT_CONSTRAINT_CLK:
+		prefix = "clk";
+		break;
+	case DEV_BOOT_CONSTRAINT_PM:
+		prefix = "pm";
+		break;
+	case DEV_BOOT_CONSTRAINT_SUPPLY:
+		prefix = "supply";
+		break;
+	default:
+		dev_err(dev, "%s: Constraint type (%d) not supported\n",
+			__func__, constraint->type);
+		return;
+	}
+
+	snprintf(name, NAME_MAX, "%s-%s", prefix, suffix);
+
+	constraint->dentry = debugfs_create_dir(name, constraint->cdev->dentry);
+}
+
+void constraint_remove_debugfs(struct constraint *constraint)
+{
+	debugfs_remove_recursive(constraint->dentry);
+}
+
+static int __init constraint_debugfs_init(void)
+{
+	rootdir = debugfs_create_dir("boot_constraints", NULL);
+
+	return 0;
+}
+core_initcall(constraint_debugfs_init);
+
+
 /* Boot constraints core */
 
 static struct constraint_dev *constraint_device_find(struct device *dev)
@@ -48,12 +105,14 @@ static struct constraint_dev *constraint_device_allocate(struct device *dev)
 	INIT_LIST_HEAD(&cdev->constraints);
 
 	list_add(&cdev->node, &constraint_devices);
+	constraint_device_add_debugfs(cdev);
 
 	return cdev;
 }
 
 static void constraint_device_free(struct constraint_dev *cdev)
 {
+	constraint_device_remove_debugfs(cdev);
 	list_del(&cdev->node);
 	kfree(cdev);
 }
diff --git a/drivers/bootconstraint/core.h b/drivers/bootconstraint/core.h
index 35ea984d74f0..3084baaee127 100644
--- a/drivers/bootconstraint/core.h
+++ b/drivers/bootconstraint/core.h
@@ -7,6 +7,7 @@
 #define _CORE_H
 
 #include <linux/boot_constraint.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/list.h>
 
@@ -14,6 +15,7 @@ struct constraint_dev {
 	struct device *dev;
 	struct list_head node;
 	struct list_head constraints;
+	struct dentry *dentry;
 };
 
 struct constraint {
@@ -22,12 +24,16 @@ struct constraint {
 	enum dev_boot_constraint_type type;
 	void (*free_resources)(void *data);
 	void *free_resources_data;
+	struct dentry *dentry;
 
 	int (*add)(struct constraint *constraint, void *data);
 	void (*remove)(struct constraint *constraint);
 	void *private;
 };
 
+void constraint_add_debugfs(struct constraint *constraint, const char *suffix);
+void constraint_remove_debugfs(struct constraint *constraint);
+
 /* Forward declarations of constraint specific callbacks */
 int constraint_clk_add(struct constraint *constraint, void *data);
 void constraint_clk_remove(struct constraint *constraint);
diff --git a/drivers/bootconstraint/pm.c b/drivers/bootconstraint/pm.c
index f52bff240dd5..65810d9485bc 100644
--- a/drivers/bootconstraint/pm.c
+++ b/drivers/bootconstraint/pm.c
@@ -11,11 +11,18 @@
 int constraint_pm_add(struct constraint *constraint, void *data)
 {
 	struct device *dev = constraint->cdev->dev;
+	int ret;
 
-	return dev_pm_domain_attach(dev, true);
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret)
+		return ret;
+
+	constraint_add_debugfs(constraint, "domain");
+
+	return 0;
 }
 
 void constraint_pm_remove(struct constraint *constraint)
 {
-	/* Nothing to do for now */
+	constraint_remove_debugfs(constraint);
 }
diff --git a/drivers/bootconstraint/supply.c b/drivers/bootconstraint/supply.c
index 352ded92d057..8965db534be6 100644
--- a/drivers/bootconstraint/supply.c
+++ b/drivers/bootconstraint/supply.c
@@ -57,6 +57,14 @@ int constraint_supply_add(struct constraint *constraint, void *data)
 	csupply->supply.name = kstrdup_const(supply->name, GFP_KERNEL);
 	constraint->private = csupply;
 
+	constraint_add_debugfs(constraint, supply->name);
+
+	debugfs_create_u32("u_volt_min", 0444, constraint->dentry,
+			   &csupply->supply.u_volt_min);
+
+	debugfs_create_u32("u_volt_max", 0444, constraint->dentry,
+			   &csupply->supply.u_volt_max);
+
 	return 0;
 
 remove_voltage:
@@ -77,6 +85,7 @@ void constraint_supply_remove(struct constraint *constraint)
 	struct device *dev = constraint->cdev->dev;
 	int ret;
 
+	constraint_remove_debugfs(constraint);
 	kfree_const(supply->name);
 
 	ret = regulator_disable(csupply->reg);
-- 
2.15.0.194.g9af6a3dea062
