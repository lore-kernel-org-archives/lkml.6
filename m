Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA45C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6805B2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6805B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbeJBUUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:20:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbeJBUUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:30 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D0219D9;
        Tue,  2 Oct 2018 13:37:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lothar Felten <lothar.felten@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 88/94] hwmon: (ina2xx) fix sysfs shunt resistor read access
Date:   Tue,  2 Oct 2018 06:25:42 -0700
Message-Id: <20181002132506.620363058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lothar Felten <lothar.felten@gmail.com>

[ Upstream commit 3ad867001c91657c46dcf6656d52eb6080286fd5 ]

fix the sysfs shunt resistor read access: return the shunt resistor
value, not the calibration register contents.

update email address

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/hwmon/ina2xx           |    2 +-
 drivers/hwmon/ina2xx.c               |   13 +++++++++++--
 include/linux/platform_data/ina2xx.h |    2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -32,7 +32,7 @@ Supported chips:
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/
 
-Author: Lothar Felten <l-felten@ti.com>
+Author: Lothar Felten <lothar.felten@gmail.com>
 
 Description
 -----------
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -17,7 +17,7 @@
  * Bi-directional Current/Power Monitor with I2C Interface
  * Datasheet: http://www.ti.com/product/ina230
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
  *
  * This program is free software; you can redistribute it and/or modify
@@ -328,6 +328,15 @@ static int ina2xx_set_shunt(struct ina2x
 	return 0;
 }
 
+static ssize_t ina2xx_show_shunt(struct device *dev,
+			      struct device_attribute *da,
+			      char *buf)
+{
+	struct ina2xx_data *data = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%li\n", data->rshunt);
+}
+
 static ssize_t ina2xx_store_shunt(struct device *dev,
 				  struct device_attribute *da,
 				  const char *buf, size_t count)
@@ -402,7 +411,7 @@ static SENSOR_DEVICE_ATTR(power1_input,
 
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_store_shunt,
+			  ina2xx_show_shunt, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
 
 /* update interval (ina226 only) */
--- a/include/linux/platform_data/ina2xx.h
+++ b/include/linux/platform_data/ina2xx.h
@@ -1,7 +1,7 @@
 /*
  * Driver for Texas Instruments INA219, INA226 power monitor chips
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as


