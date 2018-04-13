Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeDMVwp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:52:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39839 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeDMVwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:52:43 -0400
Date: Fri, 13 Apr 2018 23:52:40 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.14.34-rt27
Message-ID: <20180413215240.scbnvz7egaauawyz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.34-rt27 patch set. 

Changes since v4.14.34-rt26:

  - Two posix-timer related patches and one for the alarmtimer.

  - Backported a kvm patch patch by Christoffer Dall to remove a
    BUG_ON() statement which triggers on RT+arm64.

  - Backported a handful patches for AMD's iommu. The series avoids
    acquiring sleeping locks in atomic context on -RT. Some of patches
    were made by Scott Wood.

  - Inter-event (latency) fixes by Tom Zanussi.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.34-rt26 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.34-rt26-rt27.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.34-rt27

The RT patch against v4.14.34 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.34-rt27.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.34-rt27.tar.xz

Sebastian

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e97eee1b2e36..b96b8c11a586 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -81,11 +81,12 @@
  */
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 
-static DEFINE_RWLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(pd_bitmap_lock);
+static DEFINE_SPINLOCK(iommu_table_lock);
 
 /* List of all available dev_data structures */
-static LIST_HEAD(dev_data_list);
-static DEFINE_SPINLOCK(dev_data_list_lock);
+static LLIST_HEAD(dev_data_list);
 
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
@@ -204,40 +205,33 @@ static struct dma_ops_domain* to_dma_ops_domain(struct protection_domain *domain
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 
 	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
 	if (!dev_data)
 		return NULL;
 
 	dev_data->devid = devid;
-
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_add_tail(&dev_data->dev_data_list, &dev_data_list);
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
 	ratelimit_default_init(&dev_data->rs);
 
+	llist_add(&dev_data->dev_data_list, &dev_data_list);
 	return dev_data;
 }
 
 static struct iommu_dev_data *search_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
+	struct llist_node *node;
 
-	spin_lock_irqsave(&dev_data_list_lock, flags);
-	list_for_each_entry(dev_data, &dev_data_list, dev_data_list) {
+	if (llist_empty(&dev_data_list))
+		return NULL;
+
+	node = dev_data_list.first;
+	llist_for_each_entry(dev_data, node, dev_data_list) {
 		if (dev_data->devid == devid)
-			goto out_unlock;
+			return dev_data;
 	}
 
-	dev_data = NULL;
-
-out_unlock:
-	spin_unlock_irqrestore(&dev_data_list_lock, flags);
-
-	return dev_data;
+	return NULL;
 }
 
 static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
@@ -311,6 +305,8 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 
 	if (dev_data == NULL) {
 		dev_data = alloc_dev_data(devid);
+		if (!dev_data)
+			return NULL;
 
 		if (translation_pre_enabled(iommu))
 			dev_data->defer_attach = true;
@@ -1054,9 +1050,9 @@ static int iommu_queue_command_sync(struct amd_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret = __iommu_queue_command_sync(iommu, cmd, sync);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -1082,7 +1078,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	raw_spin_lock_irqsave(&iommu->lock, flags);
 
 	iommu->cmd_sem = 0;
 
@@ -1093,7 +1089,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	ret = wait_on_sem(&iommu->cmd_sem);
 
 out_unlock:
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return ret;
 }
@@ -1602,29 +1598,26 @@ static void del_domain_from_list(struct protection_domain *domain)
 
 static u16 domain_id_alloc(void)
 {
-	unsigned long flags;
 	int id;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	id = find_first_zero_bit(amd_iommu_pd_alloc_bitmap, MAX_DOMAIN_ID);
 	BUG_ON(id == 0);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__set_bit(id, amd_iommu_pd_alloc_bitmap);
 	else
 		id = 0;
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
 
 	return id;
 }
 
 static void domain_id_free(int id)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
 }
 
 #define DEFINE_FREE_PT_FN(LVL, FN)				\
@@ -2093,9 +2086,9 @@ static int attach_device(struct device *dev,
 	}
 
 skip_ats_check:
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	ret = __attach_device(dev_data, domain);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
@@ -2145,9 +2138,9 @@ static void detach_device(struct device *dev)
 	domain   = dev_data->domain;
 
 	/* lock device table */
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	__detach_device(dev_data);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
 	if (!dev_is_pci(dev))
 		return;
@@ -2811,7 +2804,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	struct iommu_dev_data *entry;
 	unsigned long flags;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
 
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
@@ -2819,7 +2812,7 @@ static void cleanup_domain(struct protection_domain *domain)
 		__detach_device(entry);
 	}
 
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
@@ -3586,14 +3579,62 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	amd_iommu_dev_table[devid].data[2] = dte;
 }
 
