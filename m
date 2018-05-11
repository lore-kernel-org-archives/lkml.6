Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqyfPpIsFSk5ifE6iZJgO0yjb+EfSZRhrq3QeR5F0XMcwPSeNggXf0LPGdH2ilZwzr3godX
ARC-Seal: i=1; a=rsa-sha256; t=1526071894; cv=none;
        d=google.com; s=arc-20160816;
        b=iTOypciDRd6Fe8sAX7FvFv6BVbRqXd6L8Wj51c323XCeyJoyFTce+/okhAswelBxtl
         t/bGrgaDOOfWSG654QZFOAVcqVv0v+yO2WmZ1Vq4u5o1v/FQrf/GKSSfaPjPKn62ss9z
         h3br7fBTkrEnFgMKIyt4L5oHdgmuHM4jTbM7IBh6QbHRhiLD8liHFdxhcgZo76xz82lN
         gO1HYfPxmCUpAasxnZtODPmszZAjMyFkMNngWZQQdfifskJMoBgEVL//pkluPmspwCmi
         VIsCcts6JE7I2fy2U33wuEvtpi7GiojDeL5AoLthR1vd9sIKgFkRWtzBU9Crb77d3gij
         PCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=y9EnIm6JMHUsVrhD4OWzuw42Ot5LW08FJ49s7AtOCUg=;
        b=T9ezjM8I8u0PjsQ2m5hduBU0w3lS5xKaS05iI8ZLA0A7o1vI+odTX2MdoBiqOt+Q1g
         fRts6BynDNsYS3C8UdHkdyF/Bt5FS2YMUZ2z1M0hW9+Y+UtlSs5AtgJXPQue1iHqB3xH
         3zCpcwezZuYaYCENgMURs+0NOTxY0uoZMdMsHHzlBNOWx2klwdMdm7Wdjve9AmEdZjQy
         QrpNWMKwlpB5gBoPh1uw+gIhFkYpM2d3vfdMXczRrA6Wfe4mb2/5rVK35Nq6GaOWceMS
         GvPPRIaiR/XL6phcn1MJLwELqGefN2o+TybXJyYVeNGt3B4FeD+nbCSllJOzIbS4EiKI
         U+OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104755"
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
Subject: [PATCH v5 08/23] iommu/vt-d: support flushing more translation cache types
Date: Fri, 11 May 2018 13:54:00 -0700
Message-Id: <1526072055-86990-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362792419747?=
X-GMAIL-MSGID: =?utf-8?q?1600202362792419747?=
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
index 7852678..0b5b052 100644
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
index 678a0f4..5ac0c28 100644
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
+#define QI_DEV_IOTLB_GRAN_ALL		1
+#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
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
