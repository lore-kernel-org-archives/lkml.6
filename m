Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748EBC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE220C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAE220C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390298AbeGKVIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390062AbeGKVIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL0FlJ019903
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:01:56 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5rv8s9c7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:01:55 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 15:01:54 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 15:01:50 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL1n5463832144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:01:49 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A24F86E04C;
        Wed, 11 Jul 2018 15:01:49 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B66096E05B;
        Wed, 11 Jul 2018 15:01:48 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 15:01:48 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, linux@roeck-us.net, jdelvare@suse.com,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 4/9] hwmon: Add On-Chip Controller (OCC) hwmon driver
Date:   Wed, 11 Jul 2018 16:01:33 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071121-0036-0000-0000-00000A0DD7D8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059946; UDB=6.00544035; IPR=6.00837866;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:01:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-0037-0000-0000-0000481101A7
Message-Id: <1531342898-15790-5-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OCC is a device embedded on a POWER processor that collects and
aggregates sensor data from the processor and system. The OCC can
provide the raw sensor data as well as perform thermal and power
management on the system.

This driver provides a hwmon interface to the OCC from a service
processor (e.g. a BMC). The driver supports both POWER8 and POWER9 OCCs.
Communications with the POWER8 OCC are established over standard I2C
bus. The driver communicates with the POWER9 OCC through the FSI-based
OCC driver, which handles the lower-level communication details.

This patch lays out the structure of the OCC hwmon driver. There are two
platform drivers, one each for P8 and P9 OCCs. These are probed through
the I2C tree and the FSI-based OCC driver, respectively. The patch also
defines the first common structures and methods between the two OCC
versions.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/Kconfig      |  2 ++
 drivers/hwmon/Makefile     |  1 +
 drivers/hwmon/occ/Kconfig  | 28 +++++++++++++++++
 drivers/hwmon/occ/Makefile | 11 +++++++
 drivers/hwmon/occ/common.c | 50 +++++++++++++++++++++++++++++
 drivers/hwmon/occ/common.h | 43 +++++++++++++++++++++++++
 drivers/hwmon/occ/p8_i2c.c | 71 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/p9_sbe.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 284 insertions(+)
 create mode 100644 drivers/hwmon/occ/Kconfig
 create mode 100644 drivers/hwmon/occ/Makefile
 create mode 100644 drivers/hwmon/occ/common.c
 create mode 100644 drivers/hwmon/occ/common.h
 create mode 100644 drivers/hwmon/occ/p8_i2c.c
 create mode 100644 drivers/hwmon/occ/p9_sbe.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a4e5d3c..9b3871e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1293,6 +1293,8 @@ config SENSORS_NSA320
 	  This driver can also be built as a module. If so, the module
 	  will be called nsa320-hwmon.
 
+source drivers/hwmon/occ/Kconfig
+
 config SENSORS_PCF8591
 	tristate "Philips PCF8591 ADC/DAC"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 93f7f41..f5c7b44 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -178,6 +178,7 @@ obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 
