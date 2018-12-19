Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA9221873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeLSKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:37:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLSKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:37:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBJAbU123192523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Dec 2018 02:37:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBJAbUSu3192520;
        Wed, 19 Dec 2018 02:37:30 -0800
Date:   Wed, 19 Dec 2018 02:37:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-bec04037e4e484f41ee4d9409e40616874169d20@git.kernel.org>
Cc:     bhelgaas@google.com, tglx@linutronix.de, douliyangs@gmail.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: bhelgaas@google.com, douliyangs@gmail.com, tglx@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181204155122.6327-2-douliyangs@gmail.com>
References: <20181204155122.6327-2-douliyangs@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/core: Introduce struct irq_affinity_desc
Git-Commit-ID: bec04037e4e484f41ee4d9409e40616874169d20
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bec04037e4e484f41ee4d9409e40616874169d20
Gitweb:     https://git.kernel.org/tip/bec04037e4e484f41ee4d9409e40616874169d20
Author:     Dou Liyang <douliyangs@gmail.com>
AuthorDate: Tue, 4 Dec 2018 23:51:20 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Dec 2018 11:32:08 +0100

genirq/core: Introduce struct irq_affinity_desc

The interrupt affinity management uses straight cpumask pointers to convey
the automatically assigned affinity masks for managed interrupts. The core
interrupt descriptor allocation also decides based on the pointer being non
NULL whether an interrupt is managed or not.

Devices which use managed interrupts usually have two classes of
interrupts:

  - Interrupts for multiple device queues
  - Interrupts for general device management

Currently both classes are treated the same way, i.e. as managed
interrupts. The general interrupts get the default affinity mask assigned
while the device queue interrupts are spread out over the possible CPUs.

Treating the general interrupts as managed is both a limitation and under
certain circumstances a bug. Assume the following situation:

 default_irq_affinity = 4..7

So if CPUs 4-7 are offlined, then the core code will shut down the device
management interrupts because the last CPU in their affinity mask went
offline.

It's also a limitation because it's desired to allow manual placement of
the general device interrupts for various reasons. If they are marked
managed then the interrupt affinity setting from both user and kernel space
is disabled.

To remedy that situation it's required to convey more information than the
cpumasks through various interfaces related to interrupt descriptor
allocation.

Instead of adding yet another argument, create a new data structure
'irq_affinity_desc' which for now just contains the cpumask. This struct
can be expanded to convey auxilliary information in the next step.

No functional change, just preparatory work.

[ tglx: Simplified logic and clarified changelog ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
Cc: kashyap.desai@broadcom.com
Cc: shivasharan.srikanteshwara@broadcom.com
Cc: sumit.saxena@broadcom.com
Cc: ming.lei@redhat.com
Cc: hch@lst.de
Cc: douliyang1@huawei.com
Link: https://lkml.kernel.org/r/20181204155122.6327-2-douliyangs@gmail.com

---
 drivers/pci/msi.c         |  9 ++++-----
 include/linux/interrupt.h | 14 ++++++++++++--
 include/linux/irq.h       |  6 ++++--
 include/linux/irqdomain.h |  6 ++++--
 include/linux/msi.h       |  4 ++--
 kernel/irq/affinity.c     | 22 ++++++++++++----------
 kernel/irq/devres.c       |  4 ++--
 kernel/irq/irqdesc.c      | 17 +++++++++--------
 kernel/irq/irqdomain.c    |  4 ++--
 kernel/irq/msi.c          |  8 ++++----
 10 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 265ed3e4c920..7a1c8a09efa5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -534,14 +534,13 @@ error_attrs:
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 {
-	struct cpumask *masks = NULL;
+	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
 	u16 control;
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
 
-
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(&dev->dev, nvec, masks);
 	if (!entry)
@@ -672,7 +671,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
 			      const struct irq_affinity *affd)
 {
-	struct cpumask *curmsk, *masks = NULL;
+	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
 
@@ -1264,7 +1263,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 
 		for_each_pci_msi_entry(entry, dev) {
 			if (i == nr)
-				return entry->affinity;
+				return &entry->affinity->mask;
 			i++;
 		}
 		WARN_ON_ONCE(1);
@@ -1276,7 +1275,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 				 nr >= entry->nvec_used))
 			return NULL;
 
-		return &entry->affinity[nr];
+		return &entry->affinity[nr].mask;
 	} else {
 		return cpu_possible_mask;
 	}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ca397ff40836..c44b7844dc83 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -257,6 +257,14 @@ struct irq_affinity {
 	int	*sets;
 };
 
+/**
+ * struct irq_affinity_desc - Interrupt affinity descriptor
+ * @mask:	cpumask to hold the affinity assignment
+ */
+struct irq_affinity_desc {
+	struct cpumask	mask;
+};
+
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
@@ -303,7 +311,9 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+struct irq_affinity_desc *
+irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -337,7 +347,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	return 0;
 }
 
