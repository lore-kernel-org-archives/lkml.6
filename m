Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163077AbeBNTmU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:42:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35576 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162988AbeBNTmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:42:14 -0500
X-Google-Smtp-Source: AH8x2268TjT+CgKvOwCg/7p6MpJTuv/Q7ZxOxP4nmQx/0Jio/2F/GDNfjHhuU+UdOC1pR9rh78LZJA==
From: Carlo Caione <carlo@caione.org>
To: linux@endlessm.com, hdegoede@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, sre@kernel.org, wens@csie.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 1/2] power: supply: ACPI/AXP288: Add quirk to avoid using PMIC
Date: Wed, 14 Feb 2018 19:42:00 +0000
Message-Id: <20180214194201.24385-2-carlo@caione.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180214194201.24385-1-carlo@caione.org>
References: <20180214194201.24385-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
using the ACPI drivers for AC and battery when a native PMIC driver was
already present. While this is in general a good idea (because of broken
DSDT or proprietary and undocumented ACPI opregions for the ACPI
AC/battery devices) we have come across at least one CherryTrail laptop
(ECS EF20EA) shipping the AXP288 together with a separate FG controller
(a MAX17047) instead of the one embedded in the AXP288.

The net effect of blacklisting the ACPI drivers is that on this platform
the AC/battery reporting is broken since the information is coming from
the AXP288 FG driver, not actually used in hardware.

In this case we want to keep using the ACPI AC/battery driver that is
able to interface correctly with the real FG controller.

We introduce therefore a new quirk to avoid the blacklist.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/acpi/ac.c      | 26 ++++++++++++++++++--------
 drivers/acpi/battery.c | 26 ++++++++++++++++++--------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 47a7ed557bd6..b9a4ca720309 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -87,6 +87,7 @@ static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 
 static int ac_sleep_before_get_state_ms;
+static bool ac_not_use_pmic;
 
 static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
@@ -316,6 +317,12 @@ static int thinkpad_e530_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int ac_not_use_pmic_quirk(const struct dmi_system_id *d)
+{
+	ac_not_use_pmic = true;
+	return 0;
+}
+
 static const struct dmi_system_id ac_dmi_table[] = {
 	{
 	.callback = thinkpad_e530_quirk,
@@ -384,7 +391,6 @@ static int acpi_ac_add(struct acpi_device *device)
 		kfree(ac);
 	}
 
-	dmi_check_system(ac_dmi_table);
 	return result;
 }
 
@@ -442,13 +448,17 @@ static int __init acpi_ac_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
-		if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
-				     acpi_ac_blacklist[i].hrv)) {
-			pr_info(PREFIX "AC: found native %s PMIC, not loading\n",
-				acpi_ac_blacklist[i].hid);
-			return -ENODEV;
-		}
+	dmi_check_system(ac_dmi_table);
+
+	if (!ac_not_use_pmic) {
+		for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
+			if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
+					     acpi_ac_blacklist[i].hrv)) {
+				pr_info(PREFIX "AC: found native %s PMIC, not loading\n",
+					acpi_ac_blacklist[i].hid);
+				return -ENODEV;
+			}
+	}
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7128488a3a72..258d2e66f230 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -71,6 +71,7 @@ static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_full_discharging;
+static bool battery_not_use_pmic;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -1176,6 +1177,13 @@ static int __init battery_full_discharging_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init
+battery_not_use_pmic_quirk(const struct dmi_system_id *d)
+{
+	battery_not_use_pmic = true;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1364,16 +1372,18 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 	unsigned int i;
 	int result;
 
-	for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
-		if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
-			pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
-				": found native %s PMIC, not loading\n",
-				acpi_battery_blacklist[i]);
-			return;
-		}
-
 	dmi_check_system(bat_dmi_table);
 
+	if (!battery_not_use_pmic) {
+		for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
+			if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
+				pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
+					": found native %s PMIC, not loading\n",
+					acpi_battery_blacklist[i]);
+				return;
+			}
+	}
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
-- 
2.14.1
