Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDJJGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:06:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34857 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeDJJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:06:48 -0400
X-Google-Smtp-Source: AIpwx4+NmjaJeKPIjjJ6Qgv1GlyLS8I4HgQuWTa2zAwfdmzVfne/ElIFYrZSQRjE4KedkGffSn+lbQ==
Date: Tue, 10 Apr 2018 11:06:43 +0200
From: Ognjen Galic <smclt30p@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] battery: Add the ThinkPad battery status quirk
Message-ID: <20180410090643.GA26554@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC/ACPI firmware on Lenovo ThinkPads used to report a status
of "Unknown" when the battery is between the charge start and charge
stop thresholds. On Windows, it reports "Not Charging" so the quirk
has been added to fix the "Unknown" state.

The chosen new state when the battery is not charging is "Fully Charged"
because a status of "Not Charging" breaks almost all applications in
userspace that depend on upower, because upower in itself can't handle
a state of "Not Charging", defaulting to "Unknown".

When we report "Fully Charged" instead of "Unknown", the userspace handles
everything just fine, displaying for example: "Fully Charged, 59%" in Xfce.

This is a re-write of: https://patchwork.kernel.org/patch/10205359/

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---
 drivers/acpi/battery.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bdb24d63..cb4457a7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
 static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
+static int battery_quirk_thinkpad_full;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -233,7 +234,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (acpi_battery_is_charged(battery))
+		else if (acpi_battery_is_charged(battery) ||
+				battery_quirk_thinkpad_full)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
@@ -1332,6 +1334,13 @@ battery_notification_delay_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init
+battery_thinkpad_full_charged_quirk(const struct dmi_system_id *d)
+{
+	battery_quirk_thinkpad_full = 1;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1349,6 +1358,14 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
 		},
 	},
+	{
+		.callback = battery_thinkpad_full_charged_quirk,
+		.ident = "Lenovo ThinkPad",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
+		},
+	},
 	{},
 };
 
-- 
2.15.1
