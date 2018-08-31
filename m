Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AE7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C0E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 03:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C0E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHaIBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:01:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46402 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeHaIBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:01:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45AC2200063;
        Fri, 31 Aug 2018 05:55:40 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EE042000A0;
        Fri, 31 Aug 2018 05:55:36 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 53AFE4030C;
        Fri, 31 Aug 2018 11:55:31 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 3/3] soc: fsl: add RCPM driver
Date:   Fri, 31 Aug 2018 11:52:19 +0800
Message-Id: <20180831035219.31619-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180831035219.31619-1-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
Control and Power Management), which performs all device-level
tasks associated with power management such as wakeup source control.

This driver depends on FSL platform PM driver framework which help to
isolate user and PM service provider (such as RCPM driver).

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/soc/fsl/Kconfig   |    6 ++
 drivers/soc/fsl/Makefile  |    1 +
 drivers/soc/fsl/ls-rcpm.c |  153 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/ls-rcpm.c

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 6517412..882330d 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -30,3 +30,9 @@ config FSL_PLAT_PM
 	  have to know the implement details of wakeup function it require.
 	  Besides, it is also easy for service side to upgrade its logic when
 	  design changed and remain user side unchanged.
+
+config LS_RCPM
+	bool "Freescale RCPM support"
+	depends on (FSL_PLAT_PM)
+	help
+	  This feature is to enable specified wakeup source for system sleep.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 8f9db23..43ff71a 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_PLAT_PM)	+= plat_pm.o
+obj-$(CONFIG_LS_RCPM)		+= ls-rcpm.o
diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
new file mode 100644
index 0000000..b0feb88
--- /dev/null
+++ b/drivers/soc/fsl/ls-rcpm.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// plat_pm.c - Freescale Layerscape RCPM driver
+//
+// Copyright 2018 NXP
+//
+// Author: Ran Wang <ran.wang_1@nxp.com>,
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <soc/fsl/plat_pm.h>
+
+#define MAX_COMPATIBLE_NUM	10
+
+struct rcpm_t {
+	struct device *dev;
+	void __iomem *ippdexpcr_addr;
+	bool big_endian;	/* Big/Little endian of RCPM module */
+};
+
+// rcpm_handle - Configure RCPM reg according to wake up source request
+// @user_dev: pointer to user's device struct
+// @flag: to enable(true) or disable(false) wakeup source
+// @handle_priv: pointer to struct rcpm_t instance
+//
+// Return 0 on success other negative errno
+static int rcpm_handle(struct device *user_dev, bool flag, void *handle_priv)
+{
+	struct rcpm_t *rcpm;
+	bool big_endian;
+	const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];
+	void __iomem *ippdexpcr_addr;
+	u32 ippdexpcr;
+	u32 set_bit;
+	int ret, num, i;
+
+	rcpm = handle_priv;
+	big_endian = rcpm->big_endian;
+	ippdexpcr_addr = rcpm->ippdexpcr_addr;
+
+	num = device_property_read_string_array(user_dev, "compatible",
+			dev_compatible_array, MAX_COMPATIBLE_NUM);
+	if (num < 0)
+		return num;
+
+	for (i = 0; i < num; i++) {
+		if (!device_property_present(rcpm->dev,
+					dev_compatible_array[i]))
+			continue;
+		else {
+			ret = device_property_read_u32(rcpm->dev,
+					dev_compatible_array[i], &set_bit);
+			if (ret)
+				return ret;
+
+			if (!device_property_present(rcpm->dev,
+						dev_compatible_array[i]))
+				return -ENODEV;
+			else {
+				ret = device_property_read_u32(rcpm->dev,
+						dev_compatible_array[i], &set_bit);
+				if (ret)
+					return ret;
+
+				if (big_endian)
+					ippdexpcr = ioread32be(ippdexpcr_addr);
+				else
+					ippdexpcr = ioread32(ippdexpcr_addr);
+
+				if (flag)
+					ippdexpcr |= set_bit;
+				else
+					ippdexpcr &= ~set_bit;
+
+				if (big_endian) {
+					iowrite32be(ippdexpcr, ippdexpcr_addr);
+					ippdexpcr = ioread32be(ippdexpcr_addr);
+				} else
+					iowrite32(ippdexpcr, ippdexpcr_addr);
+
+				return 0;
+			}
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int ls_rcpm_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct rcpm_t *rcpm;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	rcpm = kmalloc(sizeof(*rcpm), GFP_KERNEL);
+	if (!rcpm)
+		return -ENOMEM;
+
+	rcpm->big_endian = device_property_read_bool(&pdev->dev, "big-endian");
+
+	rcpm->ippdexpcr_addr = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(rcpm->ippdexpcr_addr))
+		return PTR_ERR(rcpm->ippdexpcr_addr);
+
+	rcpm->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rcpm);
+
+	return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);
+}
+
+static int ls_rcpm_remove(struct platform_device *pdev)
+{
+	struct rcpm_t	*rcpm;
+
+	rcpm = platform_get_drvdata(pdev);
+	deregister_fsl_platform_wakeup_source(rcpm);
+	kfree(rcpm);
+
+	return 0;
+}
+
+static const struct of_device_id ls_rcpm_of_match[] = {
+	{ .compatible = "fsl,qoriq-rcpm-2.1", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);
+
+static struct platform_driver ls_rcpm_driver = {
+	.driver = {
+		.name = "ls-rcpm",
+		.of_match_table = ls_rcpm_of_match,
+	},
+	.probe = ls_rcpm_probe,
+	.remove = ls_rcpm_remove,
+};
+
+static int __init ls_rcpm_init(void)
+{
+	return platform_driver_register(&ls_rcpm_driver);
+}
+subsys_initcall(ls_rcpm_init);
+
+static void __exit ls_rcpm_exit(void)
+{
+	platform_driver_unregister(&ls_rcpm_driver);
+}
+module_exit(ls_rcpm_exit);
-- 
1.7.1

