Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeBZOlc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:41:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeBZOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:41:28 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: rui.zhang@intel.com, rjw@rjwysocki.net
Cc: groeck@chromium.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, snanda@chromium.org, lenb@kernel.org
Subject: [RESEND PATCH v3 1/2] acpi: thermal: initialize tz_enabled to 1
Date: Mon, 26 Feb 2018 15:41:17 +0100
Message-Id: <20180226144118.24693-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameer Nanda <snanda@chromium.org>

In the acpi_thermal_add path, acpi_thermal_get_info gets called before
acpi_thermal_register_thermal_zone.  Since tz_enabled was getting set to
1 only in acpi_thermal_register_thermal_zone, acpi_thermal_get_info
ended up disabling thermal polling.

Moved setting of tz_enabled to 1 into acpi_thermal_add itself.

Signed-off-by: Sameer Nanda <snanda@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
That's another attempt to land these to patches that were sent long time
ago but never got merged, although, apparently, there is no issue with
it. Latest discussion about these here:

 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1436081.html


Changes in v3:
- [1/2] Make sure tz->tz_enabled is set properly before registering the
  zone (Zhang Rui)

Changes in v2:
- [1/2] This patch is new from v1
  (https://patchwork.kernel.org/patch/9804229/)

 drivers/acpi/thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 551b71a24b85..1d8f185e96c6 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -930,8 +930,6 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->tz_enabled = 1;
-
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
 		 tz->thermal_zone->id);
 	return 0;
@@ -1088,6 +1086,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	tz->device = device;
+	tz->tz_enabled = 1;
 	strcpy(tz->name, device->pnp.bus_id);
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
-- 
2.16.1
