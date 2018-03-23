Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELsnV5i/qagcspePfOQBPA//Dsr0Ma1zDnrgpLurasX+nZKKYrrMVdbbXlacbeQg0QnFe/hb
ARC-Seal: i=1; a=rsa-sha256; t=1521774605; cv=none;
        d=google.com; s=arc-20160816;
        b=qKJltMnFQZx8p2jwsfdjEls544GDe+fp7F31lIrrVYv/mVGU50woJV9hhWnN5viMjW
         jY+ZmKXgCzx263LYQByWqK1ZIhVf6hnlFXin6C1o4CecaCeQPX20c5usZwfcAmBFL9tx
         qfiiXYeVt63KjWeDWl7cWSEOIr15ASZp+BySc0FhbOZ6hb8oLlfmYNXu62HxjFXabEB4
         NRc5MLKjWAes7jKlOaMo6Ibi7tllnWktaq3oaHJvUNwIuWqrpmqb21gZ9eGBjDDdZxRs
         Z2O1XIl0BFyqEbv5LWkEfI5pT18ZY0pGO9fgtwr/+oUZ7wvB0+i1gHBL+35WWzNNz6Zn
         +U7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wAL4CpgdnYEsVnoxgQ5pLtE6ckrDwkI9uhKmx9H4N2I=;
        b=MGr3+K3l4/h2V57ZNQGoi23OK2QigbTAPofMD3dH5TAqTVAN3n30OKHCV4BGAluQSu
         NKr31Y8zSjQSifNl9Dudcv0+y6xmpLGOtytmjGTlb/g7aeCX/ZegOL7vUMxcajprTvrv
         6QS5MnYxV5Os7drGNaEy/z/9ddRZYeeZjFq62BmWd56aCCzynaO/D8bSe2uqVSn81zO5
         nIpEILtsar3a82L29o0ODEVifEuiigRK5ha46RicrA7UaCtUQ3BvSvFcERNJXmnfYXot
         xUWFOyEJpnT+e/3fcVx2GUD+rR3O4C18fD904wKSxuQwo8hk6shBtD3xCguyh6BoAdIN
         zEwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26315982"
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
Subject: [PATCH v4 07/22] iommu/vt-d: fix dev iotlb pfsid use
Date: Thu, 22 Mar 2018 20:11:59 -0700
Message-Id: <1521774734-48433-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696328450944312?=
X-GMAIL-MSGID: =?utf-8?q?1595696328450944312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PFSID should be used in the invalidation descriptor for flushing
device IOTLBs on SRIOV VFs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dmar.c        |  6 +++---
 drivers/iommu/intel-iommu.c | 16 +++++++++++++++-
 include/linux/intel-iommu.h |  5 ++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9a7ffd1..78f7e70 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1339,8 +1339,8 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			u64 addr, unsigned mask)
+void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask)
 {
 	struct qi_desc desc;
 
@@ -1355,7 +1355,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
 		qdep = 0;
 
 	desc.low = QI_DEV_IOTLB_SID(sid) | QI_DEV_IOTLB_QDEP(qdep) |
-		   QI_DIOTLB_TYPE;
+		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);
 
 	qi_submit_sync(&desc, iommu);
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8667727..53e9b7b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1482,6 +1482,19 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
+	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
+	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
+	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
+	 * reserved, which should be set to 0.
+	 */
+	if (!ecap_dit(info->iommu->ecap))
+		info->pfsid = 0;
+	else if (pdev && pdev->is_virtfn) {
+		if (ecap_dit(info->iommu->ecap))
+			dev_warn(&pdev->dev, "SRIOV VF device IOTLB enabled without flow control\n");
+		info->pfsid = PCI_DEVID(pdev->physfn->bus->number, pdev->physfn->devfn);
+	} else
+		info->pfsid = PCI_DEVID(info->bus, info->devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
@@ -1547,7 +1560,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 0e3b618..1c9375b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -477,9 +477,8 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
-extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
-			       u64 addr, unsigned mask);
-
+extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u16 qdep, u64 addr, unsigned mask);
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.7.4
