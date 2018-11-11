Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306F5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53F72148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCNR4ogD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53F72148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeKLEwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:52:34 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40675 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbeKLEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:52:33 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so2329454uao.7;
        Sun, 11 Nov 2018 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Z31lrupEdvDSDibWiaU2UIGrtc5Gf+yzGrBtCGAlFg=;
        b=TCNR4ogDpSPx9vIX7r2dUexjMcSY76iW2pW2cwuhceKIlbExy/P6tvvh2q3VTcs7nm
         LMd/Ni+ANCAIeCbfJyKZI8S4Ckjlt0XYvoX+2Juv3DwKCy9XeunhqM352fLVIDSiRPWo
         eep0k4j/CjrAZugdus6APvrmfBK3lZGi8BKaNrBmteeMRUR7xC9CrXj7WEliB+rhjxDA
         gxKwFcvzbnLqWkAuU5irHbL42+b2UPIoKbim7NzxDqmYOYvJ9lAt2RY+JEK1f0C6/H4I
         RGV8wodwwH7At+xiv75+IXrhneXeDvP//TUGCsx/krUGJHNqVXZeloV7+kkvM/fhs+8G
         Xgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Z31lrupEdvDSDibWiaU2UIGrtc5Gf+yzGrBtCGAlFg=;
        b=oOlEVIv980W+XErxqex1ohXEAvPLkIFQkBJf7KMTWUH/uoTHCCXVJKn4T1EHR4Csj2
         gxooJrPmXzn9agoJPdQ05snv4zILUQwG56UqMNNeBi7VHLCEuN4WNa1lhhHUu/iqTuJh
         7QOb6d7+4dWG/zfrm4gc4AL647jCAAQtuV3TaW3JIY/jKaditfb1urDnUjRsIa9DNDfX
         v0ulF92BVnEFQE+V0H5dmjBBByy8JzOwzkg10tAYwcYhMnDfR1UzTW1CmeSmDZ6Uywfs
         2gJ94cF4u4RwURHgyiVcghU7N2koOasqbL3VfNQpfGWz9WgmMGAWnvU4BYWSqefk3LWi
         uCxA==
X-Gm-Message-State: AGRZ1gKVg4jjqT3368Bry2kbthN/hiW8OQFixuCRp+xmcoQ+XXiWomF7
        pyK/ceIIDNMsA/EBdyVNgA==
X-Google-Smtp-Source: AJdET5fZQUMjzVbo/FfcN8YMxMWON1xP0mqvkQ5f4jX2Gss9VG+6BiTDIw++0mQ4gmS3ocTJ7mT9UA==
X-Received: by 2002:ab0:5484:: with SMTP id p4mr7591584uaa.102.1541962992800;
        Sun, 11 Nov 2018 11:03:12 -0800 (PST)
Received: from localhost.localdomain (c-71-226-66-69.hsd1.ga.comcast.net. [71.226.66.69])
        by smtp.gmail.com with ESMTPSA id o8sm4048168vkf.4.2018.11.11.11.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 11:03:12 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 1/3] x86: add support for Huawei WMI hotkeys.
Date:   Sun, 11 Nov 2018 14:02:43 -0500
Message-Id: <20181111190250.6055-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111190250.6055-1-ayman.bagabas@gmail.com>
References: <20181111190250.6055-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/platform/x86/huawei-wmi.c            | 215 +++++++++++++++++++
 include/linux/platform_data/x86/huawei-wmi.h |   9 +
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c
 create mode 100644 include/linux/platform_data/x86/huawei-wmi.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 54f6a40c75c6..5bdc4d54cddf 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1288,6 +1288,19 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config HUAWEI_WMI
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for Huawei WMI hotkeys.
+	  It enables the missing keys and adds support to the micmute
+	  LED found on some of these laptops.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called huawei-wmi.
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
+obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
new file mode 100644
index 000000000000..940c07ce4552
--- /dev/null
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -0,0 +1,214 @@
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
+#include <linux/platform_data/x86/huawei-wmi.h>
+
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL v2");
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
+	 * The actual key is fetched from the method WQ00.
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
+	struct input_dev *inputdev = context;
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
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
+	err = sparse_keymap_setup(inputdev, huawei_wmi_keymap, NULL);
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
diff --git a/include/linux/platform_data/x86/huawei-wmi.h b/include/linux/platform_data/x86/huawei-wmi.h
new file mode 100644
index 000000000000..dd251780ee5c
--- /dev/null
+++ b/include/linux/platform_data/x86/huawei-wmi.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if IS_ENABLED(CONFIG_HUAWEI_WMI)
+#ifndef __HUAWEI_WMI_H__
+#define __HUAWEI_WMI_H__
+
+int huawei_wmi_micmute_led_set(bool on);
+
+#endif
+#endif
-- 
2.17.2

