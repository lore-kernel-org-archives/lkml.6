Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F16208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F16208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968109AbeFRIwL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:52:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54350 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966567AbeFRIwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:52:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0CC9A207A5; Mon, 18 Jun 2018 10:52:05 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C5EFB20012;
        Mon, 18 Jun 2018 10:52:04 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: ds1685: remove improper datetime access ABI
Date:   Mon, 18 Jun 2018 10:52:01 +0200
Message-Id: <20180618085202.25422-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exposes an undocumented ABI to access the date and time
registers. It is not actually used by any userspace tools. Remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 221 ---------------------------------------
 1 file changed, 221 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 986e75e38602..28dbe2ba52c8 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1459,217 +1459,6 @@ ds1685_rtc_sysfs_ctrl4b_grp = {
 	.name = "ctrl4b",
 	.attrs = ds1685_rtc_sysfs_ctrl4b_attrs,
 };
-
-
-/**
- * struct ds1685_rtc_ctrl_regs.
- * @name: char pointer for the bit name.
- * @reg: control register the bit is in.
- * @bit: the bit's offset in the register.
- */
-struct ds1685_rtc_time_regs {
-	const char *name;
-	const u8 reg;
-	const u8 mask;
-	const u8 min;
-	const u8 max;
-};
-
-/*
- * Time/Date register lookup tables.
- */
-static const struct ds1685_rtc_time_regs
-ds1685_time_regs_bcd_table[] = {
-	{ "seconds",       RTC_SECS,       RTC_SECS_BCD_MASK,   0, 59 },
-	{ "minutes",       RTC_MINS,       RTC_MINS_BCD_MASK,   0, 59 },
-	{ "hours",         RTC_HRS,        RTC_HRS_24_BCD_MASK, 0, 23 },
-	{ "wday",          RTC_WDAY,       RTC_WDAY_MASK,       1,  7 },
-	{ "mday",          RTC_MDAY,       RTC_MDAY_BCD_MASK,   1, 31 },
-	{ "month",         RTC_MONTH,      RTC_MONTH_BCD_MASK,  1, 12 },
-	{ "year",          RTC_YEAR,       RTC_YEAR_BCD_MASK,   0, 99 },
-	{ "century",       RTC_CENTURY,    RTC_CENTURY_MASK,    0, 99 },
-	{ "alarm_seconds", RTC_SECS_ALARM, RTC_SECS_BCD_MASK,   0, 59 },
-	{ "alarm_minutes", RTC_MINS_ALARM, RTC_MINS_BCD_MASK,   0, 59 },
-	{ "alarm_hours",   RTC_HRS_ALARM,  RTC_HRS_24_BCD_MASK, 0, 23 },
-	{ "alarm_mday",    RTC_MDAY_ALARM, RTC_MDAY_ALARM_MASK, 1, 31 },
-	{ NULL,            0,              0,                   0,  0 },
-};
-
-static const struct ds1685_rtc_time_regs
-ds1685_time_regs_bin_table[] = {
-	{ "seconds",       RTC_SECS,       RTC_SECS_BIN_MASK,   0x00, 0x3b },
-	{ "minutes",       RTC_MINS,       RTC_MINS_BIN_MASK,   0x00, 0x3b },
-	{ "hours",         RTC_HRS,        RTC_HRS_24_BIN_MASK, 0x00, 0x17 },
-	{ "wday",          RTC_WDAY,       RTC_WDAY_MASK,       0x01, 0x07 },
-	{ "mday",          RTC_MDAY,       RTC_MDAY_BIN_MASK,   0x01, 0x1f },
-	{ "month",         RTC_MONTH,      RTC_MONTH_BIN_MASK,  0x01, 0x0c },
-	{ "year",          RTC_YEAR,       RTC_YEAR_BIN_MASK,   0x00, 0x63 },
-	{ "century",       RTC_CENTURY,    RTC_CENTURY_MASK,    0x00, 0x63 },
-	{ "alarm_seconds", RTC_SECS_ALARM, RTC_SECS_BIN_MASK,   0x00, 0x3b },
-	{ "alarm_minutes", RTC_MINS_ALARM, RTC_MINS_BIN_MASK,   0x00, 0x3b },
-	{ "alarm_hours",   RTC_HRS_ALARM,  RTC_HRS_24_BIN_MASK, 0x00, 0x17 },
-	{ "alarm_mday",    RTC_MDAY_ALARM, RTC_MDAY_ALARM_MASK, 0x01, 0x1f },
-	{ NULL,            0,              0,                   0x00, 0x00 },
-};
-
-/**
- * ds1685_rtc_sysfs_time_regs_bcd_lookup - time/date reg bit lookup function.
- * @name: register bit to look up in ds1685_time_regs_bcd_table.
- */
-static const struct ds1685_rtc_time_regs*
-ds1685_rtc_sysfs_time_regs_lookup(const char *name, bool bcd_mode)
-{
-	const struct ds1685_rtc_time_regs *p;
-
-	if (bcd_mode)
-		p = ds1685_time_regs_bcd_table;
-	else
-		p = ds1685_time_regs_bin_table;
-
-	for (; p->name != NULL; ++p)
-		if (strcmp(p->name, name) == 0)
-			return p;
-
-	return NULL;
-}
-
-/**
- * ds1685_rtc_sysfs_time_regs_show - reads a time/date register via sysfs.
- * @dev: pointer to device structure.
- * @attr: pointer to device_attribute structure.
- * @buf: pointer to char array to hold the output.
- */
-static ssize_t
-ds1685_rtc_sysfs_time_regs_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	u8 tmp;
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	const struct ds1685_rtc_time_regs *bcd_reg_info =
-		ds1685_rtc_sysfs_time_regs_lookup(attr->attr.name, true);
-	const struct ds1685_rtc_time_regs *bin_reg_info =
-		ds1685_rtc_sysfs_time_regs_lookup(attr->attr.name, false);
-
-	/* Make sure we actually matched something. */
-	if (!bcd_reg_info || !bin_reg_info)
-		return -EINVAL;
-
-	/* bcd_reg_info->reg == bin_reg_info->reg. */
-	ds1685_rtc_begin_data_access(rtc);
-	tmp = rtc->read(rtc, bcd_reg_info->reg);
-	ds1685_rtc_end_data_access(rtc);
-
-	tmp = ds1685_rtc_bcd2bin(rtc, tmp, bcd_reg_info->mask,
-				 bin_reg_info->mask);
-
-	return sprintf(buf, "%d\n", tmp);
-}
-
-/**
- * ds1685_rtc_sysfs_time_regs_store - writes a time/date register via sysfs.
- * @dev: pointer to device structure.
- * @attr: pointer to device_attribute structure.
- * @buf: pointer to char array to hold the output.
- * @count: number of bytes written.
- */
-static ssize_t
-ds1685_rtc_sysfs_time_regs_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
-{
-	long int val = 0;
-	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	const struct ds1685_rtc_time_regs *bcd_reg_info =
-		ds1685_rtc_sysfs_time_regs_lookup(attr->attr.name, true);
-	const struct ds1685_rtc_time_regs *bin_reg_info =
-		ds1685_rtc_sysfs_time_regs_lookup(attr->attr.name, false);
-
-	/* We only accept numbers. */
-	if (kstrtol(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	/* Make sure we actually matched something. */
-	if (!bcd_reg_info || !bin_reg_info)
-		return -EINVAL;
-
-	/* Check for a valid range. */
-	if (rtc->bcd_mode) {
-		if ((val < bcd_reg_info->min) || (val > bcd_reg_info->max))
-			return -ERANGE;
-	} else {
-		if ((val < bin_reg_info->min) || (val > bin_reg_info->max))
-			return -ERANGE;
-	}
-
-	val = ds1685_rtc_bin2bcd(rtc, val, bin_reg_info->mask,
-				 bcd_reg_info->mask);
-
-	/* bcd_reg_info->reg == bin_reg_info->reg. */
-	ds1685_rtc_begin_data_access(rtc);
-	rtc->write(rtc, bcd_reg_info->reg, val);
-	ds1685_rtc_end_data_access(rtc);
-
-	return count;
-}
-
-/**
- * DS1685_RTC_SYSFS_REG_RW - device_attribute for a read-write time register.
- * @reg: time/date register to read or write.
- */
-#define DS1685_RTC_SYSFS_TIME_REG_RW(reg)				\
-	static DEVICE_ATTR(reg, S_IRUGO | S_IWUSR,			\
-	ds1685_rtc_sysfs_time_regs_show,				\
-	ds1685_rtc_sysfs_time_regs_store)
-
-/*
- * Time/Date Register bits.
- */
-DS1685_RTC_SYSFS_TIME_REG_RW(seconds);
-DS1685_RTC_SYSFS_TIME_REG_RW(minutes);
-DS1685_RTC_SYSFS_TIME_REG_RW(hours);
-DS1685_RTC_SYSFS_TIME_REG_RW(wday);
-DS1685_RTC_SYSFS_TIME_REG_RW(mday);
-DS1685_RTC_SYSFS_TIME_REG_RW(month);
-DS1685_RTC_SYSFS_TIME_REG_RW(year);
-DS1685_RTC_SYSFS_TIME_REG_RW(century);
-DS1685_RTC_SYSFS_TIME_REG_RW(alarm_seconds);
-DS1685_RTC_SYSFS_TIME_REG_RW(alarm_minutes);
-DS1685_RTC_SYSFS_TIME_REG_RW(alarm_hours);
-DS1685_RTC_SYSFS_TIME_REG_RW(alarm_mday);
-
-static struct attribute*
-ds1685_rtc_sysfs_time_attrs[] = {
-	&dev_attr_seconds.attr,
-	&dev_attr_minutes.attr,
-	&dev_attr_hours.attr,
-	&dev_attr_wday.attr,
-	&dev_attr_mday.attr,
-	&dev_attr_month.attr,
-	&dev_attr_year.attr,
-	&dev_attr_century.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_time_grp = {
-	.name = "datetime",
-	.attrs = ds1685_rtc_sysfs_time_attrs,
-};
-
-static struct attribute*
-ds1685_rtc_sysfs_alarm_attrs[] = {
-	&dev_attr_alarm_seconds.attr,
-	&dev_attr_alarm_minutes.attr,
-	&dev_attr_alarm_hours.attr,
-	&dev_attr_alarm_mday.attr,
-	NULL,
-};
-
-static const struct attribute_group
-ds1685_rtc_sysfs_alarm_grp = {
-	.name = "alarm",
-	.attrs = ds1685_rtc_sysfs_alarm_attrs,
-};
 #endif /* CONFIG_RTC_DS1685_SYSFS_REGS */
 
 
@@ -1715,14 +1504,6 @@ ds1685_rtc_sysfs_register(struct device *dev)
 	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4b_grp);
 	if (ret)
 		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_time_grp);
-	if (ret)
-		return ret;
-
-	ret = sysfs_create_group(&dev->kobj, &ds1685_rtc_sysfs_alarm_grp);
-	if (ret)
-		return ret;
 #endif
 	return 0;
 }
@@ -1744,8 +1525,6 @@ ds1685_rtc_sysfs_unregister(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrld_grp);
 	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4a_grp);
 	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_ctrl4b_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_time_grp);
-	sysfs_remove_group(&dev->kobj, &ds1685_rtc_sysfs_alarm_grp);
 #endif
 
 	return 0;
-- 
2.17.1

