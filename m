Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE459C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853B624BE4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B624BE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeFWM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:26:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeFWM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:26:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCPv4j467247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:25:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCPvcN467244;
        Sat, 23 Jun 2018 05:25:57 -0700
Date:   Sat, 23 Jun 2018 05:25:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-1c3fd056db38a5411ec06ef7ae52067408dee7fa@git.kernel.org>
Cc:     reinette.chatre@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <fccbb9b20f07655ab0a4df9fa1c1babc0288aea0.1529706536.git.reinette.chatre@intel.com>
References: <fccbb9b20f07655ab0a4df9fa1c1babc0288aea0.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Create character device exposing
 pseudo-locked region
Git-Commit-ID: 1c3fd056db38a5411ec06ef7ae52067408dee7fa
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

Commit-ID:  1c3fd056db38a5411ec06ef7ae52067408dee7fa
Gitweb:     https://git.kernel.org/tip/1c3fd056db38a5411ec06ef7ae52067408dee7fa
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:51 +0200

x86/intel_rdt: Create character device exposing pseudo-locked region

After a pseudo-locked region is created it needs to be made
available to user space for usage.

A character device supporting mmap() is created for each pseudo-locked
region. A user space application can now use mmap() system call to map
pseudo-locked region into its virtual address space.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/fccbb9b20f07655ab0a4df9fa1c1babc0288aea0.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h             |  14 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 282 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |   1 +
 3 files changed, 288 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8a7102cfbec7..b8e490a43290 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -138,6 +138,8 @@ struct mongroup {
  * @line_size:		size of the cache lines
  * @size:		size of pseudo-locked region in bytes
  * @kmem:		the kernel memory associated with pseudo-locked region
+ * @minor:		minor number of character device associated with this
+ *			region
  * @debugfs_dir:	pointer to this region's directory in the debugfs
  *			filesystem
  */
@@ -151,6 +153,7 @@ struct pseudo_lock_region {
 	unsigned int		line_size;
 	unsigned int		size;
 	void			*kmem;
+	unsigned int		minor;
 	struct dentry		*debugfs_dir;
 };
 
@@ -524,6 +527,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
 bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm);
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
+int rdt_pseudo_lock_init(void);
+void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
@@ -551,13 +556,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 
-/*
- * Define the hooks for Cache Pseudo-Locking to use within rdt_mount().
- * These are no-ops provided for the new kernfs changes to use as a
- * baseline in preparation for a conflict-free merge between it
- * (kernfs changes) and the Cache Pseudo-Locking enabling.
- */
-static inline int rdt_pseudo_lock_init(void) { return 0; }
-static inline void rdt_pseudo_lock_release(void) { }
-
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 5851f3e20742..5020ac3e83a1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
+#include <linux/mman.h>
 #include <linux/slab.h>
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
@@ -38,6 +39,14 @@
  */
 static u64 prefetch_disable_bits;
 
+/*
+ * Major number assigned to and shared by all devices exposing
+ * pseudo-locked regions.
+ */
+static unsigned int pseudo_lock_major;
+static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
+static struct class *pseudo_lock_class;
+
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
  *
@@ -89,6 +98,66 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
+/**
+ * pseudo_lock_minor_get - Obtain available minor number
+ * @minor: Pointer to where new minor number will be stored
+ *
+ * A bitmask is used to track available minor numbers. Here the next free
+ * minor number is marked as unavailable and returned.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+static int pseudo_lock_minor_get(unsigned int *minor)
+{
+	unsigned long first_bit;
+
+	first_bit = find_first_bit(&pseudo_lock_minor_avail, MINORBITS);
+
+	if (first_bit == MINORBITS)
+		return -ENOSPC;
+
+	__clear_bit(first_bit, &pseudo_lock_minor_avail);
+	*minor = first_bit;
+
+	return 0;
+}
+
+/**
+ * pseudo_lock_minor_release - Return minor number to available
+ * @minor: The minor number made available
+ */
+static void pseudo_lock_minor_release(unsigned int minor)
+{
+	__set_bit(minor, &pseudo_lock_minor_avail);
+}
+
+/**
+ * region_find_by_minor - Locate a pseudo-lock region by inode minor number
+ * @minor: The minor number of the device representing pseudo-locked region
+ *
+ * When the character device is accessed we need to determine which
+ * pseudo-locked region it belongs to. This is done by matching the minor
+ * number of the device to the pseudo-locked region it belongs.
+ *
+ * Minor numbers are assigned at the time a pseudo-locked region is associated
+ * with a cache instance.
+ *
+ * Return: On success return pointer to resource group owning the pseudo-locked
+ *         region, NULL on failure.
+ */
+static struct rdtgroup *region_find_by_minor(unsigned int minor)
+{
+	struct rdtgroup *rdtgrp, *rdtgrp_match = NULL;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->plr && rdtgrp->plr->minor == minor) {
+			rdtgrp_match = rdtgrp;
+			break;
+		}
+	}
+	return rdtgrp_match;
+}
+
 /**
  * pseudo_lock_region_init - Initialize pseudo-lock region information
  * @plr: pseudo-lock region
@@ -872,6 +941,8 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 {
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	struct task_struct *thread;
+	unsigned int new_minor;
+	struct device *dev;
 	int ret;
 
 	ret = pseudo_lock_region_alloc(plr);
@@ -916,11 +987,55 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 					    &pseudo_measure_fops);
 	}
 
+	ret = pseudo_lock_minor_get(&new_minor);
+	if (ret < 0) {
+		rdt_last_cmd_puts("unable to obtain a new minor number\n");
+		goto out_debugfs;
+	}
+
+	/*
+	 * Unlock access but do not release the reference. The
+	 * pseudo-locked region will still be here on return.
+	 *
+	 * The mutex has to be released temporarily to avoid a potential
+	 * deadlock with the mm->mmap_sem semaphore which is obtained in
+	 * the device_create() callpath below as well as before the mmap()
+	 * callback is called.
+	 */
+	mutex_unlock(&rdtgroup_mutex);
+
+	dev = device_create(pseudo_lock_class, NULL,
+			    MKDEV(pseudo_lock_major, new_minor),
+			    rdtgrp, "%s", rdtgrp->kn->name);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		rdt_last_cmd_printf("failed to create character device: %d\n",
+				    ret);
+		goto out_minor;
+	}
+
+	/* We released the mutex - check if group was removed while we did so */
+	if (rdtgrp->flags & RDT_DELETED) {
+		ret = -ENODEV;
+		goto out_device;
+	}
+
+	plr->minor = new_minor;
+
 	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
 	closid_free(rdtgrp->closid);
 	ret = 0;
 	goto out;
 
