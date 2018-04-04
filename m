Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeDDK5b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:57:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDDK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:57:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Baoquan He <bhe@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: amd: hide unused iommu_table_lock
Date: Wed,  4 Apr 2018 12:56:59 +0200
Message-Id: <20180404105713.633983-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:9m3F+GVtT2RhfBdB82J7fDve0hFnZipG28ohUdk69s2bif2oGZq
 U2n0c//iRtvTKcTYhDvVUIIbAGwfl9EXW7fXEqffNkUczRDRjS+6phVNxI9g97KC/zd9L0Q
 AxKznUJoy3OIlLB+VJDm+Nk1mXntS6DJoPCXhk/zZSFPL9F+dLxthYhP4YFfVS7jl85puaL
 w4Q+NhpvmzamoZs/Ixebw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/KeVQVQycDY=:BHuvvx8E9+CoxvpU1PtCj2
 gF6XQ2wDIpfltcAbwgYxqw8UUO5NPOl0LcTig4R4z4gCD5Rcjmiq6iTs76LB34kLG4JJXKHMU
 4Qm2qrQJqJUWJ8I2RrxZsyJ59ykLcdY77LDxq/21VYQ5/OYcatxXRrPEi5WujuqEwzs1TIotV
 IGl4wvIqhepGuOLUxXyG6J/stIMF5IrD8M3qAukBRyHYv7OyQMET4BqPHZDCQVNIrA4dr5ees
 y8FLBKmiMeayhsh3GpxOMflDbndSuGxwgkprJM0Z9OKXlJ1ddE1jz9+vQ2nYRqIsEO0+8SfOm
 4Sj921t+oRSQswnWK0b/vm8SlIh0v972U6seOY9hgjY0S+PhDBx0Ch5KoPzKiMOCzEynHOUeA
 3hRodIImI9A8oW8i0qfEGCg8W5RH21bCnGdYxTVkzvYgFNai6GUJ8jlw8ZAX9HJRAtRu0cinL
 cA0HD4znJquCNsrQCb8vcaoDQr6WeZPelJ2V4AgfFuoQi1GMFl42xDalLt+agp4w9DvLKhJek
 kB3UVT3yAt1t0ogVWR5EvxYlZNTc4a0vcHS4A5DL1/qz5LOqLqUzBcS2lQvVoacwM+mm7Ymov
 gRiBPh/2u2/Lz8ImExdmQ0ZXAKqJAuBb+iezHG8RCJ+/WYCfrROLWH0r+6glCsMgnCXu70Hd+
 53LhMfCOq+8oytoD0R8SCBXtP4VvlfqipdmfgwLRQdMpo7RDHI4QHMRunUQk6AaAa2EjyzEIh
 vfL9eRzb3Lty/OilpHaq2YaBhHwlwiAWqIelnw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced lock is only used when CONFIG_IRQ_REMAP is enabled:

drivers/iommu/amd_iommu.c:86:24: error: 'iommu_table_lock' defined but not used [-Werror=unused-variable]
 static DEFINE_SPINLOCK(iommu_table_lock);

This moves the definition next to the user, within the #ifdef protected
section of the file.

Fixes: ea6166f4b83e ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2a99f0f14795..8fb8c737fffe 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -83,7 +83,6 @@
 
 static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
-static DEFINE_SPINLOCK(iommu_table_lock);
 
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -3562,6 +3561,7 @@ EXPORT_SYMBOL(amd_iommu_device_info);
  *****************************************************************************/
 
 static struct irq_chip amd_ir_chip;
+static DEFINE_SPINLOCK(iommu_table_lock);
 
 static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 {
-- 
2.9.0
