Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZomTZ3KuNK86CvqRMwJOPszvOOzID6MSFGBI7Qpd7hp9MsrPdRGvV50kN+Ss1TXTiiQ41to
ARC-Seal: i=1; a=rsa-sha256; t=1526071895; cv=none;
        d=google.com; s=arc-20160816;
        b=HB3dfwIvkkiT0bNOmZ8GSem+M5nF0AqX4KVOefM4goNu6726vl6Pp4/3eFNKCjlzzr
         Xr7fwquSKUDB8BQFxrJyN+pHPXhezMFFeGdDnTFkB1zmG6YdQjqNk6s7jYukmH1SzjqK
         rfy+deEI6wyDFfMEx5kCebyVGuIZVsUllhcycJTJApBCSbKMAAkScFzsrWwzba9n5crB
         r4hrKkd+cdUhrR6mC44dS9UDjasvw/EDItHQnt0EPHLDwZ2/qpIpBpPoV2LQEWzpz1Hd
         gi/bB5IHQQVFrA9Ht9f9I2zc4RvGq24kHYSbThoEcYiFUCl2Bn4cQ9Zqim0iiT03Z3H0
         GRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UMQVlas0BUXz6Dvfxcvc2wEmw5myMjiZferTnD5rx6s=;
        b=l15Yclw3yxE/Q6dP4xm4ebvziApCPUkaaYyT7th2DM8dpSwetS5IzV6hAfyxvg6jEF
         xQHnT09b4QjPDvF7p8hjA13TWqXAMw+Qh7V9cM9cMPg2XxE3MkpHvaR7ztB3XptxSw23
         6vIBheBKAdujv/UTobF0sjxebxn7YxuYPvwS+x7qNVmJx/qm1XW5JSgqdW+4u1pZAGk3
         K1kJLqaIEQrS8kWRXaMv8IZIeQ2A9JHtz8ljuw4iDMt1UbiV1ImV1mjyaXJ1J9WwxEdP
         0qb5TJvsLaW/LPLSlrejtqg7a9oP6i/K1rdh1zdREs86mUhVSKlOs81yo7OPk9uDbLkX
         VWuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="41104798"
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
Subject: [PATCH v5 21/23] iommu/vt-d: add intel iommu page response function
Date: Fri, 11 May 2018 13:54:13 -0700
Message-Id: <1526072055-86990-22-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202364414498183?=
X-GMAIL-MSGID: =?utf-8?q?1600202364414498183?=
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
index 3949b3cf..c261639 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5101,6 +5101,52 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
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
@@ -5530,6 +5576,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.bind_pasid_table	= intel_iommu_bind_pasid_table,
 	.unbind_pasid_table	= intel_iommu_unbind_pasid_table,
 	.sva_invalidate		= intel_iommu_sva_invalidate,
+	.page_response		= intel_iommu_page_response,
 #endif
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b3a26c7..94366d9 100644
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
