Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754311AbeB0P6u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:58:50 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:16540 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932240AbeB0P5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:57:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GLAAAGf5Vahz+a6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKINUmCGDGIchjQmCFQqFMgKCTFYWAQIBAQEBAQECAQIQAQE?=
 =?us-ascii?q?BCgsJCCgvgjgkAYJIAwMjBAsBRhAlAhgOAgIhNgYBEoR9AxWrM4FtOoczDYEwg?=
 =?us-ascii?q?hQBAQEBBgEBAQEBI4EPhjuBV4FmhheFRIJiBYgVB4ZKRopyMAmCC4stgzkCjnK?=
 =?us-ascii?q?KM4cdgS4lBIF/cIMSgkMQDIIaWIxSAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GLAAAGf5Vahz+a6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKINUmCGDGIchjQmCFQqFMgKCTFYWAQIBAQEBAQECAQIQAQEBCgsJCCgvgjgkA?=
 =?us-ascii?q?YJIAwMjBAsBRhAlAhgOAgIhNgYBEoR9AxWrM4FtOoczDYEwghQBAQEBBgEBAQE?=
 =?us-ascii?q?BI4EPhjuBV4FmhheFRIJiBYgVB4ZKRopyMAmCC4stgzkCjnKKM4cdgS4lBIF/c?=
 =?us-ascii?q?IMSgkMQDIIaWIxSAQEB?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="623642162"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 3/3] platform/x86: dell-smbios: Link all dell-smbios-* modules together
Date: Tue, 27 Feb 2018 09:56:54 -0600
Message-Id: <1519747014-17561-3-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some race conditions were raised due to dell-smbios and its backends
not being ready by the time that a consumer would call one of the
exported methods.

To avoid this problem, guarantee that all initialization has been
done by linking them all together and running init for them all.

As part of this change the Kconfig needs to be adjusted so that
CONFIG_DELL_SMBIOS_SMM and CONFIG_DELL_SMBIOS_WMI are boolean
rather than modules.

CONFIG_DELL_SMBIOS is a visually selectable option again and both
CONFIG_DELL_SMBIOS_WMI and CONFIG_DELL_SMBIOS_SMM are optional.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/Kconfig            | 11 ++++++++---
 drivers/platform/x86/Makefile           |  6 +++---
 drivers/platform/x86/dell-smbios-base.c | 21 ++++++++++++++++++++-
 drivers/platform/x86/dell-smbios-smm.c  | 25 +++++++++++++------------
 drivers/platform/x86/dell-smbios-wmi.c  | 24 ++++++++++++++----------
 drivers/platform/x86/dell-smbios.h      |  6 ++++++
 6 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9a8f964..0c0897e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -106,10 +106,15 @@ config ASUS_LAPTOP
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
 config DELL_SMBIOS
-	tristate
+	tristate "Dell SMBIOS driver"
+	---help---
+	This provides support for the Dell SMBIOS calling interface.
+	If you have a Dell computer you should enable this option.
+
+	Be sure to select at least one backend for it to work properly.
 
 config DELL_SMBIOS_WMI
-	tristate "Dell SMBIOS calling interface (WMI implementation)"
+	bool "Dell SMBIOS driver WMI support"
 	depends on ACPI_WMI
 	select DELL_WMI_DESCRIPTOR
 	select DELL_SMBIOS
@@ -122,7 +127,7 @@ config DELL_SMBIOS_WMI
 	it just won't load.
 
 config DELL_SMBIOS_SMM
-	tristate "Dell SMBIOS calling interface (SMM implementation)"
+	bool "Dell SMBIOS driver SMM support"
 	depends on DCDBAS
 	select DELL_SMBIOS
 	---help---
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 940b118..0e242bd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -13,9 +13,9 @@ obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
 obj-$(CONFIG_DELL_SMBIOS)	+= dell-smbios.o
