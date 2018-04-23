Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754510AbeDWJRL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:17:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40146 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbeDWJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:17:04 -0400
X-Google-Smtp-Source: AIpwx4+dcCmTPYdzA36FzqiT1o3iPLK22W3iZCjnE+6LyMEnfvbpZk8+3igS1uZnEPYxqimZ2Hht6Q==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, bill.fletcher@linaro.org,
        linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] ACPI / button: make module loadable when booted in non-ACPI mode
Date: Mon, 23 Apr 2018 11:16:56 +0200
Message-Id: <20180423091656.26257-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modules such as nouveau.ko and i915.ko have a link time dependency on
acpi_lid_open(), and due to its use of acpi_bus_register_driver(),
the button.ko module that provides it is only loadable when booted in
ACPI mode. However, the ACPI button driver can be built into the core
kernel as well, in which case the dependency can always be satisfied,
and the dependent modules can be loaded regardless of whether the
system was booted in ACPI mode or not.

So let's fix this asymmetry by making the ACPI button driver loadable
as a module even if not booted in ACPI mode, so it can provide the
acpi_lid_open() symbol in the same way as when built into the kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: invert acpi_disabled logic and move comment into __acpi_bus_register_driver

Could we perhaps get this into -stable as well? It is not a classic
regression, but it completely breaks, e.g., Fedora when booting in
DT mode on an ARM system.

 drivers/acpi/button.c | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e1eee7a60fad..f33242e4fe6c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -635,4 +635,26 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-module_acpi_driver(acpi_button_driver);
+static int __acpi_bus_register_driver(struct acpi_driver *driver)
+{
+	/*
+	 * Modules such as nouveau.ko and i915.ko have a link time dependency
+	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
+	 * capable kernels booted in non-ACPI mode if we use the ordinary
+	 * acpi_bus_[un]register_driver routines here (which only work when
+	 * booted in ACPI mode) and build this driver as a module. So provide
+	 * our own versions instead.
+	 */
+	if (acpi_disabled)
+		return 0;
+	return acpi_bus_register_driver(driver);
+}
+
+static void __acpi_bus_unregister_driver(struct acpi_driver *driver)
+{
+	if (!acpi_disabled)
+		acpi_bus_unregister_driver(driver);
+}
+
+module_driver(acpi_button_driver, __acpi_bus_register_driver,
+	      __acpi_bus_unregister_driver);
-- 
2.17.0
