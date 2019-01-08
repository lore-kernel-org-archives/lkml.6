Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23B32173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAHK2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:28:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfAHK2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:28:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E68838E596;
        Tue,  8 Jan 2019 10:28:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8C27601A3;
        Tue,  8 Jan 2019 10:27:59 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v3 12/21] dma-iommu: Implement NESTED_MSI cookie
Date:   Tue,  8 Jan 2019 11:26:24 +0100
Message-Id: <20190108102633.17482-13-eric.auger@redhat.com>
In-Reply-To: <20190108102633.17482-1-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 08 Jan 2019 10:28:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up to now, when the type was UNMANAGED, we used to
allocate IOVA pages within a range provided by the user.
This does not work in nested mode.

If both the host and the guest are exposed with SMMUs, each
would allocate an IOVA. The guest allocates an IOVA (gIOVA)
to map onto the guest MSI doorbell (gDB). The Host allocates
another IOVA (hIOVA) to map onto the physical doorbell (hDB).

So we end up with 2 unrelated mappings, at S1 and S2:
         S1             S2
gIOVA    ->     gDB
               hIOVA    ->    hDB

The PCI device would be programmed with hIOVA.

iommu_dma_bind_doorbell allows to pass gIOVA/gDB to the host
so that gIOVA can be used by the host instead of re-allocating
a new IOVA. The device handle also is passed to garantee
devices belonging to different stage1 domains record
distinguishable stage1 mappings. That way the host can create
the following nested
mapping:

         S1           S2
gIOVA    ->    gDB    ->    hDB

this time, the PCI device will be programmed with the gIOVA MSI
doorbell which is correctly mapped through the 2 stages.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- also store the device handle on S1 mapping registration.
  This garantees we associate the associated S2 mapping binds
  to the correct physical MSI controller.

v1 -> v2:
- unmap stage2 on put()
---
 drivers/iommu/dma-iommu.c | 112 ++++++++++++++++++++++++++++++++++++--
 include/linux/dma-iommu.h |  11 ++++
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..19af8107e959 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -35,12 +35,15 @@
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
+	dma_addr_t		ipa;
 	phys_addr_t		phys;
+	struct device		*dev;
 };
 
 enum iommu_dma_cookie_type {
 	IOMMU_DMA_IOVA_COOKIE,
 	IOMMU_DMA_MSI_COOKIE,
+	IOMMU_DMA_NESTED_MSI_COOKIE,
 };
 
 struct iommu_dma_cookie {
@@ -110,14 +113,17 @@ EXPORT_SYMBOL(iommu_get_dma_cookie);
  *
  * Users who manage their own IOVA allocation and do not want DMA API support,
  * but would still like to take advantage of automatic MSI remapping, can use
- * this to initialise their own domain appropriately. Users should reserve a
+ * this to initialise their own domain appropriately. Users may reserve a
  * contiguous IOVA region, starting at @base, large enough to accommodate the
  * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
- * used by the devices attached to @domain.
+ * used by the devices attached to @domain. The other way round is to provide
+ * usable iova pages through the iommu_dma_bind_doorbell API (nested stages
+ * use case)
  */
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	struct iommu_dma_cookie *cookie;
+	int nesting, ret;
 
 	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
 		return -EINVAL;
@@ -125,7 +131,12 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 	if (domain->iova_cookie)
 		return -EEXIST;
 
-	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
+	ret =  iommu_domain_get_attr(domain, DOMAIN_ATTR_NESTING, &nesting);
+	if (!ret && nesting)
+		cookie = cookie_alloc(IOMMU_DMA_NESTED_MSI_COOKIE);
+	else
+		cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
+
 	if (!cookie)
 		return -ENOMEM;
 
@@ -146,6 +157,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
+	bool s2_unmap = false;
 
 	if (!cookie)
 		return;
@@ -153,7 +165,15 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
 		put_iova_domain(&cookie->iovad);
 
+	if (cookie->type == IOMMU_DMA_NESTED_MSI_COOKIE)
+		s2_unmap = true;
+
 	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
+		if (s2_unmap && msi->phys) {
+			size_t size = cookie_msi_granule(cookie);
+
+			WARN_ON(iommu_unmap(domain, msi->ipa, size) != size);
+		}
 		list_del(&msi->list);
 		kfree(msi);
 	}
