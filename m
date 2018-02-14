Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163105AbeBNTmn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:42:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38123 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162994AbeBNTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:42:15 -0500
X-Google-Smtp-Source: AH8x2267J1Fqj9U9kHS9BfpA4oQnUaEopdOKSqVjlE+1NRjAmChGcFyuiO4EFgHJdVQ4cY2YZOplRA==
From: Carlo Caione <carlo@caione.org>
To: linux@endlessm.com, hdegoede@redhat.com, rjw@rjwysocki.net,
        lenb@kernel.org, sre@kernel.org, wens@csie.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 2/2] power: supply: ACPI/AXP288: Add quirks for ECS EF20EA
Date: Wed, 14 Feb 2018 19:42:01 +0000
Message-Id: <20180214194201.24385-3-carlo@caione.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180214194201.24385-1-carlo@caione.org>
References: <20180214194201.24385-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

On the ECS EF20EA laptop we need to move away from the AXP288 FG driver
and enable again the ACPI AC/battery drivers. Add the required quirks to
do that. We rely only on the product name because all the other DMI
entries are dummy or not filled in on this platform.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/acpi/ac.c                        | 7 +++++++
 drivers/acpi/battery.c                   | 7 +++++++
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index b9a4ca720309..39f778f954f5 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -332,6 +332,13 @@ static const struct dmi_system_id ac_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "32597CG"),
 		},
 	},
+	{
+	.callback = ac_not_use_pmic_quirk,
+	.ident = "ECS EF20EA",
+	.matches = {
+		DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{},
 };
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 258d2e66f230..fe024f1a8ad5 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1233,6 +1233,13 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "UX410UAK"),
 		},
 	},
+	{
+		.callback = battery_not_use_pmic_quirk,
+		.ident = "ECS EF20EA",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{},
 };
 
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 4cc6e038dfdd..903891a9bcf0 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -708,6 +708,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
+	{
+		/* ECS EF20EA */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{}
 };
 
-- 
2.14.1
