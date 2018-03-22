Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755219AbeCVPXh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:23:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754777AbeCVPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:56 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/10] iommu/amd: make amd_iommu_devtable_lock a spin_lock
Date: Thu, 22 Mar 2018 16:22:41 +0100
Message-Id: <20180322152242.12705-10-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 0bb6e243d7fb ("iommu/amd: Support IOMMU_DOMAIN_DMA type
allocation") amd_iommu_devtable_lock had a read_lock() user but now
there are none. In fact, after the mentioned commit we had only
write_lock() user of the lock. Since there is no reason to keep it as
writer lock, change its type to a spin_lock.
I *think* that we might even be able to remove the lock because all its
current user seem to have their own protection.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c493d345b3ef..23e26a4b708e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -80,7 +80,7 @@
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
=20
-static DEFINE_RWLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
 static DEFINE_SPINLOCK(pd_bitmap_lock);
 static DEFINE_SPINLOCK(iommu_table_lock);
=20
@@ -2097,9 +2097,9 @@ static int attach_device(struct device *dev,
 	}
=20
 skip_ats_check:
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	ret =3D __attach_device(dev_data, domain);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
=20
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
@@ -2149,9 +2149,9 @@ static void detach_device(struct device *dev)
 	domain   =3D dev_data->domain;
=20
 	/* lock device table */
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	__detach_device(dev_data);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
=20
 	if (!dev_is_pci(dev))
 		return;
@@ -2814,7 +2814,7 @@ static void cleanup_domain(struct protection_domain *=
domain)
 	struct iommu_dev_data *entry;
 	unsigned long flags;
=20
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
=20
 	while (!list_empty(&domain->dev_list)) {
 		entry =3D list_first_entry(&domain->dev_list,
@@ -2822,7 +2822,7 @@ static void cleanup_domain(struct protection_domain *=
domain)
 		__detach_device(entry);
 	}
=20
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 }
=20
 static void protection_domain_free(struct protection_domain *domain)
--=20
2.16.2
