Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeCPUVC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:21:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeCPUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:18:46 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/10] iommu/amd: split domain id out of amd_iommu_devtable_lock
Date: Fri, 16 Mar 2018 21:18:29 +0100
Message-Id: <20180316201836.7864-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316201836.7864-1-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

domain_id_alloc() and domain_id_free() is used for id management. Those
two function share a bitmap (amd_iommu_pd_alloc_bitmap) and set/clear
bits based on id allocation. There is no need to share this with
amd_iommu_devtable_lock, it can use its own lock for this operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0e57ce2c258b..692b2e3b9af1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -81,6 +81,7 @@
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
=20
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(pd_bitmap_lock);
=20
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -1600,29 +1601,26 @@ static void del_domain_from_list(struct protection_=
domain *domain)
=20
 static u16 domain_id_alloc(void)
 {
-	unsigned long flags;
 	int id;
=20
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	id =3D find_first_zero_bit(amd_iommu_pd_alloc_bitmap, MAX_DOMAIN_ID);
 	BUG_ON(id =3D=3D 0);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__set_bit(id, amd_iommu_pd_alloc_bitmap);
 	else
 		id =3D 0;
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
=20
 	return id;
 }
=20
 static void domain_id_free(int id)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
 }
=20
 #define DEFINE_FREE_PT_FN(LVL, FN)				\
--=20
2.16.2
