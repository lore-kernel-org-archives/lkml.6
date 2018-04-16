Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx49/8Wqm0vATEg5H370T8fWjAWGfJ+144PTQZJpRPyCfYCLNiJcJy8BVrh76Pgarr796kyOd
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=UgK+NncrM6Bn9gJirV0FYcDYq+ZttHU7XcMyApK60OiiC21s9F3RxVHdcw+8bYsXm4
         KrFw7WWTqF7wv4laRv0eyljhf5oXA4DlTgGTMlX0uRJmowK3Sb9XvniGRVnIbSR7dOYj
         oC3OMr44UXIVqI1WH9ww82hHJ06LWvdA3Tgwbe61MitJ6Q4+WZy7DeeZeOivSJv85MKG
         lCBpH2QivmFgUDz1sBFy7nMynThOOC+yxi/ONeq7uOMiwOmbCpt4iO6oD37Sl2lr7SVc
         cFsl1s4RNWCWjOo+MU6SUh5zpfx0+1EHg3esJbpCQJbONmv34KukRcboI7n+bq5f/ho/
         nI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HP/yZ4J4vhWuhFM/p6O3b0xFYugGA6aBTIPbyydhgoo=;
        b=JdTroaELEHvWTCN20ZN+qLb5txCWBA0AWcuWWFazgH5z8Ay2KOb8icAw6mNdztU5SZ
         asP5BzQIw1rHruGIXqUtPgfudS6fmjbEnJvJuySN9PYSrVu01FeljDP0U+TXjBHChCYQ
         v5KdLuDeSzliFcR610lNUskqi/OZ/Cdw7UU28rEL7vC1lWAlBOLSf8c567RXKQIswgbE
         8YS0b+aOjEmrQmbKEss0OU3zM3YJJH1/LtSm2XLXr1tl2CVy3/k+mVODAXNV2TPg9Zcs
         JnV4Bytn0B6xVxTZysJdnSEdxa3PoPHami++r/bj4cPv2j7JuzSuaXfWG72WeodIepQ+
         iIdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740172"
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
Subject: [PATCH v4 12/22] iommu: introduce device fault report API
Date: Mon, 16 Apr 2018 14:49:01 -0700
Message-Id: <1523915351-54415-13-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910650455321?=
X-GMAIL-MSGID: =?utf-8?q?1597940910650455321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Traditionally, device specific faults are detected and handled within
their own device drivers. When IOMMU is enabled, faults such as DMA
related transactions are detected by IOMMU. There is no generic
reporting mechanism to report faults back to the in-kernel device
driver or the guest OS in case of assigned devices.

Faults detected by IOMMU is based on the transaction's source ID which
can be reported at per device basis, regardless of the device type is a
PCI device or not.

The fault types include recoverable (e.g. page request) and
unrecoverable faults(e.g. access error). In most cases, faults can be
handled by IOMMU drivers internally. The primary use cases are as
follows:
1. page request fault originated from an SVM capable device that is
assigned to guest via vIOMMU. In this case, the first level page tables
are owned by the guest. Page request must be propagated to the guest to
let guest OS fault in the pages then send page response. In this
mechanism, the direct receiver of IOMMU fault notification is VFIO,
which can relay notification events to QEMU or other user space
software.

2. faults need more subtle handling by device drivers. Other than
simply invoke reset function, there are needs to let device driver
handle the fault with a smaller impact.

This patchset is intended to create a generic fault report API such
that it can scale as follows:
- all IOMMU types
- PCI and non-PCI devices
- recoverable and unrecoverable faults
- VFIO and other other in kernel users
- DMA & IRQ remapping (TBD)
The original idea was brought up by David Woodhouse and discussions
summarized at https://lwn.net/Articles/608914/.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h |  35 +++++++++++-
 2 files changed, 179 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 784e019..de19c33 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -581,6 +581,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 		goto err_free_name;
 	}
 
