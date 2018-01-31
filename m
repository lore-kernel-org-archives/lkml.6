Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeAaE4s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:56:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36060 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeAaE4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:56:46 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, andy.shevchenko@gmail.com, erik.schmauss@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3] ACPI: Parse entire table as a term_list for Dell XPS 9570 and Precision M5530
Date: Wed, 31 Jan 2018 12:56:34 +0800
Message-Id: <20180131045634.13328-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
of box.

The touchpad relies on its _INI method to update its _HID value from
XXXX0000 to SYNA2393.
Also, the _STA relies on value of I2CN to report correct status.

Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
correctly set up, and _INI can get run. The ACPI table in this machine
is designed to get parsed this way.

Also, change the quirk table to a more generic name.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198515
Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3: Put the function under right #ifdef, comment adjustment

v2: Andy's suggestion, merge to a single quirk table.

 drivers/acpi/bus.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e02a28..7cb18bc2b59a 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -66,10 +66,39 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
 	return 0;
 }
 #endif
+static int set_gbl_term_list(const struct dmi_system_id *id)
+{
+	pr_notice("%s detected - parse the entire table as a term_list\n",
+		  id->ident);
+	acpi_gbl_parse_table_as_term_list = 1;
+	return 0;
+}
 
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
+	/*
+	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
+	 * mode.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
+	 */
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell Precision M5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
+		},
+	},
+	{
+		.callback = set_gbl_term_list,
+		.ident = "Dell XPS 15 9570",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
+		},
+	},
 	/*
 	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
+	 * DSDT will be copied to memory.
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
 	 */
 	{
@@ -83,7 +112,7 @@ static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
 	{}
 };
 #else
-static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
+static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
 	{}
 };
 #endif
@@ -1001,11 +1030,8 @@ void __init acpi_early_init(void)
 
 	acpi_permanent_mmap = true;
 
-	/*
-	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
-	 */
-	dmi_check_system(dsdt_dmi_table);
+	/* Check machine-specific quirks */
+	dmi_check_system(acpi_quirks_dmi_table);
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
-- 
2.15.1
