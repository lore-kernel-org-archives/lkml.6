Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06683C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DC6240BD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DC6240BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeGENvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:51:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753782AbeGENvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:51:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65DnFxe108026
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 09:51:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1jka5qu1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:51:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 14:51:47 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 14:51:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65DpifQ38207642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 13:51:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEA9752052;
        Thu,  5 Jul 2018 16:52:08 +0100 (BST)
Received: from oc4502181600.ibm.com (unknown [9.79.199.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 06A5052057;
        Thu,  5 Jul 2018 16:52:06 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     linux@roeck-us.net, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
Date:   Thu,  5 Jul 2018 19:21:28 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070513-0028-0000-0000-000002D882C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070513-0029-0000-0000-000023900FC3
Message-Id: <1530798689-27742-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
which measures various system and chip level sensors. These sensors
comprises of environmental sensors (like power, temperature, current
and voltage) and performance sensors (like utilization, frequency).
All these sensors are copied to main memory at a regular interval of
100ms. OCC provides a way to select a group of sensors that is copied
to the main memory to increase the update frequency of selected sensor
groups. When a sensor-group is disabled, OCC will not copy it to main
memory and those sensors read 0 values.

This patch provides support for enabling/disabling the sensor groups
like power, temperature, current and voltage. This patch adds new
per-senor sysfs attribute to disable and enable them.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v2:
- Writes to first 'enable' attribute of the sensor group will affect all the
  sensors in the group
- Removed global mutex and made it per sensor-group

 drivers/hwmon/ibmpowernv.c | 184 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 155 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index f829dad..9c6adee 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -73,6 +73,10 @@ enum sensors {
 	struct attribute_group group;
 	u32 attr_count;
 	u32 hwmon_index;
+	struct mutex mutex;
+	u32 *gid;
+	u32 nr_gid;
+	bool enable;
 } sensor_groups[] = {
 	{ "fan"   },
 	{ "temp"  },
@@ -105,6 +109,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	ssize_t ret;
 	u64 x;
 
+	if (!sensor_groups[sdata->type].enable)
+		return -ENODATA;
+
 	ret =  opal_get_sensor_data_u64(sdata->id, &x);
 
 	if (ret)
@@ -120,6 +127,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%llu\n", x);
 }
 
+static ssize_t show_enable(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+
+	return sprintf(buf, "%u\n", sensor_groups[sdata->type].enable);
+}
+
+static ssize_t store_enable(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+	struct sensor_group *sg = &sensor_groups[sdata->type];
+	int ret, i;
+	bool data;
+
+	ret = kstrtobool(buf, &data);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&sg->mutex);
+	if (ret)
+		return ret;
+
+	if (data != sg->enable)
+		for (i = 0; i < sg->nr_gid && !ret; i++)
+			ret =  sensor_group_enable(sg->gid[i], data);
+
+	if (!ret) {
+		sg->enable = data;
+		ret = count;
+	}
+
+	mutex_unlock(&sg->mutex);
+	return ret;
+}
+
 static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
@@ -292,13 +339,68 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
 	return ++sensor_groups[sdata->type].hwmon_index;
 }
 
+static int init_sensor_group_data(struct platform_device *pdev)
+{
+	struct device_node *groups, *sg;
+	enum sensors type;
+	int ret = 0, i;
+
+	for (i = 0; i < MAX_SENSOR_TYPE; i++) {
+		sensor_groups[i].nr_gid = 0;
+		sensor_groups[i].enable = true;
+	}
+
+	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
+	if (!groups)
+		return ret;
+
+	for (i = 0; i < MAX_SENSOR_TYPE; i++) {
+		u32 gid[256];
+		u32 id, size;
+
+		for_each_child_of_node(groups, sg) {
+			type = get_sensor_type(sg);
+			if (type != i)
+				continue;
+
+			if (of_property_read_u32(sg, "sensor-group-id", &id))
+				continue;
+
+			gid[sensor_groups[i].nr_gid++] = id;
+		}
+
+		if (!sensor_groups[i].nr_gid)
+			continue;
+
+		size = sensor_groups[i].nr_gid * sizeof(u32);
+		sensor_groups[i].gid = devm_kzalloc(&pdev->dev, size,
+						    GFP_KERNEL);
+		if (!sensor_groups[i].gid) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy(sensor_groups[i].gid, gid, size);
+		sensor_groups[i].enable = false;
+		mutex_init(&sensor_groups[i].mutex);
+	}
+
+	of_node_put(groups);
+	return ret;
+}
+
 static int populate_attr_groups(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
+	int ret;
 	enum sensors type;
 
+	ret = init_sensor_group_data(pdev);
+	if (ret)
+		return ret;
+
 	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
 		const char *label;
@@ -313,7 +415,7 @@ static int populate_attr_groups(struct platform_device *pdev)
 		sensor_groups[type].attr_count++;
 
 		/*
-		 * add attributes for labels, min and max
+		 * add attributes for labels, min, max and enable
 		 */
 		if (!of_property_read_string(np, "label", &label))
 			sensor_groups[type].attr_count++;
@@ -321,6 +423,8 @@ static int populate_attr_groups(struct platform_device *pdev)
 			sensor_groups[type].attr_count++;
 		if (of_find_property(np, "sensor-data-max", NULL))
 			sensor_groups[type].attr_count++;
+		if (sensor_groups[type].nr_gid)
+			sensor_groups[type].attr_count++;
 	}
 
 	of_node_put(opal);
