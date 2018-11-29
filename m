Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE8CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6572A2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcnD0Q8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6572A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeK3BTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeK3BTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:19:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E141521019;
        Thu, 29 Nov 2018 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500859;
        bh=PYEF3MqGwKIR17j7TLBVlL+On0iM+Xw9U8ZTRIDItaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcnD0Q8Q7ISTFiJk1lFx5gme4T06ce0A9SXKSken+qugOGT6sq/cwa7uLOJYmFHc4
         8cT39OFSZ0ygTjSEAwFUnxUBgRRk5EWENnm5Re9TeXbF91NnTGKEmj5eAID954GCTz
         iNp8qDHjAjlHOiHvE0Smi49TrQtMX1sAOk/7/3/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 27/83] Input: xpad - use ida() for finding the pad_nr
Date:   Thu, 29 Nov 2018 15:11:45 +0100
Message-Id: <20181129140139.525654428@linuxfoundation.org>
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

[ Upstream commit e3b651745a03810efffd7ebf2a9b5be65fb70ec3 ]

The pad_nr corresponds to the lit up LED on the controller. Therefore there
should be no gaps when enumerating. Currently a LED is only re-assigned
after a controller is re-connected 4 times.

This patch uses ida to track connected pads - this way we can re-assign
freed up pad number immediately.

Consider the following case:
1. pad A is connected and gets pad_nr = 0
2. pad B is connected and gets pad_nr = 1
3. pad A is disconnected
4. pad A is connected again

using ida_simple_get() controller A now correctly gets pad_nr = 0 again.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 60ebd78a49a6..a395980bb816 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -244,7 +244,6 @@ static const signed short xpad_btn_triggers[] = {
 	-1
 };
 
-
 static const signed short xpad360_btn[] = {  /* buttons for x360 controller */
 	BTN_TL, BTN_TR,		/* Button LB/RB */
 	BTN_MODE,		/* The big X button */
@@ -347,7 +346,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
-	unsigned long pad_nr;		/* the order x360 pads were attached */
+	int pad_nr;			/* the order x360 pads were attached */
 };
 
 /*
@@ -883,6 +882,9 @@ static int xpad_init_ff(struct usb_xpad *xpad) { return 0; }
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 #include <linux/leds.h>
+#include <linux/idr.h>
+
+static DEFINE_IDA(xpad_pad_seq);
 
 struct xpad_led {
 	char name[16];
@@ -964,7 +966,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq = ATOMIC_INIT(-1);
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -976,9 +977,13 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->pad_nr = atomic_inc_return(&led_seq);
+	xpad->pad_nr = ida_simple_get(&xpad_pad_seq, 0, 0, GFP_KERNEL);
+	if (xpad->pad_nr < 0) {
+		error = xpad->pad_nr;
+		goto err_free_mem;
+	}
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
+	snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -986,16 +991,19 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	led_cdev->brightness_set = xpad_led_set;
 
 	error = led_classdev_register(&xpad->udev->dev, led_cdev);
-	if (error) {
-		kfree(led);
-		xpad->led = NULL;
-		return error;
-	}
+	if (error)
+		goto err_free_id;
 
 	/* Light up the segment corresponding to controller number */
 	xpad_identify_controller(xpad);
-
 	return 0;
+
+err_free_id:
+	ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
+err_free_mem:
+	kfree(led);
+	xpad->led = NULL;
+	return error;
 }
 
 static void xpad_led_disconnect(struct usb_xpad *xpad)
@@ -1004,6 +1012,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 
 	if (xpad_led) {
 		led_classdev_unregister(&xpad_led->led_cdev);
+		ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
 		kfree(xpad_led);
 	}
 }
@@ -1013,7 +1022,6 @@ static void xpad_led_disconnect(struct usb_xpad *xpad) { }
 static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
-
 static int xpad_open(struct input_dev *dev)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
-- 
2.17.1



