Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D5C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA420C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EA420C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbeGKVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390366AbeGKVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL0Bnk144679
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:04 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5sbm89an-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:03 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 15:02:03 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 15:01:58 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL1vXC20185460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:01:57 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69696E050;
        Wed, 11 Jul 2018 15:01:57 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2CD6E052;
        Wed, 11 Jul 2018 15:01:56 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 15:01:56 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, linux@roeck-us.net, jdelvare@suse.com,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 8/9] hwmon (occ): Add sensor attributes and register hwmon device
Date:   Wed, 11 Jul 2018 16:01:37 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071121-0012-0000-0000-0000168AA71B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059946; UDB=6.00544035; IPR=6.00837866;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:02:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-0013-0000-0000-000053A34775
Message-Id: <1531342898-15790-9-git-send-email-eajames@linux.vnet.ibm.com>
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

Setup the sensor attributes for every OCC sensor found by the first poll
response. Register the attributes with hwmon.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/occ/common.c | 452 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/common.h |  16 ++
 2 files changed, 468 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 1719536..da55919 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -11,10 +11,12 @@
  */
 
 #include <linux/device.h>
+#include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/sysfs.h>
 #include <asm/unaligned.h>
 
 #include "common.h"
@@ -678,6 +680,439 @@ static ssize_t occ_show_extended(struct device *dev,
 	return rc;
 }
 