-static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *get_irq_table(u16 devid)
+{
+	struct irq_remap_table *table;
+
+	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
+		      "%s: no iommu for devid %x\n", __func__, devid))
+		return NULL;
+
+	table = irq_lookup_table[devid];
+	if (WARN_ONCE(!table, "%s: no table for devid %x\n", __func__, devid))
+		return NULL;
+
+	return table;
+}
+
+static struct irq_remap_table *__alloc_irq_table(void)
+{
+	struct irq_remap_table *table;
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_KERNEL);
+	if (!table->table) {
+		kfree(table);
+		return NULL;
+	}
+	raw_spin_lock_init(&table->lock);
+
+	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		memset(table->table, 0,
+		       MAX_IRQS_PER_TABLE * sizeof(u32));
+	else
+		memset(table->table, 0,
+		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
+	return table;
+}
+
+static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
+				  struct irq_remap_table *table)
+{
+	irq_lookup_table[devid] = table;
+	set_dte_irq_entry(devid, table);
+	iommu_flush_dte(iommu, devid);
+}
+
+static struct irq_remap_table *alloc_irq_table(u16 devid)
 {
 	struct irq_remap_table *table = NULL;
+	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu *iommu;
 	unsigned long flags;
 	u16 alias;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock_irqsave(&iommu_table_lock, flags);
 
 	iommu = amd_iommu_rlookup_table[devid];
 	if (!iommu)
@@ -3606,60 +3647,45 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	alias = amd_iommu_alias_table[devid];
 	table = irq_lookup_table[alias];
 	if (table) {
-		irq_lookup_table[devid] = table;
-		set_dte_irq_entry(devid, table);
-		iommu_flush_dte(iommu, devid);
-		goto out;
+		set_remap_table_entry(iommu, devid, table);
+		goto out_wait;
 	}
+	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
 	/* Nothing there yet, allocate new irq remapping table */
-	table = kzalloc(sizeof(*table), GFP_ATOMIC);
-	if (!table)
+	new_table = __alloc_irq_table();
+	if (!new_table)
+		return NULL;
+
+	spin_lock_irqsave(&iommu_table_lock, flags);
+
+	table = irq_lookup_table[devid];
+	if (table)
 		goto out_unlock;
 
-	/* Initialize table spin-lock */
-	spin_lock_init(&table->lock);
-
-	if (ioapic)
-		/* Keep the first 32 indexes free for IOAPIC interrupts */
-		table->min_index = 32;
-
-	table->table = kmem_cache_alloc(amd_iommu_irq_cache, GFP_ATOMIC);
-	if (!table->table) {
-		kfree(table);
-		table = NULL;
-		goto out_unlock;
+	table = irq_lookup_table[alias];
+	if (table) {
+		set_remap_table_entry(iommu, devid, table);
+		goto out_wait;
 	}
 
-	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-		memset(table->table, 0,
-		       MAX_IRQS_PER_TABLE * sizeof(u32));
-	else
-		memset(table->table, 0,
-		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
+	table = new_table;
+	new_table = NULL;
 
-	if (ioapic) {
-		int i;
+	set_remap_table_entry(iommu, devid, table);
+	if (devid != alias)
+		set_remap_table_entry(iommu, alias, table);
 
-		for (i = 0; i < 32; ++i)
-			iommu->irte_ops->set_allocated(table, i);
-	}
-
-	irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
-	iommu_flush_dte(iommu, devid);
-	if (devid != alias) {
-		irq_lookup_table[alias] = table;
-		set_dte_irq_entry(alias, table);
-		iommu_flush_dte(iommu, alias);
-	}
-
-out:
+out_wait:
 	iommu_completion_wait(iommu);
 
 out_unlock:
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock_irqrestore(&iommu_table_lock, flags);
 
+	if (new_table) {
+		kmem_cache_free(amd_iommu_irq_cache, new_table->table);
+		kfree(new_table);
+	}
 	return table;
 }
 
@@ -3673,11 +3699,11 @@ static int alloc_irq_index(u16 devid, int count)
 	if (!iommu)
 		return -ENODEV;
 
-	table = get_irq_table(devid, false);
+	table = alloc_irq_table(devid);
 	if (!table)
 		return -ENODEV;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	/* Scan table for free entries */
 	for (c = 0, index = table->min_index;
@@ -3700,7 +3726,7 @@ static int alloc_irq_index(u16 devid, int count)
 	index = -ENOSPC;
 
 out:
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	return index;
 }
@@ -3717,11 +3743,11 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
@@ -3732,7 +3758,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (data)
 		data->ref = entry;
 
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3750,13 +3776,13 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	table->table[index] = irte->val;
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3774,13 +3800,13 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return;
 
-	spin_lock_irqsave(&table->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 	iommu->irte_ops->clear_allocated(table, index);
-	spin_unlock_irqrestore(&table->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
@@ -3861,10 +3887,8 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 				 u8 vector, u32 dest_apicid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
-	struct iommu_dev_data *dev_data = search_dev_data(devid);
 
-	if (!dev_data || !dev_data->use_vapic ||
-	    !irte->lo.fields_remap.guest_mode) {
+	if (!irte->lo.fields_remap.guest_mode) {
 		irte->hi.fields.vector = vector;
 		irte->lo.fields_remap.destination = dest_apicid;
 		modify_irte_ga(devid, index, irte, NULL);
@@ -4070,7 +4094,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct amd_ir_data *data = NULL;
 	struct irq_cfg *cfg;
 	int i, ret, devid;
-	int index = -1;
+	int index;
 
 	if (!info)
 		return -EINVAL;
@@ -4094,10 +4118,26 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		return ret;
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (get_irq_table(devid, true))
+		struct irq_remap_table *table;
+		struct amd_iommu *iommu;
+
+		table = alloc_irq_table(devid);
+		if (table) {
+			if (!table->min_index) {
+				/*
+				 * Keep the first 32 indexes free for IOAPIC
+				 * interrupts.
+				 */
+				table->min_index = 32;
+				iommu = amd_iommu_rlookup_table[devid];
+				for (i = 0; i < 32; ++i)
+					iommu->irte_ops->set_allocated(table, i);
+			}
+			WARN_ON(table->min_index != 32);
 			index = info->ioapic_pin;
-		else
-			ret = -ENOMEM;
+		} else {
+			index = -ENOMEM;
+		}
 	} else {
 		index = alloc_irq_index(devid, nr_irqs);
 	}
@@ -4341,7 +4381,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
 	unsigned long flags;
 	struct amd_iommu *iommu;
-	struct irq_remap_table *irt;
+	struct irq_remap_table *table;
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	int devid = ir_data->irq_2_irte.devid;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4355,11 +4395,11 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	irt = get_irq_table(devid, false);
-	if (!irt)
+	table = get_irq_table(devid);
+	if (!table)
 		return -ENODEV;
 
-	spin_lock_irqsave(&irt->lock, flags);
+	raw_spin_lock_irqsave(&table->lock, flags);
 
 	if (ref->lo.fields_vapic.guest_mode) {
 		if (cpu >= 0)
@@ -4368,7 +4408,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 		barrier();
 	}
 
-	spin_unlock_irqrestore(&irt->lock, flags);
+	raw_spin_unlock_irqrestore(&table->lock, flags);
 
 	iommu_flush_irt(iommu, devid);
 	iommu_completion_wait(iommu);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d0346073..e3cd81b32a33 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1474,7 +1474,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 {
 	int ret;
 
-	spin_lock_init(&iommu->lock);
+	raw_spin_lock_init(&iommu->lock);
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f6b24c7d8b70..16b1404da58c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -406,7 +406,7 @@ extern bool amd_iommu_iotlb_sup;
 #define IRQ_TABLE_ALIGNMENT	128
 
 struct irq_remap_table {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned min_index;
 	u32 *table;
 };
@@ -488,7 +488,7 @@ struct amd_iommu {
 	int index;
 
 	/* locks the accesses to the hardware */
-	spinlock_t lock;
+	raw_spinlock_t lock;
 
 	/* Pointer to PCI device of this IOMMU */
 	struct pci_dev *dev;
@@ -625,7 +625,7 @@ struct devid_map {
  */
 struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
-	struct list_head dev_data_list;	  /* For global dev_data_list */
+	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
 	u16 alias;			  /* Alias Device ID */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 672c4f32311e..4754eb4298b1 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -101,8 +101,8 @@ struct k_itimer {
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
-		struct rcu_head		rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
 void run_posix_cpu_timers(struct task_struct *task);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ec09ce9a6012..ede5ef787865 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -429,7 +429,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_wait_for_timer(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f357877f0cb7..c5866984f12d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -471,7 +471,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -488,7 +488,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -797,20 +797,6 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	return overrun;
 }
 
-/*
- * Protected by RCU!
- */
-static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_set == common_timer_set)
-		hrtimer_wait_for_timer(&timr->it.real.timer);
-	else
-		/* FIXME: Whacky hack for posix-cpu-timers */
-		schedule_timeout(1);
-#endif
-}
-
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 			       bool absolute, bool sigev_none)
 {
@@ -841,6 +827,22 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
+/*
+ * Protected by RCU!
+ */
+static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
+{
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_wait_for_timer(&timr->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
+	else
+		/* FIXME: Whacky hack for posix-cpu-timers */
+		schedule_timeout(1);
+#endif
+}
+
 static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 {
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 49afef3cc384..37db86145c8b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -669,7 +669,7 @@ static notrace void trace_event_raw_event_synth(void *__data,
 			char *str_val = (char *)(long)var_ref_vals[var_ref_idx + i];
 			char *str_field = (char *)&entry->fields[n_u64];
 
-			strncpy(str_field, str_val, STR_VAR_LEN_MAX);
+			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
 			entry->fields[n_u64] = var_ref_vals[var_ref_idx + i];
@@ -1686,8 +1686,6 @@ static const char *hist_field_name(struct hist_field *field,
 	else if (field->flags & HIST_FIELD_FL_LOG2 ||
 		 field->flags & HIST_FIELD_FL_ALIAS)
 		field_name = hist_field_name(field->operands[0], ++level);
-	else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-		field_name = "common_timestamp";
 	else if (field->flags & HIST_FIELD_FL_CPU)
 		field_name = "cpu";
 	else if (field->flags & HIST_FIELD_FL_EXPR ||
@@ -1703,7 +1701,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = full_name;
 		} else
 			field_name = field->name;
-	}
+	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
+		field_name = "common_timestamp";
 
 	if (field_name == NULL)
 		field_name = "";
@@ -2053,7 +2052,7 @@ static void expr_field_str(struct hist_field *field, char *expr)
 
 	strcat(expr, hist_field_name(field, 0));
 
-	if (field->flags) {
+	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
@@ -3091,7 +3090,7 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
 
-			strncpy(str, val_str, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, STR_VAR_LEN_MAX);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);
@@ -4364,6 +4363,53 @@ static void print_onmatch_spec(struct seq_file *m,
 	seq_puts(m, ")");
 }
 
+static bool actions_match(struct hist_trigger_data *hist_data,
+			  struct hist_trigger_data *hist_data_test)
+{
+	unsigned int i, j;
+
+	if (hist_data->n_actions != hist_data_test->n_actions)
+		return false;
+
+	for (i = 0; i < hist_data->n_actions; i++) {
+		struct action_data *data = hist_data->actions[i];
+		struct action_data *data_test = hist_data_test->actions[i];
+
+		if (data->fn != data_test->fn)
+			return false;
+
+		if (data->n_params != data_test->n_params)
+			return false;
+
+		for (j = 0; j < data->n_params; j++) {
+			if (strcmp(data->params[j], data_test->params[j]) != 0)
+				return false;
+		}
+
+		if (data->fn == action_trace) {
+			if (strcmp(data->onmatch.synth_event_name,
+				   data_test->onmatch.synth_event_name) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event_system,
+				   data_test->onmatch.match_event_system) != 0)
+				return false;
+			if (strcmp(data->onmatch.match_event,
+				   data_test->onmatch.match_event) != 0)
+				return false;
+		} else if (data->fn == onmax_save) {
+			if (strcmp(data->onmax.var_str,
+				   data_test->onmax.var_str) != 0)
+				return false;
+			if (strcmp(data->onmax.fn_name,
+				   data_test->onmax.fn_name) != 0)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+
 static void print_actions_spec(struct seq_file *m,
 			       struct hist_trigger_data *hist_data)
 {
@@ -4859,23 +4905,15 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 	if (hist_field->var.name)
 		seq_printf(m, "%s=", hist_field->var.name);
 
-	if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
-		seq_puts(m, "common_timestamp");
-	else if (hist_field->flags & HIST_FIELD_FL_CPU)
+	if (hist_field->flags & HIST_FIELD_FL_CPU)
 		seq_puts(m, "cpu");
 	else if (field_name) {
 		if (hist_field->flags & HIST_FIELD_FL_VAR_REF ||
 		    hist_field->flags & HIST_FIELD_FL_ALIAS)
 			seq_putc(m, '$');
 		seq_printf(m, "%s", field_name);
-	}
-
-	if (hist_field->flags) {
-		const char *flags_str = get_hist_field_flags(hist_field);
-
-		if (flags_str)
-			seq_printf(m, ".%s", flags_str);
-	}
+	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
+		seq_puts(m, "common_timestamp");
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
@@ -5184,6 +5222,9 @@ static bool hist_trigger_match(struct event_trigger_data *data,
 	    (strcmp(data->filter_str, data_test->filter_str) != 0))
 		return false;
 
+	if (!actions_match(hist_data, hist_data_test))
+		return false;
+
 	return true;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 2e9afd4a0afd..be1e37b64ad0 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt26
+-rt27
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 3db4af5d0197..60a3f23927d9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -69,7 +69,6 @@ static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 
 static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(preemptible());
 	__this_cpu_write(kvm_arm_running_vcpu, vcpu);
 }
 
@@ -79,7 +78,6 @@ static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
  */
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
 {
-	BUG_ON(preemptible());
 	return __this_cpu_read(kvm_arm_running_vcpu);
 }
 
