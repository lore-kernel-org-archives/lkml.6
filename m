Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72BEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581732150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxhqFgny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581732150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHWWCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:02:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38100 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeHWWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:02:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id k8-v6so3053639pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RwxvC5bc45m1fdARS87c3dFOfvuLZ22OhFSt1rzr5A=;
        b=VxhqFgny+Wmb4PhUzh/yNG3hZ2Xu6OxwsZ57XqM2uBSfKAWsaejzgFr5Lu7fE6Jthd
         62UB13NT9fu5xseGKdYujSyi5gEYRLwQiMhNK7wrG6pAF3ZmwxpkkJUnn8dLxOpo9KyM
         qANGIeljjzbgXHYRnNRlHMK8iQB8piQwvDDA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RwxvC5bc45m1fdARS87c3dFOfvuLZ22OhFSt1rzr5A=;
        b=tRzgKQfORhYUl8NYCJwZq0U+9aRe5iD+hoN4ZwAeruM9l9H+6xI/LGbjuLW4w+UON9
         z02IVTndnP93/UiMtyWxOFuhhf5qD8kyZZoHggO9NpZb1MMCSUEuYQitnxX/J0C7r+jl
         aXldzl1zkJQPAC1hp8t7xYIkNIvhy7VkuQKq+qTq3SMbhWE8MxXX+I9II8lXKvL9PwP4
         PLupPwH6FgfUzWosslv0Bbplo+RVqXtR0DOD6SY4H6AtHLL6glZnkDjwx+WhNwkAuTsf
         HYWxNZd8N+ApUfb74nu5F3rflDkKyDZuWf6r+5CPEY5+F0PRYuHiVxZx6uUHyAoM2Jig
         CPbA==
X-Gm-Message-State: AOUpUlGOBSWSi5T7p0Nt9hd9f7TJMmyXRr5D0LafaLPLURH+AV5xxhcq
        xbRAaoogt/G7r3aV/R9Zhp6Zpg==
X-Google-Smtp-Source: AA+uWPwOGFipjyo5+y1QX3x0RviF2WjKzHg5INf9h2U81FkTaCQ3NzyABDb3+ZgmzHrVIE3aLFBxzA==
X-Received: by 2002:a62:6b88:: with SMTP id g130-v6mr21878638pfc.140.1535049110424;
        Thu, 23 Aug 2018 11:31:50 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id p11-v6sm9054225pfj.72.2018.08.23.11.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:31:49 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 3/3] Enable high-resolution scrolling on Logitech mice
Date:   Thu, 23 Aug 2018 11:30:57 -0700
Message-Id: <20180823183057.247630-4-hcutts@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
In-Reply-To: <20180823183057.247630-1-hcutts@chromium.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three features used by various Logitech mice for
high-resolution scrolling: the fast scrolling bit in HID++ 1.0, and the
x2120 and x2121 features in HID++ 2.0 and above. This patch supports
all three, and uses the multiplier reported by the mouse for the HID++
2.0+ features.

The full list of product IDs of mice which support high-resolution
scrolling was provided by Logitech, but the patch was tested using the
following mice (over both Bluetooth and Unifying where applicable):

* HID++ 1.0: Anywhere MX, Performance MX
* x2120: M560
* x2121: MX Anywhere 2, MX Master 2S

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

 drivers/hid/hid-ids.h            |  15 ++
 drivers/hid/hid-logitech-hidpp.c | 341 ++++++++++++++++++++++++++++---
 drivers/hid/hid-quirks.c         |  11 +
 3 files changed, 340 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 79bdf0c7e351..64fbe6174189 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -717,6 +717,21 @@
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C01A	0xc01a
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C05A	0xc05a
 #define USB_DEVICE_ID_LOGITECH_MOUSE_C06A	0xc06a
+/*
+ * The following mice have different IDs over Bluetooth than Logitech Unifying
+ * protocol, hence the _BT suffix.
+ */
+#define USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT1	0xb014
+#define USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT2	0xb016
+#define USB_DEVICE_ID_LOGITECH_MOUSE_M720_BT		0xb015
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT1	0xb013
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT2	0xb018
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT3	0xb01f
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2S_BT	0xb01a
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT1	0xb012
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT2	0xb017
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT3	0xb01e
+#define USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT	0xb019
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD	0xc20a
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD	0xc211
 #define USB_DEVICE_ID_LOGITECH_EXTREME_3D	0xc215
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..17598b87f1b7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -64,6 +64,14 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
+#define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(26)
+#define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
+#define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
+
+/* Convenience constant to check for any high-res support. */
+#define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
+					 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
+					 HIDPP_QUIRK_HI_RES_SCROLL_X2121)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
@@ -149,6 +157,7 @@ struct hidpp_device {
 	unsigned long capabilities;
 
 	struct hidpp_battery battery;
+	struct hid_scroll_counter vertical_wheel_counter;
 };
 
 /* HID++ 1.0 error codes */
