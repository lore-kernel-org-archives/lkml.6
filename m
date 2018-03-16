Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeCPUS4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:18:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeCPUSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:18:48 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH 05/10] Revert "iommu/amd: Avoid locking get_irq_table() from atomic context"
Date: Fri, 16 Mar 2018 21:18:31 +0100
Message-Id: <20180316201836.7864-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316201836.7864-1-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit df42a04b15f1 ("iommu/amd: Avoid locking
get_irq_table() from atomic context").
Its goal is to avoid a warning/bug on RT. While I generally support that
goal this change is colliding with larger rework which accomplishes the
same goal but different.

Cc: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5191319d9f0a..30ad2a3fbe15 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3602,22 +3602,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_=
remap_table *table)
 	amd_iommu_dev_table[devid].data[2] =3D dte;
 }
=20
-static struct irq_remap_table *get_irq_table(u16 devid)
-{
-	struct irq_remap_table *table;
-
-	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
-		      "%s: no iommu for devid %x\n", __func__, devid))
-		return NULL;
-
-	table =3D irq_lookup_table[devid];
-	if (WARN_ONCE(!table, "%s: no table for devid %x\n", __func__, devid))
-		return NULL;
-
-	return table;
-}
-
-static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 {
 	struct irq_remap_table *table =3D NULL;
 	struct amd_iommu *iommu;
@@ -3704,7 +3689,7 @@ static int alloc_irq_index(u16 devid, int count, bool=
 align)
 	if (!iommu)
 		return -ENODEV;
=20
-	table =3D alloc_irq_table(devid, false);
+	table =3D get_irq_table(devid, false);
 	if (!table)
 		return -ENODEV;
=20
@@ -3755,7 +3740,7 @@ static int modify_irte_ga(u16 devid, int index, struc=
t irte_ga *irte,
 	if (iommu =3D=3D NULL)
 		return -EINVAL;
=20
-	table =3D get_irq_table(devid);
+	table =3D get_irq_table(devid, false);
 	if (!table)
 		return -ENOMEM;
=20
@@ -3788,7 +3773,7 @@ static int modify_irte(u16 devid, int index, union ir=
te *irte)
 	if (iommu =3D=3D NULL)
 		return -EINVAL;
=20
-	table =3D get_irq_table(devid);
+	table =3D get_irq_table(devid, false);
 	if (!table)
 		return -ENOMEM;
=20
@@ -3812,7 +3797,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu =3D=3D NULL)
 		return;
=20
-	table =3D get_irq_table(devid);
+	table =3D get_irq_table(devid, false);
 	if (!table)
 		return;
=20
@@ -4130,7 +4115,7 @@ static int irq_remapping_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 		return ret;
=20
 	if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (alloc_irq_table(devid, true))
+		if (get_irq_table(devid, true))
 			index =3D info->ioapic_pin;
 		else
 			ret =3D -ENOMEM;
@@ -4413,7 +4398,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 	if (!iommu)
 		return -ENODEV;
=20
-	irt =3D get_irq_table(devid);
+	irt =3D get_irq_table(devid, false);
 	if (!irt)
 		return -ENODEV;
=20
--=20
2.16.2
