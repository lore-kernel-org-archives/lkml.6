Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B5BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81442173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfBROgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:36:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387635AbfBRNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09E87C0587FE;
        Mon, 18 Feb 2019 13:55:57 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06D325D70E;
        Mon, 18 Feb 2019 13:55:51 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
Subject: [PATCH v4 02/22] iommu: introduce device fault data
Date:   Mon, 18 Feb 2019 14:54:43 +0100
Message-Id: <20190218135504.25048-3-eric.auger@redhat.com>
In-Reply-To: <20190218135504.25048-1-eric.auger@redhat.com>
References: <20190218135504.25048-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Feb 2019 13:55:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Device faults detected by IOMMU can be reported outside the IOMMU
subsystem for further processing. This patch introduces
a generic device fault data structure.

The fault can be either an unrecoverable fault or a page request,
also referred to as a recoverable fault.

We only care about non internal faults that are likely to be reported
to an external subsystem.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- use a union containing aither an unrecoverable fault or a page
  request message. Move the device private data in the page request
  structure. Reshuffle the fields and use flags.
- move fault perm attributes to the uapi
- remove a bunch of iommu_fault_reason enum values that were related
  to internal errors
---
 include/linux/iommu.h      |  47 +++++++++++++++
 include/uapi/linux/iommu.h | 115 +++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e90da6b6f3d1..032d33894723 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -48,6 +49,7 @@ struct bus_type;
 struct device;
 struct iommu_domain;
 struct notifier_block;
+struct iommu_fault_event;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -55,6 +57,7 @@ struct notifier_block;
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
+typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -243,6 +246,49 @@ struct iommu_device {
 	struct device *dev;
 };
 
+/**
+ * struct iommu_fault_event - Generic per device fault data
+ *
+ * - PCI and non-PCI devices
+ * - Recoverable faults (e.g. page request), information based on PCI ATS
+ *   and PASID spec.
+ * - Un-recoverable faults of device interest
+ * - DMA remapping and IRQ remapping faults
+ *
+ * @fault: fault descriptor
+ * @iommu_private: used by the IOMMU driver for storing fault-specific
+ *                 data. Users should not modify this field before
+ *                 sending the fault response.
+ */
+struct iommu_fault_event {
+	struct iommu_fault fault;
+	u64 iommu_private;
+};
+
+/**
+ * struct iommu_fault_param - per-device IOMMU fault data
+ * @dev_fault_handler: Callback function to handle IOMMU faults at device level
+ * @data: handler private data
+ *
+ */
+struct iommu_fault_param {
+	iommu_dev_fault_handler_t handler;
+	void *data;
+};
+
+/**
+ * struct iommu_param - collection of per-device IOMMU data
+ *
+ * @fault_param: IOMMU detected device fault reporting data
+ *
+ * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
+ *	struct iommu_group	*iommu_group;
+ *	struct iommu_fwspec	*iommu_fwspec;
+ */
+struct iommu_param {
+	struct iommu_fault_param *fault_param;
+};
+
 int  iommu_device_register(struct iommu_device *iommu);
 void iommu_device_unregister(struct iommu_device *iommu);
 int  iommu_device_sysfs_add(struct iommu_device *iommu,
@@ -418,6 +464,7 @@ struct iommu_ops {};
 struct iommu_group {};
 struct iommu_fwspec {};
 struct iommu_device {};
+struct iommu_fault_param {};
 
 static inline bool iommu_present(struct bus_type *bus)
 {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
new file mode 100644
index 000000000000..7ebf23ed6ccb
--- /dev/null
+++ b/include/uapi/linux/iommu.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * IOMMU user API definitions
+ */
+
+#ifndef _UAPI_IOMMU_H
+#define _UAPI_IOMMU_H
+
+#include <linux/types.h>
+
+/*  Generic fault types, can be expanded IRQ remapping fault */
+enum iommu_fault_type {
+	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
+	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
+};
+
+enum iommu_fault_reason {
+	IOMMU_FAULT_REASON_UNKNOWN = 0,
+
+	/* Could not access the PASID table (fetch caused external abort) */
+	IOMMU_FAULT_REASON_PASID_FETCH,
+
+	/* pasid entry is invalid or has configuration errors */
+	IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
+
+	/*
+	 * PASID is out of range (e.g. exceeds the maximum PASID
+	 * supported by the IOMMU) or disabled.
+	 */
+	IOMMU_FAULT_REASON_PASID_INVALID,
+
+	/*
+	 * An external abort occurred fetching (or updating) a translation
+	 * table descriptor
+	 */
+	IOMMU_FAULT_REASON_WALK_EABT,
+
+	/*
+	 * Could not access the page table entry (Bad address),
+	 * actual translation fault
+	 */
+	IOMMU_FAULT_REASON_PTE_FETCH,
+
+	/* Protection flag check failed */
+	IOMMU_FAULT_REASON_PERMISSION,
+
+	/* access flag check failed */
+	IOMMU_FAULT_REASON_ACCESS,
+
+	/* Output address of a translation stage caused Address Size fault */
+	IOMMU_FAULT_REASON_OOR_ADDRESS,
+};
+
+/**
+ * Unrecoverable fault data
+ * @reason: reason of the fault
+ * @addr: offending page address
+ * @fetch_addr: address that caused a fetch abort, if any
+ * @pasid: contains process address space ID, used in shared virtual memory
+ * @perm: Requested permission access using by the incoming transaction
+ *	IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
+ */
+struct iommu_fault_unrecoverable {
+	__u32	reason; /* enum iommu_fault_reason */
+#define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
+#define IOMMU_FAULT_UNRECOV_PERM_VALID		(1 << 1)
+#define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 2)
+#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 3)
+	__u32	flags;
+	__u32	pasid;
+#define IOMMU_FAULT_PERM_WRITE	(1 << 0) /* write */
+#define IOMMU_FAULT_PERM_EXEC	(1 << 1) /* exec */
+#define IOMMU_FAULT_PERM_PRIV	(1 << 2) /* priviledged */
+#define IOMMU_FAULT_PERM_INST	(1 << 3) /* instruction */
+	__u32	perm;
+	__u64	addr;
+	__u64	fetch_addr;
+};
+
+/*
+ * Page Request data (aka. recoverable fault data)
+ * @flags : encodes whether the pasid is valid and whether this
+ * is the last page in group
+ * @pasid: pasid
+ * @grpid: page request group index
+ * @perm: requested page permissions
+ * @addr: page address
+ */
+struct iommu_fault_page_request {
+#define IOMMU_FAULT_PAGE_REQUEST_PASID_PRESENT	(1 << 0)
+#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
+#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
+	__u32   flags;
+	__u32	pasid;
+	__u32	grpid;
+	__u32	perm;
+	__u64	addr;
+	__u64	private_data[2];
+};
+
+/**
+ * struct iommu_fault - Generic fault data
+ *
+ * @type contains fault type
+ */
+
+struct iommu_fault {
+	__u32	type;   /* enum iommu_fault_type */
+	__u32	reserved;
+	union {
+		struct iommu_fault_unrecoverable event;
+		struct iommu_fault_page_request prm;
+	};
+};
+#endif /* _UAPI_IOMMU_H */
-- 
2.20.1

