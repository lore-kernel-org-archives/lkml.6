Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52BFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986DD2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986DD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeHaOBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:01:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeHaOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D744023132;
        Fri, 31 Aug 2018 09:54:23 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB7242166B41;
        Fri, 31 Aug 2018 09:54:20 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: i2c-hid: enforce I2C_HID_QUIRK_RESEND_REPORT_DESCR
Date:   Fri, 31 Aug 2018 11:54:17 +0200
Message-Id: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 09:54:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 09:54:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec states that the HID devices should allow
the host to query the HID descriptor at any time.

Some devices require the HID descriptor to be set
on resume, or they will fail.

Instead of having a growing list of blacklisted devices
make the call part of the general resume process
so we can remove this list.

Tested on a Dell XPS 9360 and a Surface 3.

link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 57126f6837bb..17ec57c62a0b 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -47,7 +47,7 @@
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
-#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
+/* reserved: I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2) */
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -170,12 +170,6 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
-	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
-	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
-		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
 };
 
@@ -1245,11 +1239,9 @@ static int i2c_hid_resume(struct device *dev)
 	 * after resume, after this it will be back normal.
 	 * otherwise it issues too many incomplete reports.
 	 */
-	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
-		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
-		if (ret)
-			return ret;
-	}
+	ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
+	if (ret)
+		return ret;
 
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
-- 
2.14.3

