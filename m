Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5608C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC202087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfAHK1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfAHK1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:27:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3CB890C9C;
        Tue,  8 Jan 2019 10:27:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-249.ams2.redhat.com [10.36.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818EB6013A;
        Tue,  8 Jan 2019 10:27:19 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v3 06/21] vfio: VFIO_IOMMU_BIND_MSI
Date:   Tue,  8 Jan 2019 11:26:18 +0100
Message-Id: <20190108102633.17482-7-eric.auger@redhat.com>
In-Reply-To: <20190108102633.17482-1-eric.auger@redhat.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 08 Jan 2019 10:27:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the VFIO_IOMMU_BIND_MSI ioctl which aims at
passing the guest MSI binding to the host.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- adapt to new proto of bind_guest_msi
- directly use vfio_iommu_for_each_dev

v1 -> v2:
- s/vfio_iommu_type1_guest_msi_binding/vfio_iommu_type1_bind_guest_msi
---
 drivers/vfio/vfio_iommu_type1.c | 27 +++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  7 +++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c3ba3f249438..59229f6e2d84 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1673,6 +1673,15 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	return iommu_cache_invalidate(d, dev, &ustruct->info);
 }
 
+static int vfio_bind_guest_msi_fn(struct device *dev, void *data)
+{
+	struct vfio_iommu_type1_bind_guest_msi *ustruct =
+		(struct vfio_iommu_type1_bind_guest_msi *)data;
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+
+	return iommu_bind_guest_msi(d, dev, &ustruct->binding);
+}
+
 static int
 vfio_set_pasid_table(struct vfio_iommu *iommu,
 		      struct vfio_iommu_type1_set_pasid_table *ustruct)
@@ -1792,6 +1801,24 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 					      vfio_cache_inv_fn);
 		mutex_unlock(&iommu->lock);
 		return ret;
+	} else if (cmd == VFIO_IOMMU_BIND_MSI) {
+		struct vfio_iommu_type1_bind_guest_msi ustruct;
+		int ret;
+
+		minsz = offsetofend(struct vfio_iommu_type1_bind_guest_msi,
+				    binding);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		mutex_lock(&iommu->lock);
+		ret = vfio_iommu_for_each_dev(iommu, &ustruct,
+					      vfio_bind_guest_msi_fn);
+		mutex_unlock(&iommu->lock);
+		return ret;
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 11a07165e7e1..352e795a93c8 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -774,6 +774,13 @@ struct vfio_iommu_type1_cache_invalidate {
 };
 #define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
 
+struct vfio_iommu_type1_bind_guest_msi {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_guest_msi_binding binding;
+};
+#define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.17.2

