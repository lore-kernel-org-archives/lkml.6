Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrpDaF+eGEbGVuXSTxTY8hOfHjRxcvaE7lNJPQ4AaZZZR8pX1TjOHafvv1417IDscEa165v
ARC-Seal: i=1; a=rsa-sha256; t=1526071893; cv=none;
        d=google.com; s=arc-20160816;
        b=e6XdXuCD5kHhTr0ZdThQnnybSlceXGkufoIIZWKRzG/aVAunu/yOsOBU8ifxk9lOOC
         NTr/ieuYJMM/b5a+cI8nBM6gdg2iTqXSStTDd+3KUm9R34V8MGwisa0/xwuy38fYqIof
         t4wiG+xQjK+0kSi4IxXeBNYRrKfVUi9H5FCot43JCyyWztP5hsMTgTWhAqV6Xa1d52CV
         hekWxvI4cskWZCplpY7Hm7XdocaDTIlU7lO9h9O7z3aoarimBB7xwvUvpp5BMrxlkPu3
         cL+bcfw2smruMkW1AhzufEP7tnjbiJTUag9GsjlgRlTjYbEAbCl6t2rfGpOsdLp4X0G8
         LUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=X1IdWnSc1/XKhWwQYbpChNixAhIpAUgUBbvzd7a7t68=;
        b=ILbWP9qfTGlClW6M8mJptxMUeX1xp9WwrJI17vCgoryl6nqAlF1ajwUbsRCt4vJVvI
         CAhGXpCrpfCW9dmfEyKTNrKwNPvNGerIk4hzuVIR4KdW4ZsX3PW3wLTGIUgzVfgNk0Lz
         4T5J4f1xcrgMI4QZrheHD+Gu3jwEcd1xpTM4KXEMZqZ4Y94jabgI4lyoCeQSUS22iQMT
         9cHV54g657iyJXfqGgQpiw30M9XtpZ7n7Oy4YR+lGS6pAv0X0Q1dvJdlZgx6jNEUTYv+
         rU46vxb8GeJHKK5cdjAxYVQgL15TPlnPb4dCTxcl8MUaHj3wVUQAzwPSjxI87xBIZfa6
         QBHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104730"
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	"Christoph Hellwig" <hch@infradead.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Liu,
	Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Fri, 11 May 2018 13:53:53 -0700
Message-Id: <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361707330547?=
X-GMAIL-MSGID: =?utf-8?q?1600202361707330547?=
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
 include/uapi/linux/iommu.h | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 include/uapi/linux/iommu.h

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa2320..3a69620 100644
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
index 19938ee..5199ca4 100644
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
+	return -ENODEV;
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
index 0000000..cb2d625
--- /dev/null
+++ b/include/uapi/linux/iommu.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
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
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32 bytes;
+	__u64 base_ptr;
+	__u8 pasid_bits;
+};
+
+#endif /* _UAPI_IOMMU_H */
-- 
2.7.4
