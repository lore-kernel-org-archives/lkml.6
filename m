Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48qwChiZr8l4rChq7NJdVKd2t4ksr6ovG5DMbYTa+foTgmLQLKM59Kbjb+LLL6BBzeL1kag
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=0JzP0lpuY2XeVy3pex5b0GH2AN/QQznttQ4z2ek4Zh8kCqUjkbvb3JpB0Ent83UT+9
         XbcA/l+DYPIQ/mRH5U3yh0HzHTmGZxziJmkb4wzPwA84IhRt++APgLSZqvEbbk6kDPun
         bsfeWBaWrQxmFomTHzYnBAlkcCN43ydxa6W5d6DTPyLT8FWhYSLamhz3PoedGb7i2QNJ
         pVMBel66GkGNjNTjLjE7uJGj+nSQrkXLWXzSQr/CI1AOTI5+DRW10Yg6tOMS+S4eHAbV
         NxSghm1yuCdkzcybGI4JVvx/AY5jp/T6DrZZPkz8M3suhprqq0Q+aczbmpltq8z7vslI
         cokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Sfj8IR3fYALtJ+NXs2COknwR2U/7T7GscbIIY0ViY6g=;
        b=WuA72wjpry7086fuEF5dMqUUVqtIYkOcqeonVHDgicOfaSWt8Ltek48gUBGtaGLbNU
         HIR0M7FKFA63xkT4D4F8/T0yEzY3P2t+4rQ7fUPBQoOyJsMkYDkiUnHu2YE95HUmcCH9
         SETw7YC8hSPfd1LJvihA4aUAIfgRt6GFB50txVIGqHHOtWMVx0dS1u0OhhbAQrbJuNzC
         Jvw5qV+MGFtwl3WoZ8FVcS3h2ZHVfvxkw0xtjZUI+GCX6KYISz/DquDXXECh0Y535Sko
         uG13t9CzzhNfO6SokZaWnWKD52PNYEfqHBXw+nTNCHHza75kVrxOMcxBXo3hi1Xp0PH0
         wdrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740137"
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
Subject: [PATCH v4 02/22] iommu/vt-d: move device_domain_info to header
Date: Mon, 16 Apr 2018 14:48:51 -0700
Message-Id: <1523915351-54415-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909372641793?=
X-GMAIL-MSGID: =?utf-8?q?1597940909372641793?=
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
