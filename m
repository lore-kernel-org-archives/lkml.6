Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48tP+H4FHxIf6zbVE5GJYpx8epYlFswNSHsu8dWY9rC7EJ5USVxYiyZLBoUncXju5cEs7nD
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=xWx560kP4uNbFvqgfZnNxA1oWrAsGY4z9YnQQwzQ1/U7MzdL9Ti702uqyqt5IIAdW3
         eoLh7aZDttSp+UQ9/TDLlRL9RByocWZdCqnEWNC+VMRSXaF11XPTmzEOaXSBje/gwnbL
         SVJqE1YMBdoenRcDEYgc03191/vYv7BLZo67COgVH181dZ+mfy29sXIC1ZUgx0WFejSc
         wwN6NWgKnmTs7HNvJAb8xhxd/nd8r/1/ke7yc9lie+ID0kvtF30rDQvedslyspVJdmix
         Wej9qnSsvg8vKJqCK4XCnuuJ0B8AxShTd6Lc/CgOsOclHMa8yrYfw0rDbmEuzM+zPg9V
         5loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QUX6srGcy5lwVAUN3QisN6XvvdB7bEWDPoy60zyTgcU=;
        b=mBSI69BaWz4aS6h2IqQdaUb5Bjl38XbUUvxvKf9ATP+97GSz9oh7Je8maGzn6tLf5c
         UIWDASjMEkJFeeUpSMnRfZ/PP714JOzYKcle7QpDVzripWX9Hno5aqwTB51CRRXdbQPB
         Sz5fFdygjL9qyiW4OIc4qpLA3TJWN0/BE+TZxvnKVXP5pFIOdwNlMYPo8cGnV7kXyryb
         ioME1TwoRK4stQdgxi76OI+UjBDiwUFNFQIPl3rMq3yAOsCrYl1Vum3KZnCT5+OIOSLM
         17/jbcTCoN++1eAqCf5KNOibculsw6/BJLc0iTdSBC6CCqK/ubVxmhKX9/QCjOJDHvre
         TYeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740188"
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
Subject: [PATCH v4 17/22] iommu/intel-svm: report device page request
Date: Mon, 16 Apr 2018 14:49:06 -0700
Message-Id: <1523915351-54415-18-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910864208938?=
X-GMAIL-MSGID: =?utf-8?q?1597940910864208938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the source device of a page request has its PASID table pointer
bound to a guest, the first level page tables are owned by the guest.
In this case, we shall let guest OS to manage page fault.

This patch uses the IOMMU fault reporting API to send fault events,
possibly via VFIO, to the guest OS. Once guest pages are fault in, guest
will issue page response which will be passed down via the invalidation
passdown APIs.

Recoverable faults, such as page request reporting is not limitted to
guest use. In kernel driver can also request a chance to receive fault
notifications.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-svm.c | 73 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/iommu.h     |  1 +
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e8cd984..a8186f8 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -577,6 +577,58 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_EXEC;
+	if (req->priv_req)
+		prot |= IOMMU_FAULT_PRIV;
+
+	return prot;
+}
+
+static int intel_svm_prq_report(struct intel_iommu *iommu,
+				struct page_req_dsc *desc)
+{
+	int ret = 0;
+	struct iommu_fault_event event;
+	struct pci_dev *pdev;
+
+	memset(&event, 0, sizeof(struct iommu_fault_event));
+	pdev = pci_get_domain_bus_and_slot(iommu->segment,
+					desc->bus, desc->devfn);
+	if (!pdev) {
+		pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
+			desc->bus, PCI_SLOT(desc->devfn),
+			PCI_FUNC(desc->devfn));
+		return -ENODEV;
+	}
+
+	/* Fill in event data for device specific processing */
+	event.type = IOMMU_FAULT_PAGE_REQ;
+	event.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
+	event.pasid = desc->pasid;
+	event.page_req_group_id = desc->prg_index;
+	event.prot = prq_to_iommu_prot(desc);
+	event.last_req = desc->lpig;
+	event.pasid_valid = 1;
+	/* keep track of PRQ so that when the response comes back, we know
+	 * whether we do group response or stream response. SRR[0] and
+	 * private[54:32] bits in the descriptor are stored.
+	 */
+	event.iommu_private = *(u64 *)desc;
+	ret = iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
+
+	return ret;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -625,6 +677,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				goto no_pasid;
 			}
 		}
+		/* If address is not canonical, return invalid response */
+		if (!is_canonical_address(address))
+			goto bad_req;
+
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		if (!intel_svm_prq_report(iommu, req))
+			goto prq_advance;
 
 		result = QI_RESP_INVALID;
 		/* Since we're using init_mm.pgd directly, we should never take
@@ -635,9 +697,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!mmget_not_zero(svm->mm))
 			goto bad_req;
 
-		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
-			goto bad_req;
 
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
@@ -670,12 +729,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (WARN_ON(&sdev->list == &svm->devs))
 			sdev = NULL;
-
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->priv_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
-		}
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
@@ -701,7 +754,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 			qi_submit_sync(&resp, iommu);
 		}
-
+	prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 40088d6..0933f72 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,7 @@
  * if the IOMMU page table format is equivalent.
  */
 #define IOMMU_PRIV	(1 << 5)
+#define IOMMU_EXEC	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.7.4
