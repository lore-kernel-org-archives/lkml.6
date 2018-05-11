Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrgjrA41W8uNUooj1om1V0W3uImDMa3T4q98bFaJSrLPHWAV5x8Iz5353hAdg5mPsCk6FRl
ARC-Seal: i=1; a=rsa-sha256; t=1526071894; cv=none;
        d=google.com; s=arc-20160816;
        b=KMmUi+jFxnadTGwMlhC6sfWlcPKuug3r8yQYRPofyFjZexFewLmNYknkSEwFtnaKg6
         G4utwf9lMaxkG3qK0PikzgPXCs6LfjZbQLYRtFhTYZOK0S3PpE5o46jiCaAePzQPsyVS
         Tyf9qGfpkDFafYyP2IyXLlgFII7Hf0Kroa4yOreyi9z7hvCczdqzuZukg6pEa8TJMgk2
         LfsemPbjjrVV0XtSCUV7ebRt8cP4AFU6NMQyLUt80Gz/gAKxNkGBCxYFPFmEBE5HS2D3
         6Uq1ZfcGILhAg3p7/xcm0z1fs/iCPzQJGcZ8EtqkvUJAbxMffxmMAOoYZlgSd5YyrLgd
         sG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2plaEW/xN6O1KEU5AouOPCqAq97YW9rF5G91gPEEDbI=;
        b=KPs1n34fuWfLX2f6m2l8nVmMQMNTt6glciOjnmnIWmcsg4JtIyOv6Jzrbe0ajKzFUA
         ep0nuYkW5gNhPLko4llK254ajPrQGQ6pyLjC4bnJPD/kQwJuMAo/mA0/LmSlTtlOUDuC
         +xOjewpOH/B+pdymPjbEc65xVrcdMn8lTR+U0JFQwbuy9LpYcgo11//qMgRcZhDM1Uhm
         8q4eXmZue2zEUycGwl949YEt3wmjS7WyyFGsCK6H3zkJaVc0cjEycdrfjG7Fhv4wQY14
         h6irj4R7023woI+fX2Rk0OzIyLqhkCxHid/dFDB8Ce1r0j2g1Scs5nbvbp27KPqsSpYP
         MvhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104762"
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
Subject: [PATCH v5 10/23] iommu: introduce device fault data
Date: Fri, 11 May 2018 13:54:02 -0700
Message-Id: <1526072055-86990-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362595248229?=
X-GMAIL-MSGID: =?utf-8?q?1600202362595248229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Device faults detected by IOMMU can be reported outside IOMMU
subsystem for further processing. This patch intends to provide
a generic device fault data such that device drivers can be
communicated with IOMMU faults without model specific knowledge.

The proposed format is the result of discussion at:
https://lkml.org/lkml/2017/11/10/291
Part of the code is based on Jean-Philippe Brucker's patchset
(https://patchwork.kernel.org/patch/9989315/).

The assumption is that model specific IOMMU driver can filter and
handle most of the internal faults if the cause is within IOMMU driver
control. Therefore, the fault reasons can be reported are grouped
and generalized based common specifications such as PCI ATS.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 include/linux/iommu.h | 101 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e8cadb6..aeadb4f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -49,13 +49,17 @@ struct bus_type;
 struct device;
 struct iommu_domain;
 struct notifier_block;
+struct iommu_fault_event;
 
 /* iommu fault flags */
-#define IOMMU_FAULT_READ	0x0
-#define IOMMU_FAULT_WRITE	0x1
+#define IOMMU_FAULT_READ		(1 << 0)
+#define IOMMU_FAULT_WRITE		(1 << 1)
+#define IOMMU_FAULT_EXEC		(1 << 2)
+#define IOMMU_FAULT_PRIV		(1 << 3)
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
+typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -264,6 +268,98 @@ struct iommu_device {
 	struct device *dev;
 };
 
+/*  Generic fault types, can be expanded IRQ remapping fault */
+enum iommu_fault_type {
+	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
+	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
+};
+
+enum iommu_fault_reason {
+	IOMMU_FAULT_REASON_UNKNOWN = 0,
+
+	/* IOMMU internal error, no specific reason to report out */
+	IOMMU_FAULT_REASON_INTERNAL,
+
+	/* Could not access the PASID table */
+	IOMMU_FAULT_REASON_PASID_FETCH,
+
+	/*
+	 * PASID is out of range (e.g. exceeds the maximum PASID
+	 * supported by the IOMMU) or disabled.
+	 */
+	IOMMU_FAULT_REASON_PASID_INVALID,
+
+	/* Could not access the page directory (Invalid PASID entry) */
+	IOMMU_FAULT_REASON_PGD_FETCH,
+
+	/* Could not access the page table entry (Bad address) */
+	IOMMU_FAULT_REASON_PTE_FETCH,
+
+	/* Protection flag check failed */
+	IOMMU_FAULT_REASON_PERMISSION,
+};
+
+/**
+ * struct iommu_fault_event - Generic per device fault data
+ *
+ * - PCI and non-PCI devices
+ * - Recoverable faults (e.g. page request), information based on PCI ATS
+ * and PASID spec.
+ * - Un-recoverable faults of device interest
+ * - DMA remapping and IRQ remapping faults
+
+ * @type contains fault type.
+ * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
+ *         faults are not reported
+ * @addr: tells the offending page address
+ * @pasid: contains process address space ID, used in shared virtual memory(SVM)
+ * @page_req_group_id: page request group index
+ * @last_req: last request in a page request group
+ * @pasid_valid: indicates if the PRQ has a valid PASID
+ * @prot: page access protection flag, e.g. IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
+ * @device_private: if present, uniquely identify device-specific
+ *                  private data for an individual page request.
+ * @iommu_private: used by the IOMMU driver for storing fault-specific
+ *                 data. Users should not modify this field before
+ *                 sending the fault response.
+ */
+struct iommu_fault_event {
+	enum iommu_fault_type type;
+	enum iommu_fault_reason reason;
+	u64 addr;
+	u32 pasid;
+	u32 page_req_group_id;
+	u32 last_req : 1;
+	u32 pasid_valid : 1;
+	u32 prot;
+	u64 device_private;
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
@@ -437,6 +533,7 @@ struct iommu_ops {};
 struct iommu_group {};
 struct iommu_fwspec {};
 struct iommu_device {};
+struct iommu_fault_param {};
 
 static inline bool iommu_present(struct bus_type *bus)
 {
-- 
2.7.4
