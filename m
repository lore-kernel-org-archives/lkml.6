Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755869AbeEHSTx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:19:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41871 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeEHSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:35 -0400
X-Google-Smtp-Source: AB8JxZrxFV1P9yz6p45rRphChV2+Tbzwx3Y1sVpbEHI/Zsn7zLN0SsP+Gb3ltM6G4jwXFyjB6EJ6Pw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/9] iommu/tegra: gart: Provide single domain and group for all devices
Date: Tue,  8 May 2018 21:16:58 +0300
Message-Id: <20180508181700.5169-8-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART aperture is shared by all devices, hence there is a single IOMMU
domain and group shared by these devices. Allocation of a group per
device only wastes resources and allowance of having more than one domain
is simply wrong because IOMMU mappings made by the users of "different"
domains will stomp on each other.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 107 +++++++++----------------------------
 1 file changed, 24 insertions(+), 83 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 5b2d27620350..ebc105c201bd 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,7 +19,6 @@
 
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -44,22 +43,17 @@
 #define GART_PAGE_MASK						\
 	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
 
-struct gart_client {
-	struct device		*dev;
-	struct list_head	list;
-};
-
 struct gart_device {
 	void __iomem		*regs;
 	u32			*savedata;
 	u32			page_count;	/* total remappable size */
 	dma_addr_t		iovmm_base;	/* offset to vmm_area */
 	spinlock_t		pte_lock;	/* for pagetable */
-	struct list_head	client;
-	spinlock_t		client_lock;	/* for client list */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
+	struct iommu_group	*group;		/* Common IOMMU group */
+	struct gart_domain	*domain;	/* Unique IOMMU domain */
 
 	struct tegra_mc_gart_handle mc_gart_handle;
 };
@@ -169,81 +163,31 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
 static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-	struct gart_client *client, *c;
-	int err = 0;
-
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
-	if (!client)
-		return -ENOMEM;
-	client->dev = dev;
-
-	spin_lock(&gart->client_lock);
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
-			err = -EINVAL;
-			goto fail;
-		}
-	}
-	list_add(&client->list, &gart->client);
-	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
 	return 0;
-
-fail:
-	devm_kfree(gart->dev, client);
-	spin_unlock(&gart->client_lock);
-	return err;
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-	struct gart_client *c;
-
-	spin_lock(&gart->client_lock);
-
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			list_del(&c->list);
-			devm_kfree(gart->dev, c);
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			goto out;
-		}
-	}
-	dev_err(gart->dev, "Couldn't find\n");
-out:
-	spin_unlock(&gart->client_lock);
 }
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_domain *gart_domain;
-	struct gart_device *gart;
-
-	if (type != IOMMU_DOMAIN_UNMANAGED)
-		return NULL;
+	struct gart_device *gart = gart_handle;
 
-	gart = gart_handle;
-	if (!gart)
+	if (type != IOMMU_DOMAIN_UNMANAGED || gart->domain)
 		return NULL;
 
-	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
-	if (!gart_domain)
-		return NULL;
-
-	gart_domain->gart = gart;
-	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
-	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
+	gart->domain = kzalloc(sizeof(*gart->domain), GFP_KERNEL);
+	if (gart->domain) {
+		gart->domain->domain.geometry.aperture_start = gart->iovmm_base;
+		gart->domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-	gart_domain->domain.geometry.force_aperture = true;
+		gart->domain->domain.geometry.force_aperture = true;
+		gart->domain->gart = gart;
+	}
 
-	return &gart_domain->domain;
+	return &gart->domain->domain;
 }
 
 static void gart_iommu_domain_free(struct iommu_domain *domain)
@@ -251,18 +195,7 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_domain->gart;
 
-	if (gart) {
-		spin_lock(&gart->client_lock);
-		if (!list_empty(&gart->client)) {
-			struct gart_client *c;
-
-			list_for_each_entry(c, &gart->client, list)
-				gart_iommu_detach_dev(domain, c->dev);
-		}
-		spin_unlock(&gart->client_lock);
-	}
-
-	kfree(gart_domain);
+	kfree(gart->domain);
 }
 
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -377,7 +310,7 @@ struct iommu_group *gart_iommu_device_group(struct device *dev)
 	if (err)
 		return ERR_PTR(err);
 
-	return generic_device_group(dev);
+	return gart_handle->group;
 }
 
 static int gart_iommu_of_xlate(struct device *dev,
@@ -502,8 +435,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 
 	gart->dev = &pdev->dev;
 	spin_lock_init(&gart->pte_lock);
-	spin_lock_init(&gart->client_lock);
-	INIT_LIST_HEAD(&gart->client);
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
@@ -517,6 +448,14 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto iommu_unregister;
 	}
 
+	gart->group = iommu_group_alloc();
+	if (IS_ERR(gart->group)) {
+		ret = PTR_ERR(gart->group);
+		goto free_savedata;
+	}
+
+	iommu_group_ref_get(gart->group);
+
 	platform_set_drvdata(pdev, gart);
 	do_gart_setup(gart, NULL);
 
@@ -525,6 +464,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 
 	return 0;
 
+free_savedata:
+	vfree(gart->savedata);
 iommu_unregister:
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
-- 
2.17.0
