Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeB0SXj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:23:39 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:39198 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751675AbeB0SXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:23:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GLAAAFoZVamMuZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKINUmCGDGIchjQmCFQqFMgKCTFYWAQIBAQEBAQECAQIQAQE?=
 =?us-ascii?q?BAQEGDQsGKC+COCQBgkgDAyMECwFGECUCGA4CAiE2BgEShH0DFawkgW06hzMNg?=
 =?us-ascii?q?TCCFgEBAQEGAQEBAQEjgQ+GO4FXgWaGF4VEgmIFiBUHhkpGinIwCYILiy2DOQK?=
 =?us-ascii?q?Ocoozhx2BLiUNgXZwgxKCQxAMFoIEWIxSAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GLAAAFoZVamMuZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKINUmCGDGIchjQmCFQqFMgKCTFYWAQIBAQEBAQECAQIQAQEBAQEGDQsGKC+CO?=
 =?us-ascii?q?CQBgkgDAyMECwFGECUCGA4CAiE2BgEShH0DFawkgW06hzMNgTCCFgEBAQEGAQE?=
 =?us-ascii?q?BAQEjgQ+GO4FXgWaGF4VEgmIFiBUHhkpGinIwCYILiy2DOQKOcoozhx2BLiUNg?=
 =?us-ascii?q?XZwgxKCQxAMFoIEWIxSAQEB?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,402,1515477600";
   d="scan'208";a="140764456"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-* modules together
Date: Tue, 27 Feb 2018 12:23:04 -0600
Message-Id: <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
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
Changes from v2:
 * Move rest of #ifdef out of source files
 * Only compile units as necessary

 drivers/platform/x86/Kconfig            | 11 ++++++++---
 drivers/platform/x86/Makefile           |  4 ++--
 drivers/platform/x86/dell-smbios-base.c | 21 ++++++++++++++++++++-
 drivers/platform/x86/dell-smbios-smm.c  | 18 ++++--------------
 drivers/platform/x86/dell-smbios-wmi.c  | 14 ++++----------
 drivers/platform/x86/dell-smbios.h      | 27 ++++++++++++++++++++++++++-
 6 files changed, 64 insertions(+), 31 deletions(-)

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
index 940b118..2ba6cb7 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
 obj-$(CONFIG_DELL_SMBIOS)	+= dell-smbios.o
 dell-smbios-objs		:= dell-smbios-base.o
-obj-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
-obj-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
+dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
+dell-smbios-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
 obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
 obj-$(CONFIG_DELL_WMI)		+= dell-wmi.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
