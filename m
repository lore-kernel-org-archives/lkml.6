Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeCLXJk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:09:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46185 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:09:38 -0400
X-Google-Smtp-Source: AG47ELuM1Fu4hOL/VnZFmles6JDb3oebQCj0yE8kT6Lv9UqqnVjCEKz/QESqezYZmnBQg2o/CBoEiQ==
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: alps - Demystify trackstick initialization for v3 and v6 protocols
Date: Tue, 13 Mar 2018 00:09:15 +0100
Message-Id: <20180312230915.26050-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cite "Not sure what this does, but it is absolutely essential".

Extract initialization of trackstick part when touchpad is in passthrought
mode for v3 and v6 protocols into own function. Initialization for v3 is:
setscale11, setscale11, setscale11, nibble 0x9, nibble 0x4. Initialization
for v6 is: setscale11, setscale11, setscale11, setrate 0xC8, setrate 0x14.
Nibbles 0x9 and 0x4 for v3 protocol correspondent to setrate 0xC8 and 0x14,
therefore these sequences are same.

When touchpad is in passthrought mode, then OS communicates with trackstick
and this sequence is some magic vendor PS/2 command to put trackstick into
"extended" mode. After that sequence trackstick starts reporting packets in
some vendor 4 bytes format (first byte is always 0xE8).

Next step after configuring trackstick to be in "extended" mode, is to
configure touchpad for v3 protocol to expect that trackstick reports data
in "extended" mode. For v3 protocol this is done by setting bit 1 in
register 0xC2C8 (offset 0x08 from base address 0xC2C0).

When both touchpad and trackstick are not configured for "extended" mode
then touchpad reports trackstick packets in different format, which is not
supported by psmouse/alps driver (yet).

In Cirque documentation GP-AN- 130823 INTERFACING TO GEN4 OVER I2C (PDF)
available at http://www.cirque.com/gen4-dev-resources is Logical Address
0xC2C8 named as PS2AuxControl and Bit Number 1 as ProcessAuxExtendedData
with description: Auxiliary device data is assumed to be extended data when
set.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c | 80 ++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index dbe57da8c1a1..010c1bcdb06d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2063,14 +2063,11 @@ static int alps_hw_init_v1_v2(struct psmouse *psmouse)
 	return 0;
 }
 
-static int alps_hw_init_v6(struct psmouse *psmouse)
+/* Must be in passthrough mode when calling this function */
+static int alps_trackstick_enter_extended_mode_v3_v6(struct psmouse *psmouse)
 {
 	unsigned char param[2] = {0xC8, 0x14};
 
-	/* Enter passthrough mode to let trackpoint enter 6byte raw mode */
-	if (alps_passthrough_mode_v2(psmouse, true))
-		return -1;
-
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
@@ -2078,9 +2075,25 @@ static int alps_hw_init_v6(struct psmouse *psmouse)
 	    ps2_command(&psmouse->ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
 		return -1;
 
+	return 0;
+}
+
+static int alps_hw_init_v6(struct psmouse *psmouse)
+{
+	int ret;
+
+	/* Enter passthrough mode to let trackpoint enter 6byte raw mode */
+	if (alps_passthrough_mode_v2(psmouse, true))
+		return -1;
+
+	ret = alps_trackstick_enter_extended_mode_v3_v6(psmouse);
+
 	if (alps_passthrough_mode_v2(psmouse, false))
 		return -1;
 
+	if (ret)
+		return ret;
+
 	if (alps_absolute_mode_v6(psmouse)) {
 		psmouse_err(psmouse, "Failed to enable absolute mode\n");
 		return -1;
@@ -2154,10 +2167,18 @@ static int alps_probe_trackstick_v3_v7(struct psmouse *psmouse, int reg_base)
 
 static int alps_setup_trackstick_v3(struct psmouse *psmouse, int reg_base)
 {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	int ret = 0;
+	int reg_val;
 	unsigned char param[4];
 
+	/*
+	 * We need to configure trackstick to report data for touchpad in
+	 * extended format. And also we need to tell touchpad to expect data
+	 * from trackstick in extended format. Without this configuration
+	 * trackstick packets sent from touchpad are in basic format which is
+	 * different from what we expect.
+	 */
+
 	if (alps_passthrough_mode_v3(psmouse, reg_base, true))
 		return -EIO;
 
@@ -2175,39 +2196,36 @@ static int alps_setup_trackstick_v3(struct psmouse *psmouse, int reg_base)
 		ret = -ENODEV;
 	} else {
 		psmouse_dbg(psmouse, "trackstick E7 report: %3ph\n", param);
-
-		/*
-		 * Not sure what this does, but it is absolutely
-		 * essential. Without it, the touchpad does not
-		 * work at all and the trackstick just emits normal
-		 * PS/2 packets.
-		 */
-		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-		    alps_command_mode_send_nibble(psmouse, 0x9) ||
-		    alps_command_mode_send_nibble(psmouse, 0x4)) {
-			psmouse_err(psmouse,
-				    "Error sending magic E6 sequence\n");
+		if (alps_trackstick_enter_extended_mode_v3_v6(psmouse)) {
+			psmouse_err(psmouse, "Failed to enter into trackstick extended mode\n");
 			ret = -EIO;
-			goto error;
 		}
+	}
+
+	if (alps_passthrough_mode_v3(psmouse, reg_base, false))
+		return -EIO;
+
+	if (ret)
+		return ret;
 
+	if (alps_enter_command_mode(psmouse))
+		return -EIO;
+
+	reg_val = alps_command_mode_read_reg(psmouse, reg_base + 0x08);
+	if (reg_val == -1) {
+		ret = -EIO;
+	} else {
 		/*
-		 * This ensures the trackstick packets are in the format
-		 * supported by this driver. If bit 1 isn't set the packet
-		 * format is different.
+		 * Tell touchpad that trackstick is now in extended mode.
+		 * If bit 1 isn't set the packet format is different.
 		 */
-		if (alps_enter_command_mode(psmouse) ||
-		    alps_command_mode_write_reg(psmouse,
-						reg_base + 0x08, 0x82) ||
-		    alps_exit_command_mode(psmouse))
+		reg_val |= BIT(1);
+		if (__alps_command_mode_write_reg(psmouse, reg_val))
 			ret = -EIO;
 	}
 
-error:
-	if (alps_passthrough_mode_v3(psmouse, reg_base, false))
-		ret = -EIO;
+	if (alps_exit_command_mode(psmouse))
+		return -EIO;
 
 	return ret;
 }
-- 
2.11.0
