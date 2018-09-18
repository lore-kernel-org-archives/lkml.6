Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D10CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF92086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EF92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbeIRT62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbeIRT61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30D123081D8C;
        Tue, 18 Sep 2018 14:25:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53FE51DE1;
        Tue, 18 Sep 2018 14:25:34 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 04/20] vfio: VFIO_IOMMU_BIND_PASID_TABLE
Date:   Tue, 18 Sep 2018 16:24:41 +0200
Message-Id: <20180918142457.3325-5-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 18 Sep 2018 14:25:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds VFIO_IOMMU_BIND_PASID_TABLE ioctl which aims at
passing the virtual iommu guest configuration to the VFIO driver
downto to the iommu subsystem.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- s/BIND_GUEST_STAGE/BIND_PASID_TABLE
- remove the struct device arg
---
 drivers/vfio/vfio_iommu_type1.c | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d9fd3188615d..044d3a046125 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1673,6 +1673,24 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int
+vfio_bind_pasid_table(struct vfio_iommu *iommu,
+		      struct vfio_iommu_type1_bind_pasid_table *ustruct)
+{
+	struct vfio_domain *d;
+	int ret = 0;
+
+	mutex_lock(&iommu->lock);
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_bind_pasid_table(d->domain, &ustruct->config);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1743,6 +1761,19 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+	} else if (cmd == VFIO_IOMMU_BIND_PASID_TABLE) {
+		struct vfio_iommu_type1_bind_pasid_table ustruct;
+
+		minsz = offsetofend(struct vfio_iommu_type1_bind_pasid_table,
+				    config);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		return vfio_bind_pasid_table(iommu, &ustruct);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82e8169..f81ce0a75c01 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
 
 #define VFIO_API_VERSION	0
 
@@ -665,6 +666,13 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+struct vfio_iommu_type1_bind_pasid_table {
+	__u32	argsz;
+	__u32	flags;
+	struct iommu_pasid_table_config config;
+};
+#define VFIO_IOMMU_BIND_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.17.1

