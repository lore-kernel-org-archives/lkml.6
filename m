Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754868AbeCVPYB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:24:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754699AbeCVPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:53 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/10] iommu/amd: use `table' instead `irt' as variable name in amd_iommu_update_ga()
Date: Thu, 22 Mar 2018 16:22:38 +0100
Message-Id: <20180322152242.12705-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable of type struct irq_remap_table is always named `table'
except in amd_iommu_update_ga() where it is called `irt'. Make it
consistent and name it also `table'.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5982a61f181..ea120c7b46c9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4405,7 +4405,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 {
 	unsigned long flags;
 	struct amd_iommu *iommu;
-	struct irq_remap_table *irt;
+	struct irq_remap_table *table;
 	struct amd_ir_data *ir_data =3D (struct amd_ir_data *)data;
 	int devid =3D ir_data->irq_2_irte.devid;
 	struct irte_ga *entry =3D (struct irte_ga *) ir_data->entry;
@@ -4419,11 +4419,11 @@ int amd_iommu_update_ga(int cpu, bool is_run, void =
*data)
 	if (!iommu)
 		return -ENODEV;
=20
-	irt =3D get_irq_table(devid);
-	if (!irt)
+	table =3D get_irq_table(devid);
+	if (!table)
 		return -ENODEV;
=20
-	raw_spin_lock_irqsave(&irt->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
=20
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >=3D 0)
@@ -4432,7 +4432,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *d=
ata)
 		barrier();
 	}
=20
-	raw_spin_unlock_irqrestore(&irt->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
=20
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
--=20
2.16.2