-static inline struct cpumask *
+static inline struct irq_affinity_desc *
 irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
 {
 	return NULL;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c9bffda04a45..def2b2aac8b1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -27,6 +27,7 @@
 struct seq_file;
 struct module;
 struct msi_msg;
+struct irq_affinity_desc;
 enum irqchip_irq_state;
 
 /*
@@ -834,11 +835,12 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		      struct module *owner, const struct cpumask *affinity);
+		      struct module *owner,
+		      const struct irq_affinity_desc *affinity);
 
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct cpumask *affinity);
+			   const struct irq_affinity_desc *affinity);
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 068aa46f0d55..35965f41d7be 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -43,6 +43,7 @@ struct irq_chip;
 struct irq_data;
 struct cpumask;
 struct seq_file;
+struct irq_affinity_desc;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -266,7 +267,7 @@ extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
-				  const struct cpumask *affinity);
+				  const struct irq_affinity_desc *affinity);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -449,7 +450,8 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc, const struct cpumask *affinity);
+				   bool realloc,
+				   const struct irq_affinity_desc *affinity);
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index eb213b87617c..784fb52b9900 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -76,7 +76,7 @@ struct msi_desc {
 	unsigned int			nvec_used;
 	struct device			*dev;
 	struct msi_msg			msg;
-	struct cpumask			*affinity;
+	struct irq_affinity_desc	*affinity;
 
 	union {
 		/* PCI MSI/X specific data */
@@ -138,7 +138,7 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 #endif /* CONFIG_PCI_MSI */
 
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct cpumask *affinity);
+				 const struct irq_affinity_desc *affinity);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e423bff1928c..c0fe591b0dc9 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -99,7 +99,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
-				      struct cpumask *masks)
+				      struct irq_affinity_desc *masks)
 {
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	int last_affv = firstvec + numvecs;
@@ -117,7 +117,9 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(masks + curvec, masks + curvec, node_to_cpumask[n]);
+			cpumask_or(&masks[curvec].mask,
+					&masks[curvec].mask,
+					node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
@@ -150,7 +152,8 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				cpus_per_vec++;
 				--extra_vecs;
 			}
-			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
+			irq_spread_init_one(&masks[curvec].mask, nmsk,
+						cpus_per_vec);
 		}
 
 		done += v;
@@ -173,7 +176,7 @@ out:
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
-				    struct cpumask *masks)
+				    struct irq_affinity_desc *masks)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
@@ -226,15 +229,15 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * @nvecs:	The total number of vectors
  * @affd:	Description of the affinity requirements
  *
- * Returns the masks pointer or NULL if allocation failed.
+ * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
-struct cpumask *
+struct irq_affinity_desc *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
 	cpumask_var_t *node_to_cpumask;
-	struct cpumask *masks = NULL;
+	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
 	/*
@@ -254,8 +257,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
-
+		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
@@ -285,7 +287,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	else
 		curvec = affd->pre_vectors + usedvecs;
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 6a682c229e10..5d5378ea0afe 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -169,7 +169,7 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  * @cnt:	Number of consecutive irqs to allocate
  * @node:	Preferred node on which the irq descriptor should be allocated
  * @owner:	Owning module (can be NULL)
- * @affinity:	Optional pointer to an affinity mask array of size @cnt
+ * @affinity:	Optional pointer to an irq_affinity_desc array of size @cnt
  *		which hints where the irq descriptors should be allocated
  *		and which default affinities to use
  *
@@ -179,7 +179,7 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  */
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct cpumask *affinity)
+			   const struct irq_affinity_desc *affinity)
 {
 	struct irq_desc_devres *dr;
 	int base;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5f1b5b..cb401d6c5040 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -449,28 +449,29 @@ static void free_desc(unsigned int irq)
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
-		       const struct cpumask *affinity, struct module *owner)
+		       const struct irq_affinity_desc *affinity,
+		       struct module *owner)
 {
-	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
 	unsigned int flags;
 	int i;
 
 	/* Validate affinity mask(s) */
 	if (affinity) {
-		for (i = 0, mask = affinity; i < cnt; i++, mask++) {
-			if (cpumask_empty(mask))
+		for (i = 0; i < cnt; i++) {
+			if (cpumask_empty(&affinity[i].mask))
 				return -EINVAL;
 		}
 	}
 
 	flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
-	mask = NULL;
 
 	for (i = 0; i < cnt; i++) {
+		const struct cpumask *mask = NULL;
+
 		if (affinity) {
 			node = cpu_to_node(cpumask_first(affinity));
-			mask = affinity;
+			mask = &affinity->mask;
 			affinity++;
 		}
 		desc = alloc_desc(start + i, node, flags, mask, owner);
@@ -575,7 +576,7 @@ static void free_desc(unsigned int irq)
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
-			      const struct cpumask *affinity,
+			      const struct irq_affinity_desc *affinity,
 			      struct module *owner)
 {
 	u32 i;
@@ -705,7 +706,7 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct cpumask *affinity)
+		  struct module *owner, const struct irq_affinity_desc *affinity)
 {
 	int start, ret;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3366d11c3e02..8b0be4bd6565 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -969,7 +969,7 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
-			   int node, const struct cpumask *affinity)
+			   int node, const struct irq_affinity_desc *affinity)
 {
 	unsigned int hint;
 
@@ -1281,7 +1281,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
  */
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc, const struct cpumask *affinity)
+			    bool realloc, const struct irq_affinity_desc *affinity)
 {
 	int i, ret, virq;
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46645d..ad26fbcfbfc8 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -23,11 +23,11 @@
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
  *
- * If @affinity is not NULL then a an affinity array[@nvec] is allocated
- * and the affinity masks from @affinity are copied.
+ * If @affinity is not NULL then an affinity array[@nvec] is allocated
+ * and the affinity masks and flags from @affinity are copied.
  */
-struct msi_desc *
-alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
+struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
+				 const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc;
 
