Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeBWW30 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:29:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBWW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:17 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/10] iommu/amd: drop the lock while allocating new irq remap table
Date: Fri, 23 Feb 2018 23:27:34 +0100
Message-Id: <20180223222736.18542-9-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223222736.18542-1-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_remap_table is allocated while the iommu_table_lock is held with
interrupts disabled. While this works it makes RT scream very loudly.
>From looking at the call sites, all callers are in the early device
initialisation (apic_bsp_setup(), pci_enable_device(),
pci_enable_msi()) so make sense to drop the lock which also enables
interrupts and try to allocate that memory with GFP_KERNEL instead
GFP_ATOMIC.

Since during the allocation the iommu_table_lock is dropped, we need to
recheck if table exists after the lock has been reacquired. I *think*
that it is impossible that the "devid" entry appears in irq_lookup_table
while the lock is dropped since the same device can only be probed once.
It is more likely that another device added an `alias' entry. However I
check for both cases, just to be sure.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 65 +++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b763fcbd790d..de6cc41d6cd2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3588,6 +3588,30 @@ static void set_dte_irq_entry(u16 devid, struct irq_=
remap_table *table)
 	amd_iommu_dev_table[devid].data[2] =3D dte;
 }
=20
+static struct irq_remap_table *alloc_irq_table(void)
+{
+	struct irq_remap_table *table;
+
+	table =3D kzalloc(sizeof(*table), GFP_ATOMIC);
+	if (!table)
+		return NULL;
+
+	table->table =3D kmem_cache_alloc(amd_iommu_irq_cache, GFP_KERNEL);
+	if (!table->table) {
+		kfree(table);
+		return NULL;
+	}
+	spin_lock_init(&table->lock);
+
+	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		memset(table->table, 0,
+		       MAX_IRQS_PER_TABLE * sizeof(u32));
+	else
+		memset(table->table, 0,
+		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
+	return table;
+}
+
 static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 				  struct irq_remap_table *table)
 {
@@ -3599,6 +3623,7 @@ static void set_remap_table_entry(struct amd_iommu *i=
ommu, u16 devid,
 static struct irq_remap_table *get_irq_table(u16 devid)
 {
 	struct irq_remap_table *table =3D NULL;
+	struct irq_remap_table *new_table =3D NULL;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
@@ -3617,42 +3642,44 @@ static struct irq_remap_table *get_irq_table(u16 de=
vid)
 	table =3D irq_lookup_table[alias];
 	if (table) {
 		set_remap_table_entry(iommu, devid, table);
-		goto out;
+		goto out_wait;
 	}
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
=20
 	/* Nothing there yet, allocate new irq remapping table */
-	table =3D kzalloc(sizeof(*table), GFP_ATOMIC);
-	if (!table)
+	new_table =3D alloc_irq_table();
+	if (!new_table)
+		return NULL;
+
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
+
+	table =3D irq_lookup_table[devid];
+	if (table)
 		goto out_unlock;
=20
-	/* Initialize table spin-lock */
-	spin_lock_init(&table->lock);
-
-	table->table =3D kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
-	if (!table->table) {
-		kfree(table);
-		table =3D NULL;
-		goto out_unlock;
+	table =3D irq_lookup_table[alias];
+	if (table) {
+		set_remap_table_entry(iommu, devid, table);
+		goto out_wait;
 	}
=20
-	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-		memset(table->table, 0,
-		       MAX_IRQS_PER_TABLE * sizeof(u32));
-	else
-		memset(table->table, 0,
-		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
-
+	table =3D new_table;
+	new_table =3D NULL;
=20
 	set_remap_table_entry(iommu, devid, table);
 	if (devid !=3D alias)
 		set_remap_table_entry(iommu, alias, table);
=20
-out:
+out_wait:
 	iommu_completion_wait(iommu);
=20
 out_unlock:
 	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
=20
+	if (new_table) {
+		kmem_cache_free(amd_iommu_irq_cache, new_table->table);
+		kfree(new_table);
+	}
 	return table;
 }
=20
--=20
2.16.1
