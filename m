Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C24C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E4C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIFH2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:28:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIFH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:28:38 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fxkS6-0001Er-RZ; Thu, 06 Sep 2018 02:55:27 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>
Subject: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
Date:   Thu,  6 Sep 2018 10:55:18 +0800
Message-Id: <20180906025518.30191-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raydium touchscreen triggers interrupt storm after system-wide suspend:
[ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
report (58/65535)

According to Raydium, Windows driver does not reset the device after
system resume.

The HID over I2C spec does specify a reset should be used at
intialization, but it doesn't specify if reset is required for system
suspend.

Tested this patch on other i2c-hid touchpanels I have and those
touchpanels do work after S3 without doing reset. If any regression
happens to other touchpanel vendors, we can use quirk for Raydium
devices.

There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
it there.

Cc: Aaron Ma <aaron.ma@canonical.com>
Cc: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 Remove Raydium devices' ID and quirk.
 Rewording.

 drivers/hid/hid-ids.h         |  4 ----
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7da93d789080..e254ae802688 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -530,10 +530,6 @@
 #define I2C_VENDOR_ID_HANTICK		0x0911
 #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
 
-#define I2C_VENDOR_ID_RAYD		0x2386
-#define I2C_PRODUCT_ID_RAYD_3118	0x3118
-#define I2C_PRODUCT_ID_RAYD_4B33	0x4B33
-
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 57126f6837bb..f3076659361a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -170,12 +170,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
@@ -1237,11 +1233,16 @@ static int i2c_hid_resume(struct device *dev)
 	pm_runtime_enable(dev);
 
 	enable_irq(client->irq);
-	ret = i2c_hid_hwreset(client);
+
+	/* Instead of resetting device, simply powers the device on. This
+	 * solves "incomplete reports" on Raydium devices 2386:3118 and
+	 * 2386:4B33
+	 */
+	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	if (ret)
 		return ret;
 
-	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
+	/* Some devices need to re-send report descr cmd
 	 * after resume, after this it will be back normal.
 	 * otherwise it issues too many incomplete reports.
 	 */
-- 
2.17.1

