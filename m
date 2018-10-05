Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD1BC65BBA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2110208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjE4iusr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2110208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeJFBlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:41:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeJFBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:41:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so5118394pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2XNlnyGPxzTGTxa9A7yOJbqo6z39k9u5EtbjAi/i2s=;
        b=fjE4iusrk1OC+fAhZElp9B5PcLSGlsGET3RPRu8o5RDAANIasoz4nz40AJnMceA/xt
         dMhdR8W1W7bYPKNC1HPWdU3deOE8gHKuriuOZNlGRzMi+7PM+iMPs0qcEFV3ewiIzCcL
         AWxK+o45ahz1OEy3wxDLQkj+LylFJ3Gdb1zCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2XNlnyGPxzTGTxa9A7yOJbqo6z39k9u5EtbjAi/i2s=;
        b=eJm3bxHYHYY7HOrM6n9+O7T5NXFHx1OBvD1C8lpQSwfO/RNkeZsGPkH3+94IUuw7Dr
         QbWJuZqTtsTd6V+yQ86Uhr1ZrVHZpbM3A/wT3PwNzXGYcKponC4YMGfDI5Fq3ZQ56Ksh
         OL6y91zgjrDH5HH+Qe092RVwOZrKSNDpek/hClJ3jQnIeNyHWhA2/lzm1r1Wv1N6UDTk
         oMpGZAIV4sAphoEMJ6sqUNaIdn2mV1wengCG999cfwOwzzM/PljoaNyUZRnyNn3EuXzP
         F5k8KOR3Oq6NiDlN1pTUQIkKuvLReOB35kPhJPrb7oVPppnVNPiLwab45qHY0mFmyExK
         HLVw==
X-Gm-Message-State: ABuFfojP0GS1le1h6jxjI/pimcIMnN6DWRWbuZXb7jl8dBTrwkfdFHly
        K+eJg05CXeWJsrVyBXwD4Isgyw==
X-Google-Smtp-Source: ACcGV60hDP2cOedG65rAw4mB1HLh/gNMduQF0EacwWFWFQuW7Ov/K+tr9DciI/j7mv5N92f8XUYZpg==
X-Received: by 2002:a62:1551:: with SMTP id 78-v6mr13125338pfv.178.1538764880069;
        Fri, 05 Oct 2018 11:41:20 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t64-v6sm12151303pfb.44.2018.10.05.11.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:41:18 -0700 (PDT)
From:   Dmitry Torokhov <dtor@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 2/2] HID: google: add support tablet mode switch for Whiskers
Date:   Fri,  5 Oct 2018 11:41:14 -0700
Message-Id: <20181005184114.207503-2-dtor@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181005184114.207503-1-dtor@chromium.org>
References: <20181005184114.207503-1-dtor@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whiskers is a foldable base, and thus requires combining "base presence"
signal coming from EC with base state signal (folded/unfolded) coming
from USB/HID interface to produce proper SW_TABLET_MODE event.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

v2 changes (addressing Benjamin comments):

- moved everything into hid-google-hammer.c
- dropped USB interface parsing in favor of report parsing
- removed product/model from tablet mode switch device (this is different
  from what Benjamin requested - using Google USB vendor ID - but
  it is purely host interface - BUS_HOST - not USB or I2C, and those do
  not carry vendor/product ID typically. Userspace is simply supposed
  to check capabilities of the device).

 drivers/hid/hid-google-hammer.c | 413 ++++++++++++++++++++++++++++++--
 1 file changed, 394 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 6bf4da7ad63a..de3e7d055ca4 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -13,16 +13,268 @@
  * any later version.
  */
 
+#include <linux/acpi.h>
 #include <linux/hid.h>
 #include <linux/leds.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeup.h>
+#include <asm/unaligned.h>
 
 #include "hid-ids.h"
 
-#define MAX_BRIGHTNESS 100
+/*
+ * C(hrome)B(ase)A(ttached)S(witch) - switch exported by Chrome EC and reporting
+ * state of the "Whiskers" base - attached or detached. Whiskers USB device also
+ * reports position of the keyboard - folded or not. Combining base state and
+ * position allows us to generate proper "Tablet mode" events.
+ */
+struct cbas_ec {
+	struct device *dev;	/* The platform device (EC) */
+	struct input_dev *input;
+	bool base_present;
+	struct notifier_block notifier;
+};
 
