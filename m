Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4214E20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmVoNGcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJYWnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbeJYWnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16FEB20834;
        Thu, 25 Oct 2018 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476644;
        bh=UjI/cUvwhWgkunjAD06i5+BQ9WF+lTGLdp3XjpstTZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmVoNGcFvW8CIAzrnwpg5aWDPlV7dF9BoCb1rqiAmXbGXVVhu2YAqymGYTZ8Tztg1
         dzlOs+ty5WK4Pz6bURogfAT9PTVcXYz7heVACUYNzw4yAtgTbcteREHEOPSRla+/F8
         zDMa/nFVlPfAuCOL9rr3vhlOJacptumYjlywYVLI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 8/8] HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling
Date:   Thu, 25 Oct 2018 10:10:29 -0400
Message-Id: <20181025141029.213274-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141029.213274-1-sashal@kernel.org>
References: <20181025141029.213274-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit afbb1169ed5b58cfca017e368b53e019cf285853 ]

Commit 52cf93e63ee6 ("HID: i2c-hid: Don't reset device upon system resume")
removes the need for the RESEND_REPORT_DESCR quirk for Raydium devices, but
kept it for the SIS device id 10FB touchscreens, as the author of that
commit could not determine if the quirk is still necessary there.

I've tested suspend/resume on a Toshiba Click Mini L9W-B which is the
device for which this quirk was added in the first place and with the
"Don't reset device upon system resume" fix the quirk is no longer
necessary, so this commit removes it.

Note even better I also had some other devices with SIS touchscreens which
suspend/resume issues, where the RESEND_REPORT_DESCR quirk did not help.

I've also tested these devices with the "Don't reset device upon system
resume" fix and I'm happy to report that that fix also fixes touchscreen
resume on the following devices:

Asus T100HA
Asus T200TA
Peaq C1010

Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h         |  1 -
 drivers/hid/i2c-hid/i2c-hid.c | 18 +++---------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index eee6b79fb131..ae5b72269e27 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -974,7 +974,6 @@
 #define USB_DEVICE_ID_SIS817_TOUCH	0x0817
 #define USB_DEVICE_ID_SIS_TS		0x1013
 #define USB_DEVICE_ID_SIS1030_TOUCH	0x1030
-#define USB_DEVICE_ID_SIS10FB_TOUCH	0x10fb
 
 #define USB_VENDOR_ID_SKYCABLE			0x1223
 #define	USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER	0x3F07
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 37013b58098c..d17cf6e323b2 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -47,8 +47,7 @@
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
-#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
-#define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(3)
+#define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -172,8 +171,6 @@ static const struct i2c_hid_quirks {
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
@@ -1241,22 +1238,13 @@ static int i2c_hid_resume(struct device *dev)
 
 	/* Instead of resetting device, simply powers the device on. This
 	 * solves "incomplete reports" on Raydium devices 2386:3118 and
-	 * 2386:4B33
+	 * 2386:4B33 and fixes various SIS touchscreens no longer sending
+	 * data after a suspend/resume.
 	 */
 	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
 	if (ret)
 		return ret;
 
-	/* Some devices need to re-send report descr cmd
-	 * after resume, after this it will be back normal.
-	 * otherwise it issues too many incomplete reports.
-	 */
-	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
-		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
 		return ret;
-- 
2.17.1

