Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/QJx4HfGl33xa+sTCxrWQSMbJpLUgOhf9I1JD1J8r9Z0mi+dclU9LsrxpMnyYWR6cKzHb8
ARC-Seal: i=1; a=rsa-sha256; t=1523915204; cv=none;
        d=google.com; s=arc-20160816;
        b=lAKJ1SFhS64Itw0WIWHGGR6OGuY2R2R6jzMBjw14OGxrqXpb6pyBuS19R2WXnJi77x
         Gy1NDusDRNqqy3RCuJ1ZuvblCaqdLc5Wx0yeGTlbRv7UskQ1GivZbXwrmWJy47Kc1a47
         naO7kfkeKC8+qxOvO89Lrf/pD7xLQPQm5pBUumIC1F3nbQ7tkpZgjMrHTJfLFpvKMftQ
         2IGdmVuvjlag+ruhVh/jqUFYaPWMGw7To2t6v1H+Af8Iv4/kofC+w/+GiFtVDxnVRqzZ
         WxOrz59fr7DrQDZ3C2mwskSkOcRQKuywJqpZhnsQ9FwjkJ//iVWJbqd7GcQFSdQW4Fz1
         6eeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4dnTpTRcY9LnX11gphWi5M6lLS35Ibd6O4cA3fmFPpU=;
        b=pZSkw2Ju7vUFt4IOvD9+uisUY8SosjH0PCU7lejGU878d0ChMXajMoMK054undXzaD
         gu5l+/x2wB7sL8f65J9/5rHA6/pi/+siI7jznezFGkzeox8kW6GaPbaog5KWz0H/JRrA
         IG5VDAyrwYMkEVTg4tj7AApk9+yvwiEinQCbz8eO5q2THbIpGjNq6UdRlNck+jwzO3DG
         h5iPavprpxUNCxt4xgvL1INhJa3fecxfwv2XDGPBlm05BlZRqvOoHNnoeautSE5GxRmU
         gnGutGictdZjGv5u1a+rsbCpY1dElqOH7Sr7uf6Wt9d4LeonSlriqZiSx4yiW7X0Crfb
         68hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740154"
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
Subject: [PATCH v4 07/22] iommu/vt-d: fix dev iotlb pfsid use
Date: Mon, 16 Apr 2018 14:48:56 -0700
Message-Id: <1523915351-54415-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909685559911?=
X-GMAIL-MSGID: =?utf-8?q?1597940909685559911?=
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
index accf5838..38bb90f 100644
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
index d8058be..cae4042 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1459,6 +1459,19 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
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
@@ -1524,7 +1537,8 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 		sid = info->bus << 8 | info->devfn;
 		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
+		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+				qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index dfacd49..678a0f4 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -504,9 +504,8 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
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
