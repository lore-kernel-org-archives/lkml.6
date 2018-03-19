Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755148AbeCSDTq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 23:19:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:54688 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754651AbeCSDTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 23:19:44 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] irqchip: irq-gic-v4: return real error code
Date: Mon, 19 Mar 2018 19:38:14 +0800
Message-Id: <1521459494-35746-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-03-19 11:19:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-03-19 11:19:28,
        Serialize complete at 2018-03-19 11:19:28
X-MAIL: mse01.zte.com.cn w2J3JSnc043101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__irq_domain_alloc_irqs will return some different error code, so we
should return real error code in its_alloc_vcpu_irqs.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/irqchip/irq-gic-v4.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index dba9d67..ecd170d 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -99,7 +99,7 @@
 
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
-	int vpe_base_irq, i;
+	int vpe_base_irq, i, ret = -ENOMEM;
 
 	vm->fwnode = irq_domain_alloc_named_id_fwnode("GICv4-vpe",
 						      task_pid_nr(current));
@@ -120,8 +120,10 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	vpe_base_irq = __irq_domain_alloc_irqs(vm->domain, -1, vm->nr_vpes,
 					       NUMA_NO_NODE, vm,
 					       false, NULL);
-	if (vpe_base_irq <= 0)
+	if (vpe_base_irq <= 0) {
+		ret = vpe_base_irq;
 		goto err;
+	}
 
 	for (i = 0; i < vm->nr_vpes; i++)
 		vm->vpes[i]->irq = vpe_base_irq + i;
@@ -134,7 +136,7 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	if (vm->fwnode)
 		irq_domain_free_fwnode(vm->fwnode);
 
-	return -ENOMEM;
+	return ret;
 }
 
 void its_free_vcpu_irqs(struct its_vm *vm)
-- 
1.8.3.1