+obj-$(CONFIG_SENSORS_OCC)	+= occ/
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
diff --git a/drivers/hwmon/occ/Kconfig b/drivers/hwmon/occ/Kconfig
new file mode 100644
index 0000000..9579b63
--- /dev/null
+++ b/drivers/hwmon/occ/Kconfig
@@ -0,0 +1,28 @@
+#
+# On-Chip Controller configuration
+#
+
+config SENSORS_OCC
+	tristate "POWER On-Chip Controller"
+	help
+	 This option enables support for monitoring a variety of system sensors
+	 provided by the On-Chip Controller (OCC) on a POWER processor.
+
+	 This driver can also be built as a module. If so, the module will be
+	 called occ-hwmon.
+
+config SENSORS_OCC_P8_I2C
+	bool "POWER8 OCC through I2C"
+	depends on I2C && SENSORS_OCC
+	help
+	 This option enables support for monitoring sensors provided by the OCC
+	 on a POWER8 processor. Communications with the OCC are established
+	 through I2C bus.
+
+config SENSORS_OCC_P9_SBE
+	bool "POWER9 OCC through SBE"
+	depends on FSI_OCC && SENSORS_OCC
+	help
+	 This option enables support for monitoring sensors provided by the OCC
+	 on a POWER9 processor. Communications with the OCC are established
+	 through SBEFIFO on an FSI bus.
diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
new file mode 100644
index 0000000..ab5c3e9
--- /dev/null
+++ b/drivers/hwmon/occ/Makefile
@@ -0,0 +1,11 @@
+occ-hwmon-objs := common.o
+
+ifeq ($(CONFIG_SENSORS_OCC_P9_SBE), y)
+occ-hwmon-objs += p9_sbe.o
+endif
+
+ifeq ($(CONFIG_SENSORS_OCC_P8_I2C), y)
+occ-hwmon-objs += p8_i2c.o
+endif
+
+obj-$(CONFIG_SENSORS_OCC) += occ-hwmon.o
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
new file mode 100644
index 0000000..1fd3453
--- /dev/null
+++ b/drivers/hwmon/occ/common.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OCC hwmon driver common functionality
+ *
+ * Copyright (C) IBM Corporation 2018
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+
+#include "common.h"
+
+static int occ_poll(struct occ *occ)
+{
+	u16 checksum = occ->poll_cmd_data + 1;
+	u8 cmd[8];
+
+	/* big endian */
+	cmd[0] = 0;			/* sequence number */
+	cmd[1] = 0;			/* cmd type */
+	cmd[2] = 0;			/* data length msb */
+	cmd[3] = 1;			/* data length lsb */
+	cmd[4] = occ->poll_cmd_data;	/* data */
+	cmd[5] = checksum >> 8;		/* checksum msb */
+	cmd[6] = checksum & 0xFF;	/* checksum lsb */
+	cmd[7] = 0;
+
+	return occ->send_cmd(occ, cmd);
+}
+
+int occ_setup(struct occ *occ, const char *name)
+{
+	int rc;
+
+	rc = occ_poll(occ);
+	if (rc == -ESHUTDOWN) {
+		dev_info(occ->bus_dev, "host is not ready\n");
+		return rc;
+	} else if (rc < 0) {
+		dev_err(occ->bus_dev, "failed to get OCC poll response: %d\n",
+			rc);
+		return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
new file mode 100644
index 0000000..775b421
--- /dev/null
+++ b/drivers/hwmon/occ/common.h
@@ -0,0 +1,43 @@
+/*
+ * OCC hwmon driver common definitions, structures, and prototypes
+ *
+ * Copyright (C) IBM Corporation 2018
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef OCC_COMMON_H
+#define OCC_COMMON_H
+
+struct device;
+
+#define OCC_RESP_DATA_BYTES		4089
+
+/*
+ * Same response format for all OCC versions.
+ * Allocate the largest possible response.
+ */
+struct occ_response {
+	u8 seq_no;
+	u8 cmd_type;
+	u8 return_status;
+	__be16 data_length;
+	u8 data[OCC_RESP_DATA_BYTES];
+	__be16 checksum;
+} __packed;
+
+struct occ {
+	struct device *bus_dev;
+
+	struct occ_response resp;
+
+	u8 poll_cmd_data;		/* to perform OCC poll command */
+	int (*send_cmd)(struct occ *occ, u8 *cmd);
+};
+
+int occ_setup(struct occ *occ, const char *name);
+
+#endif /* OCC_COMMON_H */
diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
new file mode 100644
index 0000000..899294b
--- /dev/null
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OCC hwmon P8 driver
+ *
+ * Copyright (C) IBM Corporation 2018
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "common.h"
+
+struct p8_i2c_occ {
+	struct occ occ;
+	struct i2c_client *client;
+};
+
+#define to_p8_i2c_occ(x)	container_of((x), struct p8_i2c_occ, occ)
+
+static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int p8_i2c_occ_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct occ *occ;
+	struct p8_i2c_occ *ctx = devm_kzalloc(&client->dev, sizeof(*ctx),
+					      GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->client = client;
+	occ = &ctx->occ;
+	occ->bus_dev = &client->dev;
+	dev_set_drvdata(&client->dev, occ);
+
+	occ->poll_cmd_data = 0x10;		/* P8 OCC poll data */
+	occ->send_cmd = p8_i2c_occ_send_cmd;
+
+	return occ_setup(occ, "p8_occ");
+}
+
+static const struct of_device_id p8_i2c_occ_of_match[] = {
+	{ .compatible = "ibm,p8-occ-hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
+
+static struct i2c_driver p8_i2c_occ_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "occ-hwmon",
+		.of_match_table = p8_i2c_occ_of_match,
+	},
+	.probe = p8_i2c_occ_probe,
+};
+
+module_i2c_driver(p8_i2c_occ_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("BMC P8 OCC hwmon driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
new file mode 100644
index 0000000..7c026a5
--- /dev/null
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OCC hwmon P9 driver
+ *
+ * Copyright (C) IBM Corporation 2018
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "common.h"
+
+struct p9_sbe_occ {
+	struct occ occ;
+	struct device *sbe;
+};
+
+#define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
+
+static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int p9_sbe_occ_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct occ *occ;
+	struct p9_sbe_occ *ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx),
+					      GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->sbe = pdev->dev.parent;
+	occ = &ctx->occ;
+	occ->bus_dev = &pdev->dev;
+	platform_set_drvdata(pdev, occ);
+
+	occ->poll_cmd_data = 0x20;		/* P9 OCC poll data */
+	occ->send_cmd = p9_sbe_occ_send_cmd;
+
+	rc = occ_setup(occ, "p9_occ");
+	if (rc == -ESHUTDOWN)
+		rc = -ENODEV;	/* Host is shutdown, don't spew errors */
+
+	return rc;
+}
+
+static int p9_sbe_occ_remove(struct platform_device *pdev)
+{
+	struct occ *occ = platform_get_drvdata(pdev);
+	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
+
+	ctx->sbe = NULL;
+
+	return 0;
+}
+
+static struct platform_driver p9_sbe_occ_driver = {
+	.driver = {
+		.name = "occ-hwmon",
+	},
+	.probe	= p9_sbe_occ_probe,
+	.remove = p9_sbe_occ_remove,
+};
+
+module_platform_driver(p9_sbe_occ_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("BMC P9 OCC hwmon driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1

