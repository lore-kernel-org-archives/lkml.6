Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B28C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D20E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hGPdpCY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfBVXLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:11:48 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38681 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfBVXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:11:48 -0500
Received: by mail-it1-f193.google.com with SMTP id l66so5692259itg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ejAij+LthIUMef01ylMky/Ikzy5VZ9IWjdkqWJyFuE=;
        b=hGPdpCY+B6ML4Wcae4L52L650PGPw4kI/eIgkvLWCXk90eGe9a9yCfBt9sbqVzVxE/
         HHT/1K5G1uAG+eMevZrcydSITf0K4O7nBDIg2bnE4lXRsr3MrwN0AAlyErJYBLro7aVj
         uBQxKTmISFVXZJrxSMwaQp7SijPOcFAPh0qyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ejAij+LthIUMef01ylMky/Ikzy5VZ9IWjdkqWJyFuE=;
        b=F306lt60jWZYRD3tu4sFijAvH7S+kTBblBSX7oOmFYFY8F5UQr3jk19h84E0cVU5kl
         afK1c5pyTrFOYtfWgzg866o0AB5fua0tAicwHe/n+jd3w7nd/ty/+jqP4n9NBMX8vK6w
         bd8f6TNFxcBnWGSSRznBPzxbh7g5BwKUb1bxkF01qncwNQnlWPOzUVb/VDu5Q8x9yBI4
         AVsgIptPUDwMXgOqLjUjXu6v5HA6nsObmdNYhTnlvShZEgGNJ2cE7lDYHbudwGSbYDdk
         8vNEcjrhvEHfGuDJgcw5Xsl4pTVEIhhNTPAH+CZhCG5XHGSz8QBz1Ah2aqBSv/sQONLd
         eGxA==
X-Gm-Message-State: AHQUAuZZplzcXCZZQdhEa8RdtWAX6oXeTdxpW+6SQBRVeompae95Zb5p
        l5Pb96tNKeDW87QWEOI0hsxWww==
X-Google-Smtp-Source: AHgI3Ia+KzxxxUpZJrDK/xHwGWwg9723JedY34tyPzx8cPJhXz+94iCrZKPjmzWAw6XNZA+zvBsdoA==
X-Received: by 2002:a24:5385:: with SMTP id n127mr3786369itb.134.1550877107532;
        Fri, 22 Feb 2019 15:11:47 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id g74sm1363868itg.29.2019.02.22.15.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Feb 2019 15:11:46 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [RFC power_supply 1/2] power_supply: Add Peak Shift and Adv Batt Charging support
Date:   Fri, 22 Feb 2019 16:10:34 -0700
Message-Id: <20190222231033.102337-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add several new standard properties to the power supply subsystem
and sysfs support for them. These policies are supported on several
kinds of devices, including Lenovo and Dell. I am adding this in
particular for a new Chrome OS device. All dates and times are expected
to be in local time. Thus, the individual driver that implements these
features is responsible for maintaining the schedule. This might entail
scheduling events in the kernel that send commands to the power
controller in the device at the proper times, or, if the power
controller has its  own RTC and keeps track of the time, then the user
is responsible for ensuring that the power controller's RTC stays in
sync with the local time, even through changes such as time zone shifts
or daylight savings beginning or ending.

Peak Shift is power saving policy that minimizes AC usage during the
peak usage times during the day. For each weekday a start and end time
to run in Peak Shift mode can be set. During these times the system will
run from the battery even if the AC is attached as long as the battery
stays above the threshold specified. After the end time specified the
system will run from AC if attached but will not charge the battery. The
system will again function normally using AC and recharging the battery
after the specified Charge Start time.

Advanced Charging Mode allows the user to maximize the battery health.
In Advanced Charging Mode the system will use standard charging
algorithm and other techniques during non-work hours to maximize battery
health. During work hours, an express charge is used. This express
charge allows the battery to be charged faster; therefore, the battery
is at full charge sooner. For each day the time in which the system will
be most heavily used is specified by the start time and the duration.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c | 64 +++++++++++++++++++++++
 include/linux/power_supply.h              | 41 +++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5b528526d8fd 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -172,6 +172,24 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = sprintf(buf, "%s\n",
 			      power_supply_scope_text[value.intval]);
 		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
