Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9703C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6EF206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeLOATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:55 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198]:49271 "EHLO
        mail-qk1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbeLOATv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:51 -0500
Received: by mail-qk1-f198.google.com with SMTP id a193so6702059qkg.16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pW0/2ceoQqnDm9D9Q0nQFiWusKOGVyXQKc2tj36P0yk=;
        b=OoKjvs921ZhiFJqf5SBCPLG81/mZ2UYUQ85Wl6bqNcOQix1KbmvOvRnSPJQEVP6lIg
         j4161Z8l1gTtd3T7lGRm1SVe9pPjF+6zUnymq6CzIV8P+2KMea+N8HEinS0APYz306un
         cvv/O9RN4OvNhBZKFdVBwnfdm1xatnGmBbVQYJXP7RRT7c8YS/4qasSejzV1/mo5GLjw
         lhmuXSrksi737FOJT0MPPBw7hzRSHTDRaA0KK7Uq6HSGwJ1OJTc55EG/Gzpxq6dwlhvg
         ixVBecsRjOPJZZ38AL01VOkZ4ieZZaqtdcBrshfkRyQxpYER/ngxkLRY00U7vlMo335m
         /GjQ==
X-Gm-Message-State: AA+aEWaNj5ddXvtX5cV+n1TQ51eO9byHVDBsK16O4S9DJ2Ltf/iO3bc5
        ETNtX7QpEf7xVKS6ErxNT7oXQve0oSFvE6c2UX9w3OdQuAVZvmbWy6c7PB2WuMOexG/6mXXsOjG
        uOt0p1KYTYIcOma8VZ34wFVhIM7W7Y0wLiT3batkayarBJ9T6DJVcjm9UUsBNVMReLsoAedcxtK
        w=
X-Google-Smtp-Source: AFSGD/Xeeb5r+dpRBhDgOi24ti0qiFJi4Wt62RRcY5M2efd+Hr2I3DioLZ8N6k3Qnc2LH9rcLmjFfTrpzDalg/nQ
X-Received: by 2002:a0c:9199:: with SMTP id n25mr4912286qvn.49.1544833189107;
 Fri, 14 Dec 2018 16:19:49 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:42 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-10-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 09/10] CHROMIUM: wilco_ec: Add peakshift and adv_batt_charging
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Crews <ncrews@google.com>, Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create "peakshift" and "advanced_battery_charging" directories
within the "properties" directory, and create the relevant
attributes within these. These properties have to do with
configuring some of the advanced power management options that
prolong battery health and reduce energy use at peak hours
of the day.

Scheduling events uses a 24 hour clock, and only supports time
intervals of 15 minutes. For example, to set
advanced_battery_charging to start at 4:15pm and to last for
6 hours and 45 minutes, you would use the argument "16 15 6 45".

> cd /sys/bus/platform/devices/GOOG000C\:00
> cat properties/peakshift/peakshift_battery_threshold
> 015
[means 15 percent]
> cat properties/peakshift/peakshift_monday
16 00 20 30 00 00
[starts at 4:00 pm, ends at 8:30, charging resumes at midnight]
> echo "16 00 20 31 00 00" > properties/peakshift/peakshift_monday
-bash: echo: write error: Invalid argument
> dmesg | tail -n1
[40.34534] wilco_ec GOOG00C:00: minutes must be at the quarter hour
> echo "16 0 20 45 0 0" > properties/peakshift/peakshift_monday
> cat properties/peakshift/peakshift_monday
16 00 20 45 00 00

Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Makefile             |   3 +-
 drivers/platform/chrome/wilco_ec_adv_power.c | 533 +++++++++++++++++++
 drivers/platform/chrome/wilco_ec_adv_power.h | 193 +++++++
 drivers/platform/chrome/wilco_ec_sysfs.c     | 103 ++++
 4 files changed, 831 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.c
 create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.h

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index eefb75e5e69c..c9d3d44098f9 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 
 wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_event.o \
 					   wilco_ec_rtc.o wilco_ec_legacy.o \
+					   wilco_ec_sysfs.o \
 					   wilco_ec_properties.o \
