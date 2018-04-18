Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeDRI2K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:28:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53707 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeDRI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:28:08 -0400
From: Aaron Ma <aaron.ma@canonical.com>
To: aaron.ma@canonical.com, dan.carpenter@oracle.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: i2c-hid: Fix resume issue on Raydium touchscreen device
Date: Wed, 18 Apr 2018 16:27:57 +0800
Message-Id: <1524040077-6162-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <nycvar.YFH.7.76.1804121506360.28129@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1804121506360.28129@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Rayd touchscreen resumed from S3, it issues too many errors like:
i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)

And all the report data are corrupted, touchscreen is unresponsive.

Fix this by re-sending report description command after resume.
Add device ID as a quirk.

V2:
The V1 patch leads to the following static checker warning:

	drivers/hid/i2c-hid/i2c-hid.c:1244 i2c_hid_resume()
	info: return a literal instead of 'ret'

This test was inverted in V1 patch.
Change the condition of condition.

Cc: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/hid/hid-ids.h         |  3 +++
 drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5a3a7ead3012..0b5cc910f62e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -525,6 +525,9 @@
 #define I2C_VENDOR_ID_HANTICK		0x0911
 #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
 
+#define I2C_VENDOR_ID_RAYD		0x2386
+#define I2C_PRODUCT_ID_RAYD_3118	0x3118
+
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 97689e98e53f..963328674e93 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -47,6 +47,7 @@
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
+#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -171,6 +172,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
+	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
+		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
@@ -1220,6 +1223,16 @@ static int i2c_hid_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* RAYDIUM device (2386:3118) need to re-send report descr cmd
+	 * after resume, after this it will be back normal.
+	 * otherwise it issues too many incomplete reports.
+	 */
+	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
+		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
 		return ret;
-- 
2.14.3
