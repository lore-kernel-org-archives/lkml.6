Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ACEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F6C21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="beJmjkrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F6C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeK3BTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A38208E7;
        Thu, 29 Nov 2018 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500847;
        bh=Hw6enrK7/zn90U991yI4PjKQuMk+u7O6If8fw/BJdw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beJmjkrO6bCMypJGICh8bv5nkdBLdj2u5WHBqEZTL/Ahokt0CLPQQrJfAOVAw5fyl
         o7Z5Hej04DFEE7S0JfgJaISaDTmSJTcJOJpZV4wtScMbQjhm0J0wNCVXSWBIZABQKp
         cR7L+sjSWe2ZKk7iVDAwbVfJVBqZI2sTbtUVg26I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 22/83] Input: xpad - set the LEDs properly on XBox Wireless controllers
Date:   Thu, 29 Nov 2018 15:11:40 +0100
Message-Id: <20181129140139.318230802@linuxfoundation.org>
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

[ Upstream commit 75b7f05d2798ee3a1cc5bbdd54acd0e318a80396 ]

Based on Patch by Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>:
Add the logic to set the LEDs on XBox Wireless controllers.  Command
sequence found by sniffing the Windows data stream when plugging the
device in.

Updated based on comments on linux-input:
unify codepaths in xpad_send_led_command for wired/ wireless controller.
Also document command values for clarification.
All values tested on Xbox 360 Wireless Controller.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 50 +++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c4205ed022fd..5606e66ca5a5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -883,17 +883,57 @@ struct xpad_led {
 	struct usb_xpad *xpad;
 };
 
+/**
+ * @param command
+ *  0: off
+ *  1: all blink, then previous setting
+ *  2: 1/top-left blink, then on
+ *  3: 2/top-right blink, then on
+ *  4: 3/bottom-left blink, then on
+ *  5: 4/bottom-right blink, then on
+ *  6: 1/top-left on
+ *  7: 2/top-right on
+ *  8: 3/bottom-left on
+ *  9: 4/bottom-right on
+ * 10: rotate
+ * 11: blink, based on previous setting
+ * 12: slow blink, based on previous setting
+ * 13: rotate with two lights
+ * 14: persistent slow all blink
+ * 15: blink once, then previous setting
+ */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
+	command %= 16;
+
+	mutex_lock(&xpad->odata_mutex);
+
+	switch (xpad->xtype) {
+	case XTYPE_XBOX360:
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
 		xpad->irq_out->transfer_buffer_length = 3;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-		mutex_unlock(&xpad->odata_mutex);
+		break;
+	case XTYPE_XBOX360W:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x08;
+		xpad->odata[3] = 0x40 + command;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		break;
 	}
+
+	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	mutex_unlock(&xpad->odata_mutex);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
@@ -913,7 +953,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
-- 
2.17.1



