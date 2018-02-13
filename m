Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966291AbeBMXtt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:53399 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966230AbeBMXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822351"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 17/22] x86/intel_rdt: Create character device exposing pseudo-locked region
Date: Tue, 13 Feb 2018 07:47:01 -0800
Message-Id: <2b2b20654cd86d0d602784126440c0a63515b665.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a pseudo-locked region has been created it needs to be made
available to user space to provide benefit there.

A character device supporting mmap() is created for each pseudo-locked
region. A user space application can now use mmap() system call to map
pseudo-locked region into its virtual address space.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 267 +++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index c03413021f45..b4923aa4314c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -26,6 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/kref.h>
 #include <linux/kthread.h>
+#include <linux/mman.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
@@ -52,6 +53,14 @@
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
 struct kernfs_node *pseudo_lock_kn;
 
 /*
@@ -189,6 +198,15 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 	plr->d = NULL;
 }
 
+/**
+ * pseudo_lock_minor_release - Return minor number to available
+ * @minor: The minor number being released
+ */
+static void pseudo_lock_minor_release(unsigned int minor)
+{
+	__set_bit(minor, &pseudo_lock_minor_avail);
+}
+
 static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 {
 	bool is_new_plr = (plr == new_plr);
@@ -199,6 +217,9 @@ static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 
 	if (plr->locked) {
 		plr->d->plr = NULL;
+		device_destroy(pseudo_lock_class,
+			       MKDEV(pseudo_lock_major, plr->minor));
+		pseudo_lock_minor_release(plr->minor);
 		/*
 		 * Resource groups come and go. Simply returning this
 		 * pseudo-locked region's bits to the default CLOS may
@@ -763,11 +784,74 @@ static int pseudo_lock_fn(void *_plr)
 	return 0;
 }
 
+/**
+ * pseudo_lock_minor_get - Obtain available minor number
+ * @minor: Pointer to where new minor number will be stored
+ *
+ * A bitmask is used to track available minor numbers. Here the next free
+ * minor number is allocated and returned.
+ *
+ * RETURNS:
+ * Zero on success, error on failure.
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
+ * LOCKING:
+ * rdt_pseudo_lock_mutex must be held
+ *
+ * RETURNS:
+ * On success returns pointer to pseudo-locked region, NULL on failure.
+ */
+static struct pseudo_lock_region *region_find_by_minor(unsigned int minor)
+{
+	struct pseudo_lock_region *plr_match = NULL;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+
+	lockdep_assert_held(&rdt_pseudo_lock_mutex);
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			if (d->plr && d->plr->minor == minor) {
+				plr_match = d->plr;
+				break;
+			}
+		}
+	}
+	return plr_match;
+}
+
 static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 			    struct rdt_resource *r,
 			    struct rdt_domain *d)
 {
 	struct task_struct *thread;
+	unsigned int new_minor;
+	struct device *dev;
 	int closid;
 	int ret, i;
 
@@ -858,11 +942,45 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 			pseudo_lock_clos_set(plr, i, d->ctrl_val[0]);
 	}
 
+	ret = pseudo_lock_minor_get(&new_minor);
+	if (ret < 0) {
+		rdt_last_cmd_puts("unable to obtain a new minor number\n");
+		goto out_clos_def;
+	}
+
 	plr->locked = true;
 	d->plr = plr;
 	new_plr = NULL;
 
 	/*
+	 * Unlock access but do not release the reference. The
+	 * pseudo-locked region will still be here when we return.
+	 * If anything else attempts to access the region while we do not
+	 * have the mutex the region would be considered locked.
+	 *
+	 * We need to release the mutex temporarily to avoid a potential
+	 * deadlock with the mm->mmap_sem semaphore which is obtained in
+	 * the device_create() callpath below as well as before our mmap()
+	 * callback is called.
+	 */
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+
+	dev = device_create(pseudo_lock_class, NULL,
+			    MKDEV(pseudo_lock_major, new_minor),
+			    plr, "%s", plr->kn->name);
+
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		rdt_last_cmd_printf("failed to created character device: %d\n",
+				    ret);
+		goto out_minor;
+	}
+
+	plr->minor = new_minor;
+
+	/*
 	 * We do not return CBM to CLOS here since that will result in a
 	 * CBM of all zeroes which is an illegal MSR write.
 	 */
