Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE00CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7286F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7286F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeIRT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbeIRT6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A51C9811A9;
        Tue, 18 Sep 2018 14:25:43 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A3FE51DE1;
        Tue, 18 Sep 2018 14:25:38 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 05/20] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Date:   Tue, 18 Sep 2018 16:24:42 +0200
Message-Id: <20180918142457.3325-6-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Sep 2018 14:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

When the guest "owns" the stage 1 translation structures,  the host
IOMMU driver has no knowledge of caching structure updates unless
the guest invalidation requests are trapped and passed down to the
host.

This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims
at propagating guest stage1 IOMMU cache invalidations to the host.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- s/TLB/CACHE
- remove vfio_iommu_task usage
- commit message rewording
---
 drivers/vfio/vfio_iommu_type1.c | 44 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  7 ++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 044d3a046125..14529233f774 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1673,6 +1673,37 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int vfio_cache_inv_fn(struct device *dev, void *data)
+{
+	struct vfio_iommu_type1_cache_invalidate *ustruct =
+		(struct vfio_iommu_type1_cache_invalidate *)data;
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+
+	return iommu_cache_invalidate(d, dev, &ustruct->info);
+}
+
+static int
+vfio_cache_invalidate(struct vfio_iommu *iommu,
+		      struct vfio_iommu_type1_cache_invalidate *ustruct)
+{
+	struct vfio_domain *d;
+	struct vfio_group *g;
+	int ret = 0;
+
+	mutex_lock(&iommu->lock);
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		list_for_each_entry(g, &d->group_list, next) {
+			ret = iommu_group_for_each_dev(g->iommu_group, ustruct,
+						       vfio_cache_inv_fn);
+			if (ret)
+				break;
+		}
+	}
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static int
 vfio_bind_pasid_table(struct vfio_iommu *iommu,
 		      struct vfio_iommu_type1_bind_pasid_table *ustruct)
@@ -1774,6 +1805,19 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			return -EINVAL;
 
 		return vfio_bind_pasid_table(iommu, &ustruct);
+	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
+		struct vfio_iommu_type1_cache_invalidate ustruct;
+
+		minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate,
+				    info);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		return vfio_cache_invalidate(iommu, &ustruct);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index f81ce0a75c01..2a38d0bca0ca 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -673,6 +673,13 @@ struct vfio_iommu_type1_bind_pasid_table {
 };
 #define VFIO_IOMMU_BIND_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
 
+struct vfio_iommu_type1_cache_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_cache_invalidate_info info;
+};
+#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.17.1

