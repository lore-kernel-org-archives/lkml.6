Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C73C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A43204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnqDl2Ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A43204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbeJICDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeJICDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D948214C4;
        Mon,  8 Oct 2018 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024643;
        bh=32L7wp4Hptch2senNeoGcWZdRQ/p6p5kWof+I/aelOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnqDl2EwBGD6R9kcBqXikCMKEylN3tbpsLhFFbGm7BEQGQXQfOfi4x21G3YIpzcTI
         v6I0Pf5NLUi4oX2lS6ih+fEni9DlGYVLoCLL1reREND0rAiAgAUf9vF/AdlndW9/oL
         8qv0EbHU81sasQKT17X7odJFVOaO4eLWDCPr0+2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 106/168] HID: i2c-hid: Dont reset device upon system resume
Date:   Mon,  8 Oct 2018 20:31:26 +0200
Message-Id: <20181008175624.083609780@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 52cf93e63ee672a92f349edc6ddad86ec8808fd8 ]

Raydium touchscreen triggers interrupt storm after system-wide suspend:

	[ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/65535)

According to Raydium, Windows driver does not reset the device after system
resume.

The HID over I2C spec does specify a reset should be used at intialization, but
it doesn't specify if reset is required for system suspend.

Tested this patch on other i2c-hid touchpanels I have and those touchpanels do
work after S3 without doing reset. If any regression happens to other
touchpanel vendors, we can use quirk for Raydium devices.

There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep it
there.

Cc: Aaron Ma <aaron.ma@canonical.com>
Cc: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ids.h         |    4 ----
 drivers/hid/i2c-hid/i2c-hid.c |   13 +++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,10 +528,6 @@
 #define I2C_VENDOR_ID_HANTICK		0x0911
 #define I2C_PRODUCT_ID_HANTICK_5288	0x5288
 
-#define I2C_VENDOR_ID_RAYD		0x2386
-#define I2C_PRODUCT_ID_RAYD_3118	0x3118
-#define I2C_PRODUCT_ID_RAYD_4B33	0x4B33
-
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
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
 
@@ -1237,11 +1233,16 @@ static int i2c_hid_resume(struct device
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