-/* HID usage for keyboard backlight (Alphanumeric display brightness) */
-#define HID_AD_BRIGHTNESS 0x00140046
+static struct cbas_ec cbas_ec;
+static DEFINE_SPINLOCK(cbas_ec_lock);
+static DEFINE_MUTEX(cbas_ec_reglock);
+
+static bool cbas_parse_base_state(const void *data)
+{
+	u32 switches = get_unaligned_le32(data);
+
+	return !!(switches & BIT(EC_MKBP_BASE_ATTACHED));
+}
+
+static int cbas_ec_query_base(struct cros_ec_device *ec_dev, bool get_state,
+				  bool *state)
+{
+	struct ec_params_mkbp_info *params;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(sizeof(u32), sizeof(*params)),
+		      GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->command = EC_CMD_MKBP_INFO;
+	msg->version = 1;
+	msg->outsize = sizeof(*params);
+	msg->insize = sizeof(u32);
+	params = (struct ec_params_mkbp_info *)msg->data;
+	params->info_type = get_state ?
+		EC_MKBP_INFO_CURRENT : EC_MKBP_INFO_SUPPORTED;
+	params->event_type = EC_MKBP_EVENT_SWITCH;
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret >= 0) {
+		if (ret != sizeof(u32)) {
+			dev_warn(ec_dev->dev, "wrong result size: %d != %zu\n",
+				 ret, sizeof(u32));
+			ret = -EPROTO;
+		} else {
+			*state = cbas_parse_base_state(msg->data);
+			ret = 0;
+		}
+	}
+
+	kfree(msg);
+
+	return ret;
+}
+
+static int cbas_ec_notify(struct notifier_block *nb,
+			      unsigned long queued_during_suspend,
+			      void *_notify)
+{
+	struct cros_ec_device *ec = _notify;
+	unsigned long flags;
+	bool base_present;
+
+	if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
+		base_present = cbas_parse_base_state(
+					&ec->event_data.data.switches);
+		dev_dbg(cbas_ec.dev,
+			"%s: base: %d\n", __func__, base_present);
+
+		if (device_may_wakeup(cbas_ec.dev) ||
+		    !queued_during_suspend) {
+
+			pm_wakeup_event(cbas_ec.dev, 0);
+
+			spin_lock_irqsave(&cbas_ec_lock, flags);
+
+			/*
+			 * While input layer dedupes the events, we do not want
+			 * to disrupt the state reported by the base by
+			 * overriding it with state reported by the LID. Only
+			 * report changes, as we assume that on attach the base
+			 * is not folded.
+			 */
+			if (base_present != cbas_ec.base_present) {
+				input_report_switch(cbas_ec.input,
+						    SW_TABLET_MODE,
+						    !base_present);
+				input_sync(cbas_ec.input);
+				cbas_ec.base_present = base_present;
+			}
+
+			spin_unlock_irqrestore(&cbas_ec_lock, flags);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static __maybe_unused int cbas_ec_resume(struct device *dev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
+	bool base_present;
+	int error;
+
+	error = cbas_ec_query_base(ec, true, &base_present);
+	if (error) {
+		dev_warn(dev, "failed to fetch base state on resume: %d\n",
+			 error);
+	} else {
+		spin_lock_irq(&cbas_ec_lock);
+
+		cbas_ec.base_present = base_present;
+
+		/*
+		 * Only report if base is disconnected. If base is connected,
+		 * it will resend its state on resume, and we'll update it
+		 * in hammer_event().
+		 */
+		if (!cbas_ec.base_present) {
+			input_report_switch(cbas_ec.input, SW_TABLET_MODE, 1);
+			input_sync(cbas_ec.input);
+		}
+
+		spin_unlock_irq(&cbas_ec_lock);
+	}
+
+	return 0;
+}
+
+static const SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
+
+static void cbas_ec_set_input(struct input_dev *input)
+{
+	/* Take the lock so hammer_event() does not race with us here */
+	spin_lock_irq(&cbas_ec_lock);
+	cbas_ec.input = input;
+	spin_unlock_irq(&cbas_ec_lock);
+}
+
+static int __cbas_ec_probe(struct platform_device *pdev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct input_dev *input;
+	bool base_supported;
+	int error;
+
+	error = cbas_ec_query_base(ec, false, &base_supported);
+	if (error)
+		return error;
+
+	if (!base_supported)
+		return -ENXIO;
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "Whiskers Tablet Mode Switch";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_SW, SW_TABLET_MODE);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev, "cannot register input device: %d\n",
+			error);
+		return error;
+	}
+
+	/* Seed the state */
+	error = cbas_ec_query_base(ec, true, &cbas_ec.base_present);
+	if (error) {
+		dev_err(&pdev->dev, "cannot query base state: %d\n", error);
+		return error;
+	}
+
+	input_report_switch(input, SW_TABLET_MODE, !cbas_ec.base_present);
+
+	cbas_ec_set_input(input);
+
+	cbas_ec.dev = &pdev->dev;
+	cbas_ec.notifier.notifier_call = cbas_ec_notify;
+	error = blocking_notifier_chain_register(&ec->event_notifier,
+						 &cbas_ec.notifier);
+	if (error) {
+		dev_err(&pdev->dev, "cannot register notifier: %d\n", error);
+		cbas_ec_set_input(NULL);
+		return error;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+	return 0;
+}
+
+static int cbas_ec_probe(struct platform_device *pdev)
+{
+	int retval;
+
+	mutex_lock(&cbas_ec_reglock);
+
+	if (cbas_ec.input) {
+		retval = -EBUSY;
+		goto out;
+	}
+
+	retval = __cbas_ec_probe(pdev);
+
+out:
+	mutex_unlock(&cbas_ec_reglock);
+	return retval;
+}
+
+static int cbas_ec_remove(struct platform_device *pdev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+
+	mutex_lock(&cbas_ec_reglock);
+
+	blocking_notifier_chain_unregister(&ec->event_notifier,
+					   &cbas_ec.notifier);
+	cbas_ec_set_input(NULL);
+
+	mutex_unlock(&cbas_ec_reglock);
+	return 0;
+}
+
+static const struct acpi_device_id cbas_ec_acpi_ids[] = {
+	{ "GOOG000B", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
+
+static struct platform_driver cbas_ec_driver = {
+	.probe = cbas_ec_probe,
+	.remove = cbas_ec_remove,
+	.driver = {
+		.name = "cbas_ec",
+		.acpi_match_table = ACPI_PTR(cbas_ec_acpi_ids),
+		.pm = &cbas_ec_pm_ops,
+	},
+};
+
+#define MAX_BRIGHTNESS 100
 
 struct hammer_kbd_leds {
 	struct led_classdev cdev;
@@ -90,33 +342,130 @@ static int hammer_register_leds(struct hid_device *hdev)
 	return devm_led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
 }
 
-static int hammer_input_configured(struct hid_device *hdev,
-				   struct hid_input *hi)
+#define HID_UP_GOOGLEVENDOR	0xffd10000
+#define HID_VD_KBD_FOLDED	0x00000019
+#define WHISKERS_KBD_FOLDED	(HID_UP_GOOGLEVENDOR | HID_VD_KBD_FOLDED)
+
+/* HID usage for keyboard backlight (Alphanumeric display brightness) */
+#define HID_AD_BRIGHTNESS	0x00140046
+
+static int hammer_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+				struct hid_field *field,
+				struct hid_usage *usage,
+				unsigned long **bit, int *max)
 {
-	struct list_head *report_list =
-		&hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
+	    usage->hid == WHISKERS_KBD_FOLDED) {
+		/*
+		 * We do not want to have this usage mapped as it will get
+		 * mixed in with "base attached" signal and delivered over
+		 * separate input device for tablet switch mode.
+		 */
+		return -1;
+	}
+
+	return 0;
+}
+
+static int hammer_event(struct hid_device *hid, struct hid_field *field,
+			struct hid_usage *usage, __s32 value)
+{
+	unsigned long flags;
+
+	if (hid->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
+	    usage->hid == WHISKERS_KBD_FOLDED) {
+		spin_lock_irqsave(&cbas_ec_lock, flags);
+
+		hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
+			cbas_ec.base_present, value);
+
+		/*
+		 * We should not get event if base is detached, but in case
+		 * we happen to service HID and EC notifications out of order
+		 * let's still check the "base present" flag.
+		 */
+		if (cbas_ec.input && cbas_ec.base_present) {
+			input_report_switch(cbas_ec.input,
+					    SW_TABLET_MODE, value);
+			input_sync(cbas_ec.input);
+		}
+
+		spin_unlock_irqrestore(&cbas_ec_lock, flags);
+		return 1; /* We handled this event */
+	}
+
+	return 0;
+}
+
+static bool hammer_is_keyboard_interface(struct hid_device *hdev)
+{
+	struct hid_report_enum *re = &hdev->report_enum[HID_INPUT_REPORT];
 	struct hid_report *report;
 
-	if (list_empty(report_list))
-		return 0;
+	list_for_each_entry(report, &re->report_list, list)
+		if (report->application == HID_GD_KEYBOARD)
+			return true;
 
-	report = list_first_entry(report_list, struct hid_report, list);
+	return false;
+}
+
+static bool hammer_has_backlight_control(struct hid_device *hdev)
+{
+	struct hid_report_enum *re = &hdev->report_enum[HID_OUTPUT_REPORT];
+	struct hid_report *report;
+	int i, j;
 
-	if (report->maxfield == 1 &&
-	    report->field[0]->application == HID_GD_KEYBOARD &&
-	    report->field[0]->maxusage == 1 &&
-	    report->field[0]->usage[0].hid == HID_AD_BRIGHTNESS) {
-		int err = hammer_register_leds(hdev);
+	list_for_each_entry(report, &re->report_list, list) {
+		if (report->application != HID_GD_KEYBOARD)
+			continue;
 
-		if (err)
+		for (i = 0; i < report->maxfield; i++) {
+			struct hid_field *field = report->field[i];
+
+			for (j = 0; j < field->maxusage; j++)
+				if (field->usage[j].hid == HID_AD_BRIGHTNESS)
+					return true;
+		}
+	}
+
+	return false;
+}
+
+static int hammer_probe(struct hid_device *hdev,
+			const struct hid_device_id *id)
+{
+	int error;
+
+	/*
+	 * We always want to poll for, and handle tablet mode events from
+	 * Whiskers, even when nobody has opened the input device. This also
+	 * prevents the hid core from dropping early tablet mode events from
+	 * the device.
+	 */
+	if (hdev->product == USB_DEVICE_ID_GOOGLE_WHISKERS &&
+			hammer_is_keyboard_interface(hdev))
+		hdev->quirks |= HID_QUIRK_ALWAYS_POLL;
+
+	error = hid_parse(hdev);
+	if (error)
+		return error;
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (error)
+		return error;
+
+	if (hammer_has_backlight_control(hdev)) {
+		error = hammer_register_leds(hdev);
+		if (error)
 			hid_warn(hdev,
 				"Failed to register keyboard backlight: %d\n",
-				err);
+				error);
 	}
 
 	return 0;
 }
 
+
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
@@ -133,8 +482,34 @@ MODULE_DEVICE_TABLE(hid, hammer_devices);
 static struct hid_driver hammer_driver = {
 	.name = "hammer",
 	.id_table = hammer_devices,
-	.input_configured = hammer_input_configured,
+	.probe = hammer_probe,
+	.input_mapping = hammer_input_mapping,
+	.event = hammer_event,
 };
-module_hid_driver(hammer_driver);
+
+static int __init hammer_init(void)
+{
+	int error;
+
+	error = platform_driver_register(&cbas_ec_driver);
+	if (error)
+		return error;
+
+	error = hid_register_driver(&hammer_driver);
+	if (error) {
+		platform_driver_unregister(&cbas_ec_driver);
+		return error;
+	}
+
+	return 0;
+}
+module_init(hammer_init);
+
+static void __exit hammer_exit(void)
+{
+	hid_unregister_driver(&hammer_driver);
+	platform_driver_unregister(&cbas_ec_driver);
+}
+module_exit(hammer_exit);
 
 MODULE_LICENSE("GPL");
-- 
2.19.0.605.g01d371f741-goog

