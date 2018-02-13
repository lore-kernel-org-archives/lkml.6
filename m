Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966353AbeBMXvh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:51:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:53398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966064AbeBMXti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822337"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write - pseudo-locking core
Date: Tue, 13 Feb 2018 07:46:57 -0800
Message-Id: <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user writes the requested pseudo-locking schemata it will trigger
the pseudo-locking of equivalent sized memory. A successful return from
this schemata write means that the pseudo-locking succeeded.

To support the pseudo-locking we first initialize as much as we can
about the region that will be pseudo-locked. This includes, how much
memory does the requested bitmask represent, which CPU the requested
region is associated with, and what is the cache line size of that cache
(so that we know what stride to use for locking). At this point a
contiguous block of memory matching the requested bitmask is allocated.

After initialization the pseudo-locking is performed. A temporary CAT
allocation is made to reflect the requested bitmask and with this new
class of service active and interference minimized, the allocated memory
is loaded into the cache. This completes the pseudo-locking of kernel
memory.

As part of the pseudo-locking the pseudo-locked region is moved to
the RDT domain to which it belongs. We thus also need to ensure that
cleanups happen in this area when there is a directory removal or
unmount request.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |   2 +
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 573 +++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |   3 +-
 3 files changed, 571 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 2c4e13252057..85f9ad6de113 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -468,6 +468,8 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode);
 int rdt_pseudo_lock_rmdir(struct kernfs_node *kn);
 int pseudo_lock_schemata_show(struct kernfs_open_file *of,
 			      struct seq_file *seq, void *v);
+ssize_t pseudo_lock_schemata_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off);
 int pseudo_lock_size_show(struct kernfs_open_file *of,
 			  struct seq_file *seq, void *v);
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index f6932a7de6e7..1f351b7170ef 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -19,12 +19,18 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/kernfs.h>
 #include <linux/kref.h>
+#include <linux/kthread.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 #include <asm/intel-family.h>
+#include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
 /*
@@ -43,6 +49,20 @@ static u64 prefetch_disable_bits;
 struct kernfs_node *pseudo_lock_kn;
 
 /*
+ * Only one pseudo-locked region can be set up at a time and that is
+ * enforced by taking the rdt_pseudo_lock_mutex when the user writes the
+ * requested schemata to the resctrl file and releasing the mutex on
+ * completion. The thread locking the kernel memory into the cache starts
+ * and completes during this time so we can be sure that only one thread
+ * can run at any time.
+ * The functions starting the pseudo-locking thread needs to wait for its
+ * completion and since there can only be one we have a global workqueue
+ * and variable to support this.
+ */
+static DECLARE_WAIT_QUEUE_HEAD(wq);
+static int thread_done;
+
+/*
  * Protect the pseudo_lock_region access. Since we will link to
  * pseudo_lock_region from rdt domains rdtgroup_mutex should be obtained
  * first if needed.
@@ -53,26 +73,39 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
  * struct pseudo_lock_region - pseudo-lock region information
  * @kn:			kernfs node representing this region in the resctrl
  *			filesystem
+ * @r:			point back to the rdt_resource to which this
+ *			pseudo-locked region belongs
+ * @d:			point back to the rdt_domain to which this
+ *			pseudo-locked region belongs
  * @cbm:		bitmask of the pseudo-locked region
  * @size:		size of pseudo-locked region in bytes
+ * @line_size:		size of the cache lines
  * @cpu:		core associated with the cache on which the setup code
  *			will be run
+ * @closid:		CAT class of service that will be used temporarily
+ *			to initialize this pseudo-locked region
  * @minor:		minor number of character device associated with this
  *			region
  * @locked:		state indicating if this region has been locked or not
  * @refcount:		how many are waiting to access this pseudo-lock
  *			region via kernfs
  * @deleted:		user requested removal of region via rmdir on kernfs
+ * @kmem:		the kernel memory associated with pseudo-locked region
  */
 struct pseudo_lock_region {
 	struct kernfs_node	*kn;
+	struct rdt_resource	*r;
+	struct rdt_domain	*d;
 	u32			cbm;
 	unsigned int		size;
+	unsigned int		line_size;
 	int			cpu;
+	int			closid;
 	unsigned int		minor;
 	bool			locked;
 	struct kref		refcount;
 	bool			deleted;
+	void			*kmem;
 };
 
 /*
@@ -85,6 +118,55 @@ struct pseudo_lock_region {
  */
 static struct pseudo_lock_region *new_plr;
 
