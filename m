Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/urJgi/RhyzxRlle87X2IXNW/SlhJ5TvvDrjh7KIRCx4V2hYFkdII09E2L0y5f3Cdewues
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=iElzL+twJFrwHa5/R+U9UPo9jZB+HKpnpClr96/cDUibMUX1p6tJKQ/NMVTuOo8USt
         foYUdtnhNYCUGvs3iC6OEA8yns572Gvfi7Km/K123Z8OUFodIfmIuZKW/Nll4ZV7lnXq
         +1gO1gkC0t8BAH0jXm8A4KvAmp7j6XtghrV7+yi0qQoOeAEk8MLJwX//uh39PM6OeZv9
         0qOhZGnNmPqjz7nOtPkL3ppifdveKlmUWK8UbYBFzKcg3uYt2oHJ3F51saI9FC/oxWNk
         iIkamFJjpmJWNLtAuXU3zRzJJug3RdKCTesgEvwwGa66sX2+YrhctdTZDgTGJFVjx6xM
         Lv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6+f8D0/0eHGsWF2GgO2d8r+b7V6PGHmlb51YxCm7lWg=;
        b=Yf0zieN/VBJJj7QSebonMK6zoFpxx1dWUpd2O/1Q607OZ39ptezjYFp+JsJUlsjEUS
         NP8BcidvJUurpW6/PnKV1nHrI6LtRIHI3qQxjhFGdiy9qNLtg/UyBYire6nSuMD4MF6Y
         ijCiS6ZFApQhg0udgk7gZdAsUADbIya0bLQ3eiaqMpSG8slEFMlWElYEKrHEz03imr9C
         QX2L6oSmCdfib/PI7+U+8NsVLIfvsl0RCWDeVTrD6PYIi/5+Y5mrdVALykzrL/k8WPKB
         T2+rNbilm5sjocua0qzPULPNtO/dN18o2WdK4sUplphxJHnFW5qK9TomnzVgWkL+fP2z
         SUwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740158"
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
Subject: [PATCH v4 08/22] iommu/vt-d: support flushing more translation cache types
Date: Mon, 16 Apr 2018 14:48:57 -0700
Message-Id: <1523915351-54415-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910047497005?=
X-GMAIL-MSGID: =?utf-8?q?1597940910047497005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When Shared Virtual Memory is exposed to a guest via vIOMMU, extended
IOTLB invalidation may be passed down from outside IOMMU subsystems.
This patch adds invalidation functions that can be used for additional
translation cache types.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dmar.c        | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h | 21 +++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 38bb90f..71bfc73 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1339,6 +1339,18 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
+void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
+		unsigned int size_order, u64 granu, bool global)
+{
+	struct qi_desc desc;
+
+	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
+	desc.high = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_GL(global) |
+		QI_EIOTLB_IH(0) | QI_EIOTLB_AM(size_order);
+	qi_submit_sync(&desc, iommu);
+}
+
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask)
 {
@@ -1360,6 +1372,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	qi_submit_sync(&desc, iommu);
 }
 
+void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid,
+		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64 granu)
+{
+	struct qi_desc desc;
+
+	desc.low = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;
+	desc.high |= QI_DEV_EIOTLB_GLOB(granu);
+
+	/* If S bit is 0, we only flush a single page. If S bit is set,
+	 * The least significant zero bit indicates the size. VT-d spec
+	 * 6.5.2.6
+	 */
+	if (!size)
+		desc.high = QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
+	else {
+		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size);
+
+		desc.high = QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
+	}
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
+{
+	struct qi_desc desc;
+
+	desc.high = 0;
+	desc.low = QI_PC_TYPE | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
+
+	qi_submit_sync(&desc, iommu);
+}
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 678a0f4..c54bce1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -262,6 +262,10 @@ enum {
 #define QI_PGRP_RESP_TYPE	0x9
 #define QI_PSTRM_RESP_TYPE	0xa
 
+#define QI_DID(did)		(((u64)did & 0xffff) << 16)
+#define QI_DID_MASK		GENMASK(31, 16)
+#define QI_TYPE_MASK		GENMASK(3, 0)
+
 #define QI_IEC_SELECTIVE	(((u64)1) << 4)
 #define QI_IEC_IIDEX(idx)	(((u64)(idx & 0xffff) << 32))
 #define QI_IEC_IM(m)		(((u64)(m & 0x1f) << 27))
@@ -293,8 +297,9 @@ enum {
 #define QI_PC_DID(did)		(((u64)did) << 16)
 #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
 
-#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
-#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
+/* PASID cache invalidation granu */
+#define QI_PC_ALL_PASIDS	0
+#define QI_PC_PASID_SEL		1
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
 #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
@@ -304,6 +309,10 @@ enum {
 #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
 #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
 
+/* QI Dev-IOTLB inv granu */
+#define QI_DEV_IOTLB_GRAN_ALL		0
+#define QI_DEV_IOTLB_GRAN_PASID_SEL	1
+
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
 #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
@@ -332,6 +341,7 @@ enum {
 #define QI_RESP_INVALID		0x1
 #define QI_RESP_FAILURE		0xf
 
+/* QI EIOTLB inv granu */
 #define QI_GRAN_ALL_ALL			0
 #define QI_GRAN_NONG_ALL		1
 #define QI_GRAN_NONG_PASID		2
@@ -504,8 +514,15 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
+extern void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			u32 pasid, unsigned int size_order, u64 type, bool global);
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
+
+extern void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid,
+			u32 pasid, u16 qdep, u64 addr, unsigned size, u64 granu);
+extern void qi_flush_pasid(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
+
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.7.4
