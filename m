Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeBWW2X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:28:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbeBWW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:19 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/10] iommu/amd: declare irq_remap_table's and amd_iommu's lock as a raw_spin_lock
Date: Fri, 23 Feb 2018 23:27:35 +0100
Message-Id: <20180223222736.18542-10-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223222736.18542-1-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq affinity setting is called while desc->lock is held. The
desc->lock is a raw_spin_lock called with interrupts disabled. The
call chain involves modify_irte_ga() which needs to take the
irq_remap_table->lock in order to update the entry and later iommu->lock
in order to update and flush the iommu.
The latter is also required during table allocation.

I currently don't see a feasible way of getting this done without
turning both locks raw so here it is.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c       | 30 +++++++++++++++---------------
 drivers/iommu/amd_iommu_init.c  |  2 +-
 drivers/iommu/amd_iommu_types.h |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index de6cc41d6cd2..04b7d263523f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1052,9 +1052,9 @@ static int iommu_queue_command_sync(struct amd_iommu =
*iommu,
 	unsigned long flags;
 	int ret;
=20
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret =3D __iommu_queue_command_sync(iommu, cmd, sync);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
=20
 	return ret;
 }
@@ -1080,7 +1080,7 @@ static int iommu_completion_wait(struct amd_iommu *io=
mmu)
=20
 	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
=20
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
=20
 	iommu->cmd_sem =3D 0;
=20
@@ -1091,7 +1091,7 @@ static int iommu_completion_wait(struct amd_iommu *io=
mmu)
 	ret =3D wait_on_sem(&iommu->cmd_sem);
=20
 out_unlock:
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
=20
 	return ret;
 }
@@ -3601,7 +3601,7 @@ static struct irq_remap_table *alloc_irq_table(void)
 		kfree(table);
 		return NULL;
 	}
-	spin_lock_init(&table->lock);
+	raw_spin_lock_init(&table->lock);
=20
 	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
 		memset(table->table, 0,
@@ -3700,7 +3700,7 @@ static int alloc_irq_index(u16 devid, int count, bool=
 align)
 	if (align)
 		alignment =3D roundup_pow_of_two(count);
=20
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
=20
 	/* Scan table for free entries */
 	for (index =3D ALIGN(table->min_index, alignment), c =3D 0;
@@ -3727,7 +3727,7 @@ static int alloc_irq_index(u16 devid, int count, bool=
 align)
 	index =3D -ENOSPC;
=20
 out:
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	return index;
 }
@@ -3748,7 +3748,7 @@ static int modify_irte_ga(u16 devid, int index, struc=
t irte_ga *irte,
 	if (!table)
 		return -ENOMEM;
=20
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
=20
 	entry =3D (struct irte_ga *)table->table;
 	entry =3D &entry[index];
@@ -3759,7 +3759,7 @@ static int modify_irte_ga(u16 devid, int index, struc=
t irte_ga *irte,
 	if (data)
 		data->ref =3D entry;
=20
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3781,9 +3781,9 @@ static int modify_irte(u16 devid, int index, union ir=
te *irte)
 	if (!table)
 		return -ENOMEM;
=20
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	table->table[index] =3D irte->val;
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3805,9 +3805,9 @@ static void free_irte(u16 devid, int index)
 	if (!table)
 		return;
=20
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	iommu->irte_ops->clear_allocated(table, index);
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -4424,7 +4424,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 	if (!table)
 		return -ENODEV;
=20
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
=20
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >=3D 0)
@@ -4433,7 +4433,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 		barrier();
 	}
=20
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4e4a615bf13f..904c575d1677 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1474,7 +1474,7 @@ static int __init init_iommu_one(struct amd_iommu *io=
mmu, struct ivhd_header *h)
 {
 	int ret;
=20
-	spin_lock_init(&iommu->lock);
+	raw_spin_lock_init(&iommu->lock);
=20
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index 62d6f42b57c9..1c9b080276c9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -408,7 +408,7 @@ extern bool amd_iommu_iotlb_sup;
 #define IRQ_TABLE_ALIGNMENT	128
=20
 struct irq_remap_table {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned min_index;
 	u32 *table;
 };
@@ -490,7 +490,7 @@ struct amd_iommu {
 	int index;
=20
 	/* locks the accesses to the hardware */
-	spinlock_t lock;
+	raw_spinlock_t lock;
=20
 	/* Pointer to PCI device of this IOMMU */
 	struct pci_dev *dev;
--=20
2.16.1
