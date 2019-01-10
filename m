Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C001AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBA8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfAJCSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:18:32 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:44274 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbfAJCSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:18:32 -0500
X-ASG-Debug-ID: 1547086708-093b7e40ef08200001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id bHrQp20U7sqk4WWf (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 10 Jan 2019 10:18:28 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from openbmc001.localdomain (10.5.21.169) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 10:18:21 +0800
From:   Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <dongsheng.wang@hxt-semitech.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shunyong.yang@hxt-semitech.com>,
        Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Subject: [PATCH v3 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
Date:   Thu, 10 Jan 2019 10:18:20 +0800
X-ASG-Orig-Subj: [PATCH v3 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
Message-ID: <77c9f6f45c85cfb17062fd6a0a608d4903894a4c.1546918172.git.xiaoting.liu@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.169]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547086708
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9940 1.0000 4.2728
X-Barracuda-Spam-Score: 4.27
X-Barracuda-Spam-Status: No, SCORE=4.27 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65431
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code compares device name with name in i2c_device_id to decide
whether PMBUS_SKIP_STATUS_CHECK should be set in pmbus_platform_data,
which makes adding new devices with PMBUS_SKIP_STATUS_CHECK should also
modify code in pmbus_probe().

This patch adds pmbus_device_info to save pages and flags. Its pointer
is put in driver_data of i2c_device_id, which makes adding new device
more straightforward.

Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
---
v3:
  Remove an empty line.
---
v2:
  Move struct pmbus_device_info definition location from pmbus.h to pmbus.c. 
  Change struct name from default_pmbus_info to pmbus_info_one.
  Change struct name from pmbus_info to pmbus_info_zero.
  Replace struct name dps460_pmbus_info and sgd009_pmbus_info with
  pmbus_info_one_skip.
---
 drivers/hwmon/pmbus/pmbus.c | 54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 7688dab32f6e..ef845a1310fa 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -28,6 +28,11 @@
 #include <linux/pmbus.h>
 #include "pmbus.h"
 
+struct pmbus_device_info {
+	int pages;
+	u32 flags;
+};
+
 /*
  * Find sensor groups and status registers on each page.
  */
@@ -172,13 +177,14 @@ static int pmbus_probe(struct i2c_client *client,
 	struct pmbus_driver_info *info;
 	struct pmbus_platform_data *pdata = NULL;
 	struct device *dev = &client->dev;
+	struct pmbus_device_info *device_info;
 
 	info = devm_kzalloc(dev, sizeof(struct pmbus_driver_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	if (!strcmp(id->name, "dps460") || !strcmp(id->name, "dps800") ||
-	    !strcmp(id->name, "sgd009")) {
+	device_info = (struct pmbus_device_info *)id->driver_data;
+	if (device_info->flags & PMBUS_SKIP_STATUS_CHECK) {
 		pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
 				     GFP_KERNEL);
 		if (!pdata)
@@ -187,36 +193,40 @@ static int pmbus_probe(struct i2c_client *client,
 		pdata->flags = PMBUS_SKIP_STATUS_CHECK;
 	}
 
-	info->pages = id->driver_data;
+	info->pages = device_info->pages;
 	info->identify = pmbus_identify;
 	dev->platform_data = pdata;
 
 	return pmbus_do_probe(client, id, info);
 }
 
+static const struct pmbus_device_info pmbus_info_one = {1, 0};
+static const struct pmbus_device_info pmbus_info_zero = {0, 0};
+static const struct pmbus_device_info pmbus_info_one_skip = {
+				1, PMBUS_SKIP_STATUS_CHECK};
 /*
  * Use driver_data to set the number of pages supported by the chip.
  */
 static const struct i2c_device_id pmbus_id[] = {
-	{"adp4000", 1},
-	{"bmr453", 1},
-	{"bmr454", 1},
-	{"dps460", 1},
-	{"dps800", 1},
-	{"mdt040", 1},
-	{"ncp4200", 1},
-	{"ncp4208", 1},
-	{"pdt003", 1},
-	{"pdt006", 1},
-	{"pdt012", 1},
-	{"pmbus", 0},
-	{"sgd009", 1},
-	{"tps40400", 1},
-	{"tps544b20", 1},
-	{"tps544b25", 1},
-	{"tps544c20", 1},
-	{"tps544c25", 1},
-	{"udt020", 1},
+	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
+	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
+	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
+	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
+	{"mdt040", (kernel_ulong_t)&pmbus_info_one},
+	{"ncp4200", (kernel_ulong_t)&pmbus_info_one},
+	{"ncp4208", (kernel_ulong_t)&pmbus_info_one},
+	{"pdt003", (kernel_ulong_t)&pmbus_info_one},
+	{"pdt006", (kernel_ulong_t)&pmbus_info_one},
+	{"pdt012", (kernel_ulong_t)&pmbus_info_one},
+	{"pmbus", (kernel_ulong_t)&pmbus_info_zero},
+	{"sgd009", (kernel_ulong_t)&pmbus_info_one_skip},
+	{"tps40400", (kernel_ulong_t)&pmbus_info_one},
+	{"tps544b20", (kernel_ulong_t)&pmbus_info_one},
+	{"tps544b25", (kernel_ulong_t)&pmbus_info_one},
+	{"tps544c20", (kernel_ulong_t)&pmbus_info_one},
+	{"tps544c25", (kernel_ulong_t)&pmbus_info_one},
+	{"udt020", (kernel_ulong_t)&pmbus_info_one},
 	{}
 };

-- 
1.8.3.1