-dell-smbios-objs		:= dell-smbios-base.o
-obj-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
-obj-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
+dell-smbios-objs		:= dell-smbios-base.o	\
+				   dell-smbios-smm.o	\
+				   dell-smbios-wmi.o
 obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
 obj-$(CONFIG_DELL_WMI)		+= dell-wmi.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 4850658..fdb1044 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -555,7 +555,7 @@ static void free_group(struct platform_device *pdev)
 static int __init dell_smbios_init(void)
 {
 	const struct dmi_device *valid;
-	int ret;
+	int ret, wmi, smm;
 
 	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
 	if (!valid) {
@@ -590,8 +590,24 @@ static int __init dell_smbios_init(void)
 	if (ret)
 		goto fail_create_group;
 
+	/* register backends */
+	wmi = init_dell_smbios_wmi();
+	if (wmi)
+		pr_debug("Failed to initialize WMI backend: %d\n", wmi);
+	smm = init_dell_smbios_smm();
+	if (smm)
+		pr_debug("Failed to initialize SMM backend: %d\n", smm);
+	if (wmi && smm) {
+		pr_err("No SMBIOS backends available (wmi: %d, smm: %d)\n",
+			wmi, smm);
+		goto fail_sysfs;
+	}
+
 	return 0;
 
+fail_sysfs:
+	free_group(platform_device);
+
 fail_create_group:
 	platform_device_del(platform_device);
 
@@ -608,6 +624,8 @@ static int __init dell_smbios_init(void)
 
 static void __exit dell_smbios_exit(void)
 {
+	exit_dell_smbios_wmi();
+	exit_dell_smbios_smm();
 	mutex_lock(&smbios_mutex);
 	if (platform_device) {
 		free_group(platform_device);
@@ -624,5 +642,6 @@ module_exit(dell_smbios_exit);
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
 MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Common functions for kernel modules using Dell SMBIOS");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
index 89f65c4..dc060f3 100644
--- a/drivers/platform/x86/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell-smbios-smm.c
@@ -21,6 +21,7 @@
 #include "../../firmware/dcdbas.h"
 #include "dell-smbios.h"
 
+#ifdef CONFIG_DELL_SMBIOS_SMM
 static int da_command_address;
 static int da_command_code;
 static struct calling_interface_buffer *buffer;
@@ -58,7 +59,7 @@ static const struct dmi_system_id dell_device_table[] __initconst = {
 };
 MODULE_DEVICE_TABLE(dmi, dell_device_table);
 
-static void __init parse_da_table(const struct dmi_header *dm)
+static void parse_da_table(const struct dmi_header *dm)
 {
 	struct calling_interface_structure *table =
 		container_of(dm, struct calling_interface_structure, header);
@@ -73,7 +74,7 @@ static void __init parse_da_table(const struct dmi_header *dm)
 	da_command_code = table->cmdIOCode;
 }
 
-static void __init find_cmd_address(const struct dmi_header *dm, void *dummy)
+static void find_cmd_address(const struct dmi_header *dm, void *dummy)
 {
 	switch (dm->type) {
 	case 0xda: /* Calling interface */
@@ -128,7 +129,7 @@ static bool test_wsmt_enabled(void)
 	return false;
 }
 
-static int __init dell_smbios_smm_init(void)
+int init_dell_smbios_smm(void)
 {
 	int ret;
 	/*
@@ -176,7 +177,7 @@ static int __init dell_smbios_smm_init(void)
 	return ret;
 }
 
-static void __exit dell_smbios_smm_exit(void)
+void exit_dell_smbios_smm(void)
 {
 	if (platform_device) {
 		dell_smbios_unregister_device(&platform_device->dev);
@@ -185,12 +186,12 @@ static void __exit dell_smbios_smm_exit(void)
 	}
 }
 
-subsys_initcall(dell_smbios_smm_init);
-module_exit(dell_smbios_smm_exit);
+#else /* CONFIG_DELL_SMBIOS_SMM */
+int init_dell_smbios_smm(void)
+{
+	return -ENODEV;
+}
 
-MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
-MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
-MODULE_DESCRIPTION("Dell SMBIOS communications over SMI");
-MODULE_LICENSE("GPL");
+void exit_dell_smbios_smm(void)
+{}
+#endif /* CONFIG_DELL_SMBIOS_SMM */
diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index 609557a..c2264e4 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -18,6 +18,7 @@
 #include "dell-smbios.h"
 #include "dell-wmi-descriptor.h"
 
+#ifdef CONFIG_DELL_SMBIOS_WMI
 static DEFINE_MUTEX(call_mutex);
 static DEFINE_MUTEX(list_mutex);
 static int wmi_supported;
@@ -228,7 +229,7 @@ static const struct wmi_device_id dell_smbios_wmi_id_table[] = {
 	{ },
 };
 
-static void __init parse_b1_table(const struct dmi_header *dm)
+static void parse_b1_table(const struct dmi_header *dm)
 {
 	struct misc_bios_flags_structure *flags =
 	container_of(dm, struct misc_bios_flags_structure, header);
@@ -242,7 +243,7 @@ static void __init parse_b1_table(const struct dmi_header *dm)
 		wmi_supported = 1;
 }
 
-static void __init find_b1(const struct dmi_header *dm, void *dummy)
+static void find_b1(const struct dmi_header *dm, void *dummy)
 {
 	switch (dm->type) {
 	case 0xb1: /* misc bios flags */
@@ -261,7 +262,7 @@ static struct wmi_driver dell_smbios_wmi_driver = {
 	.filter_callback = dell_smbios_wmi_filter,
 };
 
-static int __init init_dell_smbios_wmi(void)
+int init_dell_smbios_wmi(void)
 {
 	dmi_walk(find_b1, NULL);
 
@@ -271,15 +272,18 @@ static int __init init_dell_smbios_wmi(void)
 	return wmi_driver_register(&dell_smbios_wmi_driver);
 }
 
-static void __exit exit_dell_smbios_wmi(void)
+void exit_dell_smbios_wmi(void)
 {
 	wmi_driver_unregister(&dell_smbios_wmi_driver);
 }
 
-module_init(init_dell_smbios_wmi);
-module_exit(exit_dell_smbios_wmi);
-
 MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
-MODULE_DESCRIPTION("Dell SMBIOS communications over WMI");
-MODULE_LICENSE("GPL");
+#else /* CONFIG_DELL_SMBIOS_WMI */
+int init_dell_smbios_wmi(void)
+{
+	return -ENODEV;
+}
+
+void exit_dell_smbios_wmi(void)
+{}
+#endif /* CONFIG_DELL_SMBIOS_WMI */
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index 138d478..386bfa2 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -75,4 +75,10 @@ int dell_laptop_register_notifier(struct notifier_block *nb);
 int dell_laptop_unregister_notifier(struct notifier_block *nb);
 void dell_laptop_call_notifier(unsigned long action, void *data);
 
+/* for the supported backends */
+int init_dell_smbios_wmi(void);
+void exit_dell_smbios_wmi(void);
+int init_dell_smbios_smm(void);
+void exit_dell_smbios_smm(void);
+
 #endif
-- 
2.7.4
