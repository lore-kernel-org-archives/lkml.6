Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeEGK0f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:26:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752162AbeEGKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:25:55 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit sensors
Date: Mon,  7 May 2018 15:55:37 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050710-0020-0000-0000-00000419E365
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050710-0021-0000-0000-000042AF157C
Message-Id: <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware has supported for reading sensor values of size u32.
This patch adds support to use newer firmware functions which allows
to read the sensors of size u64.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/hwmon/ibmpowernv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 5ccdd0b..74d9b5a 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -101,9 +101,10 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
 						 dev_attr);
 	ssize_t ret;
-	u32 x;
+	u64 x;
+
+	ret =  opal_get_sensor_data_u64(sdata->id, &x);
 
-	ret = opal_get_sensor_data(sdata->id, &x);
 	if (ret)
 		return ret;
 
@@ -114,7 +115,7 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	else if (sdata->type == POWER_INPUT)
 		x *= 1000000;
 
-	return sprintf(buf, "%u\n", x);
+	return sprintf(buf, "%llu\n", x);
 }
 
 static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
-- 
1.8.3.1