-					   wilco_ec_sysfs.o
+					   wilco_ec_adv_power.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec_adv_power.c b/drivers/platform/chrome/wilco_ec_adv_power.c
new file mode 100644
index 000000000000..30120e2dd007
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_adv_power.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_adv_power - peakshift and adv_batt_charging config of Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include "wilco_ec_adv_power.h"
+#include "wilco_ec_properties.h"
+#include "wilco_ec_sysfs_util.h"
+#include "wilco_ec.h"
+
+struct adv_batt_charging_data {
+	int duration_hours;
+	int duration_minutes;
+	int start_hours;
+	int start_minutes;
+};
+
+struct peakshift_data {
+	int start_hours;
+	int start_minutes;
+	int end_hours;
+	int end_minutes;
+	int charge_start_hours;
+	int charge_start_minutes;
+};
+
+/**
+ * struct time_bcd_format - spec for binary coded decimal time format
+ * @hour_position: how many bits left within the byte is the hour
+ * @minute_position: how many bits left within the byte is the minute
+ *
+ * Date and hour information is passed to/from the EC using packed bytes,
+ * where each byte represents an hour and a minute that some event occurs.
+ * The minute field always happens at quarter-hour intervals, so either
+ * 0, 15, 20, or 45. This allows this info to be packed within 2 bits.
+ * Along with the 5 bits of hour info [0-23], this gives us 7 used bits
+ * within each packed byte. The annoying thing is that the PEAKSHIFT and
+ * ADVANCED_BATTERY_CHARGING properties pack these 7 bits differently,
+ * hence this struct.
+ */
+struct time_bcd_format {
+	u8 hour_position;
+	u8 minute_position;
+};
+
+const struct time_bcd_format PEAKSHIFT_BCD_FORMAT = {
+			     // bit[0] is unused
+	.hour_position = 1,  // bits[1:7]
+	.minute_position = 6 // bits[6:8]
+};
+
+const struct time_bcd_format ADV_BATT_CHARGING_BCD_FORMAT = {
+	.minute_position = 0, // bits[0:2]
+	.hour_position = 2    // bits[2:7]
+			      // bit[7] is unused
+};
+
+/**
+ * struct peakshift_payload - The formatted peakshift time sent/received by EC.
+ * @start_time: packed byte of hour and minute info
+ * @end_time: packed byte of hour and minute info
+ * @charge_start_time: packed byte of hour and minute info
+ * @RESERVED: an unused padding byte
+ */
+struct peakshift_payload {
+	u8 start_time;
+	u8 end_time;
+	u8 charge_start_time;
+	u8 RESERVED;
+} __packed;
+
+struct adv_batt_charging_payload {
+	u16 RESERVED;
+	u8 duration_time;
+	u8 start_time;
+} __packed;
+
+/**
+ * extract_quarter_hour() - Convert from literal minutes to quarter hour.
+ * @minutes: Literal minutes value. Needs to be one of {0, 15, 30, 45}
+ *
+ * Return one of {0, 1, 2, 3} for each of {0, 15, 30, 45}, or -EINVAL on error.
+ */
+static int extract_quarter_hour(int minutes)
+{
+	if ((minutes < 0) || (minutes > 45) || minutes % 15)
+		return -EINVAL;
+	return minutes / 15;
+}
+
+static int check_adv_batt_charging_data(struct device *dev,
+					struct adv_batt_charging_data *data)
+{
+	if (data->start_hours < 0 || data->start_hours > 23) {
+		dev_err(dev, "start_hours must be in [0-23], got %d",
+			data->start_hours);
+		return -EINVAL;
+	}
+	if (data->duration_hours < 0 || data->duration_hours > 23) {
+		dev_err(dev, "duration_hours must be in [0-23], got %d",
+			data->duration_hours);
+		return -EINVAL;
+	}
+	if (data->start_minutes < 0 || data->start_minutes > 59) {
+		dev_err(dev, "start_minutes must be in [0-59], got %d",
+			data->start_minutes);
+		return -EINVAL;
+	}
+	if (data->duration_minutes < 0 || data->duration_minutes > 59) {
+		dev_err(dev, "duration_minutes must be in [0-59], got %d",
+			data->duration_minutes);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int check_peakshift_data(struct device *dev, struct peakshift_data *data)
+{
+	if (data->start_hours < 0 || data->start_hours > 23) {
+		dev_err(dev, "start_hours must be in [0-23], got %d",
+			data->start_hours);
+		return -EINVAL;
+	}
+	if (data->end_hours < 0 || data->end_hours > 23) {
+		dev_err(dev, "end_hours must be in [0-23], got %d",
+			data->end_hours);
+		return -EINVAL;
+	}
+	if (data->charge_start_hours < 0 || data->charge_start_hours > 23) {
+		dev_err(dev, "charge_start_hours must be in [0-23], got %d",
+			data->charge_start_hours);
+		return -EINVAL;
+	}
+	if (data->start_minutes < 0 || data->start_minutes > 59) {
+		dev_err(dev, "start_minutes must be in [0-59], got %d",
+			data->start_minutes);
+		return -EINVAL;
+	}
+	if (data->end_minutes < 0 || data->end_minutes > 59) {
+		dev_err(dev, "end_minutes must be in [0-59], got %d",
+			data->end_minutes);
+		return -EINVAL;
+	}
+	if (data->charge_start_minutes < 0 || data->charge_start_minutes > 59) {
+		dev_err(dev, "charge_start_minutes must be in [0-59], got %d",
+			data->charge_start_minutes);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * pack_field() - Pack hour and minute info into a byte.
+ *
+ * @fmt: The format for how to place the info within the byte
+ * @hours: In range [0-23]
+ * @quarter_hour: In range [0-3], representing :00, :15, :30, and :45
+ *
+ * Return the packed byte.
+ */
+static u8 pack_field(struct time_bcd_format fmt, int hours, int quarter_hour)
+{
+	int result = 0;
+
+	result |= hours << fmt.hour_position;
+	result |= quarter_hour << fmt.minute_position;
+	return (u8) result;
+}
+
+/**
+ * unpack_field() - Extract hour and minute info from a byte.
+ *
+ * @fmt: The format for how to place the info within the byte
+ * @field: Byte which contains the packed info
+ * @hours: The value to be filled, in [0, 24]
+ * @quarter_hour: to be filled in range [0-3], meaning :00, :15, :30, and :45
+ */
+static void unpack_field(struct time_bcd_format fmt, u8 field, int *hours,
+			 int *quarter_hour)
+{
+	*hours =	(field >> fmt.hour_position)   & 0x1f; // 00011111
+	*quarter_hour = (field >> fmt.minute_position) & 0x03; // 00000011
+}
+
+static void pack_adv_batt_charging(struct adv_batt_charging_data *data,
+		     struct adv_batt_charging_payload *payload)
+{
+	payload->start_time = pack_field(ADV_BATT_CHARGING_BCD_FORMAT,
+					 data->start_hours,
+					 data->start_minutes);
+	payload->duration_time = pack_field(ADV_BATT_CHARGING_BCD_FORMAT,
+				       data->duration_hours,
+				       data->duration_minutes);
+}
+
+static void unpack_adv_batt_charging(struct adv_batt_charging_data *data,
+		       struct adv_batt_charging_payload *payload)
+{
+	unpack_field(ADV_BATT_CHARGING_BCD_FORMAT, payload->start_time,
+		     &(data->start_hours),
+		     &(data->start_minutes));
+	unpack_field(ADV_BATT_CHARGING_BCD_FORMAT, payload->duration_time,
+		     &(data->duration_hours),
+		     &(data->duration_minutes));
+}
+
+static void pack_peakshift(struct peakshift_data *data,
+			   struct peakshift_payload *payload)
+{
+	payload->start_time = pack_field(PEAKSHIFT_BCD_FORMAT,
+					 data->start_hours,
+					 data->start_minutes);
+	payload->end_time = pack_field(PEAKSHIFT_BCD_FORMAT,
+				       data->end_hours,
+				       data->end_minutes);
+	payload->charge_start_time = pack_field(PEAKSHIFT_BCD_FORMAT,
+						data->charge_start_hours,
+						data->charge_start_minutes);
+}
+
+static void unpack_peakshift(struct peakshift_data *data,
+			     struct peakshift_payload *payload)
+{
+	unpack_field(PEAKSHIFT_BCD_FORMAT, payload->start_time,
+		     &(data->start_hours),
+		     &(data->start_minutes));
+	unpack_field(PEAKSHIFT_BCD_FORMAT, payload->end_time,
+		     &(data->end_hours),
+		     &(data->end_minutes));
+	unpack_field(PEAKSHIFT_BCD_FORMAT, payload->charge_start_time,
+		     &(data->charge_start_hours),
+		     &(data->charge_start_minutes));
+}
+
+ssize_t wilco_ec_peakshift_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	struct peakshift_payload payload;
+	struct peakshift_data data;
+	const char FORMAT[] = "%02d %02d %02d %02d %02d %02d\n";
+	const int OUT_LENGTH = 18; //six 2-char nums, 5 spaces, 1 newline
+	int ret;
+
+	if (OUT_LENGTH + 1 > PAGE_SIZE)
+		return -ENOBUFS; //no buffer space for message + null
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+	/* get the raw payload of data from the EC */
+	ret = wilco_ec_get_property(ec, prop_attr->pid, sizeof(payload),
+				    (u8 *) &payload);
+	if (ret < 0) {
+		dev_err(dev, "error in wilco_ec_mailbox()");
+		return ret;
+	}
+
+	/* unpack raw bytes, and convert quarter-hour to literal minute */
+	unpack_peakshift(&data, &payload);
+	data.start_minutes *= 15;
+	data.end_minutes *= 15;
+	data.charge_start_minutes *= 15;
+
+	/* Check that the EC returns good data */
+	ret = check_peakshift_data(dev, &data);
+	if (ret < 0) {
+		dev_err(dev, "EC returned out of range minutes or hours");
+		return -EBADMSG;
+	}
+
+	/* Print the numbers to the string */
+	ret = scnprintf(buf, OUT_LENGTH+1, FORMAT,
+			data.start_hours,
+			data.start_minutes,
+			data.end_hours,
+			data.end_minutes,
+			data.charge_start_hours,
+			data.charge_start_minutes);
+	if (ret != OUT_LENGTH) {
+		dev_err(dev, "expected to write %d chars, wrote %d", OUT_LENGTH,
+			ret);
+		return -EIO;
+	}
+
+	return OUT_LENGTH;
+}
+
+ssize_t wilco_ec_peakshift_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	struct peakshift_data data;
+	struct peakshift_payload payload;
+	const char FORMAT[] = "%d %d %d %d %d %d";
+	int ret;
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+	/* Extract our 6 numbers from the input string */
+	ret = sscanf(buf, FORMAT,
+		     &data.start_hours,
+		     &data.start_minutes,
+		     &data.end_hours,
+		     &data.end_minutes,
+		     &data.charge_start_hours,
+		     &data.charge_start_minutes);
+	if (ret != 6) {
+		dev_err(dev, "unable to parse '%s' into 6 integers", buf);
+		return -EINVAL;
+	}
+
+	/* Ensure the integers we parsed are valid */
+	ret = check_peakshift_data(dev, &data);
+	if (ret < 0)
+		return ret;
+
+	/* Convert the literal minutes to which quarter hour they represent */
+	data.start_minutes = extract_quarter_hour(data.start_minutes);
+	if (data.start_minutes < 0)
+		goto bad_minutes;
+	data.end_minutes = extract_quarter_hour(data.end_minutes);
+	if (data.end_minutes < 0)
+		goto bad_minutes;
+	data.charge_start_minutes = extract_quarter_hour(
+						data.charge_start_minutes);
+	if (data.charge_start_minutes < 0)
+		goto bad_minutes;
+
+	/* Create the raw byte payload and send it off */
+	pack_peakshift(&data, &payload);
+	wilco_ec_set_property(ec, OP_SET, prop_attr->pid, sizeof(payload),
+			      (u8 *) &payload);
+
+	return count;
+
+bad_minutes:
+	dev_err(dev, "minutes must be at the quarter hour");
+	return -EINVAL;
+}
+
+ssize_t wilco_ec_peakshift_batt_thresh_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf)
+{
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	const char FORMAT[] = "%02d\n";
+	size_t RESULT_LENGTH = 3; /* 2-char number and newline */
+	u8 percent;
+	int ret;
+
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+	ret = wilco_ec_get_property(ec, PID_PEAKSHIFT_BATTERY_THRESHOLD, 1,
+				    &percent);
+	if (ret < 0)
+		return ret;
+
+	if (percent < 15 || percent > 50) {
+		dev_err(ec->dev, "expected 15 < percentage < 50, got %d",
+			percent);
+		return -EBADMSG;
+	}
+
+	scnprintf(buf, RESULT_LENGTH+1, FORMAT, percent);
+
+	return RESULT_LENGTH;
+}
+
+ssize_t wilco_ec_peakshift_batt_thresh_store(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	u8 DECIMAL_BASE = 10;
+	u8 percent;
+	int ret;
+
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+
+	ret = kstrtou8(buf, DECIMAL_BASE, &percent);
+	if (ret) {
+		dev_err(dev, "unable to parse '%s' to u8", buf);
+		return ret;
+	}
+
+	if (percent < 15 || percent > 50) {
+		dev_err(dev, "require 15 < batt_thresh_percent < 50, got %d",
+			percent);
+		return -EINVAL;
+	}
+
+	ret = wilco_ec_set_property(ec, OP_SET, PID_PEAKSHIFT_BATTERY_THRESHOLD,
+				    1, &percent);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+ssize_t wilco_ec_abc_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	struct adv_batt_charging_payload payload;
+	struct adv_batt_charging_data data;
+	const char FORMAT[] = "%02d %02d %02d %02d\n";
+	const int OUT_LENGTH = 12; //four 2-char nums, 3 spaces, 1 newline
+	int ret;
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+
+	if (OUT_LENGTH + 1 > PAGE_SIZE)
+		return -ENOBUFS; //no buffer space for message + null
+
+	/* get the raw payload of data from the EC */
+	ret = wilco_ec_get_property(ec, prop_attr->pid, sizeof(payload),
+				    (u8 *) &payload);
+	if (ret < 0) {
+		dev_err(dev, "error in wilco_ec_mailbox()");
+		return ret;
+	}
+
+	/* unpack raw bytes, and convert quarter-hour to literal minute */
+	unpack_adv_batt_charging(&data, &payload);
+	data.start_minutes *= 15;
+	data.duration_minutes *= 15;
+
+	// /* Is this needed? can we assume the EC returns good data? */
+	// EC is returning 00 00 27 30. Was this modified, or is EC weird
+	// out of the box?
+	ret = check_adv_batt_charging_data(dev, &data);
+	if (ret < 0) {
+		dev_err(dev, "EC returned out of range minutes or hours");
+		return -EBADMSG;
+	}
+
+	/* Print the numbers to the string */
+	ret = scnprintf(buf, OUT_LENGTH+1, FORMAT,
+			data.start_hours,
+			data.start_minutes,
+			data.duration_hours,
+			data.duration_minutes);
+	if (ret != OUT_LENGTH) {
+		dev_err(dev, "expected to write %d chars, wrote %d", OUT_LENGTH,
+			ret);
+		return -EIO;
+	}
+
+	return OUT_LENGTH;
+}
+
+ssize_t wilco_ec_abc_store(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+	struct wilco_ec_device *ec;
+	struct adv_batt_charging_data data;
+	struct adv_batt_charging_payload payload;
+	const char FORMAT[] = "%d %d %d %d";
+	int ret;
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+	ec = dev_get_drvdata(dev);
+
+	/* Extract our 4 numbers from the input string */
+	ret = sscanf(buf, FORMAT,
+		     &data.start_hours,
+		     &data.start_minutes,
+		     &data.duration_hours,
+		     &data.duration_minutes);
+	if (ret != 4) {
+		dev_err(dev, "unable to parse '%s' into 4 integers", buf);
+		return -EINVAL;
+	}
+
+	/* Ensure the integers we parsed are valid */
+	ret = check_adv_batt_charging_data(dev, &data);
+	if (ret < 0)
+		return ret;
+
+	/* Convert the literal minutes to which quarter hour they represent */
+	data.start_minutes = extract_quarter_hour(data.start_minutes);
+	if (data.start_minutes < 0)
+		goto bad_minutes;
+	data.duration_minutes = extract_quarter_hour(data.duration_minutes);
+	if (data.duration_minutes < 0)
+		goto bad_minutes;
+
+	/* Create the raw byte payload and send it off */
+	pack_adv_batt_charging(&data, &payload);
+	wilco_ec_set_property(ec, OP_SET, prop_attr->pid, sizeof(payload),
+			      (u8 *) &payload);
+
+	return count;
+
+bad_minutes:
+	dev_err(dev, "minutes must be at the quarter hour");
+	return -EINVAL;
+}
diff --git a/drivers/platform/chrome/wilco_ec_adv_power.h b/drivers/platform/chrome/wilco_ec_adv_power.h
new file mode 100644
index 000000000000..8302650144ab
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_adv_power.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * wilco_ec_adv_power - peakshift and adv_batt_charging config of Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/**
+ * Peakshift:
+ * For each weekday a start and end time to run in Peak Shift mode can be set.
+ * During these times the system will run from the battery even if the AC is
+ * attached as long as the battery stays above the threshold specified.
+ * After the end time specified the system will run from AC if attached but
+ * will not charge the battery. The system will again function normally using AC
+ * and recharging the battery after the specified Charge Start time.
+ *
+ * Advanced Charging Mode:
+ * Advanced Charging Mode allows the user to maximize the battery health.
+ * In Advanced Charging Mode the system will use standard charging algorithm and
+ * other techniques during non-work hours to maximize battery health.
+ * During work hours, an express charge is used. This express charge allows the
+ * battery to be charged faster; therefore, the battery is at
+ * full charge sooner. For each day the time in which the system will be most
+ * heavily used is specified by the start time and the duration.
+ * Please read the Common UEFI BIOS Behavioral Specification and
+ * BatMan 2 BIOS_EC Specification for more details about this feature.
+ */
+
+#ifndef WILCO_EC_ADV_POWER_H
+#define WILCO_EC_ADV_POWER_H
+
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include "wilco_ec.h"
+#include "wilco_ec_sysfs_util.h"
+#include "wilco_ec_properties.h"
+
+#define PID_PEAKSHIFT				0x0412
+#define PID_PEAKSHIFT_BATTERY_THRESHOLD		0x04EB
+#define PID_PEAKSHIFT_SUNDAY_HOURS		0x04F5
+#define PID_PEAKSHIFT_MONDAY_HOURS		0x04F6
+#define PID_PEAKSHIFT_TUESDAY_HOURS		0x04F7
+#define PID_PEAKSHIFT_WEDNESDAY_HOURS		0x04F8
+#define PID_PEAKSHIFT_THURSDAY_HOURS		0x04F9
+#define PID_PEAKSHIFT_FRIDAY_HOURS		0x04Fa
+#define PID_PEAKSHIFT_SATURDAY_HOURS		0x04Fb
+
+#define PID_ABC_MODE				0x04ed
+#define PID_ABC_SUNDAY_HOURS			0x04F5
+#define PID_ABC_MONDAY_HOURS			0x04F6
+#define PID_ABC_TUESDAY_HOURS			0x04F7
+#define PID_ABC_WEDNESDAY_HOURS			0x04F8
+#define PID_ABC_THURSDAY_HOURS			0x04F9
+#define PID_ABC_FRIDAY_HOURS			0x04FA
+#define PID_ABC_SATURDAY_HOURS			0x04FB
+
+/**
+ * wilco_ec_peakshift_show() - Retrieves times stored for the peakshift policy.
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: Output buffer to fill with the result
+ *
+ * The output buffer will be filled with the format
+ * "start_hr start_min end_hr end_min charge_start_hr charge_start_min"
+ * The hour fields will be in the range [0-23], and the minutes will be
+ * one of (0, 15, 30, 45). Each number will be zero padded to two characters.
+ *
+ * An example output is "06 15 09 45 23 00",
+ * which corresponds to 6:15, 9:45, and 23:00
+ *
+ * Return the length of the output buffer, or negative error code on failure.
+ */
+ssize_t wilco_ec_peakshift_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf);
+
+/**
+ * wilco_ec_peakshift_store() - Saves times for the peakshift policy.
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: Raw input buffer
+ * @count: Number of bytes in input buffer
+ *
+ * The input buffer must have the format
+ * "start_hr start_min end_hr end_min charge_start_hr charge_start_min"
+ * The hour fields must be in the range [0-23], and the minutes must be
+ * one of (0, 15, 30, 45). The string must be parseable by sscanf() using the
+ * format string "%d %d %d %d %d %d".
+ *
+ * An example valid input is "6 15     009 45 23 0",
+ * which corresponds to 6:15, 9:45, and 23:00
+ *
+ * Return number of bytes consumed from input, negative error code on failure.
+ */
+ssize_t wilco_ec_peakshift_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count);
+
+/**
+ * peakshift_battery_show() - Retrieve batt percentage at which peakshift stops
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: Output buffer to fill with the result
+ *
+ * Result will be a 2 character integer representing the
+ * battery percentage at which peakshift stops. Will be in range [15, 50].
+ *
+ * Return the length of the output buffer, or negative error code on failure.
+ */
+ssize_t wilco_ec_peakshift_batt_thresh_show(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    char *buf);
+
+/**
+ * peakshift_battery_store() - Save batt percentage at which peakshift stops
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: Input buffer, should be parseable to range [15,50] by kstrtou8()
+ * @count: Number of bytes in input buffer
+ *
+ * Return number of bytes consumed from input, negative error code on failure.
+ */
+ssize_t wilco_ec_peakshift_batt_thresh_store(struct kobject *kobj,
+					     struct kobj_attribute *attr,
+					     const char *buf, size_t count);
+
+/**
+ * wilco_ec_abc_show() - Retrieve times for Advanced Battery Charging
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: Output buffer to fill with the result
+ *
+ * The output buffer will be filled with the format
+ * "start_hr start_min duration_hr duration_min"
+ * The hour fields will be in the range [0-23], and the minutes will be
+ * one of (0, 15, 30, 45). Each number will be zero padded to two characters.
+ *
+ * An example output is "06 15 23 45",
+ * which corresponds to a start time of 6:15 and a duration of 23:45
+ *
+ * Return the length of the output buffer, or negative error code on failure.
+ */
+ssize_t wilco_ec_abc_show(struct kobject *kobj, struct kobj_attribute *attr,
+			  char *buf);
+
+/**
+ * wilco_ec_abc_store() - Save times for Advanced Battery Charging
+ * @kobj: kobject representing the directory this attribute is in
+ * @attr: Attribute stored within the proper property_attribute
+ * @buf: The raw input buffer
+ * @count: Number of bytes in input buffer
+ *
+ * The input buffer must have the format
+ * "start_hr start_min duration_hr duration_min"
+ * The hour fields must be in the range [0-23], and the minutes must be
+ * one of (0, 15, 30, 45). The string must be parseable by sscanf() using the
+ * format string "%d %d %d %d %d %d".
+ *
+ * An example valid input is "0006 15     23 45",
+ * which corresponds to a start time of 6:15 and a duration of 23:45
+ *
+ * Return number of bytes consumed, or negative error code on failure.
+ */
+ssize_t wilco_ec_abc_store(struct kobject *kobj, struct kobj_attribute *attr,
+			   const char *buf, size_t count);
+
+#define PEAKSHIFT_KOBJ_ATTR(_name)					\
+__ATTR(_name, 0644, wilco_ec_peakshift_show, wilco_ec_peakshift_store)
+
+#define PEAKSHIFT_ATTRIBUTE(_var, _name, _pid)				\
+struct property_attribute _var = {					\
+	.kobj_attr = PEAKSHIFT_KOBJ_ATTR(_name),			\
+	.pid = _pid,							\
+}
+
+#define ABC_KOBJ_ATTR(_name)						\
+__ATTR(_name, 0644, wilco_ec_abc_show, wilco_ec_abc_store)
+
+#define ABC_ATTRIBUTE(_var, _name, _pid)				\
+struct property_attribute _var = {					\
+	.kobj_attr = ABC_KOBJ_ATTR(_name),				\
+	.pid = _pid,							\
+}
+
+#endif /* WILCO_EC_ADV_POWER_H */
diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
index 3cb7cf95098e..81dded951058 100644
--- a/drivers/platform/chrome/wilco_ec_sysfs.c
+++ b/drivers/platform/chrome/wilco_ec_sysfs.c
@@ -18,6 +18,7 @@
 #include "wilco_ec.h"
 #include "wilco_ec_legacy.h"
 #include "wilco_ec_properties.h"
