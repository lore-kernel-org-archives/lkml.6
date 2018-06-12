Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54672C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012172086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QEmHPWM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012172086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeFLUUx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:20:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36665 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933155AbeFLUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:20:49 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so127883plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1eLHrmdXiKJsuu874ij/O9TARs/bvDe+/anXepahwDg=;
        b=QEmHPWM2ZJVFFzaMT1b0WyPy/pBlDkfB6qZ3tqPHgdAeRdWYqe/rVpq3ehMI3rl0qw
         oUEfiZgXYf/FuJmn3UjBfkbeI9m6Am/r1Ah00y9XhVzeFG28PPlobCk7GlmrIwNW1i9Q
         TYkluy2qKukR+7oyZLKsoGdzzaBiMiFD4sQns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1eLHrmdXiKJsuu874ij/O9TARs/bvDe+/anXepahwDg=;
        b=NXdZIB68QmJIlyGOJlL4t4pwPCplBijLBNUKdUVzui32AcZ8skqzgAIkv8yNCaORmY
         1ARW3mi1Tf+ykvs7VJdrshMn3KTdC2V6B+X054Geq9ki7rQLyjtrW4w6PaTROUjGYOgd
         o3aWy8v+qzaJCw3vxmqMoJ2a3BcySFbMjMmvN2MtTC/4yNxThoyt1gh12rlJ+WgTAWpH
         MqdgiJSDAbraCy2jlfPgcGZf9tCDdZOGLeEUEFFOrFIaWlRMts77fRUSz2FcG30SRpFH
         QPRKVl8HZcgkxbFoj/AqDKwAp16J2w38GT6E9u5hERhnHDkq8ohp7+a4U60n23wVO4pk
         cJ9Q==
X-Gm-Message-State: APt69E0xs8VNDXlkYPmwFz9x2SxM0Ojzg2X9LqBbrzHvrsN+44QTFsbX
        2B4NgQaS55xC+HEsD/U8kHNoTA==
X-Google-Smtp-Source: ADUXVKI1yskvJN1WuayyO2gsYAC83wm0lv5BQQzhHSGXNCpss+I7NzBbzV6ITSB8tvLziqirMeXmjQ==
X-Received: by 2002:a17:902:8a8c:: with SMTP id p12-v6mr1987046plo.94.1528834849222;
        Tue, 12 Jun 2018 13:20:49 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id z28-v6sm1136732pfl.169.2018.06.12.13.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:20:47 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rhyland Klein <rklein@nvidia.com>,
        Alexandru Stan <amstan@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Phil Reid <preid@electromag.com.au>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] power: supply: sbs-battery: don't assume MANUFACTURER_DATA formats
