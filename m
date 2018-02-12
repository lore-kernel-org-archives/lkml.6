Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754266AbeBLQtX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:49:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53193 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754068AbeBLQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:48:33 -0500
X-Google-Smtp-Source: AH8x227nrYJX/+RmfAG0YD5aPkcaFyJQUPG9eItEDvhh7pr0MxgsFQKLvm9raABiN3NmnKAyWeqy4g==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCHv2 4/6] iommu/intel: Handle DMAR faults on workqueue
Date: Mon, 12 Feb 2018 16:48:23 +0000
Message-Id: <20180212164825.22421-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
References: <20180212164825.22421-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmar_fault() reports/handles/cleans DMAR faults in a cycle one-by-one.
The nuisance is that it's set as a irq handler and runs with disabled
interrupts - which works OK if you have only a couple of DMAR faults,
but becomes a problem if your intel iommu has a plenty of mappings.

We have a test that checks flapping of PCI link. Once or twice it had
stuck on soft lockup (which is panic for the typical switch):

 dmar: DMAR:[DMA Write] Request device [4a:00.0] fault addr 5e1a3000
 DMAR:[fault reason 02] Present bit in context entry is clear
 NMI watchdog: BUG: soft lockup - CPU#8 stuck for 21s!
 CPU: 8 PID: 2774 Comm: SuperServer
 Call Trace:
  generic_exec_single+0x11b/0x12d
  ? flush_tlb_func+0x0/0x18a
  smp_call_function_single+0x89/0xb5
  smp_call_function_many+0xef/0x207
  native_flush_tlb_others+0x2e/0x30
  flush_tlb_mm_range+0x139/0x18a
  tlb_flush_mmu_tlbonly+0x35/0x85
  tlb_flush_mmu+0x13/0x1f
  tlb_finish_mmu+0x14/0x39
  unmap_region+0xda/0xec
  do_munmap+0x273/0x2f5
  vm_munmap+0x45/0x5e
  SyS_munmap+0x26/0x2f
  sysenter_dispatch+0x7/0x25

 Kernel panic - not syncing: softlockup: hung tasks
 sending NMI to all CPUs:
 NMI backtrace for cpu 0
 CPU: 0 PID: 0 Comm: swapper/0
 Call Trace:
  <IRQ>
  wait_for_xmitr+0x26/0x8f
  serial8250_console_putchar+0x1c/0x2c
  uart_console_write+0x40/0x4b
  serial8250_console_write+0xe6/0x13f
  call_console_drivers.constprop.13+0xce/0x103
  console_unlock+0x1f8/0x39b
  ? local_clock+0x21/0x23
  vprintk_emit+0x39e/0x3e6
  printk+0x4d/0x4f
  dmar_fault+0x1ab/0x1fd
  handle_irq_event_percpu+0x8a/0x1f5
  handle_irq_event+0x41/0x61
  handle_edge_irq+0xe1/0xfa
  handle_irq+0x155/0x166
  do_IRQ+0x5a/0xea
  ret_from_intr+0x0/0x15
  <EOI>
  arch_cpu_idle+0xf/0x11
  cpu_startup_entry+0x22f/0x3cb
  rest_init+0x80/0x84
  start_kernel+0x470/0x47d
  x86_64_start_reservations+0x2a/0x2c
  x86_64_start_kernel+0x14b/0x15a

Move DMAR faults clearing out of irq-disabled critical section by
proceeding with that in a workqueue thread.
The next patch will correct the definition of dmar_fault().

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-iommu.c |  6 ++++++
 include/linux/dmar.h        |  1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 33fb4244e438..34a53aeede38 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -71,6 +71,12 @@ struct acpi_table_header * __initdata dmar_tbl;
 static int dmar_dev_scope_status = 1;
 static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
 
+static struct workqueue_struct *fault_wq;
+struct fault {
+	struct work_struct work;
+	struct intel_iommu *iommu;
+};
+
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
 
@@ -811,6 +817,14 @@ void __init dmar_register_bus_notifier(void)
 	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 }
 
+int __init dmar_init_workqueue(void)
+{
+	fault_wq = alloc_workqueue("dmar_fault", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (fault_wq == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
 
 int __init dmar_table_init(void)
 {
@@ -1695,6 +1709,38 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void dmar_fault_work(struct work_struct *work)
+{
+	struct fault *fault = container_of(work, struct fault, work);
+
+	dmar_fault(-1, (void*)fault->iommu);
+}
+
+static irqreturn_t dmar_fault_handler(int irq, void *dev_id)
+{
+	struct intel_iommu *iommu = dev_id;
+	struct fault *fault;
+
+	fault = kzalloc(sizeof(*fault), GFP_ATOMIC);
+	if (fault == NULL) {
+		unsigned long flag;
+
+		/* During OOM - clear faults and let device re-fault */
+		raw_spin_lock_irqsave(&iommu->register_lock, flag);
+		clear_primary_faults(iommu);
+		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+
+		return IRQ_HANDLED;
+	}
+
+	fault->iommu = iommu;
+	INIT_WORK(&fault->work, dmar_fault_work);
+
+	queue_work(fault_wq, &fault->work);
+
+	return IRQ_HANDLED;
+}
+
 int dmar_set_interrupt(struct intel_iommu *iommu)
 {
 	int irq, ret;
@@ -1713,7 +1759,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 		return -EINVAL;
 	}
 
-	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
+	ret = request_irq(irq, dmar_fault_handler, IRQF_NO_THREAD, iommu->name, iommu);
 	if (ret)
 		pr_err("Can't request irq\n");
 	return ret;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01cb7d1..64ad9786f5b9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4783,6 +4783,12 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+	if (dmar_init_workqueue()) {
+		if (force_on)
+			panic("tboot: Failed to init workqueue for DMARs\n");
+		goto out_free_dmar;
+	}
+
 	if (list_empty(&dmar_rmrr_units))
 		pr_info("No RMRR found\n");
 
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e2433bc50210..5de4932a6ad8 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -113,6 +113,7 @@ static inline bool dmar_rcu_check(void)
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
 extern void dmar_register_bus_notifier(void);
+extern int dmar_init_workqueue(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
-- 
2.13.6
