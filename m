Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7EC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9747277D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9747277D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936774AbeF3BK3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:10:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:23619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936030AbeF3BGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317318"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:18 -0700
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
Subject: [PATCH v7 13/29] fpga: dfl-pci: add enumeration for feature devices
Date:   Sat, 30 Jun 2018 08:53:20 +0800
Message-Id: <1530320016-24712-14-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Device Feature List (DFL) is implemented in MMIO and features
are linked via the DFLs. This patch enables pcie driver to prepare
enumeration information (e.g. locations of all device feature lists
in MMIO) and use common APIs provided by the Device Feature List
framework to enumerate each feature device linked.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: split from another patch
    use common functions from DFL framework for enumeration.
v4: rebase
v5: rebase due to naming changes on DFL framework APIs.
    add acked-by from Alan.
v6: reabse
v7: simplify code with pcim_iomap_regions().
---
 drivers/fpga/dfl-pci.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index e1e1f0f..66b5720 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -22,9 +22,23 @@
 #include <linux/errno.h>
 #include <linux/aer.h>
 
+#include "dfl.h"
+
 #define DRV_VERSION	"0.8"
 #define DRV_NAME	"dfl-pci"
 
+struct cci_drvdata {
+	struct dfl_fpga_cdev *cdev;	/* container device */
+};
+
+static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
+{
+	if (pcim_iomap_regions(pcidev, BIT(bar), DRV_NAME))
+		return NULL;
+
+	return pcim_iomap_table(pcidev)[bar];
+}
+
 /* PCI Device ID */
 #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
@@ -45,6 +59,120 @@
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
 
+static int cci_init_drvdata(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&pcidev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	pci_set_drvdata(pcidev, drvdata);
+
+	return 0;
+}
+
+static void cci_remove_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+
+	/* remove all children feature devices */
+	dfl_fpga_feature_devs_remove(drvdata->cdev);
+}
+
+/* enumerate feature devices under pci device */
+static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_enum_info *info;
+	struct dfl_fpga_cdev *cdev;
+	resource_size_t start, len;
+	int port_num, bar, i, ret = 0;
+	void __iomem *base;
+	u32 offset;
+	u64 v;
+
+	/* allocate enumeration info via pci_dev */
+	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* start to find Device Feature List from Bar 0 */
+	base = cci_pci_ioremap_bar(pcidev, 0);
+	if (!base) {
+		ret = -ENOMEM;
+		goto enum_info_free_exit;
+	}
+
+	/*
+	 * PF device has FME and Ports/AFUs, and VF device only has one
+	 * Port/AFU. Check them and add related "Device Feature List" info
+	 * for the next step enumeration.
+	 */
+	if (dfl_feature_is_fme(base)) {
+		start = pci_resource_start(pcidev, 0);
+		len = pci_resource_len(pcidev, 0);
+
+		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+
+		/*
+		 * find more Device Feature Lists (e.g. Ports) per information
+		 * indicated by FME module.
+		 */
+		v = readq(base + FME_HDR_CAP);
+		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
+
+		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
+
+		for (i = 0; i < port_num; i++) {
+			v = readq(base + FME_HDR_PORT_OFST(i));
+
+			/* skip ports which are not implemented. */
+			if (!(v & FME_PORT_OFST_IMP))
+				continue;
+
+			/*
+			 * add Port's Device Feature List information for next
+			 * step enumeration.
+			 */
+			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
+			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			base = cci_pci_ioremap_bar(pcidev, bar);
+			if (!base)
+				continue;
+
+			start = pci_resource_start(pcidev, bar) + offset;
+			len = pci_resource_len(pcidev, bar) - offset;
+
+			dfl_fpga_enum_info_add_dfl(info, start, len,
+						   base + offset);
+		}
+	} else if (dfl_feature_is_port(base)) {
+		start = pci_resource_start(pcidev, 0);
+		len = pci_resource_len(pcidev, 0);
+
+		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+	} else {
+		ret = -ENODEV;
+		goto enum_info_free_exit;
+	}
+
+	/* start enumeration with prepared enumeration information */
+	cdev = dfl_fpga_feature_devs_enumerate(info);
+	if (IS_ERR(cdev)) {
+		dev_err(&pcidev->dev, "Enumeration failure\n");
+		ret = PTR_ERR(cdev);
+		goto enum_info_free_exit;
+	}
+
+	drvdata->cdev = cdev;
+
+enum_info_free_exit:
+	dfl_fpga_enum_info_free(info);
+
+	return ret;
+}
+
 static
 int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 {
@@ -76,8 +204,19 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 		goto disable_error_report_exit;
 	}
 
-	/* TODO: create and add the platform device per feature list */
-	return 0;
+	ret = cci_init_drvdata(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "Fail to init drvdata %d.\n", ret);
+		goto disable_error_report_exit;
+	}
+
+	ret = cci_enumerate_feature_devs(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
+		goto disable_error_report_exit;
+	}
+
+	return ret;
 
 disable_error_report_exit:
 	pci_disable_pcie_error_reporting(pcidev);
@@ -86,6 +225,7 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
+	cci_remove_feature_devs(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
 }
 
-- 
1.8.3.1

