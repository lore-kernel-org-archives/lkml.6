Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934904AbeB1VUF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:20:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52159 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933074AbeB1VUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:20:03 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: nvmem: allow registering the nvmem device before the rtc
Date: Wed, 28 Feb 2018 22:19:58 +0100
Message-Id: <20180228211958.10044-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the parent of the nvmem device to the parent of the rtc device so it
can be registered before the RTC.

This is a small change in the ABI as the nvmem moves out of the
/sys/class/rtc/rtcX folder to be under the parent device folder (that is
where the previous nvram files where registered).

However, it is still available under its correct location,
/sys/bus/nvmem/devices which is the one that should be used by userspace
applications.

The other benefit is that the nvmem device can stay registered even if the
rtc registration fails. Or it is possible to not register the rtc if the
nvmem registration failed.

Finally, it makes a lot of sense for devices that actually have different
i2c or spi addresses for the RTC and the EEPROM. That is basically how it
would end up when using MFD or even completely separate devices.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/ABI/testing/sysfs-class-rtc | 8 --------
 drivers/rtc/class.c                       | 5 +++--
 drivers/rtc/nvmem.c                       | 2 +-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rtc b/Documentation/ABI/testing/sysfs-class-rtc
index 65270d95873c..792a38300336 100644
--- a/Documentation/ABI/testing/sysfs-class-rtc
+++ b/Documentation/ABI/testing/sysfs-class-rtc
@@ -57,14 +57,6 @@ Contact:	linux-rtc@vger.kernel.org
 Description:
 		(RO) RTC-provided time in 24-hour notation (hh:mm:ss)
 
-What:		/sys/class/rtc/rtcX/*/nvmem
-Date:		July 2017
-KernelVersion:	4.13
-Contact:	linux-rtc@vger.kernel.org
-Description:
-		(RW) The non volatile storage exported as a raw file, as
-		described in Documentation/nvmem/nvmem.txt
-
 What:		/sys/class/rtc/rtcX/offset
 Date:		February 2016
 KernelVersion:	4.6
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 999ed039da0d..5a5ab4fa14f9 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -293,8 +293,6 @@ EXPORT_SYMBOL_GPL(rtc_device_register);
  */
 void rtc_device_unregister(struct rtc_device *rtc)
 {
-	rtc_nvmem_unregister(rtc);
-
 	mutex_lock(&rtc->ops_lock);
 	/*
 	 * Remove innards of this RTC, then disable it, before
@@ -312,6 +310,7 @@ static void devm_rtc_device_release(struct device *dev, void *res)
 {
 	struct rtc_device *rtc = *(struct rtc_device **)res;
 
+	rtc_nvmem_unregister(rtc);
 	rtc_device_unregister(rtc);
 }
 
@@ -382,6 +381,8 @@ static void devm_rtc_release_device(struct device *dev, void *res)
 {
 	struct rtc_device *rtc = *(struct rtc_device **)res;
 
+	rtc_nvmem_unregister(rtc);
+
 	if (rtc->registered)
 		rtc_device_unregister(rtc);
 	else
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 3a02357eb783..17ec4c8d0fad 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -91,7 +91,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 	if (!nvmem_config)
 		return -ENODEV;
 
-	nvmem_config->dev = &rtc->dev;
+	nvmem_config->dev = rtc->dev.parent;
 	nvmem_config->owner = rtc->owner;
 	rtc->nvmem = nvmem_register(nvmem_config);
 	if (IS_ERR_OR_NULL(rtc->nvmem))
-- 
2.16.2
