Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A856BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699A7280E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699A7280E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755173AbeF3BGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:06:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:57850 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932238AbeF3BGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317406"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:43 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v7 20/29] fpga: dfl: add fpga bridge platform driver for FME
Date:   Sat, 30 Jun 2018 08:53:27 +0800
Message-Id: <1530320016-24712-21-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds fpga bridge platform driver for FPGA Management Engine.
It implements the enable_set callback for fpga bridge.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-br
    remove useless dev_dbg in probe function.
    rebased due to fpga api change.
v4: rename to dfl-fme-br and fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h
    add Acked-by from Alan and Moritz
v5: rebase due to API changes.
    defer port and its ops finding when really need.
v6: reabse and fix copyright time.
v7: fix kbuild issue.
---
 drivers/fpga/Kconfig      |   6 +++
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/dfl-fme-br.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-br.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 46b48e5..11d1943 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -162,6 +162,12 @@ config FPGA_DFL_FME_MGR
 	help
 	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_BRIDGE
+	tristate "FPGA DFL FME Bridge Driver"
+	depends on FPGA_DFL_FME && HAS_IOMEM
+	help
+	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 23f41b0..cda0551 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
+obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
new file mode 100644
index 0000000..7cc041d
--- /dev/null
+++ b/drivers/fpga/dfl-fme-br.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Bridge Driver for FPGA Management Engine (FME)
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
+#include <linux/fpga/fpga-bridge.h>
+
+#include "dfl.h"
+#include "dfl-fme-pr.h"
+
+struct fme_br_priv {
+	struct dfl_fme_br_pdata *pdata;
+	struct dfl_fpga_port_ops *port_ops;
+	struct platform_device *port_pdev;
+};
+
+static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct fme_br_priv *priv = bridge->priv;
+	struct platform_device *port_pdev;
+	struct dfl_fpga_port_ops *ops;
+
+	if (!priv->port_pdev) {
+		port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
+						    &priv->pdata->port_id,
+						    dfl_fpga_check_port_id);
+		if (!port_pdev)
+			return -ENODEV;
+
+		priv->port_pdev = port_pdev;
+	}
+
+	if (priv->port_pdev && !priv->port_ops) {
+		ops = dfl_fpga_port_ops_get(priv->port_pdev);
+		if (!ops || !ops->enable_set)
+			return -ENOENT;
+
+		priv->port_ops = ops;
+	}
+
+	return priv->port_ops->enable_set(priv->port_pdev, enable);
+}
+
+static const struct fpga_bridge_ops fme_bridge_ops = {
+	.enable_set = fme_bridge_enable_set,
+};
+
+static int fme_br_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fme_br_priv *priv;
+	struct fpga_bridge *br;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdata = dev_get_platdata(dev);
+
+	br = fpga_bridge_create(dev, "DFL FPGA FME Bridge",
+				&fme_bridge_ops, priv);
+	if (!br)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
+	if (ret)
+		fpga_bridge_free(br);
+
+	return ret;
+}
+
+static int fme_br_remove(struct platform_device *pdev)
+{
+	struct fpga_bridge *br = platform_get_drvdata(pdev);
+	struct fme_br_priv *priv = br->priv;
+
+	fpga_bridge_unregister(br);
+
+	if (priv->port_pdev)
+		put_device(&priv->port_pdev->dev);
+	if (priv->port_ops)
+		dfl_fpga_port_ops_put(priv->port_ops);
+
+	return 0;
+}
+
+static struct platform_driver fme_br_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FME_BRIDGE,
+	},
+	.probe   = fme_br_probe,
+	.remove  = fme_br_remove,
+};
+
+module_platform_driver(fme_br_driver);
+
+MODULE_DESCRIPTION("FPGA Bridge for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-bridge");
-- 
1.8.3.1

