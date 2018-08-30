Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C8AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB6120837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2dqUIwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB6120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeHaCA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45091 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeHaCAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so4476080pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3F4JxuBsYJ7mDxbuPeY7E4CxS5RryIVJNUkGSnhOpE=;
        b=X2dqUIwkvTQ+y1DfmJNfG+F+tyfhiOKDCK6pUlLauzmYHEBvSjEkdwFCCuMHL4RcHv
         UidlWoXqrmGR0VyVpkUfb7kBIGUHTSPEgW6bYxoSKX6HQZeomFsdhEKgmgMiPNA0ZPSF
         +9b4OjU09JD3A6Lc7tK7pb0FGd7+YxfBFVipw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3F4JxuBsYJ7mDxbuPeY7E4CxS5RryIVJNUkGSnhOpE=;
        b=fbzzdsuv+CIkfKdGlTkq7VX6ORFySK97nKKrMXMcx1thxD6bRSBlOpycYijmRQWGU1
         +fCy7/Ak8LAfHtg4bq//1g7AfN8Z6mcOPIYXA5zsoXGx0GfKG2CA6l7OYgdLuStgpCZm
         kin78FkYyn1u1Mzi19jHLlunmLUnrVBrJQ/RjVQpfJIydLvQ+dd258ipHwXt7aF65aB3
         f7fqokYGJxd/1ixtcvYCgSh6DFFSHf6nOCNWMdgBfzuM4XNwkOzzJEw3oEZtl4NhGr6M
         zg3ei/JLmZdX2BcKrtRL32fyrTTyt+srRLgfUxwT7SyhCtE56cXsRH2+KG7PSiTUuMz2
         Z5cQ==
X-Gm-Message-State: APzg51DJVurdEeaW28l8sNJZKdeVQO2m2CUwLh+jqgqcuq4fgFlnSRp1
        SkaTZmhjZUFMUqNB706XyDZ0Xg==
X-Google-Smtp-Source: ANB0VdZ64C2fOnsnytGs3urtOxfDGK59PTKyJYBFYVqeclcexrHtqLlCdopzVseRMpumwmdOt+VsCg==
X-Received: by 2002:a65:6413:: with SMTP id a19-v6mr4405075pgv.359.1535666191331;
        Thu, 30 Aug 2018 14:56:31 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:30 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2 4/5] Enable high-resolution scrolling on Logitech mice
Date:   Thu, 30 Aug 2018 14:56:21 -0700
Message-Id: <20180830215622.47550-5-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three features used by various Logitech mice for
high-resolution scrolling: the scrolling acceleration bit in HID++ 1.0,
and the x2120 and x2121 features in HID++ 2.0 and above. This patch
supports all three, and uses the multiplier reported by the mouse for
the HID++ 2.0+ features.

The full list of product IDs of mice which support high-resolution
scrolling was provided by Logitech, but the patch was tested using the
following mice (using the Unifying receiver):

* HID++ 1.0: Anywhere MX, Performance MX
* x2120: M560
* x2121: MX Anywhere 2, MX Master 2S

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2: None

 drivers/hid/hid-logitech-hidpp.c | 249 ++++++++++++++++++++++++++++++-
 1 file changed, 245 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7f8218f6ff56..fd6a8c325fa0 100644
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
@@ -1157,6 +1166,101 @@ static int hidpp_battery_get_property(struct power_supply *psy,
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
@@ -2420,7 +2524,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		input_report_rel(mydata->input, REL_WHEEL, v);
+		hid_scroll_counter_handle_scroll(
+				&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
@@ -2548,6 +2653,73 @@ static int g920_get_config(struct hidpp_device *hidpp)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* High-resolution scroll wheels                                              */
+/* -------------------------------------------------------------------------- */
+
+/**
+ * struct hi_res_scroll_info - Stores info on a device's high-res scroll wheel.
+ * @product_id: the HID product ID of the device being described.
+ * @microns_per_hi_res_unit: the distance moved by the user's finger for each
+ *                         high-resolution unit reported by the device, in
+ *                         256ths of a millimetre.
+ */
+struct hi_res_scroll_info {
+	__u32 product_id;
+	int microns_per_hi_res_unit;
+};
+
+static struct hi_res_scroll_info hi_res_scroll_devices[] = {
+	{ /* Anywhere MX */
+	  .product_id = 0x1017, .microns_per_hi_res_unit = 445 },
+	{ /* Performance MX */
+	  .product_id = 0x101a, .microns_per_hi_res_unit = 406 },
+	{ /* M560 */
+	  .product_id = 0x402d, .microns_per_hi_res_unit = 435 },
+	{ /* MX Master 2S */
+	  .product_id = 0x4069, .microns_per_hi_res_unit = 406 },
+};
+
+static int hi_res_scroll_look_up_microns(__u32 product_id)
+{
+	int i;
+	int num_devices = sizeof(hi_res_scroll_devices)
+			  / sizeof(hi_res_scroll_devices[0]);
+	for (i = 0; i < num_devices; i++) {
+		if (hi_res_scroll_devices[i].product_id == product_id)
+			return hi_res_scroll_devices[i].microns_per_hi_res_unit;
+	}
+	/* We don't have a value for this device, so use a sensible default. */
+	return 406;
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
+		ret = hidpp10_enable_scrolling_acceleration(hidpp);
+		multiplier = 8;
+	}
+	if (ret)
+		return ret;
+
+	hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
+	hidpp->vertical_wheel_counter.microns_per_hi_res_unit =
+		hi_res_scroll_look_up_microns(hidpp->hid_dev->product);
+	hid_info(hidpp->hid_dev, "multiplier = %d, microns = %d\n",
+		 multiplier,
+		 hidpp->vertical_wheel_counter.microns_per_hi_res_unit);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -2593,6 +2765,11 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
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
@@ -2711,6 +2888,27 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
+	struct hid_usage *usage, __s32 value)
+{
+	/* This function will only be called for scroll events, due to the
+	 * restriction imposed in hidpp_usages.
+	 */
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct hid_scroll_counter *counter = &hidpp->vertical_wheel_counter;
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
@@ -2922,6 +3120,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
+		hi_res_scroll_enable(hidpp);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
@@ -3107,6 +3308,10 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
+#define LDJ_DEVICE(product) \
+	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
+		   USB_VENDOR_ID_LOGITECH, (product))
+
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
@@ -3121,10 +3326,39 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse Logitech Anywhere MX */
+	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech Cube */
+	  LDJ_DEVICE(0x4010), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
+	{ /* Mouse Logitech M335 */
+	  LDJ_DEVICE(0x4050), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
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
+	{ /* Mouse Logitech MX Anywhere 2 */
+	  LDJ_DEVICE(0x404a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb013), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb018), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb01f), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Anywhere 2S */
+	  LDJ_DEVICE(0x406a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master */
+	  LDJ_DEVICE(0x4041), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4060), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4071), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master 2S */
+	  LDJ_DEVICE(0x4069), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech Performance MX */
+	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
@@ -3144,12 +3378,19 @@ static const struct hid_device_id hidpp_devices[] = {
 
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
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