@@ -162,6 +182,52 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+/**
+ * iommu_dma_bind_doorbell - Allows to provide a usable IOVA page
+ * @domain: domain handle
+ * @dev: device handle
+ * @binding: IOVA/IPA binding
+ *
+ * In nested stage use case, the user can provide IOVA/IPA bindings
+ * corresponding to a guest MSI stage 1 mapping. When the host needs
+ * to map its own MSI doorbells, it can use the IPA as stage 2 input
+ * and map it onto the physical MSI doorbell.
+ */
+int iommu_dma_bind_doorbell(struct iommu_domain *domain, struct device *dev,
+			    struct iommu_guest_msi_binding *binding)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iommu_dma_msi_page *msi;
+	dma_addr_t ipa, iova;
+	size_t size;
+
+	if (!cookie)
+		return -EINVAL;
+
+	if (cookie->type != IOMMU_DMA_NESTED_MSI_COOKIE)
+		return -EINVAL;
+
+	size = 1 << binding->granule;
+	iova = binding->iova & ~(phys_addr_t)(size - 1);
+	ipa = binding->gpa & ~(phys_addr_t)(size - 1);
+
+	list_for_each_entry(msi, &cookie->msi_page_list, list) {
+		if (msi->iova == iova && msi->dev == dev)
+			return 0; /* this page is already registered */
+	}
+
+	msi = kzalloc(sizeof(*msi), GFP_KERNEL);
+	if (!msi)
+		return -ENOMEM;
+
+	msi->iova = iova;
+	msi->ipa = ipa;
+	msi->dev = dev;
+	list_add(&msi->list, &cookie->msi_page_list);
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_bind_doorbell);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -856,6 +922,16 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
 }
 
+static bool msi_page_match(struct iommu_dma_msi_page *msi_page,
+			   struct device *dev, phys_addr_t msi_addr)
+{
+	bool match = msi_page->phys == msi_addr;
+
+	if (msi_page->dev)
+		match &= (msi_page->dev == dev);
+	return match;
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
@@ -867,9 +943,37 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 
 	msi_addr &= ~(phys_addr_t)(size - 1);
 	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
-		if (msi_page->phys == msi_addr)
+		if (msi_page_match(msi_page, dev, msi_addr))
 			return msi_page;
 
+	/*
+	 * In nested stage mode, we do not allocate an MSI page in
+	 * a range provided by the user. Instead, IOVA/IPA bindings are
+	 * individually provided. We reuse thise IOVAs to build the
+	 * IOVA -> IPA -> MSI PA nested stage mapping.
+	 */
+	if (cookie->type == IOMMU_DMA_NESTED_MSI_COOKIE) {
+		list_for_each_entry(msi_page, &cookie->msi_page_list, list)
+			if (!msi_page->phys && msi_page->dev == dev) {
+				dma_addr_t ipa = msi_page->ipa;
+				int ret;
+
+				msi_page->phys = msi_addr;
+
+				/* do the stage 2 mapping */
+				ret = iommu_map(domain, ipa, msi_addr, size,
+						IOMMU_MMIO | IOMMU_WRITE);
+				if (ret) {
+					pr_warn("MSI S2 mapping failed (%d)\n",
+						ret);
+					return NULL;
+				}
+				return msi_page;
+			}
+		pr_warn("%s no MSI binding found\n", __func__);
+		return NULL;
+	}
+
 	msi_page = kzalloc(sizeof(*msi_page), GFP_ATOMIC);
 	if (!msi_page)
 		return NULL;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..778243719462 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/msi.h>
+#include <uapi/linux/iommu.h>
 
 int iommu_dma_init(void);
 
@@ -73,12 +74,15 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
+int iommu_dma_bind_doorbell(struct iommu_domain *domain, struct device *dev,
+			    struct iommu_guest_msi_binding *binding);
 
 #else
 
 struct iommu_domain;
 struct msi_msg;
 struct device;
+struct iommu_guest_msi_binding;
 
 static inline int iommu_dma_init(void)
 {
@@ -103,6 +107,13 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
 
+static inline int
+iommu_dma_bind_doorbell(struct iommu_domain *domain,
+			struct iommu_guest_msi_binding *binding)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
-- 
2.17.2

