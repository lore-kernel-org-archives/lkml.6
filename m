Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeCaLWM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 07:22:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38599 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeCaLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 07:22:10 -0400
X-Google-Smtp-Source: AIpwx48NkP5a93LB3eSl9DqkdXoBolUAsjco7WWWmiIce31KAB7Pe544tIbJluVm2oZjNNDTt6et1A==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] input: xpad: avoid using __set_bit() for capabilities
Date: Sat, 31 Mar 2018 13:21:40 +0200
Message-Id: <20180331112143.18768-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

input_set_capability() and input_set_abs_param() will do it for you.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/xpad.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9d2688f3f961..cbf54082281d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1568,7 +1568,6 @@ static void xpad_close(struct input_dev *dev)
 static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 {
 	struct usb_xpad *xpad = input_get_drvdata(input_dev);
-	set_bit(abs, input_dev->absbit);
 
 	switch (abs) {
 	case ABS_X:
@@ -1628,10 +1627,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		input_dev->close = xpad_close;
 	}
 
-	__set_bit(EV_KEY, input_dev->evbit);
-
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
-		__set_bit(EV_ABS, input_dev->evbit);
 		/* set up axes */
 		for (i = 0; xpad_abs[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs[i]);
@@ -1639,21 +1635,21 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	/* set up standard buttons */
 	for (i = 0; xpad_common_btn[i] >= 0; i++)
-		__set_bit(xpad_common_btn[i], input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, xpad_common_btn[i]);
 
 	/* set up model-specific ones */
 	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
 	    xpad->xtype == XTYPE_XBOXONE) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
-			__set_bit(xpad360_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
 	} else {
 		for (i = 0; xpad_btn[i] >= 0; i++)
-			__set_bit(xpad_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, xpad_btn[i]);
 	}
 
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
-			__set_bit(xpad_btn_pad[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, xpad_btn_pad[i]);
 	}
 
 	/*
@@ -1670,7 +1666,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 
 	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
 		for (i = 0; xpad_btn_triggers[i] >= 0; i++)
-			__set_bit(xpad_btn_triggers[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY,
+					xpad_btn_triggers[i]);
 	} else {
 		for (i = 0; xpad_abs_triggers[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
-- 
2.16.2
