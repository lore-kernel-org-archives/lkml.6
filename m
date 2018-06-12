Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 78BDFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A40208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A40208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbeFLKXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:23:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:34386 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933701AbeFLKXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:23:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66322044"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:23:08 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v6 21/29] fpga: dfl: add fpga region platform driver for FME
Date:   Tue, 12 Jun 2018 18:10:35 +0800
Message-Id: <1528798243-2029-22-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds fpga region platform driver for FPGA Management Engine.
It register an fpga region with given fpga manager / bridge device.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-region
    fix fpga_mgr_put order problem in remove function.
    rebased due to fpga api changes.
v4: rename to dfl-fme-region, fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h and dfl.h
    add Acked-by from Alan and Moritz
v5: rebase, due to fpga region api changes.
v6: rebase, and fix copyright time.
---
 drivers/fpga/Kconfig          |  6 +++
 drivers/fpga/Makefile         |  1 +
 drivers/fpga/dfl-fme-region.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-region.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c933d67..a0aa163 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -168,6 +168,12 @@ config FPGA_DFL_FME_BRIDGE
 	help
 	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_REGION
+	tristate "FPGA DFL FME Region Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Region driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index cda0551..637c275 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
+obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
new file mode 100644
index 0000000..a6e0bde
--- /dev/null
+++ b/drivers/fpga/dfl-fme-region.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Region Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017-2018 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fpga/fpga-region.h>
+
+#include "dfl-fme-pr.h"
+
+static int fme_region_get_bridges(struct fpga_region *region)
+{
+	struct dfl_fme_region_pdata *pdata = region->priv;
+	struct device *dev = &pdata->br->dev;
+
+	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
+}
+
+static int fme_region_probe(struct platform_device *pdev)
+{
+	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct fpga_region *region;
+	struct fpga_manager *mgr;
+	int ret;
+
+	mgr = fpga_mgr_get(&pdata->mgr->dev);
+	if (IS_ERR(mgr))
+		return -EPROBE_DEFER;
+
+	region = fpga_region_create(dev, mgr, fme_region_get_bridges);
+	if (!region) {
+		ret = -ENOMEM;
+		goto eprobe_mgr_put;
+	}
+
+	region->priv = pdata;
+	platform_set_drvdata(pdev, region);
+
+	ret = fpga_region_register(region);
+	if (ret)
+		goto region_free;
+
+	dev_dbg(dev, "DFL FME FPGA Region probed\n");
+
+	return 0;
+
+region_free:
+	fpga_region_free(region);
+eprobe_mgr_put:
+	fpga_mgr_put(mgr);
+	return ret;
+}
+
+static int fme_region_remove(struct platform_device *pdev)
+{
+	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+
+	fpga_region_unregister(region);
+	fpga_mgr_put(region->mgr);
+
+	return 0;
+}
+
+static struct platform_driver fme_region_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FME_REGION,
+	},
+	.probe   = fme_region_probe,
+	.remove  = fme_region_remove,
+};
+
+module_platform_driver(fme_region_driver);
+
+MODULE_DESCRIPTION("FPGA Region for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-region");
-- 
1.8.3.1