+#include "wilco_ec_adv_power.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -82,6 +83,70 @@ struct attribute *wilco_ec_property_attrs[] = {
 ATTRIBUTE_GROUPS(wilco_ec_property);
 struct kobject *prop_dir_kobj;
 
+/* Make peakshift attrs, which live inside GOOG000C:00/properties/peakshift */
+
+struct kobj_attribute kobj_attr_peakshift_battery_threshold =
+	__ATTR(battery_threshold, 0644, wilco_ec_peakshift_batt_thresh_show,
+	       wilco_ec_peakshift_batt_thresh_store);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, prop_attr_peakshift, enable,
+			      PID_PEAKSHIFT);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_sunday, sunday,
+		    PID_PEAKSHIFT_SUNDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_monday, monday,
+		    PID_PEAKSHIFT_MONDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_tuesday, tuesday,
+		    PID_PEAKSHIFT_TUESDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_wednesday, wednesday,
+		    PID_PEAKSHIFT_WEDNESDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_thursday, thursday,
+		    PID_PEAKSHIFT_THURSDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_friday, friday,
+		    PID_PEAKSHIFT_FRIDAY_HOURS);
+PEAKSHIFT_ATTRIBUTE(prop_attr_peakshift_saturday, saturday,
+		    PID_PEAKSHIFT_SATURDAY_HOURS);
+
+struct attribute *wilco_ec_peakshift_attrs[] = {
+	&kobj_attr_peakshift_battery_threshold.attr,
+	&prop_attr_peakshift.kobj_attr.attr,
+	&prop_attr_peakshift_sunday.kobj_attr.attr,
+	&prop_attr_peakshift_monday.kobj_attr.attr,
+	&prop_attr_peakshift_tuesday.kobj_attr.attr,
+	&prop_attr_peakshift_wednesday.kobj_attr.attr,
+	&prop_attr_peakshift_thursday.kobj_attr.attr,
+	&prop_attr_peakshift_friday.kobj_attr.attr,
+	&prop_attr_peakshift_saturday.kobj_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wilco_ec_peakshift);
+struct kobject *peakshift_dir_kobj;
+
+/**
+ * Make peakshift attrs, which live inside
+ * GOOG000C:00/properties/advanced_battery_charging
+ */
+
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, prop_attr_abc, enable, PID_ABC_MODE);
+ABC_ATTRIBUTE(prop_attr_abc_sunday, sunday, PID_ABC_SUNDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_monday, monday, PID_ABC_MONDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_tuesday, tuesday, PID_ABC_TUESDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_wednesday, wednesday, PID_ABC_WEDNESDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_thursday, thursday, PID_ABC_THURSDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_friday, friday, PID_ABC_FRIDAY_HOURS);
+ABC_ATTRIBUTE(prop_attr_abc_saturday, saturday, PID_ABC_SATURDAY_HOURS);
+
+struct attribute *wilco_ec_adv_batt_charging_attrs[] = {
+	&prop_attr_abc.kobj_attr.attr,
+	&prop_attr_abc_sunday.kobj_attr.attr,
+	&prop_attr_abc_monday.kobj_attr.attr,
+	&prop_attr_abc_tuesday.kobj_attr.attr,
+	&prop_attr_abc_wednesday.kobj_attr.attr,
+	&prop_attr_abc_thursday.kobj_attr.attr,
+	&prop_attr_abc_friday.kobj_attr.attr,
+	&prop_attr_abc_saturday.kobj_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wilco_ec_adv_batt_charging);
+struct kobject *adv_batt_charging_dir_kobj;
 
 /**
  * wilco_ec_sysfs_init() - Initialize the sysfs directories and attributes
@@ -112,9 +177,42 @@ int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
 	if (ret)
 		goto rm_properties_dir;
 
+	// add the directory for adv batt charging into the properties directory
+	adv_batt_charging_dir_kobj = kobject_create_and_add(
+					"advanced_battery_charging",
+					prop_dir_kobj);
+	if (!adv_batt_charging_dir_kobj)
+		goto rm_properties_attrs;
+
+	// add the adv batt charging attributes into the abc directory
+	ret = sysfs_create_groups(adv_batt_charging_dir_kobj,
+				  wilco_ec_adv_batt_charging_groups);
+	if (ret)
+		goto rm_abc_dir;
+
+	// add the directory for peakshift into the properties directory
+	peakshift_dir_kobj = kobject_create_and_add("peakshift", prop_dir_kobj);
+	if (!peakshift_dir_kobj)
+		goto rm_abc_attrs;
+
+	// add the peakshift attributes into the peakshift directory
+	ret = sysfs_create_groups(peakshift_dir_kobj,
+				  wilco_ec_peakshift_groups);
+	if (ret)
+		goto rm_peakshift_dir;
+
 	return 0;
 
 /* Go upwards through the directory structure, cleaning up */
+rm_peakshift_dir:
+	kobject_put(peakshift_dir_kobj);
+rm_abc_attrs:
+	sysfs_remove_groups(adv_batt_charging_dir_kobj,
+			    wilco_ec_adv_batt_charging_groups);
+rm_abc_dir:
+	kobject_put(adv_batt_charging_dir_kobj);
+rm_properties_attrs:
+	sysfs_remove_groups(prop_dir_kobj, wilco_ec_property_groups);
 rm_properties_dir:
 	kobject_put(prop_dir_kobj);
 rm_toplevel_attrs:
@@ -129,6 +227,11 @@ void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
 	struct device *dev = ec->dev;
 
 	/* go upwards through the directory structure */
+	sysfs_remove_groups(peakshift_dir_kobj, wilco_ec_peakshift_groups);
+	kobject_put(peakshift_dir_kobj);
+	sysfs_remove_groups(adv_batt_charging_dir_kobj,
+			    wilco_ec_adv_batt_charging_groups);
+	kobject_put(adv_batt_charging_dir_kobj);
 	sysfs_remove_groups(prop_dir_kobj, wilco_ec_property_groups);
 	kobject_put(prop_dir_kobj);
 	sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
-- 
2.20.0.405.gbc1bbc6f85-goog

