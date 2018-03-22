Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeCVP1Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:27:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeCVPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:52 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/10] iommu/amd: split irq_lookup_table out of the amd_iommu_devtable_lock
Date: Thu, 22 Mar 2018 16:22:36 +0100
Message-Id: <20180322152242.12705-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
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

So split out get_irq_table() out of amd_iommu_devtable_lock's lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index fcfdce70707d..a87d2fee68db 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -82,6 +82,7 @@
=20
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
+static DEFINE_SPINLOCK(iommu_table_lock);
=20
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -3623,7 +3624,7 @@ static struct irq_remap_table *alloc_irq_table(u16 de=
vid, bool ioapic)
 	unsigned long flags;
 	u16 alias;
=20
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&iommu_table_lock, flags);
=20
 	iommu =3D amd_iommu_rlookup_table[devid];
 	if (!iommu)
@@ -3688,7 +3689,7 @@ static struct irq_remap_table *alloc_irq_table(u16 de=
vid, bool ioapic)
 	iommu_completion_wait(iommu);
=20
 out_unlock:
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&iommu_table_lock, flags);
=20
 	return table;
 }
--=20
2.16.2