index 76b9d75..5bcf8a1 100644
--- a/drivers/platform/x86/dell-smbios-base.c
+++ b/drivers/platform/x86/dell-smbios-base.c
@@ -556,7 +556,7 @@ static void free_group(struct platform_device *pdev)
 static int __init dell_smbios_init(void)
 {
 	const struct dmi_device *valid;
-	int ret;
+	int ret, wmi, smm;
 
 	valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL);
 	if (!valid) {
@@ -591,8 +591,24 @@ static int __init dell_smbios_init(void)
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
 
@@ -609,6 +625,8 @@ static int __init dell_smbios_init(void)
 
 static void __exit dell_smbios_exit(void)
 {
+	exit_dell_smbios_wmi();
+	exit_dell_smbios_smm();
 	mutex_lock(&smbios_mutex);
 	if (platform_device) {
 		free_group(platform_device);
@@ -625,5 +643,6 @@ module_exit(dell_smbios_exit);
 MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
 MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
 MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Common functions for kernel modules using Dell SMBIOS");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
index 89f65c4..e9e9da5 100644
--- a/drivers/platform/x86/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell-smbios-smm.c
@@ -58,7 +58,7 @@ static const struct dmi_system_id dell_device_table[] __initconst = {
 };
 MODULE_DEVICE_TABLE(dmi, dell_device_table);
 
-static void __init parse_da_table(const struct dmi_header *dm)
+static void parse_da_table(const struct dmi_header *dm)
 {
 	struct calling_interface_structure *table =
 		container_of(dm, struct calling_interface_structure, header);
@@ -73,7 +73,7 @@ static void __init parse_da_table(const struct dmi_header *dm)
 	da_command_code = table->cmdIOCode;
 }
 
-static void __init find_cmd_address(const struct dmi_header *dm, void *dummy)
+static void find_cmd_address(const struct dmi_header *dm, void *dummy)
 {
 	switch (dm->type) {
 	case 0xda: /* Calling interface */
@@ -128,7 +128,7 @@ static bool test_wsmt_enabled(void)
 	return false;
 }
 
-static int __init dell_smbios_smm_init(void)
+int init_dell_smbios_smm(void)
 {
 	int ret;
 	/*
@@ -176,7 +176,7 @@ static int __init dell_smbios_smm_init(void)
 	return ret;
 }
 
-static void __exit dell_smbios_smm_exit(void)
+void exit_dell_smbios_smm(void)
 {
 	if (platform_device) {
 		dell_smbios_unregister_device(&platform_device->dev);
@@ -184,13 +184,3 @@ static void __exit dell_smbios_smm_exit(void)
 		free_page((unsigned long)buffer);
 	}
 }
-
-subsys_initcall(dell_smbios_smm_init);
-module_exit(dell_smbios_smm_exit);
-
-MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
-MODULE_AUTHOR("Gabriele Mazzotta <gabriele.mzt@gmail.com>");
-MODULE_AUTHOR("Pali Rohár <pali.rohar@gmail.com>");
-MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
-MODULE_DESCRIPTION("Dell SMBIOS communications over SMI");
-MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index 609557a..fbefedb 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -228,7 +228,7 @@ static const struct wmi_device_id dell_smbios_wmi_id_table[] = {
 	{ },
 };
 
-static void __init parse_b1_table(const struct dmi_header *dm)
+static void parse_b1_table(const struct dmi_header *dm)
 {
 	struct misc_bios_flags_structure *flags =
 	container_of(dm, struct misc_bios_flags_structure, header);
@@ -242,7 +242,7 @@ static void __init parse_b1_table(const struct dmi_header *dm)
 		wmi_supported = 1;
 }
 
-static void __init find_b1(const struct dmi_header *dm, void *dummy)
+static void find_b1(const struct dmi_header *dm, void *dummy)
 {
 	switch (dm->type) {
 	case 0xb1: /* misc bios flags */
@@ -261,7 +261,7 @@ static struct wmi_driver dell_smbios_wmi_driver = {
 	.filter_callback = dell_smbios_wmi_filter,
 };
 
-static int __init init_dell_smbios_wmi(void)
+int init_dell_smbios_wmi(void)
 {
 	dmi_walk(find_b1, NULL);
 
@@ -271,15 +271,9 @@ static int __init init_dell_smbios_wmi(void)
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
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell-smbios.h
index 138d478..d8adaf9 100644
--- a/drivers/platform/x86/dell-smbios.h
+++ b/drivers/platform/x86/dell-smbios.h
@@ -75,4 +75,29 @@ int dell_laptop_register_notifier(struct notifier_block *nb);
 int dell_laptop_unregister_notifier(struct notifier_block *nb);
 void dell_laptop_call_notifier(unsigned long action, void *data);
 
-#endif
+/* for the supported backends */
+#ifdef CONFIG_DELL_SMBIOS_WMI
+int init_dell_smbios_wmi(void);
+void exit_dell_smbios_wmi(void);
+#else /* CONFIG_DELL_SMBIOS_WMI */
+static inline int init_dell_smbios_wmi(void)
+{
+	return -ENODEV;
+}
+static inline void exit_dell_smbios_wmi(void)
+{}
+#endif /* CONFIG_DELL_SMBIOS_WMI */
+
+#ifdef CONFIG_DELL_SMBIOS_SMM
+int init_dell_smbios_smm(void);
+void exit_dell_smbios_smm(void);
+#else /* CONFIG_DELL_SMBIOS_SMM */
+static inline int init_dell_smbios_smm(void)
+{
+	return -ENODEV;
+}
+static inline void exit_dell_smbios_smm(void)
+{}
+#endif /* CONFIG_DELL_SMBIOS_SMM */
+
+#endif /* _DELL_SMBIOS_H_ */
-- 
2.7.4
