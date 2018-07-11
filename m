Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E1F20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E1F20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbeGKVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390367AbeGKVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL1lCc059568
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:06 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5sex00sb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:05 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 15:02:05 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 15:02:00 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL1x8Y20185472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:01:59 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C63026E05D;
        Wed, 11 Jul 2018 15:01:59 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48F06E050;
        Wed, 11 Jul 2018 15:01:58 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 15:01:58 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, linux@roeck-us.net, jdelvare@suse.com,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 9/9] hwmon (occ): Add sysfs attributes for additional OCC data
Date:   Wed, 11 Jul 2018 16:01:38 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071121-0036-0000-0000-00000A0DD7E3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059946; UDB=6.00544035; IPR=6.00837866;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:02:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-0037-0000-0000-0000481101D8
Message-Id: <1531342898-15790-10-git-send-email-eajames@linux.vnet.ibm.com>
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

The OCC provides a variety of additional information about the state of
the host processor, such as throttling, error conditions, and the number
of OCCs detected in the system. This information is essential to service
processor applications such as fan control and host management.
Therefore, export this data in the form of sysfs attributes attached to
the platform device (to which the hwmon device is also attached).

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/occ/Makefile |   2 +-
 drivers/hwmon/occ/common.c |  45 ++++++++++-
 drivers/hwmon/occ/common.h |  17 ++++
 drivers/hwmon/occ/p8_i2c.c |  10 +++
 drivers/hwmon/occ/p9_sbe.c |   1 +
 drivers/hwmon/occ/sysfs.c  | 188 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+), 4 deletions(-)
 create mode 100644 drivers/hwmon/occ/sysfs.c

diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
index ab5c3e9..46a8636 100644
--- a/drivers/hwmon/occ/Makefile
+++ b/drivers/hwmon/occ/Makefile
@@ -1,4 +1,4 @@
-occ-hwmon-objs := common.o
+occ-hwmon-objs := common.o sysfs.o
 
 ifeq ($(CONFIG_SENSORS_OCC_P9_SBE), y)
 occ-hwmon-objs += p9_sbe.o
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index da55919..7bc52af 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -21,6 +21,11 @@
 
 #include "common.h"
 
+#define OCC_ERROR_COUNT_THRESHOLD	2	/* required by OCC spec */
+
+#define OCC_STATE_SAFE			4
+#define OCC_SAFE_TIMEOUT		msecs_to_jiffies(60000) /* 1 min */
+
 #define OCC_UPDATE_FREQUENCY		msecs_to_jiffies(1000)
 
 #define OCC_TEMP_SENSOR_FAULT		0xFF
@@ -128,8 +133,10 @@ struct extended_sensor {
 
 static int occ_poll(struct occ *occ)
 {
+	int rc;
 	u16 checksum = occ->poll_cmd_data + 1;
 	u8 cmd[8];
+	struct occ_poll_response_header *header;
 
 	/* big endian */
 	cmd[0] = 0;			/* sequence number */
@@ -142,7 +149,35 @@ static int occ_poll(struct occ *occ)
 	cmd[7] = 0;
 
 	/* mutex should already be locked if necessary */
-	return occ->send_cmd(occ, cmd);
+	rc = occ->send_cmd(occ, cmd);
+	if (rc) {
+		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
+			occ->error = rc;
+
+		goto done;
+	}
+
+	/* clear error since communication was successful */
+	occ->error_count = 0;
+	occ->error = 0;
+
+	/* check for safe state */
+	header = (struct occ_poll_response_header *)occ->resp.data;
+	if (header->occ_state == OCC_STATE_SAFE) {
+		if (occ->last_safe) {
+			if (time_after(jiffies,
+				       occ->last_safe + OCC_SAFE_TIMEOUT))
+				occ->error = -EHOSTDOWN;
+		} else {
+			occ->last_safe = jiffies;
+		}
+	} else {
+		occ->last_safe = 0;
+	}
+
+done:
+	occ_sysfs_poll_done(occ);
+	return rc;
 }
 
 static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
@@ -174,7 +209,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
 	return rc;
 }
 
