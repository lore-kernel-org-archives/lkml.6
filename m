Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeBZIeo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:34:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42467 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbeBZIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:34:39 -0500
X-Google-Smtp-Source: AH8x224Q/JbKpVCSUs83Ri0EITEtV4D3lkwOsKCb90zgl/scULTCtJQ4cu3MRf0cxbm6W1cutZWEtw==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        alexandre.belloni@free-electrons.com
Subject: [RESEND PATCH 3/3] rtc: Add one offset seconds to expand RTC range
Date: Mon, 26 Feb 2018 16:33:58 +0800
Message-Id: <ef6dae3f731f02136d72a691e23f3af0ff30b8fa.1519633350.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
In-Reply-To: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From our investigation for all RTC drivers, 1 driver will be expired before
year 2017, 7 drivers will be expired before year 2038, 23 drivers will be
expired before year 2069, 72 drivers will be expired before 2100 and 104
drivers will be expired before 2106. Especially for these early expired
drivers, we need to expand the RTC range to make the RTC can still work
after the expired year.

So we can expand the RTC range by adding one offset to the time when reading
from hardware, and subtracting it when writing back. For example, if you have
an RTC that can do 100 years, and currently is configured to be based in
Jan 1 1970, so it can represents times from 1970 to 2069. Then if you change
the start year from 1970 to 2000, which means it can represents times from
2000 to 2099. By adding or subtracting the offset produced by moving the wrap
point, all times between 1970 and 1999 from RTC hardware could get interpreted
as times from 2070 to 2099, but the interpretation of dates between 2000 and
2069 would not change.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/class.c     |   70 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/rtc/interface.c |   58 ++++++++++++++++++++++++++++++++++++++-
 include/linux/rtc.h     |    3 ++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 722d683..086a42b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -211,6 +211,73 @@ static int rtc_device_get_id(struct device *dev)
 	return id;
 }
 
+static void rtc_device_get_offset(struct rtc_device *rtc)
+{
+	time64_t range_secs;
+	u32 start_year;
+	int ret;
+
+	/*
+	 * If RTC driver did not implement the range of RTC hardware device,
+	 * then we can not expand the RTC range by adding or subtracting one
+	 * offset.
+	 */
+	if (rtc->range_min == rtc->range_max)
+		return;
+
+	ret = device_property_read_u32(rtc->dev.parent, "start-year",
+				       &start_year);
+	if (!ret) {
+		rtc->start_secs = mktime64(start_year, 1, 1, 0, 0, 0);
+		rtc->set_start_time = true;
+	}
+
+	/*
+	 * If user did not implement the start time for RTC driver, then no
+	 * need to expand the RTC range.
+	 */
+	if (!rtc->set_start_time)
+		return;
+
+	range_secs = rtc->range_max - rtc->range_min + 1;
+
+	/*
+	 * If the start_secs is larger than the maximum seconds (rtc->range_max)
+	 * supported by RTC hardware or the maximum seconds of new expanded
+	 * range (start_secs + rtc->range_max - rtc->range_min) is less than
+	 * rtc->range_min, which means the minimum seconds (rtc->range_min) of
+	 * RTC hardware will be mapped to start_secs by adding one offset, so
+	 * the offset seconds calculation formula should be:
+	 * rtc->offset_secs = rtc->start_secs - rtc->range_min;
+	 *
+	 * If the start_secs is larger than the minimum seconds (rtc->range_min)
+	 * supported by RTC hardware, then there is one region is overlapped
+	 * between the original RTC hardware range and the new expanded range,
+	 * and this overlapped region do not need to be mapped into the new
+	 * expanded range due to it is valid for RTC device. So the minimum
+	 * seconds of RTC hardware (rtc->range_min) should be mapped to
+	 * rtc->range_max + 1, then the offset seconds formula should be:
+	 * rtc->offset_secs = rtc->range_max - rtc->range_min + 1;
+	 *
+	 * If the start_secs is less than the minimum seconds (rtc->range_min),
+	 * which is similar to case 2. So the start_secs should be mapped to
+	 * start_secs + rtc->range_max - rtc->range_min + 1, then the
+	 * offset seconds formula should be:
+	 * rtc->offset_secs = -(rtc->range_max - rtc->range_min + 1);
+	 *
+	 * Otherwise the offset seconds should be 0.
+	 */
+	if (rtc->start_secs > rtc->range_max ||
+	    rtc->start_secs + range_secs - 1 < rtc->range_min)
+		rtc->offset_secs = rtc->start_secs - rtc->range_min;
+	else if (rtc->start_secs > rtc->range_min)
+		rtc->offset_secs = range_secs;
+	else if (rtc->start_secs < rtc->range_min)
+		rtc->offset_secs = -range_secs;
+	else
+		rtc->offset_secs = 0;
+}
+
 /**
  * rtc_device_register - register w/ RTC class
  * @dev: the device to register
@@ -247,6 +314,8 @@ struct rtc_device *rtc_device_register(const char *name, struct device *dev,
 
 	dev_set_name(&rtc->dev, "rtc%d", id);
 
+	rtc_device_get_offset(rtc);
+
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
 
@@ -435,6 +504,7 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc)
 		return -EINVAL;
 
 	rtc->owner = owner;
+	rtc_device_get_offset(rtc);
 
 	/* Check to see if there is an ALARM already set in hw */
 	err = __rtc_read_alarm(rtc, &alrm);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 25aebc5..6a0340b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -23,12 +23,61 @@
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
 
