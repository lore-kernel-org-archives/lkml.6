Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E757FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR3E3GMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B126821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbeJICHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeJICHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:07:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31AB520645;
        Mon,  8 Oct 2018 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024851;
        bh=bBrBJCIE8cROmmmruAs4S82mrt0HLjpYDoGoUOseqYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fR3E3GMqa4f9/+jOSdjOgqi23XDF5sAqXvg235eGOxIR3iRbydnr+L+gZitzasSxO
         slhkO6Ha7/Ula+R1tYUArNxtl7F4oEXdKqy1GzQ4rtudYynBfe9OqN4OTlBqki13D5
         qTWisU3CSn4nYeOWxqlNSkG+OQADb6w42R4LHlaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anisse Astier <anisse@astier.eu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.18 167/168] HID: i2c-hid: disable runtime PM operations on hantick touchpad
Date:   Mon,  8 Oct 2018 20:32:27 +0200
Message-Id: <20181008175626.405792150@linuxfoundation.org>
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

From: Anisse Astier <anisse@astier.eu>

commit 807588ac92018bde88a1958f546438e840eb0158 upstream.

This hantick HTIX5288 touchpad can quickly fall in a wrong state if
there are too many open/close operations. This will either make it stop
reporting any input, or will shift all the input reads by a few bytes,
making it impossible to decode.

Here, we never release the probed touchpad runtime pm while the driver
is loaded, which should disable all runtime pm suspend/resumes.

This fast repetition of sleep/wakeup is also more likely to happen when
using runtime PM, which is why the quirk is done there, and not for all
power downs, which would include suspend or module removal.

Signed-off-by: Anisse Astier <anisse@astier.eu>
Cc: stable@vger.kernel.org
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Philip Müller <philm@manjaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -48,6 +48,7 @@
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
 #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
 #define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
+#define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(3)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -169,7 +170,8 @@ static const struct i2c_hid_quirks {
 	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
-		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ 0, 0 }
@@ -1106,7 +1108,9 @@ static int i2c_hid_probe(struct i2c_clie
 		goto err_mem_free;
 	}
 
-	pm_runtime_put(&client->dev);
+	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
+		pm_runtime_put(&client->dev);
+
 	return 0;
 
 err_mem_free:
@@ -1132,7 +1136,8 @@ static int i2c_hid_remove(struct i2c_cli
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid;
 
-	pm_runtime_get_sync(&client->dev);
+	if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
+		pm_runtime_get_sync(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);


