Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB314C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2102147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2102147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeKVCC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbeKVCC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDB57307CDDA;
        Wed, 21 Nov 2018 15:27:34 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63603103BAB7;
        Wed, 21 Nov 2018 15:27:32 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/7] Revert "HID: logitech: Enable high-resolution scrolling on Logitech mice"
Date:   Wed, 21 Nov 2018 16:27:09 +0100
Message-Id: <20181121152712.6770-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 21 Nov 2018 15:27:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d56ca9855bf924f3bc9807a3e42f38539df3f41f.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 249 +------------------------------
 1 file changed, 4 insertions(+), 245 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fd6a8c325fa0..7f8218f6ff56 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -64,14 +64,6 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
-#define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(26)
-#define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
-#define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
-
-/* Convenience constant to check for any high-res support. */
-#define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
-					 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
-					 HIDPP_QUIRK_HI_RES_SCROLL_X2121)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
@@ -157,7 +149,6 @@ struct hidpp_device {
 	unsigned long capabilities;
 
 	struct hidpp_battery battery;
-	struct hid_scroll_counter vertical_wheel_counter;
 };
 
 /* HID++ 1.0 error codes */
@@ -1166,101 +1157,6 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-/* -------------------------------------------------------------------------- */
-/* 0x2120: Hi-resolution scrolling                                            */
-/* -------------------------------------------------------------------------- */
-
-#define HIDPP_PAGE_HI_RESOLUTION_SCROLLING			0x2120
-
-#define CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE	0x10
-
-static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
-	bool enabled, u8 *multiplier)
-{
-	u8 feature_index;
-	u8 feature_type;
-	int ret;
-	u8 params[1];
-	struct hidpp_report response;
-
-	ret = hidpp_root_get_feature(hidpp,
-				     HIDPP_PAGE_HI_RESOLUTION_SCROLLING,
-				     &feature_index,
-				     &feature_type);
-	if (ret)
-		return ret;
-
-	params[0] = enabled ? BIT(0) : 0;
-	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
-					  CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE,
-					  params, sizeof(params), &response);
-	if (ret)
-		return ret;
-	*multiplier = response.fap.params[1];
-	return 0;
-}
-
-/* -------------------------------------------------------------------------- */
-/* 0x2121: HiRes Wheel                                                        */
-/* -------------------------------------------------------------------------- */
-
-#define HIDPP_PAGE_HIRES_WHEEL		0x2121
-
-#define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
-#define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
-
-static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
-	u8 *multiplier)
-{
-	u8 feature_index;
-	u8 feature_type;
-	int ret;
-	struct hidpp_report response;
-
-	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
-				     &feature_index, &feature_type);
-	if (ret)
-		goto return_default;
-
-	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
-					  CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY,
-					  NULL, 0, &response);
-	if (ret)
-		goto return_default;
-
-	*multiplier = response.fap.params[0];
-	return 0;
-return_default:
-	*multiplier = 8;
-	hid_warn(hidpp->hid_dev,
-		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
-		 ret, *multiplier);
-	return ret;
-}
-
-static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
-	bool high_resolution, bool use_hidpp)
-{
-	u8 feature_index;
-	u8 feature_type;
-	int ret;
-	u8 params[1];
-	struct hidpp_report response;
-
-	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
-				     &feature_index, &feature_type);
-	if (ret)
-		return ret;
-
-	params[0] = (invert          ? BIT(2) : 0) |
-		    (high_resolution ? BIT(1) : 0) |
-		    (use_hidpp       ? BIT(0) : 0);
-
-	return hidpp_send_fap_command_sync(hidpp, feature_index,
-					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
-					   params, sizeof(params), &response);
-}
-
 /* -------------------------------------------------------------------------- */
 /* 0x4301: Solar Keyboard                                                     */
 /* -------------------------------------------------------------------------- */
@@ -2524,8 +2420,7 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		hid_scroll_counter_handle_scroll(
-				&hidpp->vertical_wheel_counter, v);
+		input_report_rel(mydata->input, REL_WHEEL, v);
 
 		input_sync(mydata->input);
 	}
@@ -2653,73 +2548,6 @@ static int g920_get_config(struct hidpp_device *hidpp)
 	return 0;
 }
 
