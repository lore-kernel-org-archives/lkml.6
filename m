Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeCFPvl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:51:41 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56249 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:51:40 -0500
X-Google-Smtp-Source: AG47ELvciE+oPPnYV03tr0msEVRqABr0aiW4ODEwJdkEJMHCRCOVi3rlq2CuJ8HKIV9OeZu0W45uew==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] irqchip: gic-v3-its: ensure nr_ites >= nr_lpis
Date: Tue,  6 Mar 2018 15:51:32 +0000
Message-Id: <20180306155132.8757-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When struct its_device instances are created, the nr_ites member
will be set to a power of 2 that equals or exceeds the requested
number of MSIs passed to the msi_prepare() callback. At the same
time, the LPI map is allocated to be some multiple of 32 in size,
where the allocated size may be less than the requested size
depending on whether a contiguous range of sufficient size is
available in the global LPI bitmap.

This may result in the situation where the nr_ites < nr_lpis, and
since nr_ites is what we program into the hardware when we map the
device, the additional LPIs will be non-functional.

For bog standard hardware, this does not really matter. However,
in cases where ITS device IDs are shared between different PCIe
devices, we may end up allocating these additional LPIs without
taking into account that they don't actually work.

So let's make nr_ites at least 32. This ensures that all allocated
LPIs are 'live', and that its_alloc_device_irq() will fail when
attempts are made to allocate MSIs beyond what was allocated in
the first place.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f53747..ee488c468400 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1412,7 +1412,7 @@ static struct irq_chip its_irq_chip = {
  * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
  */
 #define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 #define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static unsigned long *lpi_bitmap;
@@ -2123,7 +2123,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 * of two entries. No, the architecture doesn't let you
 	 * express an ITT with a single entry.
 	 */
-	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
+	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
-- 
2.11.0
