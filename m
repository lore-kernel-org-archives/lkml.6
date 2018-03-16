Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeCPUSy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:18:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57132 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeCPUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:18:49 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/10] iommu/amd: remove the special case from get_irq_table()
Date: Fri, 16 Mar 2018 21:18:32 +0100
Message-Id: <20180316201836.7864-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316201836.7864-1-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_irq_table() has a special ioapic argument. If set then it will
pre-allocate / reserve the first 32 indexes. The argument is only once
true and it would make get_irq_table() a little simpler if we would
extract the special bits to the caller.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 30ad2a3fbe15..e1628ff5f6bd 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3602,7 +3602,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_r=
emap_table *table)
 	amd_iommu_dev_table[devid].data[2] =3D dte;
 }
=20
-static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *get_irq_table(u16 devid)
 {
 	struct irq_remap_table *table =3D NULL;
 	struct amd_iommu *iommu;
@@ -3636,10 +3636,6 @@ static struct irq_remap_table *get_irq_table(u16 dev=
id, bool ioapic)
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
@@ -3654,12 +3650,6 @@ static struct irq_remap_table *get_irq_table(u16 dev=
id, bool ioapic)
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
@@ -3689,7 +3679,7 @@ static int alloc_irq_index(u16 devid, int count, bool=
 align)
 	if (!iommu)
 		return -ENODEV;
=20
-	table =3D get_irq_table(devid, false);
+	table =3D get_irq_table(devid);
 	if (!table)
 		return -ENODEV;
=20
@@ -3740,7 +3730,7 @@ static int modify_irte_ga(u16 devid, int index, struc=
t irte_ga *irte,
 	if (iommu =3D=3D NULL)
 		return -EINVAL;
=20
-	table =3D get_irq_table(devid, false);
+	table =3D get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
=20
@@ -3773,7 +3763,7 @@ static int modify_irte(u16 devid, int index, union ir=
te *irte)
 	if (iommu =3D=3D NULL)
 		return -EINVAL;
=20
-	table =3D get_irq_table(devid, false);
+	table =3D get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
=20
@@ -3797,7 +3787,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu =3D=3D NULL)
 		return;
=20
-	table =3D get_irq_table(devid, false);
+	table =3D get_irq_table(devid);
 	if (!table)
 		return;
=20
@@ -4115,10 +4105,26 @@ static int irq_remapping_alloc(struct irq_domain *d=
omain, unsigned int virq,
 		return ret;
=20
 	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (get_irq_table(devid, true))
+		struct irq_remap_table *table;
+		struct amd_iommu *iommu;
+
+		table =3D get_irq_table(devid);
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
 			index =3D info->ioapic_pin;
-		else
+			WARN_ON(table->min_index !=3D 32);
+		} else {
 			ret =3D -ENOMEM;
+		}
 	} else {
 		bool align =3D (info->type =3D=3D X86_IRQ_ALLOC_TYPE_MSI);
=20
@@ -4398,7 +4404,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 	if (!iommu)
 		return -ENODEV;
=20
-	irt =3D get_irq_table(devid, false);
+	irt =3D get_irq_table(devid);
 	if (!irt)
 		return -ENODEV;
=20
--=20
2.16.2
