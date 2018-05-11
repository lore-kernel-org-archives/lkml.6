Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpQgbVRrXF3yrD0q7Krl+8gK2zLasdVIgxZr1uaOBfDOM+xG8rFo+37R8THfB1QvPgETmu8
ARC-Seal: i=1; a=rsa-sha256; t=1526071894; cv=none;
        d=google.com; s=arc-20160816;
        b=rewhMZqh61XlI40fQTShGJNxNv95p9tjWdrClZu47NHLqn5AVFskfBnUWDJFzaD8ly
         5HVEvovLthfsCpXkmHeZvX3LmXdWH9OFT4LsWJAc3KJ9z1iNHNXjSaEWBBSQinYdFsPs
         jAqievrl/PvkAOLhQcW10EFlocTZaYBmp0LmCBNVNTed+MlK/xC9+GI8i9TdDZpHj6h9
         XHFs/o/4DT2pSrKboBevim7k55/FmGrExPddfFsi52JXqw+Mvp2/z0iVw6qWZBt4slTw
         ysLd+zQ+CmpbpiJbp8yGL8pKu+Rz+nTIWaKLcTPq0C58VJ7ejvZvxIyskDnCD6Vo+PUR
         K3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=k8HlgqbZNTJ0K85av21Lro1Vm78ce/2hS2GklHHeeuc=;
        b=QMjvU6lRZXNQWBimBpET4ad2tkQadhnTmmjI6pVAuYYb2j57al9kUJsXjJDYj6A3QG
         vJB1YpgOMMEUkoP4OTof/IjsjeDgZvpq3IOwKRNrU6aqpq9cCDJJ6xcnf+8MtcProcEo
         WrUdG7kg0ZFKHdp6VYSj/NZexxbBUOhFGXhSlVpxjtUQOUGOxxtfA9sRKgH/oSVpnixT
         dwys8acT64maEJHLgQ7gSz5xIGYh/m2Ekv6tNQKNgJ7YbaYFhg2Ff0Hf9szTqkmErNUi
         QmNU4BgBQkp3xkcJmVA4GagOHlfCwNiCIDhHne8ruiyLr/conxBsuoLI9gi+LyTQ0WXg
         MMOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104775"
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 14/23] iommu: introduce page response function
Date: Fri, 11 May 2018 13:54:06 -0700
Message-Id: <1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362922375846?=
X-GMAIL-MSGID: =?utf-8?q?1600202362922375846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

IO page faults can be handled outside IOMMU subsystem. For an example,
when nested translation is turned on and guest owns the
first level page tables, device page request can be forwared
to the guest for handling faults. As the page response returns
by the guest, IOMMU driver on the host need to process the
response which informs the device and completes the page request
transaction.

This patch introduces generic API function for page response
passing from the guest or other in-kernel users. The definitions of
the generic data is based on PCI ATS specification not limited to
any vendor.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2017/12/7/1725
---
 drivers/iommu/iommu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b3f9daf..02fed3e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1533,6 +1533,51 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
 
+int iommu_page_response(struct device *dev,
+			struct page_response_msg *msg)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = -EINVAL;
+	struct iommu_fault_event *evt;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !domain->ops->page_response)
+		return -ENODEV;
+
+	/*
+	 * Device iommu_param should have been allocated when device is
+	 * added to its iommu_group.
+	 */
+	if (!param || !param->fault_param)
+		return -EINVAL;
+
+	/* Only send response if there is a fault report pending */
+	mutex_lock(&param->fault_param->lock);
+	if (list_empty(&param->fault_param->faults)) {
+		pr_warn("no pending PRQ, drop response\n");
+		goto done_unlock;
+	}
+	/*
+	 * Check if we have a matching page request pending to respond,
+	 * otherwise return -EINVAL
+	 */
+	list_for_each_entry(evt, &param->fault_param->faults, list) {
+		if (evt->pasid == msg->pasid &&
+		    msg->page_req_group_id == evt->page_req_group_id) {
+			msg->private_data = evt->iommu_private;
+			ret = domain->ops->page_response(dev, msg);
+			list_del(&evt->list);
+			kfree(evt);
+			break;
+		}
+	}
+
+done_unlock:
+	mutex_unlock(&param->fault_param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_page_response);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3312ee..722b90f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,41 @@ struct iommu_resv_region {
 #ifdef CONFIG_IOMMU_API
 
 /**
+ * enum page_response_code - Return status of fault handlers, telling the IOMMU
+ * driver how to proceed with the fault.
+ *
+ * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum page_response_code {
+	IOMMU_PAGE_RESP_SUCCESS = 0,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * Generic page response information based on PCI ATS and PASID spec.
+ * @addr: servicing page address
+ * @pasid: contains process address space ID
+ * @resp_code: response code
+ * @page_req_group_id: page request group index
+ * @private_data: uniquely identify device-specific private data for an
+ *                individual page response
+ */
+struct page_response_msg {
+	u64 addr;
+	u32 pasid;
+	enum page_response_code resp_code;
+	u32 pasid_present:1;
+	u32 page_req_group_id;
+	u64 private_data;
+};
+
+/**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
  * @domain_alloc: allocate iommu domain
@@ -195,6 +230,7 @@ struct iommu_resv_region {
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  * @sva_invalidate: invalidate translation caches of shared virtual address
+ * @page_response: handle page request response
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -250,6 +286,7 @@ struct iommu_ops {
 				struct device *dev);
 	int (*sva_invalidate)(struct iommu_domain *domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);
+	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
 };
@@ -470,6 +507,7 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
 
+extern int iommu_page_response(struct device *dev, struct page_response_msg *msg);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -758,6 +796,11 @@ static inline int iommu_report_device_fault(struct device *dev, struct iommu_fau
 	return -ENODEV;
 }
 
+static inline int iommu_page_response(struct device *dev, struct page_response_msg *msg)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4