+/*
+ * Some helper macros to make it easier to define an occ_attribute. Since these
+ * are dynamically allocated, we shouldn't use the existing kernel macros which
+ * stringify the name argument.
+ */
+#define ATTR_OCC(_name, _mode, _show, _store) {				\
+	.attr	= {							\
+		.name = _name,						\
+		.mode = VERIFY_OCTAL_PERMISSIONS(_mode),		\
+	},								\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
+#define SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index) {	\
+	.dev_attr	= ATTR_OCC(_name, _mode, _show, _store),	\
+	.index		= _index,					\
+	.nr		= _nr,						\
+}
+
+#define OCC_INIT_ATTR(_name, _mode, _show, _store, _nr, _index)		\
+	((struct sensor_device_attribute_2)				\
+		SENSOR_ATTR_OCC(_name, _mode, _show, _store, _nr, _index))
+
+/*
+ * Allocate and instatiate sensor_device_attribute_2s. It's most efficient to
+ * use our own instead of the built-in hwmon attribute types.
+ */
+static int occ_setup_sensor_attrs(struct occ *occ)
+{
+	unsigned int i, s, num_attrs = 0;
+	struct device *dev = occ->bus_dev;
+	struct occ_sensors *sensors = &occ->sensors;
+	struct occ_attribute *attr;
+	struct temp_sensor_2 *temp;
+	ssize_t (*show_temp)(struct device *, struct device_attribute *,
+			     char *) = occ_show_temp_1;
+	ssize_t (*show_freq)(struct device *, struct device_attribute *,
+			     char *) = occ_show_freq_1;
+	ssize_t (*show_power)(struct device *, struct device_attribute *,
+			      char *) = occ_show_power_1;
+	ssize_t (*show_caps)(struct device *, struct device_attribute *,
+			     char *) = occ_show_caps_1;
+
+	switch (sensors->temp.version) {
+	case 1:
+		num_attrs += (sensors->temp.num_sensors * 2);
+		break;
+	case 2:
+		num_attrs += (sensors->temp.num_sensors * 4);
+		show_temp = occ_show_temp_2;
+		break;
+	default:
+		sensors->temp.num_sensors = 0;
+	}
+
+	switch (sensors->freq.version) {
+	case 2:
+		show_freq = occ_show_freq_2;
+		/* fall through */
+	case 1:
+		num_attrs += (sensors->freq.num_sensors * 2);
+		break;
+	default:
+		sensors->freq.num_sensors = 0;
+	}
+
+	switch (sensors->power.version) {
+	case 1:
+		num_attrs += (sensors->power.num_sensors * 4);
+		break;
+	case 2:
+		num_attrs += (sensors->power.num_sensors * 6);
+		show_power = occ_show_power_2;
+		break;
+	case 0xA0:
+		num_attrs += (sensors->power.num_sensors * 19);
+		show_power = occ_show_power_a0;
+		break;
+	default:
+		sensors->power.num_sensors = 0;
+	}
+
+	switch (sensors->caps.version) {
+	case 1:
+		num_attrs += (sensors->caps.num_sensors * 6);
+		break;
+	case 2:
+		num_attrs += (sensors->caps.num_sensors * 7);
+		show_caps = occ_show_caps_2;
+		break;
+	case 3:
+		num_attrs += (sensors->caps.num_sensors * 8);
+		show_caps = occ_show_caps_3;
+		break;
+	default:
+		sensors->caps.num_sensors = 0;
+	}
+
+	switch (sensors->extended.version) {
+	case 1:
+		num_attrs += (sensors->extended.num_sensors * 3);
+		break;
+	default:
+		sensors->extended.num_sensors = 0;
+	}
+
+	occ->attrs = devm_kzalloc(dev, sizeof(*occ->attrs) * num_attrs,
+				  GFP_KERNEL);
+	if (!occ->attrs)
+		return -ENOMEM;
+
+	/* null-terminated list */
+	occ->group.attrs = devm_kzalloc(dev, sizeof(*occ->group.attrs) *
+					num_attrs + 1, GFP_KERNEL);
+	if (!occ->group.attrs)
+		return -ENOMEM;
+
+	attr = occ->attrs;
+
+	for (i = 0; i < sensors->temp.num_sensors; ++i) {
+		s = i + 1;
+		temp = ((struct temp_sensor_2 *)sensors->temp.data) + i;
+
+		snprintf(attr->name, sizeof(attr->name), "temp%d_label", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
+					     0, i);
+		attr++;
+
+		if (sensors->temp.version > 1 &&
+		    temp->fru_type == OCC_FRU_TYPE_VRM) {
+			snprintf(attr->name, sizeof(attr->name),
+				 "temp%d_alarm", s);
+		} else {
+			snprintf(attr->name, sizeof(attr->name),
+				 "temp%d_input", s);
+		}
+
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_temp, NULL,
+					     1, i);
+		attr++;
+
+		if (sensors->temp.version > 1) {
+			snprintf(attr->name, sizeof(attr->name),
+				 "temp%d_fru_type", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_temp, NULL, 2, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "temp%d_fault", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_temp, NULL, 3, i);
+			attr++;
+		}
+	}
+
+	for (i = 0; i < sensors->freq.num_sensors; ++i) {
+		s = i + 1;
+
+		snprintf(attr->name, sizeof(attr->name), "freq%d_label", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
+					     0, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "freq%d_input", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_freq, NULL,
+					     1, i);
+		attr++;
+	}
+
+	if (sensors->power.version == 0xA0) {
+		/* Special case for many-attribute power sensor. Split it into
+		 * a sensor number per power type, emulating several sensors.
+		 */
+		for (i = 0; i < sensors->power.num_sensors; ++i) {
+			s = (i * 4) + 1;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_id", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 0, i);
+			attr++;
+
+			/* system power attributes */
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_label", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 1, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_time", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 2, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_input", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 3, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_tag", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 4, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_accumulator", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 5, i);
+			attr++;
+
+			s++;
+
+			/* processor power attributes */
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_label", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 6, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_time", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 7, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_input", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 8, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_tag", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 9, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_accumulator", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 10, i);
+			attr++;
+
+			s++;
+
+			/* vdd power attributes */
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_label", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 11, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_input", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 12, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_tag", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 13, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_accumulator", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 14, i);
+			attr++;
+
+			s++;
+
+			/* vdn power attributes */
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_label", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 15, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_input", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 16, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_tag", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 17, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_accumulator", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 18, i);
+			attr++;
+		}
+	} else {
+		for (i = 0; i < sensors->power.num_sensors; ++i) {
+			s = i + 1;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_label", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 0, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_update_tag", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 1, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_accumulator", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 2, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "power%d_input", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_power, NULL, 3, i);
+			attr++;
+
+			if (sensors->power.version > 1) {
+				snprintf(attr->name, sizeof(attr->name),
+					 "power%d_function_id", s);
+				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+							     show_power, NULL,
+							     4, i);
+				attr++;
+
+				snprintf(attr->name, sizeof(attr->name),
+					 "power%d_apss_channel", s);
+				attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+							     show_power, NULL,
+							     5, i);
+				attr++;
+			}
+		}
+	}
+
+	for (i = 0; i < sensors->caps.num_sensors; ++i) {
+		s = i + 1;
+
+		snprintf(attr->name, sizeof(attr->name), "caps%d_current", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
+					     0, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "caps%d_reading", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
+					     1, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "caps%d_norm", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
+					     2, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "caps%d_max", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
+					     3, i);
+		attr++;
+
+		if (sensors->caps.version > 2) {
+			snprintf(attr->name, sizeof(attr->name),
+				 "caps%d_min_hard", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_caps, NULL, 4, i);
+			attr++;
+
+			snprintf(attr->name, sizeof(attr->name),
+				 "caps%d_min_soft", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_caps, NULL, 7, i);
+			attr++;
+		} else {
+			snprintf(attr->name, sizeof(attr->name), "caps%d_min",
+				 s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_caps, NULL, 4, i);
+			attr++;
+		}
+
+		snprintf(attr->name, sizeof(attr->name), "caps%d_user", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0644, show_caps,
+					     occ_store_caps_user, 5, i);
+		attr++;
+
+		if (sensors->caps.version > 1) {
+			snprintf(attr->name, sizeof(attr->name),
+				 "caps%d_user_source", s);
+			attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+						     show_caps, NULL, 6, i);
+			attr++;
+		}
+	}
+
+	for (i = 0; i < sensors->extended.num_sensors; ++i) {
+		s = i + 1;
+
+		snprintf(attr->name, sizeof(attr->name), "extn%d_label", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+					     occ_show_extended, NULL, 0, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "extn%d_flags", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+					     occ_show_extended, NULL, 1, i);
+		attr++;
+
+		snprintf(attr->name, sizeof(attr->name), "extn%d_input", s);
+		attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
+					     occ_show_extended, NULL, 2, i);
+		attr++;
+	}
+
+	/* put the sensors in the group */
+	for (i = 0; i < num_attrs; ++i) {
+		sysfs_attr_init(&occ->attrs[i].sensor.dev_attr.attr);
+		occ->group.attrs[i] = &occ->attrs[i].sensor.dev_attr.attr;
+	}
+
+	return 0;
+}
+
 /* only need to do this once at startup, as OCC won't change sensors on us */
 static void occ_parse_poll_response(struct occ *occ)
 {
@@ -741,6 +1176,7 @@ int occ_setup(struct occ *occ, const char *name)
 	int rc;
 
 	mutex_init(&occ->lock);
+	occ->groups[0] = &occ->group;
 
 	/* no need to lock */
 	rc = occ_poll(occ);
@@ -755,5 +1191,21 @@ int occ_setup(struct occ *occ, const char *name)
 
 	occ_parse_poll_response(occ);
 
+	rc = occ_setup_sensor_attrs(occ);
+	if (rc) {
+		dev_err(occ->bus_dev, "failed to setup sensor attrs: %d\n",
+			rc);
+		return rc;
+	}
+
+	occ->hwmon = devm_hwmon_device_register_with_groups(occ->bus_dev, name,
+							    occ, occ->groups);
+	if (IS_ERR(occ->hwmon)) {
+		rc = PTR_ERR(occ->hwmon);
+		dev_err(occ->bus_dev, "failed to register hwmon device: %d\n",
+			rc);
+		return rc;
+	}
+
 	return 0;
 }
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index f697adb..2c1c06e 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -12,7 +12,9 @@
 #ifndef OCC_COMMON_H
 #define OCC_COMMON_H
 
+#include <linux/hwmon-sysfs.h>
 #include <linux/mutex.h>
+#include <linux/sysfs.h>
 
 struct device;
 
@@ -85,6 +87,15 @@ struct occ_sensors {
 	struct occ_sensor extended;
 };
 
+/*
+ * Use our own attribute struct so we can dynamically allocate space for the
+ * name.
+ */
+struct occ_attribute {
+	char name[32];
+	struct sensor_device_attribute_2 sensor;
+};
+
 struct occ {
 	struct device *bus_dev;
 
@@ -96,6 +107,11 @@ struct occ {
 
 	unsigned long last_update;
 	struct mutex lock;		/* lock OCC access */
+
+	struct device *hwmon;
+	struct occ_attribute *attrs;
+	struct attribute_group group;
+	const struct attribute_group *groups[2];
 };
 
 int occ_setup(struct occ *occ, const char *name);
-- 
1.8.3.1

