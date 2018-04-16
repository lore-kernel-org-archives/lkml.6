Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/tPk5IOt5211CWBrmqOk3rdqGPbyqrGtmaHYkCJZpEJ2hLKAOSyKtx54QTGRMk9Ux0Tk1R
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=itJSFpfJCgxAbAn5gYVE+3lKVH8FN6LzKg6snrE0k7Mz2lBRM1ARyA/mwloaMAPeEu
         FTsrdWbqD8AWTGpLW3rw+nBnqCZWDDVKa+vmsILJfrJQo7TOZ0K16VFlxixTWYPKzMmW
         +pvoI7lAVRugn2Gi8MtYdtJzCiQN2WWl25aeA7S2S3Jfwl/g1sECE6DNG0T6Ftd/WtA0
         klBGWrDIBtF+02dSX1gcJGRvayAE176wpAfk3C4HxbeSQJ1ospLEbrLm4RJNMwKztjQr
         OPkV5kNN+Atm3qcYR5Hi7Cfp+GqnN4EdY8HPXnaAZ0i9cWxVJ6mCuB096gi1O5+ej9ih
         n/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pUMg7dkK+Ip/6yGTfmcAj52Jb1gH/zKClS+cbz7vDeE=;
        b=lcXy7lGyoBn7DqInXBwIh3UDYlUDzvOVXFFA0NvbeDGh9iztaa/MGOOJLDpn2O5lp/
         8RXRLN7qcadakFJIBSXBTiBwq8VchZ4aKCb1lGKoCG8DI6xuZnfy4hns9ePy9WKtM5db
         7+0OgNhzxzOp43eHO83giWvA9Qt6hCwiAPxFYvwmSj7zK/RA2iSQ8kSjQ113XR4TobRN
         QAYq33WYLCkw11DVbsGySxZ8uJlCKEXGFuRL3I4EtnUA5L17bki2CWn9GaEfJ3CIA7Vo
         1fJyj2mtHNwP+tWaENKvket0RrGsUBay8k6zfPy+T7I7gAk29ImnL6Clgc4rPG8lStIn
         dxOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740191"
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
Subject: [PATCH v4 18/22] iommu/intel-svm: replace dev ops with fault report API
Date: Mon, 16 Apr 2018 14:49:07 -0700
Message-Id: <1523915351-54415-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910386934133?=
X-GMAIL-MSGID: =?utf-8?q?1597940910386934133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the introduction of generic IOMMU device fault reporting API, we
can replace the private fault callback functions with standard function
and event data.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c |  7 +------
 include/linux/intel-svm.h | 20 +++-----------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a8186f8..bdda1b6 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -299,7 +299,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 
-int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
+int intel_svm_bind_mm(struct device *dev, int *pasid, int flags)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
 	struct intel_svm_dev *sdev;
@@ -346,10 +346,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 
 			list_for_each_entry(sdev, &svm->devs, list) {
 				if (dev == sdev->dev) {
-					if (sdev->ops != ops) {
-						ret = -EBUSY;
-						goto out;
-					}
 					sdev->users++;
 					goto success;
 				}
@@ -375,7 +371,6 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	}
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
-	sdev->ops = ops;
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 99bc5b3..a39a502 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -18,18 +18,6 @@
 
 struct device;
 
-struct svm_dev_ops {
-	void (*fault_cb)(struct device *dev, int pasid, u64 address,
-			 u32 private, int rwxp, int response);
-};
-
-/* Values for rxwp in fault_cb callback */
-#define SVM_REQ_READ	(1<<3)
-#define SVM_REQ_WRITE	(1<<2)
-#define SVM_REQ_EXEC	(1<<1)
-#define SVM_REQ_PRIV	(1<<0)
-
-
 /*
  * The SVM_FLAG_PRIVATE_PASID flag requests a PASID which is *not* the "main"
  * PASID for the current process. Even if a PASID already exists, a new one
@@ -60,7 +48,6 @@ struct svm_dev_ops {
  * @dev:	Device to be granted acccess
  * @pasid:	Address for allocated PASID
  * @flags:	Flags. Later for requesting supervisor mode, etc.
- * @ops:	Callbacks to device driver
  *
  * This function attempts to enable PASID support for the given device.
  * If the @pasid argument is non-%NULL, a PASID is allocated for access
@@ -82,8 +69,7 @@ struct svm_dev_ops {
  * Multiple calls from the same process may result in the same PASID
  * being re-used. A reference count is kept.
  */
-extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
-			     struct svm_dev_ops *ops);
+extern int intel_svm_bind_mm(struct device *dev, int *pasid, int flags);
 
 /**
  * intel_svm_unbind_mm() - Unbind a specified PASID
@@ -120,7 +106,7 @@ extern int intel_svm_is_pasid_valid(struct device *dev, int pasid);
 #else /* CONFIG_INTEL_IOMMU_SVM */
 
 static inline int intel_svm_bind_mm(struct device *dev, int *pasid,
-				    int flags, struct svm_dev_ops *ops)
+				int flags)
 {
 	return -ENOSYS;
 }
@@ -136,6 +122,6 @@ static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
-#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))
+#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0))
 
 #endif /* __INTEL_SVM_H__ */
-- 
2.7.4