+/*
+ * Helper to write 64bit value to MSR without tracing. Used when
+ * use of the cache should be restricted and use of registers used
+ * for local variables should be avoided.
+ */
+static inline void pseudo_wrmsrl_notrace(unsigned int msr, u64 val)
+{
+	__wrmsr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
+}
+
+/**
+ * pseudo_lock_clos_set - Program requested class of service
+ * @plr:    pseudo-locked region identifying cache that will have its
+ *          class of service modified
+ * @closid: class of service that should be modified
+ * @bm:     new bitmask for @closid
+ */
+static int pseudo_lock_clos_set(struct pseudo_lock_region *plr,
+				int closid, u32 bm)
+{
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	int ret;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list)
+			d->have_new_ctrl = false;
+	}
+
+	r = plr->r;
+	d = plr->d;
+	d->new_ctrl = bm;
+	d->have_new_ctrl = true;
+
+	ret = update_domains(r, closid);
+
+	return ret;
+}
+
+static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
+{
+	plr->size = 0;
+	plr->line_size = 0;
+	kfree(plr->kmem);
+	plr->kmem = NULL;
+	plr->r = NULL;
+	plr->d = NULL;
+}
+
 static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 {
 	bool is_new_plr = (plr == new_plr);
@@ -93,6 +175,23 @@ static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
 	if (!plr->deleted)
 		return;
 
+	if (plr->locked) {
+		plr->d->plr = NULL;
+		/*
+		 * Resource groups come and go. Simply returning this
+		 * pseudo-locked region's bits to the default CLOS may
+		 * result in default CLOS to become fragmented, causing
+		 * the setting of its bitmask to fail. Ensure it is valid
+		 * first. If this check does fail we cannot return the bits
+		 * to the default CLOS and userspace intervention would be
+		 * required to ensure portions of the cache do not go
+		 * unused.
+		 */
+		if (cbm_validate_val(plr->d->ctrl_val[0] | plr->cbm, plr->r))
+			pseudo_lock_clos_set(plr, 0,
+					     plr->d->ctrl_val[0] | plr->cbm);
+		pseudo_lock_region_clear(plr);
+	}
 	kfree(plr);
 	if (is_new_plr)
 		new_plr = NULL;
@@ -178,17 +277,17 @@ static void pseudo_lock_region_kn_unlock(struct kernfs_node *kn)
  * @r: resource to which this cache instance belongs
  * @d: domain representing the cache instance
  *
- * Availability for pseudo-locking is determined as follows:
+ * Pseudo-locked regions are set up with wbinvd, limiting us to one region
+ * per cache instance.
+ *
+ * If no other pseudo-locked region present on this cache instance
+ * availability for pseudo-locking is determined as follows:
  * * Cache area is in use by default COS.
  * * Cache area is NOT in use by any other (other than default) COS.
  * * Cache area is not shared with any other entity. Specifically, the
  *   cache area does not appear in "Bitmask of Shareable Resource with Other
  *   executing entities" found in EBX during CAT enumeration.
  *
- * Below is also required to determine availability and will be
- * added in later:
- * * Cache area is not currently pseudo-locked.
- *
  * LOCKING:
  * rdtgroup_mutex is expected to be held when called
  *
@@ -203,6 +302,13 @@ static u32 pseudo_lock_avail_get(struct rdt_resource *r, struct rdt_domain *d)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	/*
+	 * Nothing available if a pseudo-locked region already associated
+	 * with this cache instance.
+	 */
+	if (d->plr)
+		return 0;
+
 	avail = d->ctrl_val[0];
 	for (i = 1; i < r->num_closid; i++) {
 		if (closid_allocated(i))
@@ -213,6 +319,34 @@ static u32 pseudo_lock_avail_get(struct rdt_resource *r, struct rdt_domain *d)
 	return avail;
 }
 
+/**
+ * pseudo_lock_space_avail - returns if any space available for pseudo-locking
+ *
+ * Checks all cache instances on system for any regions available for
+ * pseudo-locking.
+ *
+ * LOCKING:
+ * rdtgroup_mutex is expected to be held when called
+ *
+ * RETURNS:
+ * true if any cache instance has space available for pseudo-locking, false
+ * otherwise
+ */
+static bool pseudo_lock_space_avail(void)
+{
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			if (pseudo_lock_avail_get(r, d) > 0)
+				return true;
+		}
+	}
+	return false;
+}
+
 static int pseudo_lock_avail_show(struct seq_file *sf, void *v)
 {
 	struct rdt_resource *r;
@@ -260,6 +394,9 @@ int pseudo_lock_schemata_show(struct kernfs_open_file *of,
 		for_each_alloc_enabled_rdt_resource(r) {
 			seq_printf(seq, "%s:uninitialized\n", r->name);
 		}
+	} else {
+		seq_printf(seq, "%s:%d=%x\n", plr->r->name,
+			   plr->d->id, plr->cbm);
 	}
 
 out:
@@ -267,6 +404,418 @@ int pseudo_lock_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+/**
+ * init_from_cache_details - Initialize pseudo-lock region info from cache data
+ *
+ * When a user requests a cache region to be locked the request is provided
+ * as a bitmask. We need to allocate memory of matching size so here we
+ * translate the requested bitmask into how many bytes it represents. This
+ * is done by dividing the total cache size by the CBM len to first
+ * determine how many bytes each bit in bitmask represents, then
+ * multiply that with how many bits were set in requested bitmask.
+ *
+ * Also set the cache line size to know the stride with which data needs to
+ * be accessed to be pseudo-locked.
+ */
+static int init_from_cache_details(struct pseudo_lock_region *plr,
+				   struct rdt_resource *r)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(plr->cpu);
+	unsigned int cbm_len = r->cache.cbm_len;
+	int num_b;
+	int i;
+
+	num_b = bitmap_weight((unsigned long *)&plr->cbm, cbm_len);
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == r->cache_level) {
+			plr->size = ci->info_list[i].size / cbm_len * num_b;
+			plr->line_size = ci->info_list[i].coherency_line_size;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int pseudo_lock_region_init(struct pseudo_lock_region *plr,
+				   struct rdt_resource *r,
+				   struct rdt_domain *d)
+{
+	unsigned long b_req = plr->cbm;
+	unsigned long b_avail;
+	int ret;
+
+	b_avail = pseudo_lock_avail_get(r, d);
+
+	if (!bitmap_subset(&b_req, &b_avail, r->cache.cbm_len)) {
+		rdt_last_cmd_puts("requested bitmask not available\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * Use the first cpu we find that is associated with the
+	 * cache selected.
+	 */
+	plr->cpu = cpumask_first(&d->cpu_mask);
+
+	if (!cpu_online(plr->cpu)) {
+		rdt_last_cmd_printf("cpu %u associated with cache not online\n",
+				    plr->cpu);
+		return -ENODEV;
+	}
+
+	ret = init_from_cache_details(plr, r);
+	if (ret < 0) {
+		rdt_last_cmd_puts("unable to lookup cache details\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * We do not yet support contiguous regions larger than
+	 * KMALLOC_MAX_SIZE
+	 */
+	if (plr->size > KMALLOC_MAX_SIZE) {
+		rdt_last_cmd_puts("requested region exceeds maximum size\n");
+		return -E2BIG;
+	}
+
+	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
+	if (!plr->kmem) {
+		rdt_last_cmd_puts("unable to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	plr->r = r;
+	plr->d = d;
+
+	return 0;
+}
+
+/**
+ * pseudo_lock_fn - Load kernel memory into cache
+ *
+ * This is the core pseudo-locking function.
+ *
+ * First we ensure that the kernel memory cannot be found in the cache.
+ * Then, while taking care that there will be as little interference as
+ * possible, each cache line of the memory to be loaded is touched while
+ * core is running with class of service set to the bitmask of the
+ * pseudo-locked region. After this is complete no future CAT allocations
+ * will be allowed to overlap with this bitmask.
+ *
+ * Local register variables are utilized to ensure that the memory region
+ * to be locked is the only memory access made during the critical locking
+ * loop.
+ */
+static int pseudo_lock_fn(void *_plr)
+{
+	struct pseudo_lock_region *plr = _plr;
+	u32 rmid_p, closid_p;
+	unsigned long flags;
+	u64 i;
+#ifdef CONFIG_KASAN
+	/*
+	 * The registers used for local register variables are also used
+	 * when KASAN is active. When KASAN is active we use a regular
+	 * variable to ensure we always use a valid pointer, but the cost
+	 * is that this variable will enter the cache through evicting the
+	 * memory we are trying to lock into the cache. Thus expect lower
+	 * pseudo-locking success rate when KASAN is active.
+	 */
+	unsigned int line_size;
+	unsigned int size;
+	void *mem_r;
+#else
+	register unsigned int line_size asm("esi");
+	register unsigned int size asm("edi");
+#ifdef CONFIG_X86_64
+	register void *mem_r asm("rbx");
+#else
+	register void *mem_r asm("ebx");
+#endif /* CONFIG_X86_64 */
+#endif /* CONFIG_KASAN */
+
+	/*
+	 * Make sure none of the allocated memory is cached. If it is we
+	 * will get a cache hit in below loop from outside of pseudo-locked
+	 * region.
+	 * wbinvd (as opposed to clflush/clflushopt) is required to
+	 * increase likelihood that allocated cache portion will be filled
+	 * with associated memory
+	 */
+	wbinvd();
+
+	preempt_disable();
+	local_irq_save(flags);
+	/*
+	 * Call wrmsr and rdmsr as directly as possible to avoid tracing
+	 * clobbering local register variables or affecting cache accesses.
+	 */
+	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	closid_p = this_cpu_read(pqr_state.cur_closid);
+	rmid_p = this_cpu_read(pqr_state.cur_rmid);
+	mem_r = plr->kmem;
+	size = plr->size;
+	line_size = plr->line_size;
+	__wrmsr(IA32_PQR_ASSOC, rmid_p, plr->closid);
+	/*
+	 * Cache was flushed earlier. Now access kernel memory to read it
+	 * into cache region associated with just activated plr->closid.
+	 * Loop over data twice:
+	 * - In first loop the cache region is shared with the page walker
+	 *   as it populates the paging structure caches (including TLB).
+	 * - In the second loop the paging structure caches are used and
+	 *   cache region is populated with the memory being referenced.
+	 */
+	for (i = 0; i < size; i += PAGE_SIZE) {
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			:
+			: "r" (mem_r), "r" (i)
+			: "%eax", "memory");
+	}
+	for (i = 0; i < size; i += line_size) {
+		asm volatile("mov (%0,%1,1), %%eax\n\t"
+			:
+			: "r" (mem_r), "r" (i)
+			: "%eax", "memory");
+	}
+	__wrmsr(IA32_PQR_ASSOC, rmid_p, closid_p);
+	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	local_irq_restore(flags);
+	preempt_enable();
+
+	thread_done = 1;
+	wake_up_interruptible(&wq);
+	return 0;
+}
+
+static int pseudo_lock_doit(struct pseudo_lock_region *plr,
+			    struct rdt_resource *r,
+			    struct rdt_domain *d)
+{
+	struct task_struct *thread;
+	int closid;
+	int ret, i;
+
+	/*
+	 * With the usage of wbinvd we can only support one pseudo-locked
+	 * region per domain at this time.
+	 */
+	if (d->plr) {
+		rdt_last_cmd_puts("pseudo-locked region exists on cache\n");
+		return -ENOSPC;
+	}
+
+	ret = pseudo_lock_region_init(plr, r, d);
+	if (ret < 0)
+		return ret;
+
+	closid = closid_alloc();
+	if (closid < 0) {
+		ret = closid;
+		rdt_last_cmd_puts("unable to obtain free closid\n");
+		goto out_region;
+	}
+
+	/*
+	 * Ensure we end with a valid default CLOS. If a pseudo-locked
+	 * region in middle of possible bitmasks is selected it will split
+	 * up default CLOS which would be a fault and for which handling
+	 * is unclear so we fail back to userspace. Validation will also
+	 * ensure that default CLOS is not zero, keeping some cache
+	 * available to rest of system.
+	 */
+	if (!cbm_validate_val(d->ctrl_val[0] & ~plr->cbm, r)) {
+		ret = -EINVAL;
+		rdt_last_cmd_printf("bm 0x%x causes invalid clos 0 bm 0x%x\n",
+				    plr->cbm, d->ctrl_val[0] & ~plr->cbm);
+		goto out_closid;
+	}
+
+	ret = pseudo_lock_clos_set(plr, 0, d->ctrl_val[0] & ~plr->cbm);
+	if (ret < 0) {
+		rdt_last_cmd_printf("unable to set clos 0 bitmask to 0x%x\n",
+				    d->ctrl_val[0] & ~plr->cbm);
+		goto out_closid;
+	}
+
+	ret = pseudo_lock_clos_set(plr, closid, plr->cbm);
+	if (ret < 0) {
+		rdt_last_cmd_printf("unable to set closid %d bitmask to 0x%x\n",
+				    closid, plr->cbm);
+		goto out_clos_def;
+	}
+
+	plr->closid = closid;
+
+	thread_done = 0;
+
+	thread = kthread_create_on_node(pseudo_lock_fn, plr,
+					cpu_to_node(plr->cpu),
+					"pseudo_lock/%u", plr->cpu);
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
+		/*
+		 * We do not return CBM to newly allocated CLOS here on
+		 * error path since that will result in a CBM of all
+		 * zeroes which is an illegal MSR write.
+		 */
+		goto out_clos_def;
+	}
+
+	kthread_bind(thread, plr->cpu);
+	wake_up_process(thread);
+
+	ret = wait_event_interruptible(wq, thread_done == 1);
+	if (ret < 0) {
+		rdt_last_cmd_puts("locking thread interrupted\n");
+		goto out_clos_def;
+	}
+
+	/*
+	 * closid will be released soon but its CBM as well as CBM of not
+	 * yet allocated CLOS as stored in the array will remain. Ensure
+	 * that CBM will be what is currently the default CLOS, which
+	 * excludes pseudo-locked region.
+	 */
+	for (i = 1; i < r->num_closid; i++) {
+		if (i == closid || !closid_allocated(i))
+			pseudo_lock_clos_set(plr, i, d->ctrl_val[0]);
+	}
+
+	plr->locked = true;
+	d->plr = plr;
+	new_plr = NULL;
+
+	/*
+	 * We do not return CBM to CLOS here since that will result in a
+	 * CBM of all zeroes which is an illegal MSR write.
+	 */
+	closid_free(closid);
+	ret = 0;
+	goto out;
+
+out_clos_def:
+	pseudo_lock_clos_set(plr, 0, d->ctrl_val[0] | plr->cbm);
+out_closid:
+	closid_free(closid);
+out_region:
+	pseudo_lock_region_clear(plr);
+out:
+	return ret;
+}
+
+/**
+ * pseudo_lock_schemata_write - process user's pseudo-locking request
+ *
+ * User provides a schemata in format of RESOURCE:ID=BITMASK with the
+ * following meaning:
+ * RESOURCE - Name of the RDT resource (rdt_resource->name) that will be
+ *            pseudo-locked.
+ * ID       - id of the particular instace of RESOURCE that will be
+ *            pseudo-locked. This maps to rdt_domain->id.
+ * BITMASK  - The bitmask specifying the region of cache that should be
+ *            pseudo-locked.
+ *
+ * RETURNS:
+ * On success the user's requested region has been pseudo-locked
+ */
+ssize_t pseudo_lock_schemata_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	struct pseudo_lock_region *plr;
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+	char *resname, *dom;
+	bool found = false;
+	int ret = -EINVAL;
+	int dom_id;
+	u32 b_req;
+
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	cpus_read_lock();
+
+	plr = pseudo_lock_region_kn_lock(of->kn);
+	if (!plr) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	rdt_last_cmd_clear();
+
+	/* Do not lock a region twice. */
+	if (plr->locked) {
+		ret = -EEXIST;
+		rdt_last_cmd_puts("region is already locked\n");
+		goto out;
+	}
+
+	if (plr != new_plr) {
+		rdt_last_cmd_puts("region has already been initialized\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	buf[nbytes - 1] = '\0';
+
+	resname = strsep(&buf, ":");
+	if (!buf) {
+		rdt_last_cmd_puts("schemata missing ':'\n");
+		goto out;
+	}
+
+	dom = strsep(&buf, "=");
+	if (!buf) {
+		rdt_last_cmd_puts("schemata missing '='\n");
+		goto out;
+	}
+
+	ret = kstrtoint(dom, 10, &dom_id);
+	if (ret < 0 || dom_id < 0) {
+		rdt_last_cmd_puts("unable to parse cache id\n");
+		goto out;
+	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		if (!strcmp(resname, r->name)) {
+			found = true;
+			ret = kstrtou32(buf, 16, &b_req);
+			if (ret) {
+				rdt_last_cmd_puts("unable to parse bitmask\n");
+				goto out;
+			}
+			if (!cbm_validate_val(b_req, r)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			plr->cbm = b_req;
+			list_for_each_entry(d, &r->domains, list) {
+				if (d->id == dom_id) {
+					ret = pseudo_lock_doit(plr, r, d);
+					goto out;
+				}
+			}
+			rdt_last_cmd_puts("no matching cache instance\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	if (!found) {
+		rdt_last_cmd_puts("invalid resource name\n");
+		ret = -EINVAL;
+	}
+
+out:
+	pseudo_lock_region_kn_unlock(of->kn);
+	cpus_read_unlock();
+	return ret ?: nbytes;
+}
+
 int pseudo_lock_size_show(struct kernfs_open_file *of,
 			  struct seq_file *seq, void *v)
 {
@@ -295,7 +844,7 @@ int rdt_pseudo_lock_mkdir(const char *name, umode_t mode)
 	mutex_lock(&rdtgroup_mutex);
 	mutex_lock(&rdt_pseudo_lock_mutex);
 
-	if (new_plr) {
+	if (new_plr || !pseudo_lock_space_avail()) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -525,6 +1074,9 @@ int rdt_pseudo_lock_fs_init(struct kernfs_node *root)
  */
 void rdt_pseudo_lock_fs_remove(void)
 {
+	struct rdt_resource *r;
+	struct rdt_domain *d;
+
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (!pseudo_lock_kn)
@@ -536,6 +1088,15 @@ void rdt_pseudo_lock_fs_remove(void)
 		new_plr->deleted = true;
 		__pseudo_lock_region_release(new_plr);
 	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			if (d->plr) {
+				d->plr->deleted = true;
+				__pseudo_lock_region_release(d->plr);
+			}
+		}
+	}
 	kernfs_remove(pseudo_lock_kn);
 	pseudo_lock_kn = NULL;
 	mutex_unlock(&rdt_pseudo_lock_mutex);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index a7cbaf85ed54..5e55cd10ce31 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -861,9 +861,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "schemata",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= pseudo_lock_schemata_show,
+		.write		= pseudo_lock_schemata_write,
 		.fflags		= RF_PSEUDO_LOCK,
 	},
 	{
-- 
2.13.6