@@ -400,32 +409,53 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+/**
+ * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
+ * @hidpp_dev: the device to set the register on.
+ * @register_address: the address of the register to modify.
+ * @byte: the byte of the register to modify. Should be less than 3.
+ * Return: 0 if successful, otherwise a negative error code.
+ */
+static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
+	u8 register_address, u8 byte, u8 bit)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_GET_REGISTER,
-					HIDPP_REG_GENERAL,
-					NULL, 0, &response);
+					  REPORT_ID_HIDPP_SHORT,
+					  HIDPP_GET_REGISTER,
+					  register_address,
+					  NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	/* Set the battery bit */
-	params[0] |= BIT(4);
+	params[byte] |= BIT(bit);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_SET_REGISTER,
-					HIDPP_REG_GENERAL,
-					params, 3, &response);
+					   REPORT_ID_HIDPP_SHORT,
+					   HIDPP_SET_REGISTER,
+					   register_address,
+					   params, 3, &response);
+}
+
+
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
+}
+
+#define HIDPP_REG_FEATURES				0x01
+
+/* On HID++ 1.0 devices, high-res scrolling was called "fast scrolling". */
+static int hidpp10_enable_fast_scrolling(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
@@ -1136,6 +1166,101 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2120: Hi-resolution scrolling                                            */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_HI_RESOLUTION_SCROLLING			0x2120
+
+#define CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE	0x10
+
+static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
+	bool enabled, u8 *multiplier)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	u8 params[1];
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp,
+				     HIDPP_PAGE_HI_RESOLUTION_SCROLLING,
+				     &feature_index,
+				     &feature_type);
+	if (ret)
+		return ret;
+
+	params[0] = enabled ? BIT(0) : 0;
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE,
+					  params, sizeof(params), &response);
+	if (ret)
+		return ret;
+	*multiplier = response.fap.params[1];
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+/* 0x2121: HiRes Wheel                                                        */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_HIRES_WHEEL		0x2121
+
+#define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
+#define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
+
+static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
+	u8 *multiplier)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
+				     &feature_index, &feature_type);
+	if (ret)
+		goto return_default;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY,
+					  NULL, 0, &response);
+	if (ret)
+		goto return_default;
+
+	*multiplier = response.fap.params[0];
+	return 0;
+return_default:
+	*multiplier = 8;
+	hid_warn(hidpp->hid_dev,
+		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
+		 ret, *multiplier);
+	return ret;
+}
+
+static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
+	bool high_resolution, bool use_hidpp)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	u8 params[1];
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
+				     &feature_index, &feature_type);
+	if (ret)
+		return ret;
+
+	params[0] = (invert          ? BIT(2) : 0) |
+		    (high_resolution ? BIT(1) : 0) |
+		    (use_hidpp       ? BIT(0) : 0);
+
+	return hidpp_send_fap_command_sync(hidpp, feature_index,
+					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
+					   params, sizeof(params), &response);
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x4301: Solar Keyboard                                                     */
 /* -------------------------------------------------------------------------- */
