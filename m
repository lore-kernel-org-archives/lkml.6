Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E40C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E492146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E492146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeIRT6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbeIRT6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C52F3084038;
        Tue, 18 Sep 2018 14:25:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B737B00A;
        Tue, 18 Sep 2018 14:25:25 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 03/20] iommu: Introduce bind_guest_msi
Date:   Tue, 18 Sep 2018 16:24:40 +0200
Message-Id: <20180918142457.3325-4-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 18 Sep 2018 14:25:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM, MSI are translated by the SMMU. An IOVA is allocated
for each MSI doorbell. If both the host and the guest are exposed
with SMMUs, we end up with 2 different IOVAs allocated by each.
guest allocates an IOVA (gIOVA) to map onto the guest MSI
doorbell (gDB). The Host allocates another IOVA (hIOVA) to map
onto the physical doorbell (hDB).

So we end up with 2 untied mappings:
         S1            S2
gIOVA    ->    gDB
              hIOVA    ->    gDB

Currently the PCI device is programmed by the host with hIOVA
as MSI doorbell. So this does not work.

This patch introduces an API to pass gIOVA/gDB to the host so
that gIOVA can be reused by the host instead of re-allocating
a new IOVA. So the goal is to create the following nested mapping:

         S1            S2
gIOVA    ->    gDB     ->    hDB

and program the PCI device with gIOVA MSI doorbell.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/iommu.c      | 10 ++++++++++
 include/linux/iommu.h      | 13 +++++++++++++
 include/uapi/linux/iommu.h |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1442a6c640af..b2b8f375b169 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1409,6 +1409,16 @@ static void __iommu_detach_device(struct iommu_domain *domain,
 	trace_detach_device_from_domain(dev);
 }
 
+int iommu_bind_guest_msi(struct iommu_domain *domain,
+			 struct iommu_guest_msi_binding *binding)
+{
+	if (unlikely(!domain->ops->bind_guest_msi))
+		return -ENODEV;
+
+	return domain->ops->bind_guest_msi(domain, binding);
+}
+EXPORT_SYMBOL_GPL(iommu_bind_guest_msi);
+
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3e5f6eb1f04a..9bd3e63d562b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -242,6 +242,9 @@ struct iommu_ops {
 	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
 
+	int (*bind_guest_msi)(struct iommu_domain *domain,
+			      struct iommu_guest_msi_binding *binding);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -309,6 +312,9 @@ extern void iommu_unbind_pasid_table(struct iommu_domain *domain);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
 				struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_bind_guest_msi(struct iommu_domain *domain,
+				struct iommu_guest_msi_binding *binding);
+
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -719,6 +725,13 @@ iommu_cache_invalidate(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline
+int iommu_bind_guest_msi(struct iommu_domain *domain,
+			 struct iommu_guest_msi_binding *binding)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 4283e0334baf..21adb2a964e5 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -144,4 +144,11 @@ struct iommu_cache_invalidate_info {
 	__u64		arch_id;
 	__u64		addr;
 };
+
+struct iommu_guest_msi_binding {
+	__u64		iova;
+	__u64		gpa;
+	__u32		granule;
+};
 #endif /* _UAPI_IOMMU_H */
+
-- 
2.17.1

