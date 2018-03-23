Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELuc4lYI1YcEA4pcb+R+v/24eNOMWPS2oy49MuJaculoit2cHVGY+7TRtE9Gk6Fny9F+W7g9
ARC-Seal: i=1; a=rsa-sha256; t=1521774601; cv=none;
        d=google.com; s=arc-20160816;
        b=ZMNoKJxV2X8WEFgIDZQaLzzGO2HWnjcM8jNEwNX5pN2lqpMFhguu2MZh9P3JYxNy5q
         LqHaxEErjc+AGehL76xeU6pbKa+J1mg8fXb1tJoyRlxVJuUUP0D3ZAa1hSCUKDvgY1kY
         YaEVmaNuVcLzSuHfue7OBDmwlu57sbj6ozS5KFqx8hbQ9TOJ9IDYKgH7c1lwt5xIPoVB
         xJiDYxUyc1NljyVvFMGddGKOiN9GmnELqRbkZR5COFkj/kK8C7nRdlQbyRNc3AVk6Oa2
         hSWAm8fIf23tM7JyNPCA/iF2Ww4ZqsE2jXASTUsqL9cJZIWUPuwh26nsckJ6djJjx86+
         VzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Am1UNEqxSb22LWv+ZeUN61XQXPS00u/qmuyeIIwD8nQ=;
        b=V1/ToHeq/jBs4PqOqPl7KUzFa7BUcOK99SqQpxNJxocZpW/i7YygOon7Yvf8BiGmT7
         aGQEvF4xsB1gBVU1wBa6Ua3DxfnIfthPyLeALKv0Vkysj6SQ6ZLcMYz/V4NmrYTKANdO
         uxDjOAXlyAbqA0Hk2hClHbPZWp1gdpfLVwUT8OFWh85IN6HHF6g/yFYD28uuwO8LcknR
         hBvFCd2SXGUvO+A463hcDTwhz0/aThBvUOsDibZKoo9N1w15q4xo1CSMLz+0JsW4N7UU
         4GTP40R+wPD3H54+1hf4o4SerwHYYq0hFSzcSV6V0/d5R2IP6fPCsXJovtIkYJEZ7pdb
         wK1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315941"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Liu,
	Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH v4 01/22] iommu: introduce bind_pasid_table API function
Date: Thu, 22 Mar 2018 20:11:53 -0700
Message-Id: <1521774734-48433-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696325106747798?=
X-GMAIL-MSGID: =?utf-8?q?1595696325106747798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
use in the guest:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html

As part of the proposed architecture, when an SVM capable PCI
device is assigned to a guest, nested mode is turned on. Guest owns the
first level page tables (request with PASID) which performs GVA->GPA
translation. Second level page tables are owned by the host for GPA->HPA
translation for both request with and without PASID.

A new IOMMU driver interface is therefore needed to perform tasks as
follows:
* Enable nested translation and appropriate translation type
* Assign guest PASID table pointer (in GPA) and size to host IOMMU

This patch introduces new API functions to perform bind/unbind guest PASID
tables. Based on common data, model specific IOMMU drivers can be extended
to perform the specific steps for binding pasid table of assigned devices.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c      | 19 +++++++++++++++++++
 include/linux/iommu.h      | 24 ++++++++++++++++++++++++
 include/uapi/linux/iommu.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69fef99..734ed09 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1325,6 +1325,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
+			struct pasid_table_config *pasidt_binfo)
+{
+	if (unlikely(!domain->ops->bind_pasid_table))
+		return -ENODEV;
+
+	return domain->ops->bind_pasid_table(domain, dev, pasidt_binfo);
+}
+EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
+
+void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
+{
+	if (unlikely(!domain->ops->unbind_pasid_table))
+		return;
+
+	domain->ops->unbind_pasid_table(domain, dev);
+}
+EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..0f6f6c5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -187,6 +188,8 @@ struct iommu_resv_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @bind_pasid_table: bind pasid table pointer for guest SVM
+ * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -233,8 +236,14 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
+
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	int (*bind_pasid_table)(struct iommu_domain *domain, struct device *dev,
+				struct pasid_table_config *pasidt_binfo);
+	void (*unbind_pasid_table)(struct iommu_domain *domain,
+				struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -296,6 +305,10 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_bind_pasid_table(struct iommu_domain *domain,
+		struct device *dev, struct pasid_table_config *pasidt_binfo);
+extern void iommu_unbind_pasid_table(struct iommu_domain *domain,
+				struct device *dev);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
@@ -696,6 +709,17 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline
+int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
+			struct pasid_table_config *pasidt_binfo)
+{
+	return -EINVAL;
+}
+static inline
+void iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
+{
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
new file mode 100644
index 0000000..9f7a6bf
--- /dev/null
+++ b/include/uapi/linux/iommu.h
@@ -0,0 +1,32 @@
+/*
+ * IOMMU user API definitions
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _UAPI_IOMMU_H
+#define _UAPI_IOMMU_H
+
+#include <linux/types.h>
+
+/**
+ * PASID table data used to bind guest PASID table to the host IOMMU. This will
+ * enable guest managed first level page tables.
+ * @version: for future extensions and identification of the data format
+ * @bytes: size of this structure
+ * @base_ptr:	PASID table pointer
+ * @pasid_bits:	number of bits supported in the guest PASID table, must be less
+ *		or equal than the host supported PASID size.
+ */
+struct pasid_table_config {
+	__u32 version;
+#define PASID_TABLE_CFG_VERSION 1
+	__u32 bytes;
+	__u64 base_ptr;
+	__u8 pasid_bits;
+};
+
+#endif /* _UAPI_IOMMU_H */
-- 
2.7.4
