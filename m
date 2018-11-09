Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8702081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9zcZ4KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8702081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKJJ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:28:35 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40106 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:28:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id p193so1709138vsd.7;
        Fri, 09 Nov 2018 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yhwo+9vjqUt9z2QoyzqPYstk1TnC/gPSeSvKjoeILV8=;
        b=C9zcZ4KRfadWuUJVO+FVwXfncBiA988MJl/E7CfWOIPyKmXQOO0TygrXf5I3yd0L4d
         3VbaBQ6Qp4RmZX00jHlEnmzLLUrcffoJNw5uz4gJO353nDQsZ4wnm/wWT6rSp5naKO99
         FhOe0CfmkPRDWZLF2bhCrgzM6AJLBEazK6DtlxBwLsh5ackaSt6FHzJ1BGr2VofBZK4L
         XA0LzsLRmZ6v78W8cJc2D2FQ+s6DfRjFI/yVB/aFpXMWYlHZEz6mlK8KS02917ZIjsjz
         k0KQ0fT56rm1coBheWCPzblH3E06he5N+DdqX0cVXc2WyG43cAh33Mmx9gexMnEHuZoH
         8hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yhwo+9vjqUt9z2QoyzqPYstk1TnC/gPSeSvKjoeILV8=;
        b=bTySpiNMTwuYZ845pz86TXH5SFV9t1RE7laVvt/K0YHaA+IS/rHNOquVNv1XNu6qfU
         xkvod1QayFct5A4x1cZmQSrwJSLj2p/WqnsaizJP17gS70GNnUzP14YqU7OuamfFDCbP
         ImMqoJIPq7K+Qfec2VsD7DiKhJgJoUxzvvATz471yUqwx7aDa8nTjM8TrVw+p1ZCspYc
         ncUerbiOsE3SqY7X6wEYCCUGTzpJhOnVgABKwrjydBR0h/DTik09KnjX6SbRYbt1NLz9
         MNYeaNON1YptNWU5a0SDHFepDQfZJ5wgRXVPqjGAuVHecsuGfthpLkeFVG5Cpvk8355o
         g5qA==
X-Gm-Message-State: AGRZ1gLJMvIVRl2NG2ZtwVsnwBBtZMTbtqlqu5aCgFil7tCAAIT5eYWr
        TgY7kQa3m6bbZS/o6AkM7A==
X-Google-Smtp-Source: AJdET5cMhhkgxJvu+RuJ/+4/0Nv0Y/lV1+miUPB8aFSZjNb5jnFV3O5KnAm6zS+AjgV8UH7AXr6o7w==
X-Received: by 2002:a67:210b:: with SMTP id u11mr4685267vsf.232.1541807141366;
        Fri, 09 Nov 2018 15:45:41 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id c71sm2395689vsd.9.2018.11.09.15.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 15:45:40 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 1/3] x86: add support for Huawei WMI hotkeys.