@@ -870,6 +988,8 @@ static int pseudo_lock_doit(struct pseudo_lock_region *plr,
 	ret = 0;
 	goto out;
 
+out_minor:
+	pseudo_lock_minor_release(new_minor);
 out_clos_def:
 	pseudo_lock_clos_set(plr, 0, d->ctrl_val[0] | plr->cbm);
 out_closid:
@@ -1184,6 +1304,127 @@ static int pseudo_lock_debugfs_create(void)
 }
 #endif
 
+static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
+{
+	struct pseudo_lock_region *plr;
+
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	plr = region_find_by_minor(iminor(inode));
+	if (!plr) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -ENODEV;
+	}
+
+	filp->private_data = plr;
+	/* Perform a non-seekable open - llseek is not supported */
+	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
+	mutex_unlock(&rdt_pseudo_lock_mutex);
+
+	return 0;
+}
+
+static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
+{
+	mutex_lock(&rdt_pseudo_lock_mutex);
+	filp->private_data = NULL;
+	mutex_unlock(&rdt_pseudo_lock_mutex);
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
+static int pseudo_lock_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long vsize = vma->vm_end - vma->vm_start;
+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	struct pseudo_lock_region *plr;
+	unsigned long physical;
+	unsigned long psize;
+
+	mutex_lock(&rdt_pseudo_lock_mutex);
+
+	plr = file->private_data;
+	WARN_ON(!plr);
+	if (!plr) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -ENODEV;
+	}
+
+	/*
+	 * Task is required to run with affinity to the cpus associated
+	 * with the pseudo-locked region. If this is not the case the task
+	 * may be scheduled elsewhere and invalidate entries in the
+	 * pseudo-locked region.
+	 */
+	if (!cpumask_subset(&current->cpus_allowed, &plr->d->cpu_mask)) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -EINVAL;
+	}
+
+	physical = __pa(plr->kmem) >> PAGE_SHIFT;
+	psize = plr->size - off;
+
+	if (off > plr->size) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -ENOSPC;
+	}
+
+	/*
+	 * Ensure changes are carried directly to the memory being mapped,
+	 * do not allow copy-on-write mapping.
+	 */
+	if (!(vma->vm_flags & VM_SHARED)) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -EINVAL;
+	}
+
+	if (vsize > psize) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -ENOSPC;
+	}
+
+	memset(plr->kmem + off, 0, vsize);
+
+	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
+			    vsize, vma->vm_page_prot)) {
+		mutex_unlock(&rdt_pseudo_lock_mutex);
+		return -EAGAIN;
+	}
+	vma->vm_ops = &pseudo_mmap_ops;
+	mutex_unlock(&rdt_pseudo_lock_mutex);
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
+	struct pseudo_lock_region *plr;
+
+	plr = dev_get_drvdata(dev);
+	if (mode)
+		*mode = 0600;
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", plr->kn->name);
+}
+
 /**
  * rdt_pseudo_lock_fs_init - Create and initialize pseudo-locking files
  * @root: location in kernfs where directory and files should be created
@@ -1245,10 +1486,26 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 	if (prefetch_disable_bits == 0)
 		return 0;
 
+	ret = register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
+	if (ret < 0)
+		return ret;
+
+	pseudo_lock_major = ret;
+
+	pseudo_lock_class = class_create(THIS_MODULE, "pseudo_lock");
+	if (IS_ERR(pseudo_lock_class)) {
+		ret = PTR_ERR(pseudo_lock_class);
+		goto out_char;
+	}
+
+	pseudo_lock_class->devnode = pseudo_lock_devnode;
+
 	pseudo_lock_kn = kernfs_create_dir(root, "pseudo_lock",
 					   root->mode, NULL);
-	if (IS_ERR(pseudo_lock_kn))
-		return PTR_ERR(pseudo_lock_kn);
+	if (IS_ERR(pseudo_lock_kn)) {
+		ret = PTR_ERR(pseudo_lock_kn);
+		goto out_class;
+	}
 
 	kn = __kernfs_create_file(pseudo_lock_kn, "avail", 0444,
 				  0, &pseudo_lock_avail_ops,
@@ -1276,6 +1533,10 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
 error:
 	kernfs_remove(pseudo_lock_kn);
 	pseudo_lock_kn = NULL;
+out_class:
+	class_destroy(pseudo_lock_class);
+out_char:
+	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
 out:
 	return ret;
 }
@@ -1321,5 +1582,7 @@ void rdt_pseudo_lock_fs_remove(void)
 #endif
 	kernfs_remove(pseudo_lock_kn);
 	pseudo_lock_kn = NULL;
+	class_destroy(pseudo_lock_class);
+	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
 	mutex_unlock(&rdt_pseudo_lock_mutex);
 }
-- 
2.13.6
