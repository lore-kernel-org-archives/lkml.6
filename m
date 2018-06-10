Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9Do1Dnu3HFswQAAAmS7hNA
	; Sun, 10 Jun 2018 05:30:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2870A60795; Sun, 10 Jun 2018 05:30:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89613602FC;
	Sun, 10 Jun 2018 05:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89613602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeFJFab (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:30:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeFJFaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:30:30 -0400
Received: from [217.76.163.81] (helo=nanos.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fRsvs-0007Ix-Ph; Sun, 10 Jun 2018 07:30:29 +0200
Date: Sun, 10 Jun 2018 07:30:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.18
Message-ID: <alpine.DEB.2.21.1806100720100.1606@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

Two small fixlets:

 - Add the missing iomu mapping call in the Fleescale/NXP/Qualcomm/whoever
   owns it now/ SCFG MSI irqchip driver. Otherwise IRQs wont work at all.

 - Fix a SMP=n build warning in the STM32 irq chip driver

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      irqchip/stm32: Fix non-SMP build warning

Laurentiu Tudor (1):
      irqchip/ls-scfg-msi: Map MSIs in the iommu


 drivers/irqchip/irq-ls-scfg-msi.c | 3 +++
 drivers/irqchip/irq-stm32-exti.c  | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 57e3d900f19e..1ec3bfe56693 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -21,6 +21,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/dma-iommu.h>
 
 #define MSI_IRQS_PER_MSIR	32
 #define MSI_MSIR_OFFSET		4
@@ -94,6 +95,8 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 
 	if (msi_affinity_flag)
 		msg->data |= cpumask_first(data->common->affinity);
+
+	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 5089c1e2838d..3a7e8905a97e 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -552,9 +552,7 @@ static struct irq_chip stm32_exti_h_chip = {
 	.irq_set_type		= stm32_exti_h_set_type,
 	.irq_set_wake		= stm32_exti_h_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-#ifdef CONFIG_SMP
-	.irq_set_affinity	= stm32_exti_h_set_affinity,
-#endif
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
 };
 
 static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