-/* -------------------------------------------------------------------------- */
-/* High-resolution scroll wheels                                              */
-/* -------------------------------------------------------------------------- */
-
-/**
- * struct hi_res_scroll_info - Stores info on a device's high-res scroll wheel.
- * @product_id: the HID product ID of the device being described.
- * @microns_per_hi_res_unit: the distance moved by the user's finger for each
- *                         high-resolution unit reported by the device, in
- *                         256ths of a millimetre.
- */
-struct hi_res_scroll_info {
-	__u32 product_id;
-	int microns_per_hi_res_unit;
-};
-
-static struct hi_res_scroll_info hi_res_scroll_devices[] = {
-	{ /* Anywhere MX */
-	  .product_id = 0x1017, .microns_per_hi_res_unit = 445 },
-	{ /* Performance MX */
-	  .product_id = 0x101a, .microns_per_hi_res_unit = 406 },
-	{ /* M560 */
-	  .product_id = 0x402d, .microns_per_hi_res_unit = 435 },
-	{ /* MX Master 2S */
-	  .product_id = 0x4069, .microns_per_hi_res_unit = 406 },
-};
-
-static int hi_res_scroll_look_up_microns(__u32 product_id)
-{
-	int i;
-	int num_devices = sizeof(hi_res_scroll_devices)
-			  / sizeof(hi_res_scroll_devices[0]);
-	for (i = 0; i < num_devices; i++) {
-		if (hi_res_scroll_devices[i].product_id == product_id)
-			return hi_res_scroll_devices[i].microns_per_hi_res_unit;
-	}
-	/* We don't have a value for this device, so use a sensible default. */
-	return 406;
-}
-
-static int hi_res_scroll_enable(struct hidpp_device *hidpp)
-{
-	int ret;
-	u8 multiplier;
-
-	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
-		hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
-	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
-		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
-							   &multiplier);
-	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
-		ret = hidpp10_enable_scrolling_acceleration(hidpp);
-		multiplier = 8;
-	}
-	if (ret)
-		return ret;
-
-	hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
-	hidpp->vertical_wheel_counter.microns_per_hi_res_unit =
-		hi_res_scroll_look_up_microns(hidpp->hid_dev->product);
-	hid_info(hidpp->hid_dev, "multiplier = %d, microns = %d\n",
-		 multiplier,
-		 hidpp->vertical_wheel_counter.microns_per_hi_res_unit);
-	return 0;
-}
-
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -2765,11 +2593,6 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
-
-	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) {
-		input_set_capability(input, EV_REL, REL_WHEEL_HI_RES);
-		hidpp->vertical_wheel_counter.dev = input;
-	}
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2888,27 +2711,6 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
-static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
-	struct hid_usage *usage, __s32 value)
-{
-	/* This function will only be called for scroll events, due to the
-	 * restriction imposed in hidpp_usages.
-	 */
-	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-	struct hid_scroll_counter *counter = &hidpp->vertical_wheel_counter;
-	/* A scroll event may occur before the multiplier has been retrieved or
-	 * the input device set, or high-res scroll enabling may fail. In such
-	 * cases we must return early (falling back to default behaviour) to
-	 * avoid a crash in hid_scroll_counter_handle_scroll.
-	 */
-	if (!(hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) || value == 0
-	    || counter->dev == NULL || counter->resolution_multiplier == 0)
-		return 0;
-
-	hid_scroll_counter_handle_scroll(counter, value);
-	return 1;
-}
-
 static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
@@ -3120,9 +2922,6 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
-	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
-		hi_res_scroll_enable(hidpp);
-
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
@@ -3308,10 +3107,6 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
-#define LDJ_DEVICE(product) \
-	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
-		   USB_VENDOR_ID_LOGITECH, (product))
-
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
@@ -3326,39 +3121,10 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
-	{ /* Mouse Logitech Anywhere MX */
-	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
-	{ /* Mouse Logitech Cube */
-	  LDJ_DEVICE(0x4010), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
-	{ /* Mouse Logitech M335 */
-	  LDJ_DEVICE(0x4050), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech M515 */
-	  LDJ_DEVICE(0x4007), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
 	{ /* Mouse logitech M560 */
-	  LDJ_DEVICE(0x402d),
-	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560
-		| HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
-	{ /* Mouse Logitech M705 (firmware RQM17) */
-	  LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
-	{ /* Mouse Logitech M705 (firmware RQM67) */
-	  LDJ_DEVICE(0x406d), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech M720 */
-	  LDJ_DEVICE(0x405e), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech MX Anywhere 2 */
-	  LDJ_DEVICE(0x404a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ LDJ_DEVICE(0xb013), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ LDJ_DEVICE(0xb018), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ LDJ_DEVICE(0xb01f), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech MX Anywhere 2S */
-	  LDJ_DEVICE(0x406a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech MX Master */
-	  LDJ_DEVICE(0x4041), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ LDJ_DEVICE(0x4060), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ LDJ_DEVICE(0x4071), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech MX Master 2S */
-	  LDJ_DEVICE(0x4069), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
-	{ /* Mouse Logitech Performance MX */
-	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x402d),
+	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
@@ -3378,19 +3144,12 @@ static const struct hid_device_id hidpp_devices[] = {
 
 MODULE_DEVICE_TABLE(hid, hidpp_devices);
 
-static const struct hid_usage_id hidpp_usages[] = {
-	{ HID_GD_WHEEL, EV_REL, REL_WHEEL },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
-};
-
 static struct hid_driver hidpp_driver = {
 	.name = "logitech-hidpp-device",
 	.id_table = hidpp_devices,
 	.probe = hidpp_probe,
 	.remove = hidpp_remove,
 	.raw_event = hidpp_raw_event,
-	.usage_table = hidpp_usages,
-	.event = hidpp_event,
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
-- 
2.19.1

