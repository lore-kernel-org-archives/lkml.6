Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48bITYyHlSnp6GsFB3t44p+sieZr/tLrEZFqc4lQ40bW3gxQ9U97DTn7TIrtCTCy41ZKO8Q
ARC-Seal: i=1; a=rsa-sha256; t=1523915205; cv=none;
        d=google.com; s=arc-20160816;
        b=y2oviimBdUB6qzxdptqr6s/zGWQNojq8ob6lJQ8q6Y4qnfvliZgGxpsv00K3GPr8nS
         oqeRoE8UlKbayKbgP++DAaZm2nmK4ap/3NffbqBpJEZUj0MkpefB7oMndGg4v5pi8+cR
         Yy5Hb0mI3TPhuZ4NcbZR/PL9LWE+zZ6MNEpInRfZ2RsEmE6JVZ/ghuhri1w4fwOiKvPi
         HnDG0a+Hl1XFfHZrJ5I/bjrC9624XCtIiP6LdEN4qaCQ7LdLk9Vb+XI84XDtyq5gAwD1
         I+6cNgvjwNywUzze+WPSb14Lr0OlOhPvZAn7dqKCmmwArnO/jWHEInJroGnoAM/euvST
         96Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fo2v+ut2dJBnvsHqcI+vVmcjZVlayf4PB1KESHLtN8Y=;
        b=CvEgp59u3X9Ky4/lX5X9yvnm7vMyEwr0Q3AYwr5XIWyAyGzwCs/FZiKfeTOEOn9GJJ
         zvPjhYhFVe8BdmZ7J4WqWDcmE/vGvSWFAqBCtOD+seT9zFtQoB1Woj1qtEieb4xJTYp5
         VUC39U+EpknePH+lbg6K+kJA5CW6+gGqBVBuOIkGKGzXXB3+lxC5sg4CQeaQLvAhkctj
         ur12lukS6XrJzd+N8R6tu9s0O+eWkgweSdzmijnVylZnQfcB2i3AJg8FAf6I/2Y/sH9m
         hbXhkpeAlqn7vNVjf4ZIqkKxhu1gndzVPVY/TLIZUWvjWXWrfb4dTRjLnGqCtrX3cB4r
         +pxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,460,1517904000";
   d="scan'208";a="34740184"
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Liu,
	Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH v4 16/22] iommu/vt-d: report non-recoverable faults to device
Date: Mon, 16 Apr 2018 14:49:05 -0700
Message-Id: <1523915351-54415-17-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910313654842?=
X-GMAIL-MSGID: =?utf-8?q?1597940910313654842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, dmar fault IRQ handler does nothing more than rate
limited printk, no critical hardware handling need to be done
in IRQ context.
For some use case such as vIOMMU, it might be useful to report
non-recoverable faults outside host IOMMU subsystem. DMAR fault
can come from both DMA and interrupt remapping which has to be
set up early before threaded IRQ is available.
This patch adds an option and a workqueue such that when faults
are requested, DMAR fault IRQ handler can use the IOMMU fault
reporting API to report.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/dmar.c        | 159 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-iommu.c |   6 +-
 include/linux/dmar.h        |   2 +-
 include/linux/intel-iommu.h |   1 +
 4 files changed, 159 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 71bfc73..9dcc95a 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1110,6 +1110,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	return err;
 }
 
