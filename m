Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF50FC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64232280DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64232280DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965179AbeF3BGi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:06:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:57850 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934989AbeF3BGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317331"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:21 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v7 14/29] fpga: dfl: add FPGA Management Engine driver basic framework
Date:   Sat, 30 Jun 2018 08:53:21 +0800
Message-Id: <1530320016-24712-15-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Luwei <luwei.kang@intel.com>

The FPGA Management Engine (FME) provides power, thermal management,
performance counters, partial reconfiguration and other functions. For each
function, it is packaged into a private feature linked to the FME feature
device in the 'Device Feature List'. It's a platform device created by
DFL framework.

This patch adds the basic framework of FME platform driver. It defines
sub feature drivers to handle the different sub features, including init,
uinit and ioctl. It also registers the file operations for the device file.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver from intel-fpga-fme to dfl-fme
    rename Kconfig from INTEL_FPGA_FME to FPGA_DFL_FME
v4: fix SPDX license issue, use dfl-fme as module name
v5: rebase, due to DFL framework naming changes on functions and data structures.
    fix uinit order in remove function.
    remove else block in fme_ioctl function per suggestion from Alan.
v6: fix copyright time, rebase and add Acked-by from Alan.
v7: improve Kconfig description and add Acked-by from Moritz.
---
 drivers/fpga/Kconfig        |  10 +++
 drivers/fpga/Makefile       |   3 +
 drivers/fpga/dfl-fme-main.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-main.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index f2659f1..43803a1 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -146,6 +146,16 @@ config FPGA_DFL
 	  Gate Array (FPGA) solutions which implement Device Feature List.
 	  It provides enumeration APIs and feature device infrastructure.
 
+config FPGA_DFL_FME
+	tristate "FPGA DFL FME Driver"
+	depends on FPGA_DFL
+	help
+	  The FPGA Management Engine (FME) is a feature device implemented
+	  under Device Feature List (DFL) framework. Select this option to
+	  enable the platform device driver for FME which implements all
+	  FPGA platform level management features. There shall be one FME
+	  per DFL based FPGA device.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 02e0253..db11f34 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -31,6 +31,9 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
+obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
+
+dfl-fme-objs := dfl-fme-main.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
new file mode 100644
index 0000000..bdcfe95
--- /dev/null
+++ b/drivers/fpga/dfl-fme-main.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017-2018 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "dfl.h"
+
+static int fme_hdr_init(struct platform_device *pdev,
+			struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR Init.\n");
+
+	return 0;
+}
+
+static void fme_hdr_uinit(struct platform_device *pdev,
+			  struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
+}
+
+static const struct dfl_feature_ops fme_hdr_ops = {
+	.init = fme_hdr_init,
+	.uinit = fme_hdr_uinit,
+};
+
+static struct dfl_feature_driver fme_feature_drvs[] = {
+	{
+		.id = FME_FEATURE_ID_HEADER,
+		.ops = &fme_hdr_ops,
+	},
+	{
+		.ops = NULL,
+	},
+};
+
+static int fme_open(struct inode *inode, struct file *filp)
+{
+	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
+	int ret;
+
+	if (WARN_ON(!pdata))
+		return -ENODEV;
+
+	ret = dfl_feature_dev_use_begin(pdata);
+	if (ret)
+		return ret;
+
+	dev_dbg(&fdev->dev, "Device File Open\n");
+	filp->private_data = pdata;
+
+	return 0;
+}
+
+static int fme_release(struct inode *inode, struct file *filp)
+{
+	struct dfl_feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+
+	dev_dbg(&pdev->dev, "Device File Release\n");
+	dfl_feature_dev_use_end(pdata);
+
+	return 0;
+}
+
+static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct dfl_feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature *f;
+	long ret;
+
+	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
+
+	switch (cmd) {
+	default:
+		/*
+		 * Let sub-feature's ioctl function to handle the cmd.
+		 * Sub-feature's ioctl returns -ENODEV when cmd is not
+		 * handled in this sub feature, and returns 0 or other
+		 * error code if cmd is handled.
+		 */
+		dfl_fpga_dev_for_each_feature(pdata, f) {
+			if (f->ops && f->ops->ioctl) {
+				ret = f->ops->ioctl(pdev, f, cmd, arg);
+				if (ret != -ENODEV)
+					return ret;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations fme_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fme_open,
+	.release	= fme_release,
+	.unlocked_ioctl = fme_ioctl,
+};
+
+static int fme_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = dfl_fpga_dev_feature_init(pdev, fme_feature_drvs);
+	if (ret)
+		goto exit;
+
+	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
+	if (ret)
+		goto feature_uinit;
+
+	return 0;
+
+feature_uinit:
+	dfl_fpga_dev_feature_uinit(pdev);
+exit:
+	return ret;
+}
+
+static int fme_remove(struct platform_device *pdev)
+{
+	dfl_fpga_dev_ops_unregister(pdev);
+	dfl_fpga_dev_feature_uinit(pdev);
+
+	return 0;
+}
+
+static struct platform_driver fme_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FEATURE_DEV_FME,
+	},
+	.probe   = fme_probe,
+	.remove  = fme_remove,
+};
+
+module_platform_driver(fme_driver);
+
+MODULE_DESCRIPTION("FPGA Management Engine driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme");
-- 
1.8.3.1

