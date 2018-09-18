Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C572146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C572146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeIRT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbeIRT7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B17EE307D863;
        Tue, 18 Sep 2018 14:27:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57D4851DE1;
        Tue, 18 Sep 2018 14:26:56 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     tianyu.lan@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [RFC v2 18/20] vfio: VFIO_IOMMU_GET_FAULT_EVENTS
Date:   Tue, 18 Sep 2018 16:24:55 +0200
Message-Id: <20180918142457.3325-19-eric.auger@redhat.com>
In-Reply-To: <20180918142457.3325-1-eric.auger@redhat.com>
References: <20180918142457.3325-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 18 Sep 2018 14:27:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an IOTCL that allows the userspace to consume fault
events that may have occurred. The userspace buffer gets filled
by pending faults, if any. The number of filled faults is
reported to the userspace. Read faults are removed from the kfifo.
the kernel does not expect any response from the userspace.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

the fault_lock may not be needed as kfifo documentation says:
"Note that with only one concurrent reader and one concurrent
writer, you don't need extra locking to use these macro."
---
 drivers/vfio/vfio_iommu_type1.c | 33 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       | 10 ++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e52cbeb479c3..917bb8f9c9ae 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1769,7 +1769,7 @@ vfio_iommu_fault_handler(struct iommu_fault_event *event, void *data)
 		eventfd_signal(iommu->fault_ctx, 1);
 out:
 	mutex_unlock(&iommu->fault_lock);
-	return 0;
+	return ret;
 }
 
 static inline int
@@ -1981,6 +1981,37 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			return -EINVAL;
 
 		return vfio_iommu_set_fault_eventfd(iommu, &ustruct);
+	} else if (cmd == VFIO_IOMMU_GET_FAULT_EVENTS) {
+		struct vfio_iommu_type1_get_fault_events ustruct;
+		size_t buf_size, len, elem_size;
+		int copied, max_events, ret;
+
+		minsz = offsetofend(struct vfio_iommu_type1_get_fault_events,
+				    reserved);
+
+		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (ustruct.argsz < minsz || ustruct.flags)
+			return -EINVAL;
+
+		elem_size = sizeof(struct iommu_fault);
+		buf_size = ustruct.argsz - minsz;
+		max_events = buf_size / elem_size;
+		len = max_events * elem_size;
+
+		mutex_lock(&iommu->fault_lock);
+
+		ret = kfifo_to_user(&iommu->fault_fifo,
+				    (void __user *)(arg + minsz), len, &copied);
+
+		mutex_unlock(&iommu->fault_lock);
+		if (ret)
+			return ret;
+
+		ustruct.count = copied / elem_size;
+
+		return copy_to_user((void __user *)arg, &ustruct, minsz);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 0d62598c818a..5b9165b7db8d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -703,6 +703,16 @@ struct vfio_iommu_type1_set_fault_eventfd {
 };
 #define VFIO_IOMMU_SET_FAULT_EVENTFD      _IO(VFIO_TYPE, VFIO_BASE + 25)
 
+struct vfio_iommu_type1_get_fault_events {
+	__u32	argsz;
+	__u32   flags;
+	__u32	count; /* number of faults returned */
+	__u32   reserved;
+	struct iommu_fault events[];
+};
+
+#define VFIO_IOMMU_GET_FAULT_EVENTS	_IO(VFIO_TYPE, VFIO_BASE + 26)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.17.1

