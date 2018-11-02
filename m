Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D5BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194E2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsupSOVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5194E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeKCDtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E8D20847;
        Fri,  2 Nov 2018 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184097;
        bh=4tZNb8Yh2VXVC1+0V3y0XizUGLU12bRbJicDBievKHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsupSOVWArk9g7b46BqdCPNjG6nQQ80bM9NpvFQfzIgHcLFtHktVHRpKpNTZ75gQ2
         rZ3JbyvPQBHkq+7KiQNHhghyyQcRNQsuHpnrg55/B5SJk+hBEnaF8iCDoIH7OjHrjT
         pBDcfAuHIxmTQSloJnPu10mNDgcKDsFRiAmKAiG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 078/150] HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling
Date:   Fri,  2 Nov 2018 19:34:00 +0100
Message-Id: <20181102182909.019218166@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



