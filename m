Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeBWWan (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:30:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41807 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeBWW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:15 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/10] iommu/amd: split irq_lookup_table out of the amd_iommu_devtable_lock
Date: Fri, 23 Feb 2018 23:27:30 +0100
Message-Id: <20180223222736.18542-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223222736.18542-1-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_irq_table() reads/writes irq_lookup_table while holding
the amd_iommu_devtable_lock. It also modifies
amd_iommu_dev_table[].data[2].
set_dte_entry() is using amd_iommu_dev_table[].data[0|1] (under the
domain->lock) so it should be okay. The access to the iommu is
serialized with its own (iommu's) lock.

So split out get_irq_table() out of amd_iommu_devtable_lock's lock. The
new lock is a raw_spin_lock because modify_irte_ga() is called while
desc->lock is held (which is raw).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 958efe311057..72487ac43eef 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -82,6 +82,7 @@
=20
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
+static DEFINE_RAW_SPINLOCK(iommu_table_lock);
=20
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -3594,7 +3595,7 @@ static struct irq_remap_table *get_irq_table(u16 devi=
d, bool ioapic)
 	unsigned long flags;
 	u16 alias;
=20
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	raw_spin_lock_irqsave(&iommu_table_lock, flags);
=20
 	iommu =3D amd_iommu_rlookup_table[devid];
 	if (!iommu)
@@ -3659,7 +3660,7 @@ static struct irq_remap_table *get_irq_table(u16 devi=
d, bool ioapic)
 	iommu_completion_wait(iommu);
=20
 out_unlock:
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
=20
 	return table;
 }
--=20
2.16.1
