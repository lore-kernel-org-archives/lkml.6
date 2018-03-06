Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeCFOab (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:30:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37861 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeCFOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:30:29 -0500
X-Google-Smtp-Source: AG47ELuHyI209CfblnW4T7Ssq5VtmPU6rlxEw8uUNDeDX8ddXqE+VguXnsIM5pLIuZ0bHFE4kQGSqg==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] irqchip: gic-v3-its: fail IRQ allocation if nr_ites is exceeded
Date: Tue,  6 Mar 2018 14:30:15 +0000
Message-Id: <20180306143015.27316-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, ITS device IDs are not shared between different PCIe
devices, and ITS MSIs are allocated from the range that was
reserved when the device's struct its_device was created.

When a duplicate device ID is seen by its_msi_prepare(), it skips
the call to its_create_device(), since it assumes it is dealing
with an alias of what is essentially the same device.

In exceptional cases, such as on the Socionext SynQuacer SoC that
maps all PCIe RIDs to ITS device ID #0, we may end up in the
situation where its_alloc_device_irq() calls succeed erroneously,
due to the fact that the first its_create_device() call allocated
a LPI map of sufficient size to cover the newly allocated MSI,
while the size of the ITT mapping (which is based on nr_ites) has
already been programmed to a value that does not cover this MSI.

The result is that the additional devices that share device ID #0
get MSIs assigned to them, but asserting them doesn't actually
work, and the device doesn't function.

Instead, let's fail the its_alloc_device_irq() in this case, and
allow the device to fall back to legacy INTx interrupts instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f53747..b5a1e4f83297 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2186,7 +2186,7 @@ static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
 
 	idx = find_first_zero_bit(dev->event_map.lpi_map,
 				  dev->event_map.nr_lpis);
-	if (idx == dev->event_map.nr_lpis)
+	if (idx == dev->event_map.nr_lpis || idx == dev->nr_ites)
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
-- 
2.11.0
