Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1176BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CB420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CB420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbeKIGnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:43:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbeKIGnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:43:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8L0mgg022966
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 16:05:47 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmt5b6k7w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:05:46 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Thu, 8 Nov 2018 21:05:45 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 21:05:42 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8L5frU31260674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 21:05:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D8422805A;
        Thu,  8 Nov 2018 21:05:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1275428058;
        Thu,  8 Nov 2018 21:05:40 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 21:05:39 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@roeck-us.net, rdunlap@infradead.org,
        benh@kernel.crashing.org, Eddie James <eajames@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v6 08/10] hwmon (occ): Add sensor types and versions
Date:   Thu,  8 Nov 2018 15:05:27 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110821-0052-0000-0000-00000352D5A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114610; UDB=6.00577887; IPR=6.00894708;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 21:05:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110821-0053-0000-0000-00005EB383BD
Message-Id: <1541711129-26631-9-git-send-email-eajames@linux.ibm.com>
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

Add structures to define all sensor types and versions. Add sysfs show
and store functions for each sensor type. Add a method to construct the
"set user power cap" command and send it to the OCC. Add rate limit to
polling the OCC (in case user-space reads our hwmon entries rapidly).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 621 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/common.h |   6 +
 drivers/hwmon/occ/p8_i2c.c |   1 +
 drivers/hwmon/occ/p9_sbe.c |   1 +
 4 files changed, 629 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index a066509..f7220132 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1,10 +1,116 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <asm/unaligned.h>
 
 #include "common.h"
 
+#define EXTN_FLAG_SENSOR_ID		BIT(7)
+
+#define OCC_UPDATE_FREQUENCY		msecs_to_jiffies(1000)
+
+#define OCC_TEMP_SENSOR_FAULT		0xFF
+
+#define OCC_FRU_TYPE_VRM		3
+
+/* OCC sensor type and version definitions */
+
+struct temp_sensor_1 {
+	u16 sensor_id;
+	u16 value;
+} __packed;
+
+struct temp_sensor_2 {
+	u32 sensor_id;
+	u8 fru_type;
+	u8 value;
+} __packed;
+
+struct freq_sensor_1 {
+	u16 sensor_id;
+	u16 value;
+} __packed;
+
+struct freq_sensor_2 {
+	u32 sensor_id;
+	u16 value;
+} __packed;
+
+struct power_sensor_1 {
+	u16 sensor_id;
+	u32 update_tag;
+	u32 accumulator;
+	u16 value;
+} __packed;
+
+struct power_sensor_2 {
+	u32 sensor_id;
+	u8 function_id;
+	u8 apss_channel;
+	u16 reserved;
+	u32 update_tag;
+	u64 accumulator;
+	u16 value;
+} __packed;
+
+struct power_sensor_data {
+	u16 value;
+	u32 update_tag;
+	u64 accumulator;
+} __packed;
+
+struct power_sensor_data_and_time {
+	u16 update_time;
+	u16 value;
+	u32 update_tag;
+	u64 accumulator;
+} __packed;
+
+struct power_sensor_a0 {
+	u32 sensor_id;
+	struct power_sensor_data_and_time system;
+	u32 reserved;
+	struct power_sensor_data_and_time proc;
+	struct power_sensor_data vdd;
+	struct power_sensor_data vdn;
+} __packed;
+
+struct caps_sensor_2 {
+	u16 cap;
+	u16 system_power;
+	u16 n_cap;
+	u16 max;
+	u16 min;
+	u16 user;
+	u8 user_source;
+} __packed;
+
+struct caps_sensor_3 {
+	u16 cap;
+	u16 system_power;
+	u16 n_cap;
+	u16 max;
+	u16 hard_min;
+	u16 soft_min;
+	u16 user;
+	u8 user_source;
+} __packed;
+
+struct extended_sensor {
+	union {
+		u8 name[4];
+		u32 sensor_id;
+	};
+	u8 flags;
+	u8 reserved;
+	u8 data[6];
+} __packed;
+
 static int occ_poll(struct occ *occ)
 {
 	u16 checksum = occ->poll_cmd_data + 1;
@@ -20,9 +126,521 @@ static int occ_poll(struct occ *occ)
 	cmd[6] = checksum & 0xFF;	/* checksum lsb */
 	cmd[7] = 0;
 
+	/* mutex should already be locked if necessary */
 	return occ->send_cmd(occ, cmd);
 }
 
