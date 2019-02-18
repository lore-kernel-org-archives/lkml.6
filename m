Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40280C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1621736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfBRN4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387855AbfBRN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCCF181F13;
        Mon, 18 Feb 2019 13:56:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402965D70A;
        Mon, 18 Feb 2019 13:56:34 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [PATCH v4 09/22] vfio: VFIO_IOMMU_BIND/UNBIND_MSI
Date:   Mon, 18 Feb 2019 14:54:50 +0100
Message-Id: <20190218135504.25048-10-eric.auger@redhat.com>
In-Reply-To: <20190218135504.25048-1-eric.auger@redhat.com>
References: <20190218135504.25048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Feb 2019 13:56:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the VFIO_IOMMU_BIND/UNBIND_MSI ioctl which aim
to pass/withdraw the guest MSI binding to/from the host.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- add UNBIND
- unwind on BIND error

v2 -> v3:
- adapt to new proto of bind_guest_msi
- directly use vfio_iommu_for_each_dev

v1 -> v2:
- s/vfio_iommu_type1_guest_msi_binding/vfio_iommu_type1_bind_guest_msi
---
 drivers/vfio/vfio_iommu_type1.c | 58 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 29 +++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 12a40b9db6aa..66513679081b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1710,6 +1710,25 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	return iommu_cache_invalidate(d, dev, &ustruct->info);
 }
 
+static int vfio_bind_msi_fn(struct device *dev, void *data)
+{
+	struct vfio_iommu_type1_bind_msi *ustruct =
+		(struct vfio_iommu_type1_bind_msi *)data;
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+
+	return iommu_bind_guest_msi(d, dev, ustruct->iova,
+				    ustruct->gpa, ustruct->size);
+}
+
+static int vfio_unbind_msi_fn(struct device *dev, void *data)
+{
+	dma_addr_t *iova = (dma_addr_t *)data;
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+
+	iommu_unbind_guest_msi(d, dev, *iova);
+	return 0;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1814,6 +1833,45 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 					      vfio_cache_inv_fn);
 		mutex_unlock(&iommu->lock);
 		return ret;
+	} else if (cmd == VFIO_IOMMU_BIND_MSI) {
+		struct vfio_iommu_type1_bind_msi ustruct;
+		int ret;
+
+		minsz = offsetofend(struct vfio_iommu_type1_bind_msi,
+				    size);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		mutex_lock(&iommu->lock);
+		ret = vfio_iommu_for_each_dev(iommu, &ustruct,
+					      vfio_bind_msi_fn);
+		if (ret)
+			vfio_iommu_for_each_dev(iommu, &ustruct.iova,
+						vfio_unbind_msi_fn);
+		mutex_unlock(&iommu->lock);
+		return ret;
+	} else if (cmd == VFIO_IOMMU_UNBIND_MSI) {
+		struct vfio_iommu_type1_unbind_msi ustruct;
+		int ret;
+
+		minsz = offsetofend(struct vfio_iommu_type1_unbind_msi,
+				    iova);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		mutex_lock(&iommu->lock);
+		ret = vfio_iommu_for_each_dev(iommu, &ustruct.iova,
+					      vfio_unbind_msi_fn);
+		mutex_unlock(&iommu->lock);
+		return ret;
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 29f0ef2d805d..6763389b6adc 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -789,6 +789,35 @@ struct vfio_iommu_type1_cache_invalidate {
 };
 #define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
 
+/**
+ * VFIO_IOMMU_BIND_MSI - _IOWR(VFIO_TYPE, VFIO_BASE + 25,
+ *			struct vfio_iommu_type1_bind_msi)
+ *
+ * Pass a stage 1 MSI doorbell mapping to the host so that this
+ * latter can build a nested stage2 mapping
+ */
+struct vfio_iommu_type1_bind_msi {
+	__u32   argsz;
+	__u32   flags;
+	__u64	iova;
+	__u64	gpa;
+	__u64	size;
+};
+#define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 25)
+
+/**
+ * VFIO_IOMMU_UNBIND_MSI - _IOWR(VFIO_TYPE, VFIO_BASE + 26,
+ *			struct vfio_iommu_type1_unbind_msi)
+ *
+ * Unregister an MSI mapping
+ */
+struct vfio_iommu_type1_unbind_msi {
+	__u32   argsz;
+	__u32   flags;
+	__u64	iova;
+};
+#define VFIO_IOMMU_UNBIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 26)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.20.1