+		ret = sprintf(buf, "%02d %02d %02d %02d %02d %02d\n",
+			      value.psval.start_hours,
+			      value.psval.start_minutes,
+			      value.psval.end_hours,
+			      value.psval.end_minutes,
+			      value.psval.charge_start_hours,
+			      value.psval.charge_start_minutes);
+		break;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
+		ret = sprintf(buf, "%02d %02d %02d %02d\n",
+			      value.abcval.start_hours,
+			      value.abcval.start_minutes,
+			      value.abcval.duration_hours,
+			      value.abcval.duration_minutes);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
 		ret = sprintf(buf, "%s\n", value.strval);
 		break;
@@ -209,6 +227,28 @@ static ssize_t power_supply_store_property(struct device *dev,
 	case POWER_SUPPLY_PROP_SCOPE:
 		ret = sysfs_match_string(power_supply_scope_text, buf);
 		break;
+	case POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY:
+		ret = sscanf(buf, "%d %d %d %d %d %d",
+			     &value.psval.start_hours,
+			     &value.psval.start_minutes,
+			     &value.psval.end_hours,
+			     &value.psval.end_minutes,
+			     &value.psval.charge_start_hours,
+			     &value.psval.charge_start_minutes);
+		if (ret != 6)
+			return -EINVAL;
+		goto store_property;
+	case POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY ...
+	     POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY:
+		ret = sscanf(buf, "%d %d %d %d",
+			     &value.abcval.start_hours,
+			     &value.abcval.start_minutes,
+			     &value.abcval.duration_hours,
+			     &value.abcval.duration_minutes);
+		if (ret != 4)
+			return -EINVAL;
+		goto store_property;
 	default:
 		ret = -EINVAL;
 	}
@@ -229,6 +269,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	value.intval = ret;
 
+store_property:
 	ret = power_supply_set_property(psy, psp, &value);
 	if (ret < 0)
 		return ret;
@@ -303,10 +344,33 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(precharge_current),
 	POWER_SUPPLY_ATTR(charge_term_current),
 	POWER_SUPPLY_ATTR(calibrate),
+	POWER_SUPPLY_ATTR(peak_shift_enable),
+	POWER_SUPPLY_ATTR(peak_shift_batt_threshold),
+	POWER_SUPPLY_ATTR(adv_batt_charging_enable),
+	/* Local extensions */
+	POWER_SUPPLY_ATTR(usb_hc),
+	POWER_SUPPLY_ATTR(usb_otg),
+	POWER_SUPPLY_ATTR(charge_enabled),
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
 	POWER_SUPPLY_ATTR(serial_number),
+	/* Peak Shift Schedule properties */
+	POWER_SUPPLY_ATTR(peak_shift_sched_sunday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_monday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_tuesday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_wednesday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_thursday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_friday),
+	POWER_SUPPLY_ATTR(peak_shift_sched_saturday),
+	/* Advanced Battery Charging Schedule properties */
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_sunday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_monday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_tuesday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_wednesday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_thursday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_friday),
+	POWER_SUPPLY_ATTR(adv_batt_charging_sched_saturday),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 57b2ab82b951..1d89590537bf 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -150,10 +150,33 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CALIBRATE,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_ENABLE,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_BATT_THRESHOLD,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_ENABLE,
+	/* Local extensions */
+	POWER_SUPPLY_PROP_USB_HC,
+	POWER_SUPPLY_PROP_USB_OTG,
+	POWER_SUPPLY_PROP_CHARGE_ENABLED,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	/* Peak Shift Schedule properties */
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SUNDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_MONDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_TUESDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_WEDNESDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_THURSDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_FRIDAY,
+	POWER_SUPPLY_PROP_PEAK_SHIFT_SCHED_SATURDAY,
+	/* Advanced Battery Charging Schedule properties */
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SUNDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_MONDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_TUESDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_WEDNESDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_THURSDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_FRIDAY,
+	POWER_SUPPLY_PROP_ADV_BATT_CHARGING_SCHED_SATURDAY,
 };
 
 enum power_supply_type {
@@ -188,9 +211,27 @@ enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
 
+struct peak_shift_schedule {
+	int start_hours;
+	int start_minutes;
+	int end_hours;
+	int end_minutes;
+	int charge_start_hours;
+	int charge_start_minutes;
+};
+
+struct adv_batt_charging_schedule {
+	int start_hours;
+	int start_minutes;
+	int duration_hours;
+	int duration_minutes;
+};
+
 union power_supply_propval {
 	int intval;
 	const char *strval;
+	struct peak_shift_schedule psval;
+	struct adv_batt_charging_schedule abcval;
 };
 
 struct device_node;
-- 
2.20.1