+static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
+{
+	int rc;
+	u8 cmd[8];
+	u16 checksum = 0x24;
+	__be16 user_power_cap_be = cpu_to_be16(user_power_cap);
+
+	cmd[0] = 0;
+	cmd[1] = 0x22;
+	cmd[2] = 0;
+	cmd[3] = 2;
+
+	memcpy(&cmd[4], &user_power_cap_be, 2);
+
+	checksum += cmd[4] + cmd[5];
+	cmd[6] = checksum >> 8;
+	cmd[7] = checksum & 0xFF;
+
+	rc = mutex_lock_interruptible(&occ->lock);
+	if (rc)
+		return rc;
+
+	rc = occ->send_cmd(occ, cmd);
+
+	mutex_unlock(&occ->lock);
+
+	return rc;
+}
+
+static int occ_update_response(struct occ *occ)
+{
+	int rc = mutex_lock_interruptible(&occ->lock);
+
+	if (rc)
+		return rc;
+
+	/* limit the maximum rate of polling the OCC */
+	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
+		rc = occ_poll(occ);
+		occ->last_update = jiffies;
+	}
+
+	mutex_unlock(&occ->lock);
+	return rc;
+}
+
+static ssize_t occ_show_temp_1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_1 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_1 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&temp->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be16(&temp->value) * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_temp_2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_2 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_2 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&temp->sensor_id);
+		break;
+	case 1:
+		val = temp->value;
+		if (val == OCC_TEMP_SENSOR_FAULT)
+			return -EREMOTEIO;
+
+		/*
+		 * VRM doesn't return temperature, only alarm bit. This
+		 * attribute maps to tempX_alarm instead of tempX_input for
+		 * VRM
+		 */
+		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
+			/* sensor not ready */
+			if (val == 0)
+				return -EAGAIN;
+
+			val *= 1000;
+		}
+		break;
+	case 2:
+		val = temp->fru_type;
+		break;
+	case 3:
+		val = temp->value == OCC_TEMP_SENSOR_FAULT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_freq_1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u16 val = 0;
+	struct freq_sensor_1 *freq;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	freq = ((struct freq_sensor_1 *)sensors->freq.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&freq->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be16(&freq->value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_freq_2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct freq_sensor_2 *freq;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	freq = ((struct freq_sensor_2 *)sensors->freq.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&freq->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be16(&freq->value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_power_1(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_1 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_1 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&power->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be32(&power->accumulator) /
+			get_unaligned_be32(&power->update_tag);
+		val *= 1000000ULL;
+		break;
+	case 2:
+		val = get_unaligned_be32(&power->update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 3:
+		val = get_unaligned_be16(&power->value) * 1000000ULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
+{
+	return div64_u64(get_unaligned_be64(accum) * 1000000ULL,
+			 get_unaligned_be32(samples));
+}
+
+static ssize_t occ_show_power_2(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_2 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_2 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		return snprintf(buf, PAGE_SIZE - 1, "%u_%u_%u\n",
+				get_unaligned_be32(&power->sensor_id),
+				power->function_id, power->apss_channel);
+	case 1:
+		val = occ_get_powr_avg(&power->accumulator,
+				       &power->update_tag);
+		break;
+	case 2:
+		val = get_unaligned_be32(&power->update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 3:
+		val = get_unaligned_be16(&power->value) * 1000000ULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_power_a0(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_a0 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_a0 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		return snprintf(buf, PAGE_SIZE - 1, "%u_system\n",
+				get_unaligned_be32(&power->sensor_id));
+	case 1:
+		val = occ_get_powr_avg(&power->system.accumulator,
+				       &power->system.update_tag);
+		break;
+	case 2:
+		val = get_unaligned_be32(&power->system.update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 3:
+		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
+		break;
+	case 4:
+		return snprintf(buf, PAGE_SIZE - 1, "%u_proc\n",
+				get_unaligned_be32(&power->sensor_id));
+	case 5:
+		val = occ_get_powr_avg(&power->proc.accumulator,
+				       &power->proc.update_tag);
+		break;
+	case 6:
+		val = get_unaligned_be32(&power->proc.update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 7:
+		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
+		break;
+	case 8:
+		return snprintf(buf, PAGE_SIZE - 1, "%u_vdd\n",
+				get_unaligned_be32(&power->sensor_id));
+	case 9:
+		val = occ_get_powr_avg(&power->vdd.accumulator,
+				       &power->vdd.update_tag);
+		break;
+	case 10:
+		val = get_unaligned_be32(&power->vdd.update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 11:
+		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
+		break;
+	case 12:
+		return snprintf(buf, PAGE_SIZE - 1, "%u_vdn\n",
+				get_unaligned_be32(&power->sensor_id));
+	case 13:
+		val = occ_get_powr_avg(&power->vdn.accumulator,
+				       &power->vdn.update_tag);
+		break;
+	case 14:
+		val = get_unaligned_be32(&power->vdn.update_tag) *
+			occ->powr_sample_time_us;
+		break;
+	case 15:
+		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_caps_1_2(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct caps_sensor_2 *caps;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	caps = ((struct caps_sensor_2 *)sensors->caps.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		return snprintf(buf, PAGE_SIZE - 1, "system\n");
+	case 1:
+		val = get_unaligned_be16(&caps->cap) * 1000000ULL;
+		break;
+	case 2:
+		val = get_unaligned_be16(&caps->system_power) * 1000000ULL;
+		break;
+	case 3:
+		val = get_unaligned_be16(&caps->n_cap) * 1000000ULL;
+		break;
+	case 4:
+		val = get_unaligned_be16(&caps->max) * 1000000ULL;
+		break;
+	case 5:
+		val = get_unaligned_be16(&caps->min) * 1000000ULL;
+		break;
+	case 6:
+		val = get_unaligned_be16(&caps->user) * 1000000ULL;
+		break;
+	case 7:
+		if (occ->sensors.caps.version == 1)
+			return -EINVAL;
+
+		val = caps->user_source;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_caps_3(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct caps_sensor_3 *caps;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	caps = ((struct caps_sensor_3 *)sensors->caps.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		return snprintf(buf, PAGE_SIZE - 1, "system\n");
+	case 1:
+		val = get_unaligned_be16(&caps->cap) * 1000000ULL;
+		break;
+	case 2:
+		val = get_unaligned_be16(&caps->system_power) * 1000000ULL;
+		break;
+	case 3:
+		val = get_unaligned_be16(&caps->n_cap) * 1000000ULL;
+		break;
+	case 4:
+		val = get_unaligned_be16(&caps->max) * 1000000ULL;
+		break;
+	case 5:
+		val = get_unaligned_be16(&caps->hard_min) * 1000000ULL;
+		break;
+	case 6:
+		val = get_unaligned_be16(&caps->user) * 1000000ULL;
+		break;
+	case 7:
+		val = caps->user_source;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_store_caps_user(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	u16 user_power_cap;
+	unsigned long long value;
+	struct occ *occ = dev_get_drvdata(dev);
+
+	rc = kstrtoull(buf, 0, &value);
+	if (rc)
+		return rc;
+
+	user_power_cap = div64_u64(value, 1000000ULL); /* microwatt to watt */
+
+	rc = occ_set_user_power_cap(occ, user_power_cap);
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static ssize_t occ_show_extended(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int rc;
+	struct extended_sensor *extn;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	extn = ((struct extended_sensor *)sensors->extended.data) +
+		sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		if (extn->flags & EXTN_FLAG_SENSOR_ID)
+			rc = snprintf(buf, PAGE_SIZE - 1, "%u",
+				      get_unaligned_be32(&extn->sensor_id));
+		else
+			rc = snprintf(buf, PAGE_SIZE - 1, "%02x%02x%02x%02x\n",
+				      extn->name[0], extn->name[1],
+				      extn->name[2], extn->name[3]);
+		break;
+	case 1:
+		rc = snprintf(buf, PAGE_SIZE - 1, "%02x\n", extn->flags);
+		break;
+	case 2:
+		rc = snprintf(buf, PAGE_SIZE - 1, "%02x%02x%02x%02x%02x%02x\n",
+			      extn->data[0], extn->data[1], extn->data[2],
+			      extn->data[3], extn->data[4], extn->data[5]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
 /* only need to do this once at startup, as OCC won't change sensors on us */
 static void occ_parse_poll_response(struct occ *occ)
 {
@@ -85,6 +703,9 @@ int occ_setup(struct occ *occ, const char *name)
 {
 	int rc;
 
+	mutex_init(&occ->lock);
+
+	/* no need to lock */
 	rc = occ_poll(occ);
 	if (rc == -ESHUTDOWN) {
 		dev_info(occ->bus_dev, "host is not ready\n");
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 0a7a107..e074251 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -3,6 +3,8 @@
 #ifndef OCC_COMMON_H
 #define OCC_COMMON_H
 
+#include <linux/mutex.h>
+
 struct device;
 
 #define OCC_RESP_DATA_BYTES		4089
@@ -80,8 +82,12 @@ struct occ {
 	struct occ_response resp;
 	struct occ_sensors sensors;
 
+	int powr_sample_time_us;	/* average power sample time */
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
+
+	unsigned long last_update;
+	struct mutex lock;		/* lock OCC access */
 };
 
 int occ_setup(struct occ *occ, const char *name);
diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
index e3326ff..e4c2c04 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -216,6 +216,7 @@ static int p8_i2c_occ_probe(struct i2c_client *client,
 	occ->bus_dev = &client->dev;
 	dev_set_drvdata(&client->dev, occ);
 
+	occ->powr_sample_time_us = 250;
 	occ->poll_cmd_data = 0x10;		/* P8 OCC poll data */
 	occ->send_cmd = p8_i2c_occ_send_cmd;
 
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 0ed5e22..b33f4fe 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -69,6 +69,7 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
 	occ->bus_dev = &pdev->dev;
 	platform_set_drvdata(pdev, occ);
 
+	occ->powr_sample_time_us = 500;
 	occ->poll_cmd_data = 0x20;		/* P9 OCC poll data */
 	occ->send_cmd = p9_sbe_occ_send_cmd;
 
-- 
1.8.3.1

