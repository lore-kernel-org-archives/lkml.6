Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AG47ELv6+2ZKvZKx+/N1jbmE3CLCc+0nx3G0IeOMlaDtTykOF5Wu6lfcjTexvLV71ehVDftRd//3
ARC-Seal: i=1; a=rsa-sha256; t=1521774612; cv=none;
        d=google.com; s=arc-20160816;
        b=GCErwEsIo8IpUsqyEScs5CCobITU3YStcb2eCvkqyEsSWjr/QvlRs+5FgWZnoiAcPP
         7biSljtvzAQkzBzYYLr8mG2aS6Z8rc3yDJJ5MyHrp2b1mni+AIwFpb+P7O7xQ2FM1KNb
         Oiss/5n7CtAVDVEbU6qhiUW1b0WyB+XkLWutErcG/WWoDHOaCKlluYFGWNpectZK2+uj
         rygrA5c71SUI3J1uMUCxrS+UWKDKGcgmxhHp4fGs2R9tRQFcvOwl5ZZlEVofyDLNjthj
         0bkaOnKmQBORhWwL1NbYgzK8VpAWvHDCLi96n1v5htwR4n1P6N3g9wx1ILISCmiqY+fD
         JIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=U0Eqv/6jN0CDZ+9wIiFrCJVbIlsrpBjsVWwNleIRPUE=;
        b=n1ojl6vuk2ef/HGpsO78WKAa2HxE3dHHd+l28MblM9W2e6tQS+tMKzsUsj4xNthNqM
         mri8wZJ4mHrgXc2xxE68ngMrwPpYjha+QRl0kR5CSqnsnI9nuXOvojkSQ74zNQpzrmRg
         plrDQeA68gxliu663Y/x7ngN4c5Bq4LIQoGPIfVdkySyl1/u8AHTtBlnhg+ItF2l5RTw
         gG+8jby1BGrj3stlazsdxGZgsefA2uCpZH9TR3UA7iOag1Mc3sDcR+Pfiuo5EceEwiTb
         zuYaXmbel+12QMrYAxVz3PMDZAhfpAC2iSJVZ4Irncl/PXfH3Ce85B8QXJbWIIAN4xij
         I1WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="scan'208";a="26316046"
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
Subject: [PATCH v4 20/22] iommu/vt-d: add intel iommu page response function
Date: Thu, 22 Mar 2018 20:12:12 -0700
Message-Id: <1521774734-48433-21-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696335947162394?=
X-GMAIL-MSGID: =?utf-8?q?1595696335947162394?=
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
index 3229e20..8d73ff0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5195,6 +5195,52 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	return ret;
 }
 
+int intel_iommu_page_response(struct device *dev, struct page_response_msg *msg)
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
@@ -5625,6 +5671,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
 	.sva_invalidate		= intel_iommu_sva_invalidate,
+	.page_response		= intel_iommu_page_response,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index dacb6cf..d2e1b5c 100644
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