Date:   Fri,  9 Nov 2018 18:45:19 -0500
Message-Id: <20181109234526.4280-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181109234526.4280-1-ayman.bagabas@gmail.com>
References: <20181109234526.4280-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for missing hotkeys on some Huawei laptops.
Currently, only Huawei Matebook X and Matebook X Pro is supported.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig                 |  10 +
 drivers/platform/x86/Makefile                |   1 +
 drivers/platform/x86/huawei_wmi.c            | 215 +++++++++++++++++++
 include/linux/platform_data/x86/huawei_wmi.h |   9 +
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/platform/x86/huawei_wmi.c
 create mode 100644 include/linux/platform_data/x86/huawei_wmi.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 54f6a40c75c6..5bdc4d54cddf 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1288,6 +1288,16 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config HUAWEI_LAPTOP
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for Huawei WMI hotkeys.
+	  It enables the missing keys and adds support to the micmute
+	  LED found on some of these laptops.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 39ae94135406..ee93655d8bc1 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ACERHDF)		+= acerhdf.o
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_HUAWEI_LAPTOP)		+= huawei_wmi.o
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
new file mode 100644
index 000000000000..940c07ce4552
--- /dev/null
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Huawei WMI hotkeys
+ *
+ *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/module.h>
+#include <linux/platform_data/x86/huawei_wmi.h>
+
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL");
+
+/*
+ * Huawei WMI Events GUIDs
+ */
+#define MBX_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+#define MBXP_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+
+MODULE_ALIAS("wmi:"MBX_EVENT_GUID);
+MODULE_ALIAS("wmi:"MBXP_EVENT_GUID);
+
+static const struct key_entry huawei_wmi_keymap[] __initconst = {
+		{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
+		{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
+		{ KE_KEY,    0x284, { KEY_MUTE } },
+		{ KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
+		{ KE_KEY,    0x286, { KEY_VOLUMEUP } },
+		{ KE_KEY,	 0x287, { KEY_MICMUTE } },
+		{ KE_KEY,	 0x289, { KEY_WLAN } },
+		// Huawei |M| button
+		{ KE_KEY,	 0x28a, { KEY_PROG1 } },
+		// Keyboard light
+		{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
+		{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
+		{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+		{ KE_END,	 0 }
+};
+
+static char *event_guid;
+static struct input_dev *inputdev;
+
+int huawei_wmi_micmute_led_set(bool on)
+{
+	acpi_handle handle;
+	char *method;
+	union acpi_object args[3];
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+
+	handle = ACPI_HANDLE(&inputdev->dev);
+	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = 0x04;
+
+	if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
+		args[0].integer.value = 0;
+		args[2].integer.value = on ? 1 : 0;
+	} else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
+		args[0].integer.value = 1;
+		args[2].integer.value = on ? 0 : 1;
+	} else {
+		dev_err(&inputdev->dev, "Unable to find ACPI method\n");
+		return -ENOSYS;
+	}
+
+	acpi_evaluate_object(handle, method, &arg_list, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(huawei_wmi_micmute_led_set);
+
+static void huawei_wmi_process_key(struct input_dev *inputdev, int code)
+{
+	const struct key_entry *key;
+
+	/*
+	 * MBX uses code 0x80 to indicate a hotkey event.
+	 * The actual key is fetched from the method WQ00
+	 */
+	if (code == 0x80) {
+		acpi_status status;
+		unsigned long long result;
+		const char *method = "\\WMI0.WQ00";
+		union acpi_object args[1];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		args[0].type = ACPI_TYPE_INTEGER;
+		args[0].integer.value = 0;
+
+		status = acpi_evaluate_integer(ACPI_HANDLE(&inputdev->dev), (char *)method, &arg_list, &result);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&inputdev->dev, "Unable to evaluate ACPI method %s\n", method);
+			return;
+		}
+
+		code = result;
+	}
+
+	key = sparse_keymap_entry_from_scancode(inputdev, code);
+	if (!key) {
+		dev_info(&inputdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
+		return;
+	}
+
+	/*
+	 * The MBXP handles backlight natively using ACPI,
+	 * but not the MBX. If MBXP is being used, skip reporting event.
+	 */
+	if ((key->sw.code == KEY_BRIGHTNESSUP || key->sw.code == KEY_BRIGHTNESSDOWN)
+			&& strcmp(event_guid, MBXP_EVENT_GUID) == 0)
+		return;
+
+	sparse_keymap_report_entry(inputdev, key, 1, true);
+}
+
+static void huawei_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	struct input_dev *inputdev = (struct input_dev *)context;
+
+	status = wmi_get_event_data(value, &response);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&inputdev->dev, "Bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(inputdev, obj->integer.value);
+	else
+		dev_info(&inputdev->dev, "Unknown response received %d\n", obj->type);
+
+	kfree(response.pointer);
+}
+
+static int huawei_wmi_input_init(void)
+{
+	acpi_status status;
+	int err;
+
+	inputdev = input_allocate_device();
+	if (!inputdev)
+		return -ENOMEM;
+
+	inputdev->name = "Huawei WMI hotkeys";
+	inputdev->phys = "wmi/input0";
+	inputdev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(inputdev,
+			huawei_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	status = wmi_install_notify_handler(event_guid,
+			huawei_wmi_notify,
+			inputdev);
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_free_dev;
+	}
+
+	err = input_register_device(inputdev);
+	if (err)
+		goto err_remove_notifier;
+
+	return 0;
+
+err_remove_notifier:
+	wmi_remove_notify_handler(event_guid);
+err_free_dev:
+	input_free_device(inputdev);
+	return err;
+}
+
+static void huawei_wmi_input_exit(void)
+{
+	wmi_remove_notify_handler(event_guid);
+	input_unregister_device(inputdev);
+}
+
+static int __init huawei_wmi_init(void)
+{
+	if (wmi_has_guid(MBX_EVENT_GUID)) {
+		event_guid = MBX_EVENT_GUID;
+	} else if (wmi_has_guid(MBXP_EVENT_GUID)) {
+		event_guid = MBXP_EVENT_GUID;
+	} else {
+		pr_warn("Compatible WMI GUID not found\n");
+		return -ENODEV;
+	}
+
+	return huawei_wmi_input_init();
+}
+
+static void __exit huawei_wmi_exit(void)
+{
+	huawei_wmi_input_exit();
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
diff --git a/include/linux/platform_data/x86/huawei_wmi.h b/include/linux/platform_data/x86/huawei_wmi.h
new file mode 100644
index 000000000000..dd251780ee5c
--- /dev/null
+++ b/include/linux/platform_data/x86/huawei_wmi.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#ifndef __HUAWEI_WMI_H__
+#define __HUAWEI_WMI_H__
+
+int huawei_wmi_micmute_led_set(bool on);
+
+#endif
+#endif
-- 
2.17.2

