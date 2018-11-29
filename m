Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D839C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B919B208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0O/oLtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B919B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeK3BVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbeK3BVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:21:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F339D208E7;
        Thu, 29 Nov 2018 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500981;
        bh=RHPm3PRQ+RON6QS6lbhgIzpdNMsXcZCoputW7EQb6Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0O/oLtKaiM6ohOz+PMpWMtcc3cxbwrHRzaRTotiA/5xgF891KsONCmnu3X9NkbmW
         RU7IlNHwRz4nDO3yETUqHxuV84fT+RAd5iI6hXoPIYJK4WoC3ayIUy29WRmkSAHDFt
         IWEHda3TaBI3TMAkkb/Lpamr7zCXLlzE8aI2LDso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 32/83] Input: xpad - query wireless controller state at init
Date:   Thu, 29 Nov 2018 15:11:50 +0100
Message-Id: <20181129140139.740350139@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aba54876bb38dde81abead1ed1936eb04fa30ca9 ]

When we initialize the driver/device, we really don't know how many
controllers are connected.  So send a "query presence" command to the
base-station. (Command discovered by Zachary Lund)

Presence packet taken from:

https://github.com/computerquip/xpad5

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 652efb284e09..ff368860a5f9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -770,6 +770,33 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 	}
 }
 
+static int xpad_inquiry_pad_presence(struct usb_xpad *xpad)
+{
+	int retval;
+
+	mutex_lock(&xpad->odata_mutex);
+
+	xpad->odata[0] = 0x08;
+	xpad->odata[1] = 0x00;
+	xpad->odata[2] = 0x0F;
+	xpad->odata[3] = 0xC0;
+	xpad->odata[4] = 0x00;
+	xpad->odata[5] = 0x00;
+	xpad->odata[6] = 0x00;
+	xpad->odata[7] = 0x00;
+	xpad->odata[8] = 0x00;
+	xpad->odata[9] = 0x00;
+	xpad->odata[10] = 0x00;
+	xpad->odata[11] = 0x00;
+	xpad->irq_out->transfer_buffer_length = 12;
+
+	retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+
+	mutex_unlock(&xpad->odata_mutex);
+
+	return retval;
+}
+
 #ifdef CONFIG_JOYSTICK_XPAD_FF
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
@@ -1264,9 +1291,22 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
 			goto err_deinit_input;
+
+		/*
+		 * Send presence packet.
+		 * This will force the controller to resend connection packets.
+		 * This is useful in the case we activate the module after the
+		 * adapter has been plugged in, as it won't automatically
+		 * send us info about the controllers.
+		 */
+		error = xpad_inquiry_pad_presence(xpad);
+		if (error)
+			goto err_kill_in_urb;
 	}
 	return 0;
 
+err_kill_in_urb:
+	usb_kill_urb(xpad->irq_in);
 err_deinit_input:
 	xpad_deinit_input(xpad);
 err_deinit_output:
-- 
2.17.1



