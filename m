Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754275AbeCFWkI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:40:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbeCFWkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:40:07 -0500
From: Jagannathan Raman <jag.raman@oracle.com>
To: joro@8bytes.org, tglx@linutronix.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: fix usage of force parameter in intel_ir_reconfigure_irte()
Date: Tue,  6 Mar 2018 17:39:41 -0500
Message-Id: <1520375981-4958-1-git-send-email-jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060243
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was noticed that the IRTE configured for guest OS kernel
was over-written while the guest was running. As a result,
vt-d Posted Interrupts configured for the guest are not being
delivered directly, and instead bounces off the host. Every
interrupt delivery takes a VM Exit.

It was noticed that the following stack is doing the over-write:
[  147.463177]  modify_irte+0x171/0x1f0
[  147.463405]  intel_ir_set_affinity+0x5c/0x80
[  147.463641]  msi_domain_set_affinity+0x32/0x90
[  147.463881]  irq_do_set_affinity+0x37/0xd0
[  147.464125]  irq_set_affinity_locked+0x9d/0xb0
[  147.464374]  __irq_set_affinity+0x42/0x70
[  147.464627]  write_irq_affinity.isra.5+0xe1/0x110
[  147.464895]  proc_reg_write+0x38/0x70
[  147.465150]  __vfs_write+0x36/0x180
[  147.465408]  ? handle_mm_fault+0xdf/0x200
[  147.465671]  ? _cond_resched+0x15/0x30
[  147.465936]  vfs_write+0xad/0x1a0
[  147.466204]  SyS_write+0x52/0xc0
[  147.466472]  do_syscall_64+0x74/0x1a0
[  147.466744]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

reversing the sense of force check in intel_ir_reconfigure_irte()
restores proper posted interrupt functionality

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Hi Thomas,

 I noticed that you added intel_ir_reconfigure_irte() with the
 following commit:
 d491bdff888e ("iommu/vt-d: Reevaluate vector configuration on
 activate()")

 Could you please confirm the usage of "force" parameter in
 intel_ir_reconfigure_irte()?

 drivers/iommu/intel_irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 66f69af..3062a15 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1136,7 +1136,7 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
 	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (!force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
 		modify_irte(&ir_data->irq_2_iommu, irte);
 }
 
-- 
1.8.3.1
