Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELtw5qx/s6jVapY5VqiSq7JbDDtfDnqDA9130h+saJsTP2hrCe9xaR94tTpBvrNebBXOn/lW
ARC-Seal: i=1; a=rsa-sha256; t=1521774602; cv=none;
        d=google.com; s=arc-20160816;
        b=xXYJuSrGSMM1pIIUTShQ5cN7XMgCvZImt0oORsbNqOrqzKZdMWLGSJ4bADEco3osmX
         A1m+p5dFfP0Dy26pi0/3XH6pQCjECulwTO+/EgZEsppofn3p7NBg6Uwz1Dw6tjIzle/o
         22n4RguDWoBkOf44Pp96zsbcxJsAMmsBj5R1MDBJKNedkyonZZ17Hf7SJ2q+tl8fJzXY
         y6alAMsLUMNNi0Wtk9T5GhWGT3kZZm9F31aE/ydr1OCxVSqTvXzJsVeQdbieR/c6Urxa
         +vBYqKGWZZWP3LsZiQY7q7zHygOHuvxMQ2bytGyM3oORqovX+ZX0N63WLw0rLref95c2
         AB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=G9mclERd/1qS9z6/kWbemokEzc8o4bE0XBGzNejuOaw=;
        b=ZQ4iqsMU04qpOpcDvWGPwtCjFDUE4XYvBdZ6ps7O7CugNYKIjrXtMXxs/VE8ZteVGn
         4LwUa/RKwXFItNrsgH5g7iKiFcRq+/dBzVfBeC5IYnaqCB2IyXdSxUC55+OjnQn0I4Zp
         rzLofWF7lEVXWQfKCgG2bLrbBR40HK/vFnil86SMQA8EU1Z9XgWWdKrzZUO1iRmhqdJR
         1wp6fzoJWS4C+C77wnft+DlWdoQc2qRKswkixsY10mj9v2t3anwkrCeBSh41WYvlnb1d
         RAsEDSjY0p/gW+2rBotpEirSGpBVxdwyXoKkBISnbO0CfqBn5kkbP8T4/lvjPFiAgX9h
         l7ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315948"
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
Subject: [PATCH v4 02/22] iommu/vt-d: move device_domain_info to header
Date: Thu, 22 Mar 2018 20:11:54 -0700
Message-Id: <1521774734-48433-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696325577429557?=
X-GMAIL-MSGID: =?utf-8?q?1595696325577429557?=
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
index 582fd01..15fa30d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -414,24 +414,6 @@ struct dmar_domain {
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
index 8dad3dd..13b44bb 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -434,6 +434,25 @@ struct intel_iommu {
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