+static void rtc_add_offset(struct rtc_device *rtc, struct rtc_time *tm)
+{
+	time64_t secs;
+
+	if (!rtc->offset_secs)
+		return;
+
+	secs = rtc_tm_to_time64(tm);
+
+	/*
+	 * Since the reading time values from RTC device are always in the RTC
+	 * original valid range, but we need to skip the overlapped region
+	 * between expanded range and original range, which is no need to add
+	 * the offset.
+	 */
+	if ((rtc->start_secs > rtc->range_min && secs >= rtc->start_secs) ||
+	    (rtc->start_secs < rtc->range_min &&
+	     secs <= (rtc->start_secs + rtc->range_max - rtc->range_min)))
+		return;
+
+	rtc_time64_to_tm(secs + rtc->offset_secs, tm);
+}
+
+static void rtc_subtract_offset(struct rtc_device *rtc, struct rtc_time *tm)
+{
+	time64_t secs;
+
+	if (!rtc->offset_secs)
+		return;
+
+	secs = rtc_tm_to_time64(tm);
+
+	/*
+	 * If the setting time values are in the valid range of RTC hardware
+	 * device, then no need to subtract the offset when setting time to RTC
+	 * device. Otherwise we need to subtract the offset to make the time
+	 * values are valid for RTC hardware device.
+	 */
+	if (secs >= rtc->range_min && secs <= rtc->range_max)
+		return;
+
+	rtc_time64_to_tm(secs - rtc->offset_secs, tm);
+}
+
 static int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
 {
 	if (rtc->range_min != rtc->range_max) {
 		time64_t time = rtc_tm_to_time64(tm);
+		time64_t range_min = rtc->set_start_time ? rtc->start_secs :
+			rtc->range_min;
+		time64_t range_max = rtc->set_start_time ?
+			(rtc->start_secs + rtc->range_max - rtc->range_min) :
+			rtc->range_max;
 
-		if (time < rtc->range_min || time > rtc->range_max)
+		if (time < range_min || time > range_max)
 			return -ERANGE;
 	}
 
@@ -51,6 +100,8 @@ static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 			return err;
 		}
 
+		rtc_add_offset(rtc, tm);
+
 		err = rtc_valid_tm(tm);
 		if (err < 0)
 			dev_dbg(&rtc->dev, "read_time: rtc_time isn't valid\n");
@@ -86,6 +137,8 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	if (err)
 		return err;
 
+	rtc_subtract_offset(rtc, tm);
+
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
@@ -143,6 +196,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
 
 	mutex_unlock(&rtc->ops_lock);
 
+	rtc_add_offset(rtc, &alarm->time);
 	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }
@@ -355,6 +409,8 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 	if (err)
 		return err;
+
+	rtc_subtract_offset(rtc, &alarm->time);
 	scheduled = rtc_tm_to_time64(&alarm->time);
 
 	/* Make sure we're not setting alarms in the past */
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 8560282..f63add6 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -153,6 +153,9 @@ struct rtc_device {
 
 	time64_t range_min;
 	time64_t range_max;
+	time64_t start_secs;
+	time64_t offset_secs;
+	bool set_start_time;
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	struct work_struct uie_task;
-- 
1.7.9.5
