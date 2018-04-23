Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeDWKfm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:35:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38718 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754781AbeDWKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:35:22 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
Date: Mon, 23 Apr 2018 11:34:37 +0100
Message-Id: <20180423103440.26592-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180423103440.26592-1-marc.zyngier@arm.com>
References: <20180423103440.26592-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inclusion of include/dma-iommu.h when CONFIG_IOMMU_DMA is not selected
results in the following splat:

In file included from drivers/irqchip/irq-gic-v3-mbi.c:20:0:
./include/linux/dma-iommu.h:95:69: error: unknown type name ‘dma_addr_t’
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
                                                                     ^~~~~~~~~~
./include/linux/dma-iommu.h:108:74: warning: ‘struct list_head’ declared inside parameter list will not be visible outside of this definition or declaration
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
                                                                          ^~~~~~~~~
scripts/Makefile.build:312: recipe for target 'drivers/irqchip/irq-gic-v3-mbi.o' failed

Fix it by including linux/types.h.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/dma-iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 92f20832fd28..e8ca5e654277 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -17,6 +17,7 @@
 #define __DMA_IOMMU_H
 
 #ifdef __KERNEL__
+#include <linux/types.h>
 #include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
-- 
2.14.2
