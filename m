Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeFDQ1s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:27:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeFDQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:42 -0400
Message-Id: <20180604162224.555716895@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:56 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: [patch 4/8] irq_remapping: Use apic_ack_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=irq_remapping--Use-apic_ack_irq().patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of the special ir_ack_apic_edge() implementation which is
merily a wrapper around ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/iommu/amd_iommu.c           |    2 +-
 drivers/iommu/intel_irq_remapping.c |    2 +-
 drivers/iommu/irq_remapping.c       |    5 -----
 drivers/iommu/irq_remapping.h       |    2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4379,7 +4379,7 @@ static void ir_compose_msi_msg(struct ir
 
 static struct irq_chip amd_ir_chip = {
 	.name			= "AMD-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= amd_ir_set_affinity,
 	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1223,7 +1223,7 @@ static int intel_ir_set_vcpu_affinity(st
 
 static struct irq_chip intel_ir_chip = {
 	.name			= "INTEL-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -156,11 +156,6 @@ void panic_if_irq_remap(const char *msg)
 		panic(msg);
 }
 
-void ir_ack_apic_edge(struct irq_data *data)
-{
-	ack_APIC_irq();
-}
-
 /**
  * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
  *				     device serving request @info
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -65,8 +65,6 @@ struct irq_remap_ops {
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
 
-extern void ir_ack_apic_edge(struct irq_data *data);
-
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0
