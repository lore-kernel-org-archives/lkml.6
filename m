Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeCaLWS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 07:22:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40370 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeCaLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 07:22:13 -0400
X-Google-Smtp-Source: AIpwx4+e/A0H/RJBmMhIUlhme/J8X0pOmSkjEAUPZiVQ8e7ZC7z5sKsENtpGusJwLdhtAARk/Aj6DQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] input: gamecon: avoid using __set_bit() for capabilities
Date: Sat, 31 Mar 2018 13:21:42 +0200
Message-Id: <20180331112143.18768-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180331112143.18768-1-marcus.folkesson@gmail.com>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

input_set_capability() and input_set_abs_param() will do it for you.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/gamecon.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index 2ffb2e8bdc3b..e3a9ef3d5f5a 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -862,7 +862,7 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 
 	case GC_N64:
 		for (i = 0; i < 10; i++)
-			__set_bit(gc_n64_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_n64_btn[i]);
 
 		for (i = 0; i < 2; i++) {
 			input_set_abs_params(input_dev, ABS_X + i, -127, 126, 0, 2);
@@ -879,26 +879,27 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 		break;
 
 	case GC_SNESMOUSE:
-		__set_bit(BTN_LEFT, input_dev->keybit);
-		__set_bit(BTN_RIGHT, input_dev->keybit);
-		__set_bit(REL_X, input_dev->relbit);
-		__set_bit(REL_Y, input_dev->relbit);
+		input_set_capability(input_dev, EV_KEY, BTN_LEFT);
+		input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
+		input_set_capability(input_dev, EV_REL, REL_X);
+		input_set_capability(input_dev, EV_REL, REL_Y);
 		break;
 
 	case GC_SNES:
 		for (i = 4; i < 8; i++)
-			__set_bit(gc_snes_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_snes_btn[i]);
 		/* fall through */
 	case GC_NES:
 		for (i = 0; i < 4; i++)
-			__set_bit(gc_snes_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_snes_btn[i]);
 		break;
 
 	case GC_MULTI2:
-		__set_bit(BTN_THUMB, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_THUMB);
 		/* fall through */
 	case GC_MULTI:
-		__set_bit(BTN_TRIGGER, input_dev->keybit);
+		input_set_capability(input_dev, EV_KEY, BTN_TRIGGER);
+		/* fall through */
 		break;
 
 	case GC_PSX:
@@ -906,15 +907,16 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 			input_set_abs_params(input_dev,
 					     gc_psx_abs[i], 4, 252, 0, 2);
 		for (i = 0; i < 12; i++)
-			__set_bit(gc_psx_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_psx_btn[i]);
+		break;
 
 		break;
 
 	case GC_DDR:
 		for (i = 0; i < 4; i++)
-			__set_bit(gc_psx_ddr_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_psx_ddr_btn[i]);
 		for (i = 0; i < 12; i++)
-			__set_bit(gc_psx_btn[i], input_dev->keybit);
+			input_set_capability(input_dev, EV_KEY, gc_psx_btn[i]);
 
 		break;
 	}
-- 
2.16.2
