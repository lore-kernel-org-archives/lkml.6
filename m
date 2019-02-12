Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81921C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E54217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfBLBCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:02:54 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:57172 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728056AbfBLBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:02:52 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11HRU009616;
        Mon, 11 Feb 2019 19:02:46 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhus0se72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:46 -0600
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12j0l016495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:45 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:45 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:45 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
Date:   Mon, 11 Feb 2019 19:01:39 -0600
Message-ID: <20190212010143.3729-3-virendra.kakade@ni.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 drivers/mfd/Kconfig          |  7 +++
 drivers/mfd/Makefile         |  2 +-
 drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/e31x-pmu.h | 20 ++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/e31x-pmu.c
 create mode 100644 include/linux/mfd/e31x-pmu.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..6c4c0747f2a5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1916,4 +1916,11 @@ config RAVE_SP_CORE
 	  device found on several devices in RAVE line of hardware.
 
 endmenu
+
+config MFD_E31X_PMU
+	tristate "E31X PMU driver"
+	select MFD_SYSCON
+	help
+	 Select this to get support for the Ettus Research E31x devices.
+
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..e37c2057134b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -241,4 +241,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
-
+obj-$(CONFIG_MFD_E31X_PMU)      += e31x-pmu.o
diff --git a/drivers/mfd/e31x-pmu.c b/drivers/mfd/e31x-pmu.c
new file mode 100644
index 000000000000..383df68a538f
--- /dev/null
+++ b/drivers/mfd/e31x-pmu.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x PMU MFD driver
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+#include <linux/of_device.h>
+#include <linux/mfd/e31x-pmu.h>
+#include <linux/platform_device.h>
+
+#define E31X_PMU_MISC_IRQ_MASK		BIT(8)
+#define E31X_PMU_MISC_IRQ_SHIFT		8
+#define E31X_PMU_MISC_VERSION_MIN_MASK	GENMASK(3, 0)
+#define E31X_PMU_MISC_VERSION_MIN_SHIFT	0
+#define E31X_PMU_MISC_VERSION_MAJ_MASK	GENMASK(7, 4)
+#define E31X_PMU_MISC_VERSION_MAJ_SHIFT	4
+
+struct e31x_pmu {
+	struct regmap *regmap;
+};
+
+static int e31x_pmu_check_version(struct e31x_pmu *pmu)
+{
+	int timeout = 100;
+	u32 misc, maj;
+	int err;
+	/* we need to wait a bit for firmware to populate the fields */
+	while (timeout--) {
+		err = regmap_read(pmu->regmap, E31X_PMU_REG_MISC, &misc);
+		if (err)
+			return err;
+		if (misc)
+			break;
+
+	usleep_range(2500, 5000);
+	}
+
+	/* only firmware versions above 2.0 are supported */
+	maj = E31X_PMU_GET_FIELD(MISC_VERSION_MAJ, misc);
+	if (maj < 2)
+		return -ENOTSUPP;
+	return 0;
+}
+
+static int e31x_pmu_probe(struct platform_device *pdev)
+{
+	struct e31x_pmu *pmu;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+	pmu->regmap = syscon_regmap_lookup_by_phandle(\
+			pdev->dev.of_node, "regmap");
+
+	if (IS_ERR(pmu->regmap))
+		return PTR_ERR(pmu->regmap);
+	if (e31x_pmu_check_version(pmu))
+		return -ENOTSUPP;
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id e31x_pmu_id[] = {
+	{ .compatible = "ni,e31x-pmu" },
+	{},
+};
+
+static struct platform_driver e31x_pmu_driver = {
+	.driver = {
+	.name = "e31x-pmu",
+	.of_match_table = e31x_pmu_id,
+	},
+	.probe = e31x_pmu_probe,
+};
+module_platform_driver(e31x_pmu_driver);
+
+MODULE_DESCRIPTION("E31x PMU driver");
+MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
new file mode 100644
index 000000000000..c57d5a8c1aad
--- /dev/null
+++ b/include/linux/mfd/e31x-pmu.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x PMU constants
+ */
+
+#ifndef MFD_E31X_PMU_H
+#define MFD_E31X_PMU_H
+
+#include <linux/bitops.h>
+
+#define E31X_PMU_REG_MISC      0x04
+
+#define E31X_PMU_GET_FIELD(name, reg) \
+	(((reg) & E31X_PMU_## name ##_MASK) >> \
+	E31X_PMU_## name ##_SHIFT)
+
+#endif /* MFD_E31X_PMU_H */
-- 
2.17.1

