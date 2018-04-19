Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDSQ7C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:59:02 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44894 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeDSQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:59:00 -0400
X-Google-Smtp-Source: AIpwx4/XtnxX7xD4K5qB0eIQ6YbriMCmrytXi1s8S7czD4v0iOKKI8/IzoQJ7sRK+ObBfqnnOJNzjQ==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, bill.fletcher@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] ACPI / bus: ignore rather than fail bus driver registrations on non-ACPI boot
Date: Thu, 19 Apr 2018 18:58:25 +0200
Message-Id: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ACPI bus drivers such as button.ko into the core kernel,
other drivers that depend on its symbols are loadable even when booting
with ACPI disabled. For instance, nouveau.ko has a link time dependency
on acpi_lid_open() on ACPI capable kernels, and calls it regardless of
whether the system booted via ACPI.

However, when building button.ko as a module, it will refuse to load if
the system did not boot in ACPI mode, which subsequently prevents the
nouveau driver from loading as well, resulting in broken graphics.

Given that returning an error from an initcall() is ignored for drivers
that are built into the kernel, let's align the module case with this,
and not return an error when registering an ACPI bus driver on a system
that did not boot via ACPI.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..529d3d496fab 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -880,7 +880,7 @@ int acpi_bus_register_driver(struct acpi_driver *driver)
 	int ret;
 
 	if (acpi_disabled)
-		return -ENODEV;
+		return 0;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
 	driver->drv.owner = driver->owner;
-- 
2.17.0
