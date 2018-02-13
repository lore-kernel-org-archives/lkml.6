Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbeBMOLi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:11:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40049 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964935AbeBMOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:11:37 -0500
X-Google-Smtp-Source: AH8x227cIs7NCBNAcn10gHStuwRqpD1mtLiYLe6PNsG+mX9dygo2cxb6NqXdaXF9izKlOGOL8XLO3A==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com
Cc: graeme.gregory@linaro.org, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [RFC PATCH] irqchip/gic-v3-its: apply ACPI device based quirks
Date: Tue, 13 Feb 2018 14:11:18 +0000
Message-Id: <20180213141118.3092-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reapply the SynQuacer quirk for ITS frames that are matched by 'SCX0005'
based ACPI devices, replacing the dummy fwnode with the one populated by
the ACPI device core.

This allows the SynQuacer ACPI tables to publish a device node such
as

    Device (ITS0) {
      Name (_HID, "SCX0005")
      Name (_ADR, 0x30020000)
      Name (_DSD, Package ()  // _DSD: Device-Specific Data
      {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
          Package (2) {
            "socionext,synquacer-pre-its",
            Package () { 0x58000000, 0x200000 }
          },
        }
      })
    }

which will trigger the existing quirk that replaces the doorbell
address with the appropriate address in the pre-ITS frame.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Marc, Lorenzo,

I am aware that this patch may be seen as controversial, but I would like to
propose it nonetheless. The reason is that this is the only thing standing in
the way of full ACPI support in Socionext SynQuacer based platforms.

The pre-ITS is a monstrosity, but as it turns out, Socionext had help from
ARM designing it, and the reason we need DT/ACPI based quirks in the first
place is that the IIDR of this GICv3 implementation is simply the ARM Ltd.
one (as they designed the IP)

Please take this into consideration when reviewing this patch,

Thanks,
Ard.

 drivers/irqchip/irq-gic-v3-its.c | 39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025fd5726..a63973baf08a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3517,3 +3517,42 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 
 	return 0;
 }
+
+#if defined(CONFIG_SOCIONEXT_SYNQUACER_PREITS) && defined(CONFIG_ACPI)
+static acpi_status __init acpi_its_device_probe (acpi_handle handle,
+						 u32 depth, void *context,
+						 void **ret)
+{
+	struct acpi_device *adev;
+	unsigned long long phys_base;
+	struct its_node *its;
+	acpi_status status;
+	int err;
+
+	err = acpi_bus_get_device(handle, &adev);
+	if (err)
+		return AE_CTRL_TERMINATE;
+
+	status = acpi_evaluate_integer(handle, "_ADR", NULL, &phys_base);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	list_for_each_entry(its, &its_nodes, entry)
+		if (its->phys_base == phys_base) {
+			irq_domain_free_fwnode(its->fwnode_handle);
+			its->fwnode_handle = &adev->fwnode;
+			its_enable_quirk_socionext_synquacer(its);
+			break;
+		}
+
+	return AE_CTRL_TERMINATE;
+}
+
+static int __init acpi_its_device_probe_init(void)
+{
+	if (!acpi_disabled)
+		acpi_get_devices("SCX0005", acpi_its_device_probe, NULL, NULL);
+	return 0;
+}
+subsys_initcall_sync(acpi_its_device_probe_init);
+#endif
-- 
2.11.0
