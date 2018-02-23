Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeBWW2P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 17:28:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41802 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeBWW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:13 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/10] iommu/amd: turn dev_data_list into a lock less list
Date: Fri, 23 Feb 2018 23:27:28 +0100
Message-Id: <20180223222736.18542-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223222736.18542-1-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_dev_data() adds new items to dev_data_list and search_dev_data()
is searching for items in this list. Both protect the access to the list
with a spinlock.
There is no need to navigate forth and back within the list and there is
also no deleting of a specific item. This qualifies the list to become a
lock less list and as part of this, the spinlock can be removed.
With this change the ordering of those items within the list is changed:
before the change new items were added to the end of the list, now they
are added to the front. I don't think it matters but wanted to mention
it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iommu/amd_iommu.c       | 28 ++++++++++------------------
 drivers/iommu/amd_iommu_types.h |  2 +-
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8b591c192daf..53aece41ddf2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -83,8 +83,7 @@
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
=20
 /* List of all available dev_data structures */
-static LIST_HEAD(dev_data_list);
-static DEFINE_SPINLOCK(dev_data_list_lock);
+static LLIST_HEAD(dev_data_list);
=20
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
@@ -203,40 +202,33 @@ static struct dma_ops_domain* to_dma_ops_domain(struc=
t protection_domain *domain
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
=20
 	dev_data =3D kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data)
 		return NULL;
=20
 	dev_data->devid =3D devid;
-
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_add_tail(&dev_data->dev_data_list, &dev_data_list);
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
 	ratelimit_default_init(&dev_data->rs);
=20
+	llist_add(&dev_data->dev_data_list, &dev_data_list);
 	return dev_data;
 }
=20
 static struct iommu_dev_data *search_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
+	struct llist_node *node;
=20
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_for_each_entry(dev_data, &dev_data_list, dev_data_list) {
+	if (llist_empty(&dev_data_list))
+		return NULL;
+
+	node =3D dev_data_list.first;
+	llist_for_each_entry(dev_data, node, dev_data_list) {
 		if (dev_data->devid =3D=3D devid)
-			goto out_unlock;
+			return dev_data;
 	}
=20
-	dev_data =3D NULL;
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
-	return dev_data;
+	return NULL;
 }
=20
 static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_type=
s.h
index 6a877ebd058b..62d6f42b57c9 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -627,7 +627,7 @@ struct devid_map {
  */
 struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
-	struct list_head dev_data_list;	  /* For global dev_data_list */
+	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
 	u16 alias;			  /* Alias Device ID */
--=20
2.16.1
