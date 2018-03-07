Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934512AbeCGWoV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:44:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56430 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933743AbeCGWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:44:18 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: Add RTC range
Date: Wed,  7 Mar 2018 23:44:02 +0100
Message-Id: <20180307224403.18315-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way for drivers to inform the core of the supported date/time range.
The core can then check whether the date/time or alarm is in the range
before calling ->set_time, ->set_mmss or ->set_alarm. It returns -ERANGE
when the time is out of range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/ABI/testing/sysfs-class-rtc |  8 ++++++++
 drivers/rtc/interface.c                   | 14 ++++++++++++++
 drivers/rtc/rtc-sysfs.c                   | 12 ++++++++++++
 include/linux/rtc.h                       |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-rtc b/Documentation/ABI/testing/sysfs-class-rtc
index 792a38300336..95984289a4ee 100644
--- a/Documentation/ABI/testing/sysfs-class-rtc
+++ b/Documentation/ABI/testing/sysfs-class-rtc
@@ -43,6 +43,14 @@ Contact:	linux-rtc@vger.kernel.org
 Description:
 		(RO) The name of the RTC corresponding to this sysfs directory
 
+What:		/sys/class/rtc/rtcX/range
+Date:		January 2018
+KernelVersion:	4.16
+Contact:	linux-rtc@vger.kernel.org
+Description:
+		Valid time range for the RTC, as seconds from epoch, formatted
+		as [min, max]
+
 What:		/sys/class/rtc/rtcX/since_epoch
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7e253be19ba7..c068daebeec2 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -70,6 +70,13 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	if (err != 0)
 		return err;
 
+	if (rtc->range_min != rtc->range_max) {
+		time64_t time = rtc_tm_to_time64(tm);
+
+		if (time < rtc->range_min || time > rtc->range_max)
+			return -ERANGE;
+	}
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
@@ -374,6 +381,13 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err != 0)
 		return err;
 
+	if (rtc->range_min != rtc->range_max) {
+		time64_t time = rtc_tm_to_time64(&alarm->time);
+
+		if (time < rtc->range_min || time > rtc->range_max)
+			return -ERANGE;
+	}
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 92ff2edb86a6..454da38c6012 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -248,6 +248,14 @@ offset_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(offset);
 
+static ssize_t
+range_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "[%lld,%llu]\n", to_rtc_device(dev)->range_min,
+		       to_rtc_device(dev)->range_max);
+}
+static DEVICE_ATTR_RO(range);
+
 static struct attribute *rtc_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_date.attr,
@@ -257,6 +265,7 @@ static struct attribute *rtc_attrs[] = {
 	&dev_attr_hctosys.attr,
 	&dev_attr_wakealarm.attr,
 	&dev_attr_offset.attr,
+	&dev_attr_range.attr,
 	NULL,
 };
 
@@ -286,6 +295,9 @@ static umode_t rtc_attr_is_visible(struct kobject *kobj,
 	} else if (attr == &dev_attr_offset.attr) {
 		if (!rtc->ops->set_offset)
 			mode = 0;
+	} else if (attr == &dev_attr_range.attr) {
+		if (!(rtc->range_max - rtc->range_min))
+			mode = 0;
 	}
 
 	return mode;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 3b65b201169c..c78528c394e5 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -150,6 +150,9 @@ struct rtc_device {
 	bool nvram_old_abi;
 	struct bin_attribute *nvram;
 
+	time64_t range_min;
+	timeu64_t range_max;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
 	struct timer_list uie_timer;
-- 
2.16.2
