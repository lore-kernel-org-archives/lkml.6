Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEMOFf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:05:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeEMOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:05:34 -0400
Date: Sun, 13 May 2018 07:05:23 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-8a22a3e1e768c309b718f99bd86f9f25a453e0dc@git.kernel.org>
Cc: jason@lakedaemon.net, mingo@kernel.org, hpa@zytor.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        srinivas.kandagatla@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com
Reply-To: tglx@linutronix.de, srinivas.kandagatla@linaro.org, robh@kernel.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com, hpa@zytor.com,
        jason@lakedaemon.net, mingo@kernel.org, ard.biesheuvel@linaro.org
In-Reply-To: <20180508121438.11301-5-marc.zyngier@arm.com>
References: <20180508121438.11301-5-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
Git-Commit-ID: 8a22a3e1e768c309b718f99bd86f9f25a453e0dc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8a22a3e1e768c309b718f99bd86f9f25a453e0dc
Gitweb:     https://git.kernel.org/tip/8a22a3e1e768c309b718f99bd86f9f25a453e0dc
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:33 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:59:00 +0200

dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-5-marc.zyngier@arm.com

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
