Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12091C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92C822513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGcxk9X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92C822513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeKOI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeKOI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:28:48 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C079622513;
        Wed, 14 Nov 2018 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234223;
        bh=T72EJMuj2HLn+ZWDwg3p5TPZkU1/0JbEr7f7nk355Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGcxk9X0DIHJW8+FX50jXwipeZwqSnCTorsQ4uV3vuX+Iq3ELshciM+JT8f9auYwC
         ZgGHP+qMThAp+gocKhi/C98cxattFxVJUW9mI17C64za8ccmVnaEaBtBbOzr6tma6D
         03qjV/C0Bno4/ZZevV/Lkpvy9FfjrNHAWx+pAaoc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 02/59] HID: i2c-hid: Add a small delay after sleep command for Raydium touchpanel
Date:   Wed, 14 Nov 2018 17:22:34 -0500
Message-Id: <20181114222335.99339-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 00b790ea545b6ef30221adef6e9c3707e03b82b5 ]

Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
although it works in display manager.

During user logging, the display manager exits, close the HID device,
then the device gets runtime suspended and powered off. The desktop
session begins shortly after, opens the HID device, then the device gets
runtime resumed and powered on.

If the trasition from display manager to desktop sesesion is fast, the
touchpanel cannot switch from powered off to powered on in short
timeframe. So add a small delay to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h         |  3 +++
 drivers/hid/i2c-hid/i2c-hid.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ae5b72269e27..7e61af2f0976 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -919,6 +919,9 @@
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
 
+#define I2C_VENDOR_ID_RAYDIUM		0x2386
+#define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
+
 #define USB_VENDOR_ID_RAZER            0x1532
 #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
 
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index d17cf6e323b2..d835fd02da4f 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -48,6 +48,7 @@
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
+#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -157,6 +158,8 @@ struct i2c_hid {
 
 	bool			irq_wake_enabled;
 	struct mutex		reset_lock;
+
+	unsigned long		sleep_delay;
 };
 
 static const struct i2c_hid_quirks {
@@ -171,6 +174,8 @@ static const struct i2c_hid_quirks {
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
+		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
 	{ 0, 0 }
 };
 
@@ -386,6 +391,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
+	unsigned long now, delay;
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
@@ -403,9 +409,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 			goto set_pwr_exit;
 	}
 
+	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
+	    power_state == I2C_HID_PWR_ON) {
+		now = jiffies;
+		if (time_after(ihid->sleep_delay, now)) {
+			delay = jiffies_to_usecs(ihid->sleep_delay - now);
+			usleep_range(delay, delay + 1);
+		}
+	}
+
 	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
 		0, NULL, 0, NULL, 0);
 
+	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
+	    power_state == I2C_HID_PWR_SLEEP)
+		ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
+
 	if (ret)
 		dev_err(&client->dev, "failed to change power setting.\n");
 
-- 
2.17.1