+out_device:
+	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
+out_minor:
+	pseudo_lock_minor_release(new_minor);
+out_debugfs:
+	debugfs_remove_recursive(plr->debugfs_dir);
 out_region:
 	pseudo_lock_region_clear(plr);
 out:
@@ -943,6 +1058,8 @@ out:
  */
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 {
+	struct pseudo_lock_region *plr = rdtgrp->plr;
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 		/*
 		 * Default group cannot be a pseudo-locked region so we can
@@ -953,7 +1070,172 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 	}
 
 	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
+	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
+	pseudo_lock_minor_release(plr->minor);
 
 free:
 	pseudo_lock_free(rdtgrp);
 }
+
+static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
+{
+	struct rdtgroup *rdtgrp;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdtgrp = region_find_by_minor(iminor(inode));
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
+	filp->private_data = rdtgrp;
+	atomic_inc(&rdtgrp->waitcount);
+	/* Perform a non-seekable open - llseek is not supported */
+	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
+static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
+{
+	struct rdtgroup *rdtgrp;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdtgrp = filp->private_data;
+	WARN_ON(!rdtgrp);
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+	filp->private_data = NULL;
+	atomic_dec(&rdtgrp->waitcount);
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
+{
+	/* Not supported */
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct pseudo_mmap_ops = {
+	.mremap = pseudo_lock_dev_mremap,
+};
+
+static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	unsigned long vsize = vma->vm_end - vma->vm_start;
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	struct pseudo_lock_region *plr;
+	struct rdtgroup *rdtgrp;
+	unsigned long physical;
+	unsigned long psize;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdtgrp = filp->private_data;
+	WARN_ON(!rdtgrp);
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
+	plr = rdtgrp->plr;
+
+	/*
+	 * Task is required to run with affinity to the cpus associated
+	 * with the pseudo-locked region. If this is not the case the task
+	 * may be scheduled elsewhere and invalidate entries in the
+	 * pseudo-locked region.
+	 */
+	if (!cpumask_subset(&current->cpus_allowed, &plr->d->cpu_mask)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
+
+	physical = __pa(plr->kmem) >> PAGE_SHIFT;
+	psize = plr->size - off;
+
+	if (off > plr->size) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENOSPC;
+	}
+
+	/*
+	 * Ensure changes are carried directly to the memory being mapped,
+	 * do not allow copy-on-write mapping.
+	 */
+	if (!(vma->vm_flags & VM_SHARED)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
+
+	if (vsize > psize) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENOSPC;
+	}
+
+	memset(plr->kmem + off, 0, vsize);
+
+	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
+			    vsize, vma->vm_page_prot)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EAGAIN;
+	}
+	vma->vm_ops = &pseudo_mmap_ops;
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static const struct file_operations pseudo_lock_dev_fops = {
+	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
+	.read =		NULL,
+	.write =	NULL,
+	.open =		pseudo_lock_dev_open,
+	.release =	pseudo_lock_dev_release,
+	.mmap =		pseudo_lock_dev_mmap,
+};
+
+static char *pseudo_lock_devnode(struct device *dev, umode_t *mode)
+{
+	struct rdtgroup *rdtgrp;
+
+	rdtgrp = dev_get_drvdata(dev);
+	if (mode)
+		*mode = 0600;
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
+}
+
+int rdt_pseudo_lock_init(void)
+{
+	int ret;
+
+	ret = register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
+	if (ret < 0)
+		return ret;
+
+	pseudo_lock_major = ret;
+
+	pseudo_lock_class = class_create(THIS_MODULE, "pseudo_lock");
+	if (IS_ERR(pseudo_lock_class)) {
+		ret = PTR_ERR(pseudo_lock_class);
+		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
+		return ret;
+	}
+
+	pseudo_lock_class->devnode = pseudo_lock_devnode;
+	return 0;
+}
+
+void rdt_pseudo_lock_release(void)
+{
+	class_destroy(pseudo_lock_class);
+	pseudo_lock_class = NULL;
+	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
+	pseudo_lock_major = 0;
+}
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bc52c593a87c..7b4a09d81a30 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2067,6 +2067,7 @@ static void rdt_kill_sb(struct super_block *sb)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
+	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
