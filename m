Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZo09Myxpm2ouu4Yb7+ZAZwRPXxIm3YJvsKAsFCeObXTT7sGjRIpN5HXBPGwGdDOUK3dG0IN
ARC-Seal: i=1; a=rsa-sha256; t=1526071892; cv=none;
        d=google.com; s=arc-20160816;
        b=lhZDzvoreqnlO9AVHjdPONxCqazbQoaqhbZKN033ms1PQzHGazRWpuzisa1Zlbrh/F
         OT1H1jLHOKbyzTCsXyJYxlKbka7gWWLZ5alj/EsNt+7b2uPeJ6WBbVGytnbz7j/TIIAC
         U9Cr8cco2nxMEDgA1Y8LnyPm/Lhc9e4qMux1F8O5D5mcVa4YrbjvCj1WIzY7firmvEEJ
         wC0Ya5AmOQWQxsXBiTGbPca+mlNLYayADm9nvZxB2oYs3WndDBGvPN0vT/cQNdm6QoC+
         bS1SpMstubaIOdrHd1P9zCPCsBGk1lYwp/eOcbAa/UNvQAyLJyDivaubvq/qo5/+l3Ko
         4/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Sfj8IR3fYALtJ+NXs2COknwR2U/7T7GscbIIY0ViY6g=;
        b=Leo0tA7dxy9+KjyezAKIhh0lGPya2AiNeUprLZIRT9RLL6vO8KQqixw84wtSikvtJ/
         6YLmhTEEyhnEEUN48vxfG9kfJ+WQFkxr6NC+zZMi1M3Be7lY4m1Ts0QYevoFNZZqh5/C
         KrUnZxV/BpiKwUj5Py5tmPvXvfzNWa1l8Oa8pNYXxsmt6JClyPqfnLEzc7kBEUZC879H
         IeRtUB9uRJ73N3R5gyZPxkj61jHrmkDadUqL9GDc0onmN36R0Zf2nXgb6dDNfAbz/uZn
         cOQisU3/A092hhBd9HfN+ZwmuHJ30uKhT2DVoFODY9UMDJkp//T5zbcW55j8lXV5xyFs
         0V3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104734"
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
Subject: [PATCH v5 02/23] iommu/vt-d: move device_domain_info to header
Date: Fri, 11 May 2018 13:53:54 -0700
Message-Id: <1526072055-86990-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202360814280773?=
X-GMAIL-MSGID: =?utf-8?q?1600202360814280773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allow both intel-iommu.c and dmar.c to access device_domain_info.
Prepare for additional per device arch data used in TLB flush function

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 18 ------------------
 include/linux/intel-iommu.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d60b2fb..a0f81a4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -391,24 +391,6 @@ struct dmar_domain {
 					   iommu core */
 };
 
-/* PCI domain-device relationship */
-struct device_domain_info {
-	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
-	u8 bus;			/* PCI bus number */
-	u8 devfn;		/* PCI devfn number */
-	u8 pasid_supported:3;
-	u8 pasid_enabled:1;
-	u8 pri_supported:1;
-	u8 pri_enabled:1;
-	u8 ats_supported:1;
-	u8 ats_enabled:1;
-	u8 ats_qdep;
-	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-	struct intel_iommu *iommu; /* IOMMU used by this device */
-	struct dmar_domain *domain; /* pointer to domain */
-};
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index eec4827..304afae 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -461,6 +461,25 @@ struct intel_iommu {
 	u32		flags;      /* Software defined flags */
 };
 
+/* PCI domain-device relationship */
+struct device_domain_info {
+	struct list_head link;	/* link to domain siblings */
+	struct list_head global; /* link to global list */
+	u8 bus;			/* PCI bus number */
+	u8 devfn;		/* PCI devfn number */
+	u8 pasid_supported:3;
+	u8 pasid_enabled:1;
+	u8 pri_supported:1;
+	u8 pri_enabled:1;
+	u8 ats_supported:1;
+	u8 ats_enabled:1;
+	u8 ats_qdep;
+	u64 fault_mask;	/* selected IOMMU faults to be reported */
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct intel_iommu *iommu; /* IOMMU used by this device */
+	struct dmar_domain *domain; /* pointer to domain */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
-- 
2.7.4
