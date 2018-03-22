Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeCVPZN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:25:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39538 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754608AbeCVPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:53 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/10] iommu/amd: remove the special case from alloc_irq_table()
Date: Thu, 22 Mar 2018 16:22:37 +0100
Message-Id: <20180322152242.12705-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_irq_table() has a special ioapic argument. If set then it will
pre-allocate / reserve the first 32 indexes. The argument is only once
true and it would make alloc_irq_table() a little simpler if we would
extract the special bits to the caller.
The caller of irq_remapping_alloc() is holding irq_domain_mutex so the
initialization of iommu->irte_ops->set_allocated() should not race
against other user.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a87d2fee68db..a5982a61f181 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3617,7 +3617,7 @@ static struct irq_remap_table *get_irq_table(u16 devi=
d)
 	return table;
 }
=20
-static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *alloc_irq_table(u16 devid)
 {
 	struct irq_remap_table *table =3D NULL;
 	struct amd_iommu *iommu;
@@ -3651,10 +3651,6 @@ static struct irq_remap_table *alloc_irq_table(u16 d=
evid, bool ioapic)
 	/* Initialize table spin-lock */
 	raw_spin_lock_init(&table->lock);
=20
-	if (ioapic)
-		/* Keep the first 32 indexes free for IOAPIC interrupts */
-		table->min_index =3D 32;
-
 	table->table =3D kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
 	if (!table->table) {
 		kfree(table);
@@ -3669,12 +3665,6 @@ static struct irq_remap_table *alloc_irq_table(u16 d=
evid, bool ioapic)
 		memset(table->table, 0,
 		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
=20
-	if (ioapic) {
-		int i;
-
-		for (i =3D 0; i < 32; ++i)
-			iommu->irte_ops->set_allocated(table, i);
-	}
=20
 	irq_lookup_table[devid] =3D table;
 	set_dte_irq_entry(devid, table);
@@ -3704,7 +3694,7 @@ static int alloc_irq_index(u16 devid, int count, bool=
 align)
 	if (!iommu)
 		return -ENODEV;
=20
-	table =3D alloc_irq_table(devid, false);
+	table =3D alloc_irq_table(devid);
 	if (!table)
 		return -ENODEV;
=20
@@ -4130,10 +4120,26 @@ static int irq_remapping_alloc(struct irq_domain *d=
omain, unsigned int virq,
 		return ret;
=20
 	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (alloc_irq_table(devid, true))
+		struct irq_remap_table *table;
+		struct amd_iommu *iommu;
+
+		table =3D alloc_irq_table(devid);
+		if (table) {
+			if (!table->min_index) {
+				/*
+				 * Keep the first 32 indexes free for IOAPIC
+				 * interrupts.
+				 */
+				table->min_index =3D 32;
+				iommu =3D amd_iommu_rlookup_table[devid];
+				for (i =3D 0; i < 32; ++i)
+					iommu->irte_ops->set_allocated(table, i);
+			}
+			WARN_ON(table->min_index !=3D 32);
 			index =3D info->ioapic_pin;
-		else
+		} else {
 			ret =3D -ENOMEM;
+		}
 	} else {
 		bool align =3D (info->type =3D=3D X86_IRQ_ALLOC_TYPE_MSI);
=20
--=20
2.16.2
