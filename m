Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7210020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg9R9lei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7210020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLFTWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:22:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45452 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeLFTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:22:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so600813plm.12;
        Thu, 06 Dec 2018 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHtfZSw3bJfTY14XL6gwOVvioUlUAVqgYjInTtQFuvs=;
        b=Hg9R9lei56uOl6H+jNdr2q2tXqZ6v9glViav7QsnxrDOGOYySjdzF62n8Katr2LIXM
         sqephNh2ooL3bXIhpYu/fpURVDwYCxcU3pFFCDvH4REKQYhIvyWeNygW4qqzkkp5iw5m
         Gkgo0VvBBBRpZDE1nR0k0y7oRbByTXtLvRiU+4kRQjRqzkC61Vat2oDq4Gi82yxT77Xh
         FoGjBktg6w5pFRe2YcZ35q7bgujkV0X/qPOuLGM06EJU8pn2e71dP1aVUPYab5i2rimO
         UH80ik1Ovaco0eTkysVZwVTc+tYofvYuklIKg0omx5y3WKVEx3H5p3tHSvelof7LEJO2
         lYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=yHtfZSw3bJfTY14XL6gwOVvioUlUAVqgYjInTtQFuvs=;
        b=Yuhfyw3VauW6rF7tvebKJTtqXR8pgt5EWYYDvby+Abe43F5xZhm2USgmSXhOBEyFzo
         8Rm/V/29i7zdL4GlE4j3lz2T7eZEAVs7bT2Bi2R8yM5VAzaObGrUo4ryIh/OD+lCDmdi
         jbso3UBJKRk4Eu/6Ma3ZY/vtKJ5+U1pFdgKZ8H33wp/Sn95u1HKenouO3TMi6plpP2GC
         3i5mAXFU6oIFYxiDbeWSaP1xA7S1NzeDHxaPDcyMcUI7hueCGunTNuvS0RrxsgezeJSh
         RX0mf5Y5uVi8CG709BRr3jOMNL9e2yJk2H6TH/eFgISH5U5mNkzJftCmqRzvcIv7a9Oa
         WIcg==
X-Gm-Message-State: AA+aEWZBsEa/LxMRKugOo86uz2BWO3XfEM7u11RFykHhGPcXG6Ef9C2K
        1jcSU5DZpHM7NEE3ueoPkGkLTiHU
X-Google-Smtp-Source: AFSGD/XcbPSdsnwp6L7tBE4WBxfpqVcM7oFF6ef9SQGwbxyNNZalpwX8FXZKuyvZwC4+2YJq5AB7EA==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr29769328plb.244.1544124159862;
        Thu, 06 Dec 2018 11:22:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l184sm1582952pfc.112.2018.12.06.11.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:22:39 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH (resend) 01/13] hwmon: Introduce SENSOR_DEVICE_ATTR_{RO, RW, WO} and variants
Date:   Thu,  6 Dec 2018 11:22:21 -0800
Message-Id: <1544124153-23961-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
References: <1544124153-23961-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce SENSOR_DEVICE_ATTR_{RO,RW,WO} and SENSOR_DEVICE_ATTR_2_{RO,RW,WO}
as simplified variants of SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 to
simplify the source code, improve readbility, and reduce the chance of
inconsistencies.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/hwmon-kernel-api.txt | 24 +++++++++++++-------
 include/linux/hwmon-sysfs.h              | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/hwmon/hwmon-kernel-api.txt
index eb7a78aebb38..8bdefb41be30 100644
--- a/Documentation/hwmon/hwmon-kernel-api.txt
+++ b/Documentation/hwmon/hwmon-kernel-api.txt
@@ -299,17 +299,25 @@ functions is used.
 The header file linux/hwmon-sysfs.h provides a number of useful macros to
 declare and use hardware monitoring sysfs attributes.
 
-In many cases, you can use the exsting define DEVICE_ATTR to declare such
-attributes. This is feasible if an attribute has no additional context. However,
-in many cases there will be additional information such as a sensor index which
-will need to be passed to the sysfs attribute handling function.
+In many cases, you can use the exsting define DEVICE_ATTR or its variants
+DEVICE_ATTR_{RW,RO,WO} to declare such attributes. This is feasible if an
+attribute has no additional context. However, in many cases there will be
+additional information such as a sensor index which will need to be passed
+to the sysfs attribute handling function.
 
 SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 can be used to define attributes
 which need such additional context information. SENSOR_DEVICE_ATTR requires
 one additional argument, SENSOR_DEVICE_ATTR_2 requires two.
 
-SENSOR_DEVICE_ATTR defines a struct sensor_device_attribute variable.
-This structure has the following fields.
+Simplified variants of SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 are available
+and should be used if standard attribute permissions and function names are
+feasible. Standard permissions are 0644 for SENSOR_DEVICE_ATTR[_2]_RW,
+0444 for SENSOR_DEVICE_ATTR[_2]_RO, and 0200 for SENSOR_DEVICE_ATTR[_2]_WO.
+Standard functions, similar to DEVICE_ATTR_{RW,RO,WO}, have _show and _store
+appended to the provided function name.
+
+SENSOR_DEVICE_ATTR and its variants define a struct sensor_device_attribute
+variable. This structure has the following fields.
 
 struct sensor_device_attribute {
 	struct device_attribute dev_attr;
@@ -320,8 +328,8 @@ You can use to_sensor_dev_attr to get the pointer to this structure from the
 attribute read or write function. Its parameter is the device to which the
 attribute is attached.
 
-SENSOR_DEVICE_ATTR_2 defines a struct sensor_device_attribute_2 variable,
-which is defined as follows.
+SENSOR_DEVICE_ATTR_2 and its variants define a struct sensor_device_attribute_2
+variable, which is defined as follows.
 
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index 1c7b89ae6bdc..473897bbd898 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -33,10 +33,28 @@ struct sensor_device_attribute{
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .index = _index }
 
+#define SENSOR_ATTR_RO(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0444, _func##_show, NULL, _index)
+
+#define SENSOR_ATTR_RW(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+
+#define SENSOR_ATTR_WO(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0200, NULL, _func##_store, _index)
+
 #define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
 struct sensor_device_attribute sensor_dev_attr_##_name		\
 	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
 
+#define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
+
+#define SENSOR_DEVICE_ATTR_RW(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+
+#define SENSOR_DEVICE_ATTR_WO(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store, _index)
+
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
 	u8 index;
@@ -50,8 +68,29 @@ struct sensor_device_attribute_2 {
 	  .index = _index,					\
 	  .nr = _nr }
 
+#define SENSOR_ATTR_2_RO(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0444, _func##_show, NULL, _nr, _index)
+
+#define SENSOR_ATTR_2_RW(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0644, _func##_show, _func##_store, _nr, _index)
+
+#define SENSOR_ATTR_2_WO(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0200, NULL, _func##_store, _nr, _index)
+
 #define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
 struct sensor_device_attribute_2 sensor_dev_attr_##_name		\
 	= SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)
 
+#define SENSOR_DEVICE_ATTR_2_RO(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0444, _func##_show, NULL,		\
+			     _nr, _index)
+
+#define SENSOR_DEVICE_ATTR_2_RW(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0644, _func##_show, _func##_store,	\
+			     _nr, _index)
+
+#define SENSOR_DEVICE_ATTR_2_WO(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0200, NULL, _func##_store,		\
+			     _nr, _index)
+
 #endif /* _LINUX_HWMON_SYSFS_H */
-- 
2.7.4

