Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE84C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C82133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY31dgWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeK3BTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CAD21019;
        Thu, 29 Nov 2018 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500849;
        bh=6ukXugA9CzzD3iYlz575eISC70KnOTMhB6J+4NSDgAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MY31dgWDa4CY9ZacskK3Pl9mPJuFTum3odnJAWY8Epp6eZ1LYlXs1DVkIE9w0DE3b
         NeUosRVEY/0h8kQmI5r0kNMqh1GzJr5Y//J/GNbpIYptldRJ6QInihBCl35yAk1vzA
         ATz0l3bUKSyGbNIKND9vlq0Nh9/ZxArG8tGfceEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 23/83] Input: xpad - re-send LED command on present event
Date:   Thu, 29 Nov 2018 15:11:41 +0100
Message-Id: <20181129140139.366260661@linuxfoundation.org>
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

[ Upstream commit cae705baa40b2c20de8f9bb79ef4bcc6b2418c7c ]

The controller only receives commands when its present. So for the
correct LED to be lit the LED command has to be sent on the present
event.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 5606e66ca5a5..a66720136290 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -346,6 +346,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
+	unsigned long led_no;		/* led to lit on xbox360 controllers */
 };
 
 /*
@@ -490,6 +491,8 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
+static void xpad_identify_controller(struct usb_xpad *xpad);
+
 /*
  * xpad360w_process_packet
  *
@@ -512,6 +515,11 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
 			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
+			/*
+			 * Light up the segment corresponding to
+			 * controller number.
+			 */
+			xpad_identify_controller(xpad);
 		} else
 			xpad->pad_present = 0;
 	}
@@ -936,6 +944,12 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 	mutex_unlock(&xpad->odata_mutex);
 }
 
+static void xpad_identify_controller(struct usb_xpad *xpad)
+{
+	/* Light up the segment corresponding to controller number */
+	xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
+}
+
 static void xpad_led_set(struct led_classdev *led_cdev,
 			 enum led_brightness value)
 {
@@ -947,8 +961,7 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq	= ATOMIC_INIT(-1);
-	unsigned long led_no;
+	static atomic_t led_seq = ATOMIC_INIT(-1);
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -960,9 +973,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	led_no = atomic_inc_return(&led_seq);
+	xpad->led_no = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->led_no);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -976,10 +989,8 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 		return error;
 	}
 
-	/*
-	 * Light up the segment corresponding to controller number
-	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+	/* Light up the segment corresponding to controller number */
+	xpad_identify_controller(xpad);
 
 	return 0;
 }
@@ -996,6 +1007,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
+static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
 
-- 
2.17.1