-static int occ_update_response(struct occ *occ)
+int occ_update_response(struct occ *occ)
 {
 	int rc = mutex_lock_interruptible(&occ->lock);
 
@@ -1207,5 +1242,9 @@ int occ_setup(struct occ *occ, const char *name)
 		return rc;
 	}
 
-	return 0;
+	rc = occ_setup_sysfs(occ);
+	if (rc)
+		dev_err(occ->bus_dev, "failed to setup sysfs: %d\n", rc);
+
+	return rc;
 }
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 2c1c06e..7bacbb6 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -112,8 +112,25 @@ struct occ {
 	struct occ_attribute *attrs;
 	struct attribute_group group;
 	const struct attribute_group *groups[2];
+
+	int error;                      /* latest transfer error */
+	unsigned int error_count;       /* number of xfr errors observed */
+	unsigned long last_safe;        /* time OCC entered "safe" state */
+
+	/*
+	 * Store the previous state data for comparison in order to notify
+	 * sysfs readers of state changes.
+	 */
+	int prev_error;
+	u8 prev_stat;
+	u8 prev_ext_stat;
+	u8 prev_occs_present;
 };
 
 int occ_setup(struct occ *occ, const char *name);
+int occ_setup_sysfs(struct occ *occ);
+void occ_shutdown(struct occ *occ);
+void occ_sysfs_poll_done(struct occ *occ);
+int occ_update_response(struct occ *occ);
 
 #endif /* OCC_COMMON_H */
diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
index 9a920db..63f3db8 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -232,6 +232,15 @@ static int p8_i2c_occ_probe(struct i2c_client *client,
 	return occ_setup(occ, "p8_occ");
 }
 
+static int p8_i2c_occ_remove(struct i2c_client *client)
+{
+	struct occ *occ = dev_get_drvdata(&client->dev);
+
+	occ_shutdown(occ);
+
+	return 0;
+}
+
 static const struct of_device_id p8_i2c_occ_of_match[] = {
 	{ .compatible = "ibm,p8-occ-hwmon" },
 	{}
@@ -245,6 +254,7 @@ static int p8_i2c_occ_probe(struct i2c_client *client,
 		.of_match_table = p8_i2c_occ_of_match,
 	},
 	.probe = p8_i2c_occ_probe,
+	.remove = p8_i2c_occ_remove,
 };
 
 module_i2c_driver(p8_i2c_occ_driver);
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index fb32788..e379b05 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -95,6 +95,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 
 	ctx->sbe = NULL;
+	occ_shutdown(occ);
 
 	return 0;
 }
diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
new file mode 100644
index 0000000..743b26ec
--- /dev/null
+++ b/drivers/hwmon/occ/sysfs.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * OCC hwmon driver sysfs interface
+ *
+ * Copyright (C) IBM Corporation 2018
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/kernel.h>
+#include <linux/sysfs.h>
+
+#include "common.h"
+
+/* OCC status register */
+#define OCC_STAT_MASTER			BIT(7)
+#define OCC_STAT_ACTIVE			BIT(0)
+
+/* OCC extended status register */
+#define OCC_EXT_STAT_DVFS_OT		BIT(7)
+#define OCC_EXT_STAT_DVFS_POWER		BIT(6)
+#define OCC_EXT_STAT_MEM_THROTTLE	BIT(5)
+#define OCC_EXT_STAT_QUICK_DROP		BIT(4)
+
+static ssize_t occ_sysfs_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int rc;
+	int val = 0;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_poll_response_header *header;
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	header = (struct occ_poll_response_header *)occ->resp.data;
+
+	switch (sattr->index) {
+	case 0:
+		val = !!(header->status & OCC_STAT_MASTER);
+		break;
+	case 1:
+		val = !!(header->status & OCC_STAT_ACTIVE);
+		break;
+	case 2:
+		val = !!(header->status & OCC_EXT_STAT_DVFS_OT);
+		break;
+	case 3:
+		val = !!(header->status & OCC_EXT_STAT_DVFS_POWER);
+		break;
+	case 4:
+		val = !!(header->status & OCC_EXT_STAT_MEM_THROTTLE);
+		break;
+	case 5:
+		val = !!(header->status & OCC_EXT_STAT_QUICK_DROP);
+		break;
+	case 6:
+		val = header->occ_state;
+		break;
+	case 7:
+		if (header->status & OCC_STAT_MASTER)
+			val = hweight8(header->occs_present);
+		else
+			val = 1;
+		break;
+	case 8:
+		val = occ->error;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
+}
+
+static SENSOR_DEVICE_ATTR(occ_master, 0444, occ_sysfs_show, NULL, 0);
+static SENSOR_DEVICE_ATTR(occ_active, 0444, occ_sysfs_show, NULL, 1);
+static SENSOR_DEVICE_ATTR(occ_dvfs_overtemp, 0444, occ_sysfs_show, NULL, 2);
+static SENSOR_DEVICE_ATTR(occ_dvfs_power, 0444, occ_sysfs_show, NULL, 3);
+static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
+static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
+static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
+static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
+static SENSOR_DEVICE_ATTR(occ_error, 0444, occ_sysfs_show, NULL, 8);
+
+static struct attribute *occ_attributes[] = {
+	&sensor_dev_attr_occ_master.dev_attr.attr,
+	&sensor_dev_attr_occ_active.dev_attr.attr,
+	&sensor_dev_attr_occ_dvfs_overtemp.dev_attr.attr,
+	&sensor_dev_attr_occ_dvfs_power.dev_attr.attr,
+	&sensor_dev_attr_occ_mem_throttle.dev_attr.attr,
+	&sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
+	&sensor_dev_attr_occ_state.dev_attr.attr,
+	&sensor_dev_attr_occs_present.dev_attr.attr,
+	&sensor_dev_attr_occ_error.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group occ_sysfs = {
+	.attrs = occ_attributes,
+};
+
+void occ_sysfs_poll_done(struct occ *occ)
+{
+	const char *name;
+	struct occ_poll_response_header *header =
+		(struct occ_poll_response_header *)occ->resp.data;
+
+	/*
+	 * On the first poll response, we haven't yet created the sysfs
+	 * attributes, so don't make any notify calls.
+	 */
+	if (!occ->hwmon)
+		goto done;
+
+	if ((header->status & OCC_STAT_MASTER) !=
+	    (occ->prev_stat & OCC_STAT_MASTER)) {
+		name = sensor_dev_attr_occ_master.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->status & OCC_STAT_ACTIVE) !=
+	    (occ->prev_stat & OCC_STAT_ACTIVE)) {
+		name = sensor_dev_attr_occ_active.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->ext_status & OCC_EXT_STAT_DVFS_OT) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_OT)) {
+		name = sensor_dev_attr_occ_dvfs_overtemp.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->ext_status & OCC_EXT_STAT_DVFS_POWER) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_POWER)) {
+		name = sensor_dev_attr_occ_dvfs_power.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->ext_status & OCC_EXT_STAT_MEM_THROTTLE) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_MEM_THROTTLE)) {
+		name = sensor_dev_attr_occ_mem_throttle.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->ext_status & OCC_EXT_STAT_QUICK_DROP) !=
+	    (occ->prev_ext_stat & OCC_EXT_STAT_QUICK_DROP)) {
+		name = sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if ((header->status & OCC_STAT_MASTER) &&
+	    header->occs_present != occ->prev_occs_present) {
+		name = sensor_dev_attr_occs_present.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	if (occ->error && occ->error != occ->prev_error) {
+		name = sensor_dev_attr_occ_error.dev_attr.attr.name;
+		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
+	}
+
+	/* no notifications for OCC state; doesn't indicate error condition */
+
+done:
+	occ->prev_error = occ->error;
+	occ->prev_stat = header->status;
+	occ->prev_ext_stat = header->ext_status;
+	occ->prev_occs_present = header->occs_present;
+}
+
+int occ_setup_sysfs(struct occ *occ)
+{
+	return sysfs_create_group(&occ->bus_dev->kobj, &occ_sysfs);
+}
+
+void occ_shutdown(struct occ *occ)
+{
+	sysfs_remove_group(&occ->bus_dev->kobj, &occ_sysfs);
+}
-- 
1.8.3.1