+	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
+	if (!dev->iommu_param) {
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+	mutex_init(&dev->iommu_param->lock);
+
 	kobject_get(group->devices_kobj);
 
 	dev->iommu_group = group;
@@ -611,6 +618,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_unlock(&group->mutex);
 	dev->iommu_group = NULL;
 	kobject_put(group->devices_kobj);
+	kfree(dev->iommu_param);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
@@ -657,7 +665,7 @@ void iommu_group_remove_device(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
 	trace_remove_device_from_group(group->id, dev);
-
+	kfree(dev->iommu_param);
 	kfree(device->name);
 	kfree(device);
 	dev->iommu_group = NULL;
@@ -792,6 +800,143 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
 EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
 
 /**
+ * iommu_register_device_fault_handler() - Register a device fault handler
+ * @dev: the device
+ * @handler: the fault handler
+ * @data: private data passed as argument to the handler
+ *
+ * When an IOMMU fault event is received, call this handler with the fault event
+ * and data as argument. The handler should return 0. If the fault is
+ * recoverable (IOMMU_FAULT_PAGE_REQ), the handler must also complete
+ * the fault by calling iommu_page_response() with one of the following
+ * response code:
+ * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
+ * - IOMMU_PAGE_RESP_INVALID: terminate the fault
+ * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
+ *   page faults if possible.
+ *
+ * Return 0 if the fault handler was installed successfully, or an error.
+ */
+int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data)
+{
+	struct iommu_param *param = dev->iommu_param;
+
+	/*
+	 * Device iommu_param should have been allocated when device is
+	 * added to its iommu_group.
+	 */
+	if (!param)
+		return -EINVAL;
+
+	/* Only allow one fault handler registered for each device */
+	if (param->fault_param)
+		return -EBUSY;
+
+	mutex_lock(&param->lock);
+	get_device(dev);
+	param->fault_param =
+		kzalloc(sizeof(struct iommu_fault_param), GFP_ATOMIC);
+	if (!param->fault_param) {
+		put_device(dev);
+		mutex_unlock(&param->lock);
+		return -ENOMEM;
+	}
+	mutex_init(&param->fault_param->lock);
+	param->fault_param->handler = handler;
+	param->fault_param->data = data;
+	INIT_LIST_HEAD(&param->fault_param->faults);
+
+	mutex_unlock(&param->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
+
+/**
+ * iommu_unregister_device_fault_handler() - Unregister the device fault handler
+ * @dev: the device
+ *
+ * Remove the device fault handler installed with
+ * iommu_register_device_fault_handler().
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	struct iommu_param *param = dev->iommu_param;
+	int ret = 0;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->lock);
+	/* we cannot unregister handler if there are pending faults */
+	if (list_empty(&param->fault_param->faults)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	list_del(&param->fault_param->faults);
+	kfree(param->fault_param);
+	param->fault_param = NULL;
+	put_device(dev);
+
+unlock:
+	mutex_unlock(&param->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
+
+
+/**
+ * iommu_report_device_fault() - Report fault event to device
+ * @dev: the device
+ * @evt: fault event data
+ *
+ * Called by IOMMU model specific drivers when fault is detected, typically
+ * in a threaded IRQ handler.
+ *
+ * Return 0 on success, or an error.
+ */
+int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	int ret = 0;
+	struct iommu_fault_event *evt_pending;
+	struct iommu_fault_param *fparam;
+
+	/* iommu_param is allocated when device is added to group */
+	if (!dev->iommu_param | !evt)
+		return -EINVAL;
+	/* we only report device fault if there is a handler registered */
+	mutex_lock(&dev->iommu_param->lock);
+	if (!dev->iommu_param->fault_param ||
+		!dev->iommu_param->fault_param->handler) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	fparam = dev->iommu_param->fault_param;
+	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
+		evt_pending = kzalloc(sizeof(*evt_pending), GFP_ATOMIC);
+		if (!evt_pending) {
+			ret = -ENOMEM;
+			goto done_unlock;
+		}
+		memcpy(evt_pending, evt, sizeof(struct iommu_fault_event));
+		mutex_lock(&fparam->lock);
+		list_add_tail(&evt_pending->list, &fparam->faults);
+		mutex_unlock(&fparam->lock);
+	}
+	ret = fparam->handler(evt, fparam->data);
+done_unlock:
+	mutex_unlock(&dev->iommu_param->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_fault);
+
+/**
  * iommu_group_id - Return ID for a group
  * @group: the group to ID
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8968933..32435f9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -307,7 +307,8 @@ enum iommu_fault_reason {
  * and PASID spec.
  * - Un-recoverable faults of device interest
  * - DMA remapping and IRQ remapping faults
-
+ *
+ * @list pending fault event list, used for tracking responses
  * @type contains fault type.
  * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
  *         faults are not reported
@@ -325,6 +326,7 @@ enum iommu_fault_reason {
  *                 sending the fault response.
  */
 struct iommu_fault_event {
+	struct list_head list;
 	enum iommu_fault_type type;
 	enum iommu_fault_reason reason;
 	u64 addr;
@@ -341,10 +343,13 @@ struct iommu_fault_event {
  * struct iommu_fault_param - per-device IOMMU fault data
  * @dev_fault_handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
- *
+ * @faults: holds the pending faults which needs response, e.g. page response.
+ * @lock: protect pending PRQ event list
  */
 struct iommu_fault_param {
 	iommu_dev_fault_handler_t handler;
+	struct list_head faults;
+	struct mutex lock;
 	void *data;
 };
 
@@ -358,6 +363,7 @@ struct iommu_fault_param {
  *	struct iommu_fwspec	*iommu_fwspec;
  */
 struct iommu_param {
+	struct mutex lock;
 	struct iommu_fault_param *fault_param;
 };
 
@@ -457,6 +463,14 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
 extern int iommu_group_unregister_notifier(struct iommu_group *group,
 					   struct notifier_block *nb);
+extern int iommu_register_device_fault_handler(struct device *dev,
+					iommu_dev_fault_handler_t handler,
+					void *data);
+
+extern int iommu_unregister_device_fault_handler(struct device *dev);
+
+extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
+
 extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
@@ -728,6 +742,23 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
 	return 0;
 }
 
+static inline int iommu_register_device_fault_handler(struct device *dev,
+						iommu_dev_fault_handler_t handler,
+						void *data)
+{
+	return 0;
+}
+
+static inline int iommu_unregister_device_fault_handler(struct device *dev)
+{
+	return 0;
+}
+
+static inline int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
+{
+	return 0;
+}
+
 static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
-- 
2.7.4
