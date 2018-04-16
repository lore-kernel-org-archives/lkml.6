Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx487HUuMEk2JFqRZHxUkyK1XCU46Zx96JEl6idQ65/IEG2zd6KOw9cocgIk3oL7XOMzpd5+a
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=ju0saFanNg/YN32yquViKc1xYZFP5IbQTQpfFFETHKu8xcFsXRBnEJjlISwglmgJ6I
         aiD8Ce/iavt5XmJK3Z2y7QAo1kIbdg4SY1Wa0p2uKb9OsNymNgMUCWNUkNat3TdQr/Ad
         gD17cDXoXkB0MdieT4OYIYGr0eVvyd+XPu4w2rEuNzcwQ+Uu/ClJ7DNwatFMvrLLOSPz
         9bRbQMpJs8VrTFtn3fhDS1rNN99UDFCTHmlboHv1y7wn3y0xrqIG9gKwKf2XeDiIQ/84
         Z6M0+koVpdoFAXa00U4CKC+rlg+LqPVxW3wgrr2cvmzZBWSIMs0n8B3BAceUc829cuey
         bljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kGWkAT+qqa5o1ERwMsQZWxaly+UaPiwTE2S28Q1EIdA=;
        b=bPRB8egZGT2Z4niOiBW8hZREleo8OWTCf/xjkn2f+rc5aG0ZAJM4jgIZifuHMCHBUW
         Y+uLkZHzoreLTcb7eMTy/Ehddj/CdPs3WhB4TBz3Q0dBW6jkxR1HHVAxXQ4MwqZEOzOp
         GXqtYvfn4JEln9AY0Kdu2fK+zsXjvY4n3mMEq2MpYSikGAvPjdFm8JVjnW3DmuH9L1C5
         nUS0/LJ2D/6yEjChrYvlvH6f/FNr33GeJlUa+S4iqyVODZbK6xYZlojbEPw1MW5U6KfP
         hKGnhjxZfE5sRZ4QNzmi1WjSe6G9aDzm+fNjwgJA3ggHtSztkxl5NbDkRqaOu492LRrh
         YGPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740175"
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
Subject: [PATCH v4 13/22] iommu: introduce page response function
Date: Mon, 16 Apr 2018 14:49:02 -0700
Message-Id: <1523915351-54415-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910346286875?=
X-GMAIL-MSGID: =?utf-8?q?1597940910346286875?=
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
index de19c33..628346c 100644
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
index 32435f9..058b552 100644
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
