Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx49K6/mYUM9ESTq0hZjn50U3Hub+V55uBEttfUyHdVg6PjLnAqN2mcoqedR7UGREZfBxciWv
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=lNpVSFIe4ajtID3nGhvY2PZ4OClDyRd+u+hg/+7C+OHdr9+e18hxRsBNGX3G9cSyVY
         mCqPHzl7SqnYiX/f/7zQSt+cVFU5IAw9wUUyUWjhm+POJUzdItd6P8AeszYRFTq689An
         WTusL3W1H7iZ5zTl2/3tJTEybrCl7lPqUWCYc/v3EWEWFYhYLFO8V1eC9FXz/C+Gl5F3
         BEGfbgzOUhw7dSpO6MBzGbBQWV1qqAkJy1XONdUiIOs+w+anuSA8fjbkKJy6w3fKP4Uw
         5eE40of+Kx5uCSgM354El+ayyvLULtUTIwYNQvYKo+511VcSJBXeenN+SSukecz7u5Bo
         KVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BczkwraTvtAo7yZIZ2RGyKw7kQA00uoT2prq0ySpQRA=;
        b=ncUw3oadEOKKAUr2Rtkt+Bgi7FYJRvlrQ/zaABb1lhRXJOgu9sN8wvG2NbZRypmxF/
         +FzPkNJ1xoasvtcFX85sl9mODn4KlKmwgUJSbL0QbcvjKqKXmp9JORKQcrz7lIBsjKCL
         4l+YooLeX498tuoIgYtqnpZ3B7fMq4K2Ipp1sqEDdYRdpbrb5cOyPniBNNEWbgpz8Z3N
         fZsAeuB/YK8QEs7/D1PhBM6aCOcX+LufAIyIZU3nxUVRAoOucWclobEkXqYXEUG4IaVE
         YxVftE67fEp/xEcBFtASB310v+EwDA9B1On8f/XUYAqt/hN3YDSW3dLEvov7rH7EuryE
         zCzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740197"
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
Subject: [PATCH v4 20/22] iommu/vt-d: add intel iommu page response function
Date: Mon, 16 Apr 2018 14:49:09 -0700
Message-Id: <1523915351-54415-21-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909906468274?=
X-GMAIL-MSGID: =?utf-8?q?1597940909906468274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds page response support for Intel VT-d.
Generic response data is taken from the IOMMU API
then parsed into VT-d specific response descriptor format.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a6ea67d..38f76d4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5142,6 +5142,52 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	return ret;
 }
 
+static int intel_iommu_page_response(struct device *dev, struct page_response_msg *msg)
+{
+	struct qi_desc resp;
+	struct intel_iommu *iommu;
+	struct pci_dev *pdev;
+	u8 bus, devfn;
+	u16 rid;
+	u64 desc;
+
+	pdev = to_pci_dev(dev);
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu) {
+		dev_err(dev, "No IOMMU for device to unbind PASID table\n");
+		return -ENODEV;
+	}
+
+	pci_dev_get(pdev);
+	rid = ((u16)bus << 8) | devfn;
+	/* Iommu private data contains  preserved page request descriptor, so we
+	 * inspect the SRR bit for response type then queue response with only
+	 * the private data [54:32].
+	 */
+	desc = msg->private_data;
+	if (desc & QI_PRQ_SRR) {
+		/* Page Stream Response */
+		resp.low = QI_PSTRM_IDX(msg->page_req_group_id) |
+			(desc & QI_PRQ_PRIV) | QI_PSTRM_BUS(PCI_BUS_NUM(pdev->bus->number)) |
+			QI_PSTRM_PASID(msg->pasid) | QI_PSTRM_RESP_TYPE;
+		resp.high = QI_PSTRM_ADDR(msg->addr) | QI_PSTRM_DEVFN(pdev->devfn & 0xff) |
+			QI_PSTRM_RESP_CODE(msg->resp_code);
+	} else {
+		/* Page Group Response */
+		resp.low = QI_PGRP_PASID(msg->pasid) |
+			QI_PGRP_DID(rid) |
+			QI_PGRP_PASID_P(msg->pasid_present) |
+			QI_PGRP_RESP_TYPE;
+		resp.high = QI_PGRP_IDX(msg->page_req_group_id) |
+			(desc & QI_PRQ_PRIV) | QI_PGRP_RESP_CODE(msg->resp_code);
+
+	}
+	qi_submit_sync(&resp, iommu);
+	pci_dev_put(pdev);
+
+	return 0;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5568,6 +5614,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
 	.sva_invalidate		= intel_iommu_sva_invalidate,
+	.page_response		= intel_iommu_page_response,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index dbe8c93..ed2883a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -337,6 +337,9 @@ enum {
 #define QI_PSTRM_BUS(bus)	(((u64)(bus)) << 24)
 #define QI_PSTRM_PASID(pasid)	(((u64)(pasid)) << 4)
 
+#define QI_PRQ_SRR	BIT_ULL(0)
+#define QI_PRQ_PRIV	GENMASK_ULL(54, 32)
+
 #define QI_RESP_SUCCESS		0x0
 #define QI_RESP_INVALID		0x1
 #define QI_RESP_FAILURE		0xf
-- 
2.7.4