@@ -344,7 +448,10 @@ static int populate_attr_groups(struct platform_device *pdev)
 static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
 			      ssize_t (*show)(struct device *dev,
 					      struct device_attribute *attr,
-					      char *buf))
+					      char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count))
 {
 	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
 		 sensor_groups[sdata->type].name, sdata->hwmon_index,
@@ -352,8 +459,13 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
 
 	sysfs_attr_init(&sdata->dev_attr.attr);
 	sdata->dev_attr.attr.name = sdata->name;
-	sdata->dev_attr.attr.mode = S_IRUGO;
 	sdata->dev_attr.show = show;
+	if (store) {
+		sdata->dev_attr.store = store;
+		sdata->dev_attr.attr.mode = 0664;
+	} else {
+		sdata->dev_attr.attr.mode = 0444;
+	}
 }
 
 static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
@@ -361,13 +473,16 @@ static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
 			    const struct attribute_group *pgroup,
 			    ssize_t (*show)(struct device *dev,
 					    struct device_attribute *attr,
-					    char *buf))
+					    char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count))
 {
 	sdata->id = sid;
 	sdata->type = type;
 	sdata->opal_index = od;
 	sdata->hwmon_index = hd;
-	create_hwmon_attr(sdata, attr_name, show);
+	create_hwmon_attr(sdata, attr_name, show, store);
 	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
 }
 
@@ -408,18 +523,16 @@ static int create_device_attrs(struct platform_device *pdev)
 	u32 count = 0;
 	int err = 0;
 
-	opal = of_find_node_by_path("/ibm,opal/sensors");
 	sdata = devm_kcalloc(&pdev->dev,
 			     pdata->sensors_count, sizeof(*sdata),
 			     GFP_KERNEL);
-	if (!sdata) {
-		err = -ENOMEM;
-		goto exit_put_node;
-	}
+	if (!sdata)
+		return -ENOMEM;
 
+	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
 		const char *attr_name;
-		u32 opal_index;
+		u32 opal_index, hw_id;
 		const char *label;
 
 		if (np->name == NULL)
@@ -456,14 +569,11 @@ static int create_device_attrs(struct platform_device *pdev)
 			opal_index = INVALID_INDEX;
 		}
 
-		sdata[count].opal_index = opal_index;
-		sdata[count].hwmon_index =
-			get_sensor_hwmon_index(&sdata[count], sdata, count);
-
-		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
-
-		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
-				&sdata[count++].dev_attr.attr;
+		hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
+		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
+				attr_name, type, pgroups[type], show_sensor,
+				NULL);
+		count++;
 
 		if (!of_property_read_string(np, "label", &label)) {
 			/*
@@ -474,33 +584,49 @@ static int create_device_attrs(struct platform_device *pdev)
 			 */
 
 			make_sensor_label(np, &sdata[count], label);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, "label", type, pgroups[type],
-					show_label);
+					show_label, NULL);
 			count++;
 		}
 
 		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
 			attr_name = get_max_attr(type);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, attr_name, type,
-					pgroups[type], show_sensor);
+					pgroups[type], show_sensor, NULL);
 			count++;
 		}
 
 		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
 			attr_name = get_min_attr(type);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, attr_name, type,
-					pgroups[type], show_sensor);
+					pgroups[type], show_sensor, NULL);
 			count++;
 		}
+
+		if (sensor_groups[type].nr_gid) {
+			ssize_t (*store)(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count);
+
+			if (!sensor_groups[type].enable) {
+				sensor_groups[type].enable = true;
+				store = store_enable;
+			} else {
+				store = NULL;
+			}
+
+			sensor_groups[type].enable = true;
+			populate_sensor(&sdata[count], opal_index, hw_id,
+					sensor_id, "enable", type,
+					pgroups[type], show_enable, store);
+			count++;
+		}
+
 	}
 
-exit_put_node:
 	of_node_put(opal);
 	return err;
 }
-- 
1.8.3.1

