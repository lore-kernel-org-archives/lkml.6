Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E77C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507C12192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198535;
	bh=1zusJERhOeg081NzPEpnxe1ptW9MXZoaZdM2Uc6fNqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkU9UfNIMwXHDPP+IgDfbncC2G59ggADfVdA0JAamBwE6W6CF6vhZ6eYppaVqtTSI
	 hS+seUpOeuFqxEN9NBFXVLvgXJ8MVRWK4rmrDU50aY4s2jaWy+ahOHZYGVKpwty1zj
	 +R1i7Yj6yMDHzqXcmx73q9A2m2HK0qg22394GWqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfBOCmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbfBOCJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6A2206BA;
        Fri, 15 Feb 2019 02:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196567;
        bh=1zusJERhOeg081NzPEpnxe1ptW9MXZoaZdM2Uc6fNqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWB1gU/0ug73fp+SY/cSASuquWR/GmMTdsxb27E2kk8XHeNLe6WIFCU1BFagCKLYb
         GoaPCVed9YF+coitK0Bbrg9jFCzVvI7AsAG2JVUqr1WQf/8jqYBM0KNpMLinmWImD+
         aGuMZ5Zn3N/B8E1NCP2seYQMZNYC73YzH7jLZ1a0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 15/77] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date:   Thu, 14 Feb 2019 21:07:53 -0500
Message-Id: <20190215020855.176727-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 77ae0d8e401f083ca69c202502da4fc0e38cb1b7 ]

A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
but there's no input event from HID subsystem.

Turns out it reports some invalid data:
[   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00

After some trial and error, it's another device that doesn't work well
with ON/SLEEP commands. Disable runtime PM to fix the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 27519eb8ee63..81bc2f6b93a3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -459,6 +459,9 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
+#define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
+
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8555ce7e737b..c5edfa966343 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -179,6 +179,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ 0, 0 }
 };
 
-- 
2.19.1

