Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CFEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E3B20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E3B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKIGnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:43:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbeKIGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:43:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8L0Bwb144932
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 16:05:50 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nmtwtvw6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:05:50 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Thu, 8 Nov 2018 21:05:49 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 21:05:44 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8L5hqf23003328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 21:05:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9498A28059;
        Thu,  8 Nov 2018 21:05:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82D212805A;
        Thu,  8 Nov 2018 21:05:42 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 21:05:42 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@roeck-us.net, rdunlap@infradead.org,
        benh@kernel.crashing.org, Eddie James <eajames@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v6 10/10] hwmon (occ): Add sysfs attributes for additional OCC data
Date:   Thu,  8 Nov 2018 15:05:29 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110821-2213-0000-0000-00000313CB14
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114610; UDB=6.00577887; IPR=6.00894709;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 21:05:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110821-2214-0000-0000-00005C2FEB08
Message-Id: <1541711129-26631-11-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.vnet.ibm.com>

The OCC provides a variety of additional information about the state of
the host processor, such as throttling, error conditions, and the number
of OCCs detected in the system. This information is essential to service
processor applications such as fan control and host management.
Therefore, export this data in the form of sysfs attributes attached to
the platform device (to which the hwmon device is also attached).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/Makefile |   4 +-
 drivers/hwmon/occ/common.c |  45 ++++++++++-
 drivers/hwmon/occ/common.h |  17 ++++
 drivers/hwmon/occ/p8_i2c.c |  10 +++
 drivers/hwmon/occ/p9_sbe.c |   1 +
 drivers/hwmon/occ/sysfs.c  | 188 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 260 insertions(+), 5 deletions(-)
 create mode 100644 drivers/hwmon/occ/sysfs.c

diff --git a/drivers/hwmon/occ/Makefile b/drivers/hwmon/occ/Makefile
index 57c0e91..3fec12d 100644
--- a/drivers/hwmon/occ/Makefile
+++ b/drivers/hwmon/occ/Makefile
@@ -1,5 +1,5 @@
-occ-p8-hwmon-objs := common.o p8_i2c.o
-occ-p9-hwmon-objs := common.o p9_sbe.o
+occ-p8-hwmon-objs := common.o sysfs.o p8_i2c.o
+occ-p9-hwmon-objs := common.o sysfs.o p9_sbe.o
 
 obj-$(CONFIG_SENSORS_OCC_P8_I2C) += occ-p8-hwmon.o
 obj-$(CONFIG_SENSORS_OCC_P9_SBE) += occ-p9-hwmon.o
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index c6c8161..423903f 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -14,6 +14,11 @@
 
 #define EXTN_FLAG_SENSOR_ID		BIT(7)
 
+#define OCC_ERROR_COUNT_THRESHOLD	2	/* required by OCC spec */
+
+#define OCC_STATE_SAFE			4
+#define OCC_SAFE_TIMEOUT		msecs_to_jiffies(60000) /* 1 min */
+
 #define OCC_UPDATE_FREQUENCY		msecs_to_jiffies(1000)
 
 #define OCC_TEMP_SENSOR_FAULT		0xFF
@@ -115,8 +120,10 @@ struct extended_sensor {
 
 static int occ_poll(struct occ *occ)
 {
+	int rc;
 	u16 checksum = occ->poll_cmd_data + 1;
 	u8 cmd[8];
+	struct occ_poll_response_header *header;
 
 	/* big endian */
 	cmd[0] = 0;			/* sequence number */
@@ -129,7 +136,35 @@ static int occ_poll(struct occ *occ)
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
@@ -161,7 +196,7 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
 	return rc;
 }
 
-static int occ_update_response(struct occ *occ)
+int occ_update_response(struct occ *occ)
 {
 	int rc = mutex_lock_interruptible(&occ->lock);
 
@@ -1055,5 +1090,9 @@ int occ_setup(struct occ *occ, const char *name)
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
index 00ac101..da80e65 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -104,8 +104,25 @@ struct occ {
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
index e4c2c04..b59efc9 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -223,6 +223,15 @@ static int p8_i2c_occ_probe(struct i2c_client *client,
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
@@ -236,6 +245,7 @@ static int p8_i2c_occ_probe(struct i2c_client *client,
 		.of_match_table = p8_i2c_occ_of_match,
 	},
 	.probe = p8_i2c_occ_probe,
+	.remove = p8_i2c_occ_remove,
 };
 
 module_i2c_driver(p8_i2c_occ_driver);
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index b33f4fe..b65c1d1 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -86,6 +86,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
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

