Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtazwWQ9v6DB1GsNkmCK9LWVFIbX365gtCK6YIUVH7+3tiCahURZGvLwxE66Y0XN3RxaCoz
ARC-Seal: i=1; a=rsa-sha256; t=1521774608; cv=none;
        d=google.com; s=arc-20160816;
        b=WC4/PZ2lYahOJyJ8Q0QTycN7BTZw+yief38PtcsWT/6XeWvL7oSuZqhMsGLC8TQ/R2
         Ho/ylM48T0HsS6f201ygmiEaaJ+2/Hgyeg7s5e8SO9F9igo+oIgVpWMtTgCbnbgdlUm6
         GU3kdL1QZqMjsOx+TQls625HFgqudvfxJcS5UCYTHcEgFo77mNlkN/aW4TLOibBF8Hoa
         I0NA/xIYxEaoFMs00yyO7SZ5+35bzccpmxIJHOPU6swLRjrzeVpECBqUQgq/YArb5BNo
         ucy1pDFa1D6SSvcBJAa5JQlYMH6XBw/E7JH9U2GoOnpakUjFIMCaMnZIwtIIlsp4HOOy
         5Rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GCvxOp9s/OBsfdvuTmBXFK++yOJl1CohmBNJSe0Fn9w=;
        b=slk6uhKxrRnjdUimTgzgN34xfJqaIJ/H30vEUrhIw9egCA7+on4QpQ0D70I6KA/QCG
         7kFbBmvAk5CwL6szees6G4ATijOQLBdifB3HK1+vKCFVsi7YEGSG4Jj+Y2BGuJPaYbrx
         2AnB2hTIMK6T2Q9bV3N+HCiOMWqfPt4C6Oc1gSNQu0ZvCd6kK9bef+ha4eBiUcTYJNRM
         eF7QNNSZU9VFJok0q4pCibffTbkabIc80i6+XBawZ6LxoDg/fDqXsCWyyok614/4CyqE
         gRYKzPw7JmKhMZeIqWkCtdcKapQp6NBoi+rJ2aTIZGu6/lAjY+rr2oGQhAuyYMeOZvFZ
         oCFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316017"
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 13/22] iommu: introduce page response function
Date: Thu, 22 Mar 2018 20:12:05 -0700
Message-Id: <1521774734-48433-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696332145721762?=
X-GMAIL-MSGID: =?utf-8?q?1595696332145721762?=
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
 drivers/iommu/iommu.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd653ff..42e8f00 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1503,6 +1503,51 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
 
+int iommu_page_response(struct device *dev,
+			struct page_response_msg *msg)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = -EINVAL;
+	struct iommu_fault_event *evt, *iter;
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
+	list_for_each_entry_safe(evt, iter, &param->fault_param->faults, list) {
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
index b89e881..af0e393 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,55 @@ struct iommu_resv_region {
 #ifdef CONFIG_IOMMU_API
 
 /**
+ * enum page_response_code - Return status of fault handlers, telling the IOMMU
+ * driver how to proceed with the fault.
+ *
+ * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent faults from
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't retry the
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum page_response_code {
+	IOMMU_PAGE_RESP_SUCCESS = 0,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * enum page_request_handle_t - Return page request/response handler status
+ *
+ * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do not send a
+ *	reply to the device.
+ * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the next handler,
+ *	or terminate.
+ */
+enum page_request_handle_t {
+	IOMMU_PAGE_RESP_HANDLED = 0,
+	IOMMU_PAGE_RESP_CONTINUE,
+};
+
+/**
+ * Generic page response information based on PCI ATS and PASID spec.
+ * @addr: servicing page address
+ * @pasid: contains process address space ID
+ * @resp_code: response code
+ * @page_req_group_id: page request group index
+ * @type: group or stream/single page response
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
@@ -195,6 +244,7 @@ struct iommu_resv_region {
  * @bind_pasid_table: bind pasid table pointer for guest SVM
  * @unbind_pasid_table: unbind pasid table pointer and restore defaults
  * @sva_invalidate: invalidate translation caches of shared virtual address
+ * @page_response: handle page request response
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -250,6 +300,7 @@ struct iommu_ops {
 				struct device *dev);
 	int (*sva_invalidate)(struct iommu_domain *domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);
+	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
 };
@@ -471,6 +522,7 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
 
+extern int iommu_page_response(struct device *dev, struct page_response_msg *msg);
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
-- 
2.7.4