+static inline void dmar_free_fault_wq(struct intel_iommu *iommu)
+{
+	if (iommu->fault_wq)
+		destroy_workqueue(iommu->fault_wq);
+}
+
 static void free_iommu(struct intel_iommu *iommu)
 {
 	if (intel_iommu_enabled) {
@@ -1126,6 +1132,7 @@ static void free_iommu(struct intel_iommu *iommu)
 		free_irq(iommu->irq, iommu);
 		dmar_free_hwirq(iommu->irq);
 		iommu->irq = 0;
+		dmar_free_fault_wq(iommu);
 	}
 
 	if (iommu->qi) {
@@ -1554,6 +1561,31 @@ static const char *irq_remap_fault_reasons[] =
 	"Blocked an interrupt request due to source-id verification failure",
 };
 
+/* fault data and status */
+enum intel_iommu_fault_reason {
+	INTEL_IOMMU_FAULT_REASON_SW,
+	INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID,
+	INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH,
+	INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS,
+	INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS,
+	INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID,
+	INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID,
+	INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_RTP,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_CTP,
+	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_PTE,
+	NR_INTEL_IOMMU_FAULT_REASON,
+};
+
+/* fault reasons that are allowed to be reported outside IOMMU subsystem */
+#define INTEL_IOMMU_FAULT_REASON_ALLOWED			\
+	((1ULL << INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH) |	\
+		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS) |	\
+		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS))
+
+
 static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 {
 	if (fault_reason >= 0x20 && (fault_reason - 0x20 <
@@ -1634,11 +1666,91 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
+static enum iommu_fault_reason to_iommu_fault_reason(u8 reason)
+{
+	if (reason >= NR_INTEL_IOMMU_FAULT_REASON) {
+		pr_warn("unknown DMAR fault reason %d\n", reason);
+		return IOMMU_FAULT_REASON_UNKNOWN;
+	}
+	switch (reason) {
+	case INTEL_IOMMU_FAULT_REASON_SW:
+	case INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH:
+	case INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID:
+		return IOMMU_FAULT_REASON_INTERNAL;
+	case INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID:
+	case INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS:
+	case INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS:
+		return IOMMU_FAULT_REASON_PERMISSION;
+	default:
+		return IOMMU_FAULT_REASON_UNKNOWN;
+	}
+}
+
+struct dmar_fault_work {
+	struct work_struct fault_work;
+	struct intel_iommu *iommu;
+	u64 addr;
+	int type;
+	int fault_type;
+	enum intel_iommu_fault_reason reason;
+	u16 sid;
+};
+
+static void report_fault_to_device(struct work_struct *work)
+{
+	struct dmar_fault_work *dfw = container_of(work, struct dmar_fault_work,
+						fault_work);
+	struct iommu_fault_event event;
+	struct pci_dev *pdev;
+	u8 bus, devfn;
+
+	memset(&event, 0, sizeof(struct iommu_fault_event));
+
+	/* check if fault reason is permitted to report outside IOMMU */
+	if (!((1 << dfw->reason) & INTEL_IOMMU_FAULT_REASON_ALLOWED)) {
+		pr_debug("Fault reason %d not allowed to report to device\n",
+			dfw->reason);
+		goto free_work;
+	}
+
+	bus = PCI_BUS_NUM(dfw->sid);
+	devfn = PCI_DEVFN(PCI_SLOT(dfw->sid), PCI_FUNC(dfw->sid));
+	/*
+	 * we need to check if the fault reporting is requested for the
+	 * offending device.
+	 */
+	pdev = pci_get_domain_bus_and_slot(dfw->iommu->segment, bus, devfn);
+	if (!pdev) {
+		pr_warn("No PCI device found for source ID %x\n", dfw->sid);
+		goto free_work;
+	}
+	/*
+	 * unrecoverable fault is reported per IOMMU, notifier handler can
+	 * resolve PCI device based on source ID.
+	 */
+	event.reason = to_iommu_fault_reason(dfw->reason);
+	event.addr = dfw->addr;
+	event.type = IOMMU_FAULT_DMA_UNRECOV;
+	event.prot = dfw->type ? IOMMU_READ : IOMMU_WRITE;
+	dev_warn(&pdev->dev, "report device unrecoverable fault: %d, %x, %d\n",
+		event.reason, dfw->sid, event.type);
+	iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
+
+free_work:
+	kfree(dfw);
+}
+
 static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 		u8 fault_reason, u16 source_id, unsigned long long addr)
 {
 	const char *reason;
 	int fault_type;
+	struct dmar_fault_work *dfw;
 
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
@@ -1647,11 +1759,29 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 			source_id >> 8, PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
-	else
+	else {
 		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
 		       type ? "DMA Read" : "DMA Write",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+	}
+
+	dfw = kmalloc(sizeof(*dfw), GFP_ATOMIC);
+	if (!dfw)
+		return -ENOMEM;
+
+	INIT_WORK(&dfw->fault_work, report_fault_to_device);
+	dfw->addr = addr;
+	dfw->type = type;
+	dfw->fault_type = fault_type;
+	dfw->reason = fault_reason;
+	dfw->sid = source_id;
+	dfw->iommu = iommu;
+	if (!queue_work(iommu->fault_wq, &dfw->fault_work)) {
+		kfree(dfw);
+		return -EBUSY;
+	}
+
 	return 0;
 }
 
@@ -1731,10 +1861,28 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int dmar_set_interrupt(struct intel_iommu *iommu)
+static int dmar_set_fault_wq(struct intel_iommu *iommu)
+{
+	if (iommu->fault_wq)
+		return 0;
+
+	iommu->fault_wq = alloc_ordered_workqueue(iommu->name, 0);
+	if (!iommu->fault_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int dmar_set_interrupt(struct intel_iommu *iommu, bool queue_fault)
 {
 	int irq, ret;
 
+	/* fault can be reported back to device drivers via a wq */
+	if (queue_fault) {
+		ret = dmar_set_fault_wq(iommu);
+		if (ret)
+			pr_err("Failed to create fault handling workqueue\n");
+	}
 	/*
 	 * Check if the fault interrupt is already initialized.
 	 */
@@ -1748,10 +1896,11 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 		pr_err("No free IRQ vectors\n");
 		return -EINVAL;
 	}
-
 	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
-	if (ret)
+	if (ret) {
 		pr_err("Can't request irq\n");
+		dmar_free_fault_wq(iommu);
+	}
 	return ret;
 }
 
@@ -1765,7 +1914,7 @@ int __init enable_drhd_fault_handling(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
+		int ret = dmar_set_interrupt(iommu, false);
 
 		if (ret) {
 			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c765448..a6ea67d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3401,10 +3401,10 @@ static int __init init_dmars(void)
 				goto free_iommu;
 		}
 #endif
-		ret = dmar_set_interrupt(iommu);
+		ret = dmar_set_interrupt(iommu, true);
+
 		if (ret)
 			goto free_iommu;
-
 		if (!translation_pre_enabled(iommu))
 			iommu_enable_translation(iommu);
 
@@ -4291,7 +4291,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 			goto disable_iommu;
 	}
 #endif
-	ret = dmar_set_interrupt(iommu);
+	ret = dmar_set_interrupt(iommu, true);
 	if (ret)
 		goto disable_iommu;
 
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e2433bc..21f2162 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -278,7 +278,7 @@ extern void dmar_msi_unmask(struct irq_data *data);
 extern void dmar_msi_mask(struct irq_data *data);
 extern void dmar_msi_read(int irq, struct msi_msg *msg);
 extern void dmar_msi_write(int irq, struct msi_msg *msg);
-extern int dmar_set_interrupt(struct intel_iommu *iommu);
+extern int dmar_set_interrupt(struct intel_iommu *iommu, bool queue_fault);
 extern irqreturn_t dmar_fault(int irq, void *dev_id);
 extern int dmar_alloc_hwirq(int id, int node, void *arg);
 extern void dmar_free_hwirq(int irq);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c54bce1..dbe8c93 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -472,6 +472,7 @@ struct intel_iommu {
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
 	u32		flags;      /* Software defined flags */
+	struct workqueue_struct *fault_wq; /* Reporting IOMMU fault to device */
 };
 
 /* PCI domain-device relationship */
-- 
2.7.4
