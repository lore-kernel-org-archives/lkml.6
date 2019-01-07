Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96416C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4BC20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfAGG1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:27:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60213 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAGG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:27:08 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggONL-00082g-O7; Mon, 07 Jan 2019 06:27:04 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] HID: i2c-hid: Ignore input report if there's no data present on Elan touchpanels
Date:   Mon,  7 Jan 2019 14:26:56 +0800
Message-Id: <20190107062656.3065-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using Elan touchpads, the message floods:
[  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)

Though the message flood is annoying, the device it self works without
any issue. I suspect that the device in question takes too much time to
pull the IRQ back to high after I2C host has done reading its data.

Since the host receives all useful data, let's ignore the input report
when there's no data.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 Use dev_warn_once() to warn the user about the situation.

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8555ce7e737b..fd3b0ddace27 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -50,6 +50,7 @@
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
 #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
 #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
+#define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
+		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ 0, 0 }
 };
 
@@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
+	if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
+		dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but
+			      there's no data\n", __func__);
+		return;
+	}
+
 	if ((ret_size > size) || (ret_size < 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
-- 
2.17.1

