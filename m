Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754997AbeCVPXA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:23:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39547 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeCVPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:54 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 07/10] iommu/amd: factor out setting the remap table for a devid
Date: Thu, 22 Mar 2018 16:22:39 +0100
Message-Id: <20180322152242.12705-8-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the IRQ remap table for a specific devid (or its alias devid)
includes three steps. Those three steps are always repeated each time
this is done.
Introduce a new helper function, move those steps there and use that
function instead. The compiler can still decide if it is worth to
inline.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ea120c7b46c9..11ea2d656be8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3617,6 +3617,14 @@ static struct irq_remap_table *get_irq_table(u16 dev=
id)
 	return table;
 }
=20
+static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
+				  struct irq_remap_table *table)
+{
+	irq_lookup_table[devid] =3D table;
+	set_dte_irq_entry(devid, table);
+	iommu_flush_dte(iommu, devid);
+}
+
 static struct irq_remap_table *alloc_irq_table(u16 devid)
 {
 	struct irq_remap_table *table =3D NULL;
@@ -3637,9 +3645,7 @@ static struct irq_remap_table *alloc_irq_table(u16 de=
vid)
 	alias =3D amd_iommu_alias_table[devid];
 	table =3D irq_lookup_table[alias];
 	if (table) {
-		irq_lookup_table[devid] =3D table;
-		set_dte_irq_entry(devid, table);
-		iommu_flush_dte(iommu, devid);
+		set_remap_table_entry(iommu, devid, table);
 		goto out;
 	}
=20
@@ -3666,14 +3672,9 @@ static struct irq_remap_table *alloc_irq_table(u16 d=
evid)
 		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
=20
=20
-	irq_lookup_table[devid] =3D table;
-	set_dte_irq_entry(devid, table);
-	iommu_flush_dte(iommu, devid);
-	if (devid !=3D alias) {
-		irq_lookup_table[alias] =3D table;
-		set_dte_irq_entry(alias, table);
-		iommu_flush_dte(iommu, alias);
-	}
+	set_remap_table_entry(iommu, devid, table);
+	if (devid !=3D alias)
+		set_remap_table_entry(iommu, alias, table);
=20
 out:
 	iommu_completion_wait(iommu);
--=20
2.16.2