@@ -2399,7 +2524,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		input_report_rel(mydata->input, REL_WHEEL, v);
+		hid_scroll_counter_handle_scroll(
+				&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
@@ -2527,6 +2653,71 @@ static int g920_get_config(struct hidpp_device *hidpp)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* High-resolution scroll wheels                                              */
+/* -------------------------------------------------------------------------- */
+
+/**
+ * struct hi_res_scroll_info - Stores info on a device's high-res scroll wheel.
+ * @product_id: the HID product ID of the device being described.
+ * @mm256_per_hi_res_unit: the distance moved by the user's finger for each
+ *                         high-resolution unit reported by the device, in
+ *                         256ths of a millimetre.
+ */
+struct hi_res_scroll_info {
+	__u32 product_id;
+	int mm256_per_hi_res_unit;
+};
+
+static struct hi_res_scroll_info hi_res_scroll_devices[] = {
+	{ /* Anywhere MX */
+	  .product_id = 0x1017, .mm256_per_hi_res_unit = 114 },
+	{ /* Performance MX */
+	  .product_id = 0x101a, .mm256_per_hi_res_unit = 104 },
+	{ /* M560 */
+	  .product_id = 0x402d, .mm256_per_hi_res_unit = 111 },
+	{ /* MX Master 2S */
+	  .product_id = 0x4069, .mm256_per_hi_res_unit = 104 },
+	{ .product_id = USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT,
+	  .mm256_per_hi_res_unit = 104 },
+};
+
+static int hi_res_scroll_look_up_mm256(__u32 product_id)
+{
+	int i;
+	int num_devices = sizeof(hi_res_scroll_devices)
+			  / sizeof(hi_res_scroll_devices[0]);
+	for (i = 0; i < num_devices; i++) {
+		if (hi_res_scroll_devices[i].product_id == product_id)
+			return hi_res_scroll_devices[i].mm256_per_hi_res_unit;
+	}
+	return 104;
+}
+
+static int hi_res_scroll_enable(struct hidpp_device *hidpp)
+{
+	int ret;
+	u8 multiplier;
+
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
+		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
+		hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
+	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
+		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
+							   &multiplier);
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
+		ret = hidpp10_enable_fast_scrolling(hidpp);
+		multiplier = 8;
+	}
+	if (ret)
+		return ret;
+
+	hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
+	hidpp->vertical_wheel_counter.mm256_per_hi_res_unit =
+		hi_res_scroll_look_up_mm256(hidpp->hid_dev->product);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -2572,6 +2763,11 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
+
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) {
+		input_set_capability(input, EV_REL, REL_WHEEL_HI_RES);
+		hidpp->vertical_wheel_counter.dev = input;
+	}
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2690,6 +2886,25 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
+	struct hid_usage *usage, __s32 value)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct hid_scroll_counter *counter = &hidpp->vertical_wheel_counter;
+
+	/* A scroll event may occur before the multiplier has been retrieved or
+	 * the input device set, or high-res scroll enabling may fail. In such
+	 * cases we must return early (falling back to default behaviour) to
+	 * avoid a crash in hid_scroll_counter_handle_scroll.
+	 */
+	if (!(hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) || value == 0
+	    || counter->dev == NULL || counter->resolution_multiplier == 0)
+		return 0;
+
+	hid_scroll_counter_handle_scroll(counter, value);
+	return 1;
+}
+
 static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
@@ -2901,6 +3116,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
+		hi_res_scroll_enable(hidpp);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
@@ -3086,35 +3304,97 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
+#define LDJ_DEVICE(product) \
+	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
+		   USB_VENDOR_ID_LOGITECH, (product))
+
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4011),
+	  LDJ_DEVICE(0x4011),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
 			 HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
 	{ /* wireless touchpad T650 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4101),
+	  LDJ_DEVICE(0x4101),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse Logitech Anywhere MX */
+	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech Cube */
+	  LDJ_DEVICE(0x4010), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
+	{ /* Mouse Logitech M335 */
+	  LDJ_DEVICE(0x4050), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech M336, M337, and M535 */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT1),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT2),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech M515 */
+	  LDJ_DEVICE(0x4007), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
 	{ /* Mouse logitech M560 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x402d),
-	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	  LDJ_DEVICE(0x402d),
+	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560
+		| HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
+	{ /* Mouse Logitech M705 (firmware RQM17) */
+	  LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech M705 (firmware RQM67) */
+	  LDJ_DEVICE(0x406d), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech M720 */
+	  LDJ_DEVICE(0x405e), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_M720_BT),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Anywhere 2 */
+	  LDJ_DEVICE(0x404a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb013), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb018), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb01f), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT1),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT2),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT3),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Anywhere 2S */
+	  LDJ_DEVICE(0x406a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2S_BT),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master */
+	  LDJ_DEVICE(0x4041), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4060), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4071), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT1),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT2),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT3),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master 2S */
+	  LDJ_DEVICE(0x4069), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT),
+	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech Performance MX */
+	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4024),
+	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 	{ /* Solar Keyboard Logitech K750 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4002),
+	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
-	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
+	{ LDJ_DEVICE(HID_ANY_ID) },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -3123,12 +3403,19 @@ static const struct hid_device_id hidpp_devices[] = {
 
 MODULE_DEVICE_TABLE(hid, hidpp_devices);
 
+static const struct hid_usage_id hidpp_usages[] = {
+	{ HID_GD_WHEEL, EV_REL, REL_WHEEL },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
 static struct hid_driver hidpp_driver = {
 	.name = "logitech-hidpp-device",
 	.id_table = hidpp_devices,
 	.probe = hidpp_probe,
 	.remove = hidpp_remove,
 	.raw_event = hidpp_raw_event,
+	.usage_table = hidpp_usages,
+	.event = hidpp_event,
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..7926c275f258 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -463,6 +463,17 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_T651) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT1) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M336_337_535_BT2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_M720_BT) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT1) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2_BT3) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_ANYWHERE_2S_BT) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT1) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_BT3) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_MX_MASTER_2S_BT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
 #endif
 #if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
-- 
2.18.0.1017.ga543ac7ca45-goog