Date:   Tue, 12 Jun 2018 13:20:41 -0700
Message-Id: <20180612202042.107603-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was originally submitted for the TI BQ20Z75 battery IC
(commit a7640bfa10c5 ("power_supply: Add driver for TI BQ20Z75 gas gauge
IC")) and later renamed to express generic SBS support. While it's
mostly true that this driver implemented a standard SBS command set, it
takes liberties with the REG_MANUFACTURER_DATA register. This register
is specified in the SBS spec, but it doesn't make any mention of what
its actual contents are.

We've sort of noticed this optionality previously, with commit
17c6d3979e5b ("sbs-battery: make writes to ManufacturerAccess
optional"), where we found that some batteries NAK writes to this
register.

What this really means is that so far, we've just been lucky that most
batteries have either been compatible with the TI chip, or else at least
haven't reported highly-unexpected values.

For instance, one battery I have here seems to report either 0x0000 or
0x0100 to the MANUFACTURER_ACCESS_STATUS command -- while this seems to
match either Wake Up (bits[11:8] = 0000b) or Normal Discharge
(bits[11:8] = 0001b) status for the TI part [1], they don't seem to
actually correspond to real states (for instance, I never see 0101b =
Charge, even when charging).

On other batteries, I'm getting apparently random data in return, which
means that occasionally, we interpret this as "battery not present" or
"battery is not healthy".

All in all, it seems to be a really bad idea to make assumptions about
REG_MANUFACTURER_DATA, unless we already know what battery we're using.
Therefore, this patch reimplements the "present" and "health" checks to
the following on most SBS batteries:

1. HEALTH: report "unknown" -- I couldn't find a standard SBS command
   that gives us much useful here
2. PRESENT: just send a REG_STATUS command; if it succeeds, then the
   battery is present

Also, we stop sending MANUFACTURER_ACCESS_SLEEP to non-TI parts. I have
no proof that this is useful and supported.

If someone explicitly provided a 'ti,bq20z75' compatible property, then
we continue to use the existing TI command behaviors, and we effectively
revert commit 17c6d3979e5b ("sbs-battery: make writes to
ManufacturerAccess optional") to again make these commands required.

[1] http://www.ti.com/lit/er/sluu265a/sluu265a.pdf

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rhyland Klein <rklein@nvidia.com>
---
v2:
 * don't stub out POWER_SUPPLY_PROP_PRESENT from sbs_data[]
 * use if/else instead of switch/case

v3:
 * pull 'return 0' out of if/else, to satisfy braindead tooling

v4:
 * make ManufacturerAccess non-optional for TI parts again

v5: no change
---
 drivers/power/supply/sbs-battery.c | 67 ++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83d7b4115857..8ba6abf584de 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/power/sbs-battery.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
@@ -156,6 +157,9 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME
 };
 
+/* Supports special manufacturer commands from TI BQ20Z75 IC. */
+#define SBS_FLAGS_TI_BQ20Z75		BIT(0)
+
 struct sbs_info {
 	struct i2c_client		*client;
 	struct power_supply		*power_supply;
@@ -168,6 +172,7 @@ struct sbs_info {
 	u32				poll_retry_count;
 	struct delayed_work		work;
 	struct mutex			mode_lock;
+	u32				flags;
 };
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
@@ -315,17 +320,41 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 static int sbs_get_battery_presence_and_health(
 	struct i2c_client *client, enum power_supply_property psp,
 	union power_supply_propval *val)
+{
+	int ret;
+
+	if (psp == POWER_SUPPLY_PROP_PRESENT) {
+		/* Dummy command; if it succeeds, battery is present. */
+		ret = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+		if (ret < 0)
+			val->intval = 0; /* battery disconnected */
+		else
+			val->intval = 1; /* battery present */
+	} else { /* POWER_SUPPLY_PROP_HEALTH */
+		/* SBS spec doesn't have a general health command. */
+		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int sbs_get_ti_battery_presence_and_health(
+	struct i2c_client *client, enum power_supply_property psp,
+	union power_supply_propval *val)
 {
 	s32 ret;
 
 	/*
 	 * Write to ManufacturerAccess with ManufacturerAccess command
-	 * and then read the status. Do not check for error on the write
-	 * since not all batteries implement write access to this command,
-	 * while others mandate it.
+	 * and then read the status.
 	 */
-	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
-			    MANUFACTURER_ACCESS_STATUS);
+	ret = sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
+				  MANUFACTURER_ACCESS_STATUS);
+	if (ret < 0) {
+		if (psp == POWER_SUPPLY_PROP_PRESENT)
+			val->intval = 0; /* battery removed */
+		return ret;
+	}
 
 	ret = sbs_read_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr);
 	if (ret < 0) {
@@ -600,7 +629,12 @@ static int sbs_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret = sbs_get_battery_presence_and_health(client, psp, val);
+		if (client->flags & SBS_FLAGS_TI_BQ20Z75)
+			ret = sbs_get_ti_battery_presence_and_health(client,
+								     psp, val);
+		else
+			ret = sbs_get_battery_presence_and_health(client, psp,
+								  val);
 		if (psp == POWER_SUPPLY_PROP_PRESENT)
 			return 0;
 		break;
@@ -806,6 +840,7 @@ static int sbs_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
+	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
 	chip->client = client;
 	chip->enable_detection = false;
 	psy_cfg.of_node = client->dev.of_node;
@@ -911,16 +946,19 @@ static int sbs_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct sbs_info *chip = i2c_get_clientdata(client);
+	int ret;
 
 	if (chip->poll_time > 0)
 		cancel_delayed_work_sync(&chip->work);
 
-	/*
-	 * Write to manufacturer access with sleep command.
-	 * Support is manufacturer dependend, so ignore errors.
-	 */
-	sbs_write_word_data(client, sbs_data[REG_MANUFACTURER_DATA].addr,
-		MANUFACTURER_ACCESS_SLEEP);
+	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
+		/* Write to manufacturer access with sleep command. */
+		ret = sbs_write_word_data(client,
+					  sbs_data[REG_MANUFACTURER_DATA].addr,
+					  MANUFACTURER_ACCESS_SLEEP);
+		if (chip->is_present && ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -941,7 +979,10 @@ MODULE_DEVICE_TABLE(i2c, sbs_id);
 
 static const struct of_device_id sbs_dt_ids[] = {
 	{ .compatible = "sbs,sbs-battery" },
-	{ .compatible = "ti,bq20z75" },
+	{
+		.compatible = "ti,bq20z75",
+		.data = (void *)SBS_FLAGS_TI_BQ20Z75,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sbs_dt_ids);
-- 
2.18.0.rc1.242.g61856ae69a-goog

