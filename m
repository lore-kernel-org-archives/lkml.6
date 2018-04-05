Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeDEN1A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:27:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751361AbeDENZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:53 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/8] Input: elantech - split device info into a separate structure
Date: Thu,  5 Apr 2018 15:25:33 +0200
Message-Id: <20180405132537.3218-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for SMBus device support, move static device
information that we query form the touchpad upon initialization into
separate structure. This will allow us to query the device without
allocating memory first.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 271 ++++++++++++++++++++++++-----------------
 drivers/input/mouse/elantech.h |  28 +++--
 2 files changed, 175 insertions(+), 124 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index db47a5e1d114..d485664f1563 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -24,7 +24,7 @@
 
 #define elantech_debug(fmt, ...)					\
 	do {								\
-		if (etd->debug)						\
+		if (etd->info.debug)					\
 			psmouse_printk(KERN_DEBUG, psmouse,		\
 					fmt, ##__VA_ARGS__);		\
 	} while (0)
@@ -105,7 +105,7 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
 	if (reg > 0x11 && reg < 0x20)
 		return -1;
 
-	switch (etd->hw_version) {
+	switch (etd->info.hw_version) {
 	case 1:
 		if (ps2_sliced_command(&psmouse->ps2dev, ETP_REGISTER_READ) ||
 		    ps2_sliced_command(&psmouse->ps2dev, reg) ||
@@ -137,7 +137,7 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
 
 	if (rc)
 		psmouse_err(psmouse, "failed to read register 0x%02x.\n", reg);
-	else if (etd->hw_version != 4)
+	else if (etd->info.hw_version != 4)
 		*val = param[0];
 	else
 		*val = param[1];
@@ -160,7 +160,7 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
 	if (reg > 0x11 && reg < 0x20)
 		return -1;
 
-	switch (etd->hw_version) {
+	switch (etd->info.hw_version) {
 	case 1:
 		if (ps2_sliced_command(&psmouse->ps2dev, ETP_REGISTER_WRITE) ||
 		    ps2_sliced_command(&psmouse->ps2dev, reg) ||
@@ -237,7 +237,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 	int fingers;
 
-	if (etd->fw_version < 0x020000) {
+	if (etd->info.fw_version < 0x020000) {
 		/*
 		 * byte 0:  D   U  p1  p2   1  p3   R   L
 		 * byte 1:  f   0  th  tw  x9  x8  y9  y8
@@ -252,7 +252,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 		fingers = (packet[0] & 0xc0) >> 6;
 	}
 
-	if (etd->jumpy_cursor) {
+	if (etd->info.jumpy_cursor) {
 		if (fingers != 1) {
 			etd->single_finger_reports = 0;
 		} else if (etd->single_finger_reports < 2) {
@@ -282,8 +282,8 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 
 	psmouse_report_standard_buttons(dev, packet[0]);
 
-	if (etd->fw_version < 0x020000 &&
-	    (etd->capabilities[0] & ETP_CAP_HAS_ROCKER)) {
+	if (etd->info.fw_version < 0x020000 &&
+	    (etd->info.capabilities[0] & ETP_CAP_HAS_ROCKER)) {
 		/* rocker up */
 		input_report_key(dev, BTN_FORWARD, packet[0] & 0x40);
 		/* rocker down */
@@ -391,7 +391,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
 	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
 	psmouse_report_standard_buttons(dev, packet[0]);
-	if (etd->reports_pressure) {
+	if (etd->info.reports_pressure) {
 		input_report_abs(dev, ABS_PRESSURE, pres);
 		input_report_abs(dev, ABS_TOOL_WIDTH, width);
 	}
@@ -444,7 +444,7 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 
 	default:
 		/* Dump unexpected packet sequences if debug=1 (default) */
-		if (etd->debug == 1)
+		if (etd->info.debug == 1)
 			elantech_packet_dump(psmouse);
 
 		break;
@@ -523,7 +523,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->fw_version & 0x001000)
+	if (etd->info.fw_version & 0x001000)
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
 	else
 		psmouse_report_standard_buttons(dev, packet[0]);
@@ -541,7 +541,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->fw_version & 0x001000)
+	if (etd->info.fw_version & 0x001000)
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
 	else
 		psmouse_report_standard_buttons(dev, packet[0]);
@@ -669,7 +669,7 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 	unsigned char p1, p2, p3;
 
 	/* Parity bits are placed differently */
-	if (etd->fw_version < 0x020000) {
+	if (etd->info.fw_version < 0x020000) {
 		/* byte 0:  D   U  p1  p2   1  p3   R   L */
 		p1 = (packet[0] & 0x20) >> 5;
 		p2 = (packet[0] & 0x10) >> 4;
@@ -714,7 +714,7 @@ static int elantech_packet_check_v2(struct psmouse *psmouse)
 	 * With all three cases, if the constant bits are not exactly what I
 	 * expected, I consider them invalid.
 	 */
-	if (etd->reports_pressure)
+	if (etd->info.reports_pressure)
 		return (packet[0] & 0x0c) == 0x04 &&
 		       (packet[3] & 0x0f) == 0x02;
 
@@ -751,7 +751,7 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
 	 * If the hardware flag 'crc_enabled' is set the packets have
 	 * different signatures.
 	 */
-	if (etd->crc_enabled) {
+	if (etd->info.crc_enabled) {
 		if ((packet[3] & 0x09) == 0x08)
 			return PACKET_V3_HEAD;
 
@@ -782,7 +782,7 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 		return PACKET_TRACKPOINT;
 
 	/* This represents the version of IC body. */
-	ic_version = (etd->fw_version & 0x0f0000) >> 16;
+	ic_version = (etd->info.fw_version & 0x0f0000) >> 16;
 
 	/*
 	 * Sanity check based on the constant bits of a packet.
@@ -791,9 +791,9 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	 * the IC body, but are the same for every packet,
 	 * regardless of the type.
 	 */
-	if (etd->crc_enabled)
+	if (etd->info.crc_enabled)
 		sanity_check = ((packet[3] & 0x08) == 0x00);
-	else if (ic_version == 7 && etd->samples[1] == 0x2A)
+	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
 		sanity_check = ((packet[3] & 0x1c) == 0x10);
 	else
 		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
@@ -827,12 +827,12 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
 
-	if (etd->debug > 1)
+	if (etd->info.debug > 1)
 		elantech_packet_dump(psmouse);
 
-	switch (etd->hw_version) {
+	switch (etd->info.hw_version) {
 	case 1:
-		if (etd->paritycheck && !elantech_packet_check_v1(psmouse))
+		if (etd->info.paritycheck && !elantech_packet_check_v1(psmouse))
 			return PSMOUSE_BAD_DATA;
 
 		elantech_report_absolute_v1(psmouse);
@@ -843,7 +843,7 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 		if (elantech_debounce_check_v2(psmouse))
 			return PSMOUSE_FULL_PACKET;
 
-		if (etd->paritycheck && !elantech_packet_check_v2(psmouse))
+		if (etd->info.paritycheck && !elantech_packet_check_v2(psmouse))
 			return PSMOUSE_BAD_DATA;
 
 		elantech_report_absolute_v2(psmouse);
@@ -916,7 +916,7 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 	int tries = ETP_READ_BACK_TRIES;
 	int rc = 0;
 
-	switch (etd->hw_version) {
+	switch (etd->info.hw_version) {
 	case 1:
 		etd->reg_10 = 0x16;
 		etd->reg_11 = 0x8f;
@@ -939,7 +939,7 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		break;
 
 	case 3:
-		if (etd->set_hw_resolution)
+		if (etd->info.set_hw_resolution)
 			etd->reg_10 = 0x0b;
 		else
 			etd->reg_10 = 0x01;
@@ -976,7 +976,7 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		if (rc) {
 			psmouse_err(psmouse,
 				    "failed to read back register 0x10.\n");
-		} else if (etd->hw_version == 1 &&
+		} else if (etd->info.hw_version == 1 &&
 			   !(val & ETP_R10_ABSOLUTE_MODE)) {
 			psmouse_err(psmouse,
 				    "touchpad refuses to switch to absolute mode.\n");
@@ -997,10 +997,11 @@ static int elantech_set_range(struct psmouse *psmouse,
 			      unsigned int *width)
 {
 	struct elantech_data *etd = psmouse->private;
+	struct elantech_device_info *info = &etd->info;
 	unsigned char param[3];
 	unsigned char traces;
 
-	switch (etd->hw_version) {
+	switch (info->hw_version) {
 	case 1:
 		*x_min = ETP_XMIN_V1;
 		*y_min = ETP_YMIN_V1;
@@ -1009,9 +1010,9 @@ static int elantech_set_range(struct psmouse *psmouse,
 		break;
 
 	case 2:
-		if (etd->fw_version == 0x020800 ||
-		    etd->fw_version == 0x020b00 ||
-		    etd->fw_version == 0x020030) {
+		if (info->fw_version == 0x020800 ||
+		    info->fw_version == 0x020b00 ||
+		    info->fw_version == 0x020030) {
 			*x_min = ETP_XMIN_V2;
 			*y_min = ETP_YMIN_V2;
 			*x_max = ETP_XMAX_V2;
@@ -1020,35 +1021,35 @@ static int elantech_set_range(struct psmouse *psmouse,
 			int i;
 			int fixed_dpi;
 
-			i = (etd->fw_version > 0x020800 &&
-			     etd->fw_version < 0x020900) ? 1 : 2;
+			i = (info->fw_version > 0x020800 &&
+			     info->fw_version < 0x020900) ? 1 : 2;
 
-			if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+			if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 				return -1;
 
 			fixed_dpi = param[1] & 0x10;
 
-			if (((etd->fw_version >> 16) == 0x14) && fixed_dpi) {
-				if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
+			if (((info->fw_version >> 16) == 0x14) && fixed_dpi) {
+				if (info->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
 					return -1;
 
-				*x_max = (etd->capabilities[1] - i) * param[1] / 2;
-				*y_max = (etd->capabilities[2] - i) * param[2] / 2;
-			} else if (etd->fw_version == 0x040216) {
+				*x_max = (info->capabilities[1] - i) * param[1] / 2;
+				*y_max = (info->capabilities[2] - i) * param[2] / 2;
+			} else if (info->fw_version == 0x040216) {
 				*x_max = 819;
 				*y_max = 405;
-			} else if (etd->fw_version == 0x040219 || etd->fw_version == 0x040215) {
+			} else if (info->fw_version == 0x040219 || info->fw_version == 0x040215) {
 				*x_max = 900;
 				*y_max = 500;
 			} else {
-				*x_max = (etd->capabilities[1] - i) * 64;
-				*y_max = (etd->capabilities[2] - i) * 64;
+				*x_max = (info->capabilities[1] - i) * 64;
+				*y_max = (info->capabilities[2] - i) * 64;
 			}
 		}
 		break;
 
 	case 3:
-		if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 			return -1;
 
 		*x_max = (0x0f & param[0]) << 8 | param[1];
@@ -1056,12 +1057,12 @@ static int elantech_set_range(struct psmouse *psmouse,
 		break;
 
 	case 4:
-		if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 			return -1;
 
 		*x_max = (0x0f & param[0]) << 8 | param[1];
 		*y_max = (0xf0 & param[0]) << 4 | param[2];
-		traces = etd->capabilities[1];
+		traces = info->capabilities[1];
 		if ((traces < 2) || (traces > *x_max))
 			return -1;
 
@@ -1140,7 +1141,7 @@ static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 
-	if (etd->fw_version & 0x001000) {
+	if (etd->info.fw_version & 0x001000) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		__clear_bit(BTN_RIGHT, dev->keybit);
 	}
@@ -1176,6 +1177,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
+	struct elantech_device_info *info = &etd->info;
 	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
 	unsigned int x_res = 31, y_res = 31;
 
@@ -1197,11 +1199,11 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
 	__set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
 
-	switch (etd->hw_version) {
+	switch (info->hw_version) {
 	case 1:
 		/* Rocker button */
-		if (etd->fw_version < 0x020000 &&
-		    (etd->capabilities[0] & ETP_CAP_HAS_ROCKER)) {
+		if (info->fw_version < 0x020000 &&
+		    (info->capabilities[0] & ETP_CAP_HAS_ROCKER)) {
 			__set_bit(BTN_FORWARD, dev->keybit);
 			__set_bit(BTN_BACK, dev->keybit);
 		}
@@ -1214,11 +1216,11 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
 		/* fall through */
 	case 3:
-		if (etd->hw_version == 3)
+		if (info->hw_version == 3)
 			elantech_set_buttonpad_prop(psmouse);
 		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
 		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
-		if (etd->reports_pressure) {
+		if (info->reports_pressure) {
 			input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
 					     ETP_PMAX_V2, 0, 0);
 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
@@ -1267,7 +1269,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 
 	input_abs_set_res(dev, ABS_X, x_res);
 	input_abs_set_res(dev, ABS_Y, y_res);
-	if (etd->hw_version > 1) {
+	if (info->hw_version > 1) {
 		input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
 	}
@@ -1317,7 +1319,7 @@ static ssize_t elantech_set_int_attr(struct psmouse *psmouse,
 		return err;
 
 	/* Do we need to preserve some bits for version 2 hardware too? */
-	if (etd->hw_version == 1) {
+	if (etd->info.hw_version == 1) {
 		if (attr->reg == 0x10)
 			/* Force absolute mode always on */
 			value |= ETP_R10_ABSOLUTE_MODE;
@@ -1337,11 +1339,22 @@ static ssize_t elantech_set_int_attr(struct psmouse *psmouse,
 		.field_offset = offsetof(struct elantech_data, _name),	\
 		.reg = _register,					\
 	};								\
-	PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,			\
+	PSMOUSE_DEFINE_ATTR(_name, 0644,				\
 			    &elantech_attr_##_name,			\
 			    elantech_show_int_attr,			\
 			    elantech_set_int_attr)
 
+#define ELANTECH_INFO_ATTR(_name)					       \
+	static struct elantech_attr_data elantech_attr_##_name = {	       \
+		.field_offset = offsetof(struct elantech_data, info) +	       \
+				offsetof(struct elantech_device_info, _name),  \
+		.reg = 0,						       \
+	};								       \
+	PSMOUSE_DEFINE_ATTR(_name, 0644,				       \
+			    &elantech_attr_##_name,			       \
+			    elantech_show_int_attr,			       \
+			    elantech_set_int_attr)
+
 ELANTECH_INT_ATTR(reg_07, 0x07);
 ELANTECH_INT_ATTR(reg_10, 0x10);
 ELANTECH_INT_ATTR(reg_11, 0x11);
@@ -1352,9 +1365,9 @@ ELANTECH_INT_ATTR(reg_23, 0x23);
 ELANTECH_INT_ATTR(reg_24, 0x24);
 ELANTECH_INT_ATTR(reg_25, 0x25);
 ELANTECH_INT_ATTR(reg_26, 0x26);
-ELANTECH_INT_ATTR(debug, 0);
-ELANTECH_INT_ATTR(paritycheck, 0);
-ELANTECH_INT_ATTR(crc_enabled, 0);
+ELANTECH_INFO_ATTR(debug);
+ELANTECH_INFO_ATTR(paritycheck);
+ELANTECH_INFO_ATTR(crc_enabled);
 
 static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_07.dattr.attr,
@@ -1588,25 +1601,25 @@ static const struct dmi_system_id no_hw_res_dmi_table[] = {
 /*
  * determine hardware version and set some properties according to it.
  */
-static int elantech_set_properties(struct elantech_data *etd)
+static int elantech_set_properties(struct elantech_device_info *info)
 {
 	/* This represents the version of IC body. */
-	int ver = (etd->fw_version & 0x0f0000) >> 16;
+	int ver = (info->fw_version & 0x0f0000) >> 16;
 
 	/* Early version of Elan touchpads doesn't obey the rule. */
-	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
-		etd->hw_version = 1;
+	if (info->fw_version < 0x020030 || info->fw_version == 0x020600)
+		info->hw_version = 1;
 	else {
 		switch (ver) {
 		case 2:
 		case 4:
-			etd->hw_version = 2;
+			info->hw_version = 2;
 			break;
 		case 5:
-			etd->hw_version = 3;
+			info->hw_version = 3;
 			break;
 		case 6 ... 15:
-			etd->hw_version = 4;
+			info->hw_version = 4;
 			break;
 		default:
 			return -1;
@@ -1614,100 +1627,86 @@ static int elantech_set_properties(struct elantech_data *etd)
 	}
 
 	/* decide which send_cmd we're gonna use early */
-	etd->send_cmd = etd->hw_version >= 3 ? elantech_send_cmd :
-					       synaptics_send_cmd;
+	info->send_cmd = info->hw_version >= 3 ? elantech_send_cmd :
+						 synaptics_send_cmd;
 
 	/* Turn on packet checking by default */
-	etd->paritycheck = 1;
+	info->paritycheck = 1;
 
 	/*
 	 * This firmware suffers from misreporting coordinates when
 	 * a touch action starts causing the mouse cursor or scrolled page
 	 * to jump. Enable a workaround.
 	 */
-	etd->jumpy_cursor =
-		(etd->fw_version == 0x020022 || etd->fw_version == 0x020600);
+	info->jumpy_cursor =
+		(info->fw_version == 0x020022 || info->fw_version == 0x020600);
 
-	if (etd->hw_version > 1) {
+	if (info->hw_version > 1) {
 		/* For now show extra debug information */
-		etd->debug = 1;
+		info->debug = 1;
 
-		if (etd->fw_version >= 0x020800)
-			etd->reports_pressure = true;
+		if (info->fw_version >= 0x020800)
+			info->reports_pressure = true;
 	}
 
 	/*
 	 * The signatures of v3 and v4 packets change depending on the
 	 * value of this hardware flag.
 	 */
-	etd->crc_enabled = (etd->fw_version & 0x4000) == 0x4000 ||
-			   dmi_check_system(elantech_dmi_force_crc_enabled);
+	info->crc_enabled = (info->fw_version & 0x4000) == 0x4000 ||
+			     dmi_check_system(elantech_dmi_force_crc_enabled);
 
 	/* Enable real hardware resolution on hw_version 3 ? */
-	etd->set_hw_resolution = !dmi_check_system(no_hw_res_dmi_table);
+	info->set_hw_resolution = !dmi_check_system(no_hw_res_dmi_table);
 
 	return 0;
 }
 
-/*
- * Initialize the touchpad and create sysfs entries
- */
-int elantech_init(struct psmouse *psmouse)
+int elantech_query_info(struct psmouse *psmouse,
+			struct elantech_device_info *info)
 {
-	struct elantech_data *etd;
-	int i;
-	int error = -EINVAL;
 	unsigned char param[3];
-	struct input_dev *tp_dev;
-
-	psmouse->private = etd = kzalloc(sizeof(struct elantech_data), GFP_KERNEL);
-	if (!etd)
-		return -ENOMEM;
-
-	psmouse_reset(psmouse);
-
-	etd->parity[0] = 1;
-	for (i = 1; i < 256; i++)
-		etd->parity[i] = etd->parity[i & (i - 1)] ^ 1;
 
 	/*
 	 * Do the version query again so we can store the result
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
 		psmouse_err(psmouse, "failed to query firmware version.\n");
-		goto init_fail;
+		return -EINVAL;
 	}
-	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
+	info->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
 
-	if (elantech_set_properties(etd)) {
+	if (elantech_set_properties(info)) {
 		psmouse_err(psmouse, "unknown hardware version, aborting...\n");
-		goto init_fail;
+		return -EINVAL;
 	}
 	psmouse_info(psmouse,
 		     "assuming hardware version %d (with firmware version 0x%02x%02x%02x)\n",
-		     etd->hw_version, param[0], param[1], param[2]);
+		     info->hw_version, param[0], param[1], param[2]);
 
-	if (etd->send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
-	    etd->capabilities)) {
+	if (info->send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
+	    info->capabilities)) {
 		psmouse_err(psmouse, "failed to query capabilities.\n");
-		goto init_fail;
+		return -EINVAL;
 	}
 	psmouse_info(psmouse,
 		     "Synaptics capabilities query result 0x%02x, 0x%02x, 0x%02x.\n",
-		     etd->capabilities[0], etd->capabilities[1],
-		     etd->capabilities[2]);
+		     info->capabilities[0], info->capabilities[1],
+		     info->capabilities[2]);
 
-	if (etd->hw_version != 1) {
-		if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, etd->samples)) {
+	if (info->hw_version != 1) {
+		if (info->send_cmd(psmouse, ETP_SAMPLE_QUERY, info->samples)) {
 			psmouse_err(psmouse, "failed to query sample data\n");
-			goto init_fail;
+			return -EINVAL;
 		}
 		psmouse_info(psmouse,
 			     "Elan sample query result %02x, %02x, %02x\n",
-			     etd->samples[0], etd->samples[1], etd->samples[2]);
+			     info->samples[0],
+			     info->samples[1],
+			     info->samples[2]);
 	}
 
-	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+	if (info->samples[1] == 0x74 && info->hw_version == 0x03) {
 		/*
 		 * This module has a bug which makes absolute mode
 		 * unusable, so let's abort so we'll be using standard
@@ -1715,16 +1714,43 @@ int elantech_init(struct psmouse *psmouse)
 		 */
 		psmouse_info(psmouse,
 			     "absolute mode broken, forcing standard PS/2 protocol\n");
-		goto init_fail;
+		return -ENODEV;
 	}
 
+	/* The MSB indicates the presence of the trackpoint */
+	info->has_trackpoint = (info->capabilities[0] & 0x80) == 0x80;
+
+	return 0;
+}
+
+/*
+ * Initialize the touchpad and create sysfs entries
+ */
+static int elantech_setup_ps2(struct psmouse *psmouse,
+			      struct elantech_device_info *info)
+{
+	struct elantech_data *etd;
+	int i;
+	int error;
+	struct input_dev *tp_dev;
+
+	psmouse->private = etd = kzalloc(sizeof(*etd), GFP_KERNEL);
+	if (!etd)
+		return -ENOMEM;
+
+	etd->info = *info;
+
+	etd->parity[0] = 1;
+	for (i = 1; i < 256; i++)
+		etd->parity[i] = etd->parity[i & (i - 1)] ^ 1;
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
 		goto init_fail;
 	}
 
-	if (etd->fw_version == 0x381f17) {
+	if (info->fw_version == 0x381f17) {
 		etd->original_set_rate = psmouse->set_rate;
 		psmouse->set_rate = elantech_set_rate_restore_reg_07;
 	}
@@ -1743,8 +1769,7 @@ int elantech_init(struct psmouse *psmouse)
 		goto init_fail;
 	}
 
-	/* The MSB indicates the presence of the trackpoint */
-	if ((etd->capabilities[0] & 0x80) == 0x80) {
+	if (info->has_trackpoint) {
 		tp_dev = input_allocate_device();
 
 		if (!tp_dev) {
@@ -1780,7 +1805,7 @@ int elantech_init(struct psmouse *psmouse)
 	psmouse->protocol_handler = elantech_process_byte;
 	psmouse->disconnect = elantech_disconnect;
 	psmouse->reconnect = elantech_reconnect;
-	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
+	psmouse->pktsize = info->hw_version > 1 ? 6 : 4;
 
 	return 0;
  init_fail_tp_reg:
@@ -1789,7 +1814,27 @@ int elantech_init(struct psmouse *psmouse)
 	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
 			   &elantech_attr_group);
  init_fail:
-	psmouse_reset(psmouse);
 	kfree(etd);
 	return error;
 }
+
+int elantech_init(struct psmouse *psmouse)
+{
+	struct elantech_device_info info;
+	int error = -EINVAL;
+
+	psmouse_reset(psmouse);
+
+	error = elantech_query_info(psmouse, &info);
+	if (error)
+		goto init_fail;
+
+	error = elantech_setup_ps2(psmouse, &info);
+	if (error)
+		goto init_fail;
+
+	return 0;
+ init_fail:
+	psmouse_reset(psmouse);
+	return error;
+}
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index e1cbf409d9c8..d8ac27fe4597 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -114,6 +114,22 @@ struct finger_pos {
 	unsigned int y;
 };
 
+struct elantech_device_info {
+	unsigned char capabilities[3];
+	unsigned char samples[3];
+	unsigned char debug;
+	unsigned char hw_version;
+	unsigned int fw_version;
+	bool paritycheck;
+	bool jumpy_cursor;
+	bool reports_pressure;
+	bool crc_enabled;
+	bool set_hw_resolution;
+	bool has_trackpoint;
+	int (*send_cmd)(struct psmouse *psmouse, unsigned char c,
+			unsigned char *param);
+};
+
 struct elantech_data {
 	struct input_dev *tp_dev;	/* Relative device for trackpoint */
 	char tp_phys[32];
@@ -127,22 +143,12 @@ struct elantech_data {
 	unsigned char reg_24;
 	unsigned char reg_25;
 	unsigned char reg_26;
-	unsigned char debug;
-	unsigned char capabilities[3];
-	unsigned char samples[3];
-	bool paritycheck;
-	bool jumpy_cursor;
-	bool reports_pressure;
-	bool crc_enabled;
-	bool set_hw_resolution;
-	unsigned char hw_version;
-	unsigned int fw_version;
 	unsigned int single_finger_reports;
 	unsigned int y_max;
 	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
-	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
+	struct elantech_device_info info;
 	void (*original_set_rate)(struct psmouse *psmouse, unsigned int rate);
 };
 
-- 
2.14.3
