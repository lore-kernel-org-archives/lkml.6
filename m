Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeDTDaI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:30:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754077AbeDTDaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:30:07 -0400
From: Mark Salter <msalter@redhat.com>
To: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
        <frederic.danis.oss@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / scan: Fix regression related to X-Gene UARTs
Date: Thu, 19 Apr 2018 23:29:47 -0400
Message-Id: <20180420032947.23023-1-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e361d1f85855 ("ACPI / scan: Fix enumeration for special UART
devices") caused a regression with some X-Gene based platforms (Mustang
and M400) with invalid DSDT. The DSDT makes it appear that the UART
device is also a slave device attached to itself. With the above commit
the UART won't be enumerated by ACPI scan (slave serial devices shouldn't
be). So check for X-Gene UART device and skip slace device check on it.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/acpi/scan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index cc234e6a6297..1dcdd0122862 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1551,6 +1551,14 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
+	/*
+	 * Firmware on some arm64 X-Gene platforms will make the UART
+	 * device appear as both a UART and a slave of that UART. Just
+	 * bail out here for X-Gene UARTs.
+	 */
+	if (!strcmp(acpi_device_hid(device), "APMC0D08"))
+		return false;
+
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list,
 			       acpi_check_serial_bus_slave,
-- 
2.14.3
