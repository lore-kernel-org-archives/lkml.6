Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935097AbeEINQf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:16:35 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:43325 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934594AbeEINQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:16:34 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="54094683"
From: Paul Durrant <paul.durrant@citrix.com>
To: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: Paul Durrant <paul.durrant@citrix.com>,
        Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v5] xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE
Date: Wed, 9 May 2018 14:16:12 +0100
Message-ID: <20180509131612.21107-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My recent Xen patch series introduces a new HYPERVISOR_memory_op to
support direct priv-mapping of certain guest resources (such as ioreq
pages, used by emulators) by a tools domain, rather than having to access
such resources via the guest P2M.

This patch adds the necessary infrastructure to the privcmd driver and
Xen MMU code to support direct resource mapping.

NOTE: The adjustment in the MMU code is partially cosmetic. Xen will now
      allow a PV tools domain to map guest pages either by GFN or MFN, thus
      the term 'mfn' has been swapped for 'pfn' in the lower layers of the
      remap code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v5:
 - Handle the case of xen_feature(XENFEAT_auto_translated_physmap) &&
   (PAGE_SIZE > XEN_PAGE_SIZE)

v4:
 - Remove stray line of debug that causes a build warning on ARM 32-bit

v3:
 - Addres comments from Boris
 - Fix ARM build

v2:
 - Fix bug when mapping multiple pages of a resource
---
 arch/arm/xen/enlighten.c       |  11 ++++
 arch/x86/xen/mmu.c             |  60 +++++++++++++------
 drivers/xen/privcmd.c          | 133 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/xen/privcmd.h     |  11 ++++
 include/xen/interface/memory.h |  66 ++++++++++++++++++++
 include/xen/interface/xen.h    |   7 ++-
 include/xen/xen-ops.h          |  24 +++++++-
 7 files changed, 291 insertions(+), 21 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ba7f4c8f5c3e..8073625371f5 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -89,6 +89,17 @@ int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL_GPL(xen_unmap_domain_gfn_range);
 
+/* Not used by XENFEAT_auto_translated guests. */
+int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
+			       unsigned long addr,
+			       xen_pfn_t *mfn, int nr,
+			       int *err_ptr, pgprot_t prot,
+			       unsigned int domid, struct page **pages)
+{
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
+
 static void xen_read_wallclock(struct timespec64 *ts)
 {
 	u32 version;
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index d33e7dbe3129..af2960cb7a3e 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -65,37 +65,44 @@ static void xen_flush_tlb_all(void)
 #define REMAP_BATCH_SIZE 16
 
 struct remap_data {
-	xen_pfn_t *mfn;
+	xen_pfn_t *pfn;
 	bool contiguous;
+	bool no_translate;
 	pgprot_t prot;
 	struct mmu_update *mmu_update;
 };
 
-static int remap_area_mfn_pte_fn(pte_t *ptep, pgtable_t token,
+static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
 				 unsigned long addr, void *data)
 {
 	struct remap_data *rmd = data;
-	pte_t pte = pte_mkspecial(mfn_pte(*rmd->mfn, rmd->prot));
+	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
 
-	/* If we have a contiguous range, just update the mfn itself,
-	   else update pointer to be "next mfn". */
+	/*
+	 * If we have a contiguous range, just update the pfn itself,
+	 * else update pointer to be "next pfn".
+	 */
 	if (rmd->contiguous)
-		(*rmd->mfn)++;
+		(*rmd->pfn)++;
 	else
-		rmd->mfn++;
+		rmd->pfn++;
 
-	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr | MMU_NORMAL_PT_UPDATE;
+	rmd->mmu_update->ptr = virt_to_machine(ptep).maddr;
+	rmd->mmu_update->ptr |= rmd->no_translate ?
+		MMU_PT_UPDATE_NO_TRANSLATE :
+		MMU_NORMAL_PT_UPDATE;
 	rmd->mmu_update->val = pte_val_ma(pte);
 	rmd->mmu_update++;
 
 	return 0;
 }
 
-static int do_remap_gfn(struct vm_area_struct *vma,
+static int do_remap_pfn(struct vm_area_struct *vma,
 			unsigned long addr,
-			xen_pfn_t *gfn, int nr,
+			xen_pfn_t *pfn, int nr,
 			int *err_ptr, pgprot_t prot,
-			unsigned domid,
+			unsigned int domid,
+			bool no_translate,
 			struct page **pages)
 {
 	int err = 0;
@@ -106,11 +113,14 @@ static int do_remap_gfn(struct vm_area_struct *vma,
 
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_IO)) == (VM_PFNMAP | VM_IO)));
 
-	rmd.mfn = gfn;
+	rmd.pfn = pfn;
 	rmd.prot = prot;
-	/* We use the err_ptr to indicate if there we are doing a contiguous
-	 * mapping or a discontigious mapping. */
+	/*
+	 * We use the err_ptr to indicate if there we are doing a contiguous
+	 * mapping or a discontigious mapping.
+	 */
 	rmd.contiguous = !err_ptr;
+	rmd.no_translate = no_translate;
 
 	while (nr) {
 		int index = 0;
@@ -121,7 +131,7 @@ static int do_remap_gfn(struct vm_area_struct *vma,
 
 		rmd.mmu_update = mmu_update;
 		err = apply_to_page_range(vma->vm_mm, addr, range,
-					  remap_area_mfn_pte_fn, &rmd);
+					  remap_area_pfn_pte_fn, &rmd);
 		if (err)
 			goto out;
 
@@ -175,7 +185,8 @@ int xen_remap_domain_gfn_range(struct vm_area_struct *vma,
 	if (xen_feature(XENFEAT_auto_translated_physmap))
 		return -EOPNOTSUPP;
 
-	return do_remap_gfn(vma, addr, &gfn, nr, NULL, prot, domid, pages);
+	return do_remap_pfn(vma, addr, &gfn, nr, NULL, prot, domid, false,
+			    pages);
 }
 EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_range);
 
@@ -194,10 +205,25 @@ int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
 	 * cause of "wrong memory was mapped in".
 	 */
 	BUG_ON(err_ptr == NULL);
-	return do_remap_gfn(vma, addr, gfn, nr, err_ptr, prot, domid, pages);
+	return do_remap_pfn(vma, addr, gfn, nr, err_ptr, prot, domid,
+			    false, pages);
 }
 EXPORT_SYMBOL_GPL(xen_remap_domain_gfn_array);
 
+int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
+			       unsigned long addr,
+			       xen_pfn_t *mfn, int nr,
+			       int *err_ptr, pgprot_t prot,
+			       unsigned int domid, struct page **pages)
+{
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return -EOPNOTSUPP;
+
+	return do_remap_pfn(vma, addr, mfn, nr, err_ptr, prot, domid,
+			    true, pages);
+}
+EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_array);
+
 /* Returns: 0 success */
 int xen_unmap_domain_gfn_range(struct vm_area_struct *vma,
 			       int nr, struct page **pages)
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 1c909183c42a..a7a2286d101a 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -33,6 +33,7 @@
 #include <xen/xen.h>
 #include <xen/privcmd.h>
 #include <xen/interface/xen.h>
+#include <xen/interface/memory.h>
 #include <xen/interface/hvm/dm_op.h>
 #include <xen/features.h>
 #include <xen/page.h>
@@ -722,6 +723,134 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
 	return 0;
 }
 
+struct remap_pfn {
+	struct mm_struct *mm;
+	struct page **pages;
+	pgprot_t prot;
+	unsigned long i;
+};
+
+static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
+			void *data)
+{
+	struct remap_pfn *r = data;
+	struct page *page = r->pages[r->i];
+	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
+
+	set_pte_at(r->mm, addr, ptep, pte);
+	r->i++;
+
+	return 0;
+}
+
+static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
+{
+	struct privcmd_data *data = file->private_data;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct privcmd_mmap_resource kdata;
+	xen_pfn_t *pfns = NULL;
+	struct xen_mem_acquire_resource xdata;
+	int rc;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	/* If restriction is in place, check the domid matches */
+	if (data->domid != DOMID_INVALID && data->domid != kdata.dom)
+		return -EPERM;
+
+	down_write(&mm->mmap_sem);
+
+	vma = find_vma(mm, kdata.addr);
+	if (!vma || vma->vm_ops != &privcmd_vm_ops) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	pfns = kcalloc(kdata.num, sizeof(*pfns), GFP_KERNEL);
+	if (!pfns) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+		unsigned int nr = DIV_ROUND_UP(kdata.num, XEN_PFN_PER_PAGE);
+		struct page **pages;
+		unsigned int i;
+
+		rc = alloc_empty_pages(vma, nr);
+		if (rc < 0)
+			goto out;
+
+		pages = vma->vm_private_data;
+		for (i = 0; i < kdata.num; i++) {
+			xen_pfn_t pfn =
+				page_to_xen_pfn(pages[i / XEN_PFN_PER_PAGE]);
+
+			pfns[i] = pfn + (i % XEN_PFN_PER_PAGE);
+		}
+	} else
+		vma->vm_private_data = PRIV_VMA_LOCKED;
+
+	memset(&xdata, 0, sizeof(xdata));
+	xdata.domid = kdata.dom;
+	xdata.type = kdata.type;
+	xdata.id = kdata.id;
+	xdata.frame = kdata.idx;
+	xdata.nr_frames = kdata.num;
+	set_xen_guest_handle(xdata.frame_list, pfns);
+
+	xen_preemptible_hcall_begin();
+	rc = HYPERVISOR_memory_op(XENMEM_acquire_resource, &xdata);
+	xen_preemptible_hcall_end();
+
+	if (rc)
+		goto out;
+
+	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+		struct remap_pfn r = {
+			.mm = vma->vm_mm,
+			.pages = vma->vm_private_data,
+			.prot = vma->vm_page_prot,
+		};
+
+		rc = apply_to_page_range(r.mm, kdata.addr,
+					 kdata.num << PAGE_SHIFT,
+					 remap_pfn_fn, &r);
+	} else {
+		unsigned int domid =
+			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
+			DOMID_SELF : kdata.dom;
+		int num;
+
+		num = xen_remap_domain_mfn_array(vma,
+						 kdata.addr & PAGE_MASK,
+						 pfns, kdata.num, (int *)pfns,
+						 vma->vm_page_prot,
+						 domid,
+						 vma->vm_private_data);
+		if (num < 0)
+			rc = num;
+		else if (num != kdata.num) {
+			unsigned int i;
+
+			for (i = 0; i < num; i++) {
+				rc = pfns[i];
+				if (rc < 0)
+					break;
+			}
+		} else
+			rc = 0;
+	}
+
+out:
+	up_write(&mm->mmap_sem);
+	kfree(pfns);
+
+	return rc;
+}
+
 static long privcmd_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long data)
 {
@@ -753,6 +882,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_restrict(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_MMAP_RESOURCE:
+		ret = privcmd_ioctl_mmap_resource(file, udata);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 39d3e7b8e993..d2029556083e 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -89,6 +89,15 @@ struct privcmd_dm_op {
 	const struct privcmd_dm_op_buf __user *ubufs;
 };
 
+struct privcmd_mmap_resource {
+	domid_t dom;
+	__u32 type;
+	__u32 id;
+	__u32 idx;
+	__u64 num;
+	__u64 addr;
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -114,5 +123,7 @@ struct privcmd_dm_op {
 	_IOC(_IOC_NONE, 'P', 5, sizeof(struct privcmd_dm_op))
 #define IOCTL_PRIVCMD_RESTRICT					\
 	_IOC(_IOC_NONE, 'P', 6, sizeof(domid_t))
+#define IOCTL_PRIVCMD_MMAP_RESOURCE				\
+	_IOC(_IOC_NONE, 'P', 7, sizeof(struct privcmd_mmap_resource))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index 583dd93b3016..4c5751c26f87 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -265,4 +265,70 @@ struct xen_remove_from_physmap {
 };
 DEFINE_GUEST_HANDLE_STRUCT(xen_remove_from_physmap);
 
+/*
+ * Get the pages for a particular guest resource, so that they can be
+ * mapped directly by a tools domain.
+ */
+#define XENMEM_acquire_resource 28
+struct xen_mem_acquire_resource {
+    /* IN - The domain whose resource is to be mapped */
+    domid_t domid;
+    /* IN - the type of resource */
+    uint16_t type;
+
+#define XENMEM_resource_ioreq_server 0
+#define XENMEM_resource_grant_table 1
+
+    /*
+     * IN - a type-specific resource identifier, which must be zero
+     *      unless stated otherwise.
+     *
+     * type == XENMEM_resource_ioreq_server -> id == ioreq server id
+     * type == XENMEM_resource_grant_table -> id defined below
+     */
+    uint32_t id;
+
+#define XENMEM_resource_grant_table_id_shared 0
+#define XENMEM_resource_grant_table_id_status 1
+
+    /* IN/OUT - As an IN parameter number of frames of the resource
+     *          to be mapped. However, if the specified value is 0 and
+     *          frame_list is NULL then this field will be set to the
+     *          maximum value supported by the implementation on return.
+     */
+    uint32_t nr_frames;
+    /*
+     * OUT - Must be zero on entry. On return this may contain a bitwise
+     *       OR of the following values.
+     */
+    uint32_t flags;
+
+    /* The resource pages have been assigned to the calling domain */
+#define _XENMEM_rsrc_acq_caller_owned 0
+#define XENMEM_rsrc_acq_caller_owned (1u << _XENMEM_rsrc_acq_caller_owned)
+
+    /*
+     * IN - the index of the initial frame to be mapped. This parameter
+     *      is ignored if nr_frames is 0.
+     */
+    uint64_t frame;
+
+#define XENMEM_resource_ioreq_server_frame_bufioreq 0
+#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
+
+    /*
+     * IN/OUT - If the tools domain is PV then, upon return, frame_list
+     *          will be populated with the MFNs of the resource.
+     *          If the tools domain is HVM then it is expected that, on
+     *          entry, frame_list will be populated with a list of GFNs
+     *          that will be mapped to the MFNs of the resource.
+     *          If -EIO is returned then the frame_list has only been
+     *          partially mapped and it is up to the caller to unmap all
+     *          the GFNs.
+     *          This parameter may be NULL if nr_frames is 0.
+     */
+    GUEST_HANDLE(xen_pfn_t) frame_list;
+};
+DEFINE_GUEST_HANDLE_STRUCT(xen_mem_acquire_resource);
+
 #endif /* __XEN_PUBLIC_MEMORY_H__ */
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 4f4830ef8f93..8bfb242f433e 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -265,9 +265,10 @@
  *
  * PAT (bit 7 on) --> PWT (bit 3 on) and clear bit 7.
  */
-#define MMU_NORMAL_PT_UPDATE      0 /* checked '*ptr = val'. ptr is MA.       */
-#define MMU_MACHPHYS_UPDATE       1 /* ptr = MA of frame to modify entry for  */
-#define MMU_PT_UPDATE_PRESERVE_AD 2 /* atomically: *ptr = val | (*ptr&(A|D)) */
+#define MMU_NORMAL_PT_UPDATE       0 /* checked '*ptr = val'. ptr is MA.      */
+#define MMU_MACHPHYS_UPDATE        1 /* ptr = MA of frame to modify entry for */
+#define MMU_PT_UPDATE_PRESERVE_AD  2 /* atomically: *ptr = val | (*ptr&(A|D)) */
+#define MMU_PT_UPDATE_NO_TRANSLATE 3 /* checked '*ptr = val'. ptr is MA.      */
 
 /*
  * MMU EXTENDED OPERATIONS
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index fd23e42c6024..fd18c974a619 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -63,7 +63,7 @@ static inline void xen_destroy_contiguous_region(phys_addr_t pstart,
 struct vm_area_struct;
 
 /*
- * xen_remap_domain_gfn_array() - map an array of foreign frames
+ * xen_remap_domain_gfn_array() - map an array of foreign frames by gfn
  * @vma:     VMA to map the pages into
  * @addr:    Address at which to map the pages
  * @gfn:     Array of GFNs to map
@@ -86,6 +86,28 @@ int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
 			       unsigned domid,
 			       struct page **pages);
 
+/*
+ * xen_remap_domain_mfn_array() - map an array of foreign frames by mfn
+ * @vma:     VMA to map the pages into
+ * @addr:    Address at which to map the pages
+ * @mfn:     Array of MFNs to map
+ * @nr:      Number entries in the MFN array
+ * @err_ptr: Returns per-MFN error status.
+ * @prot:    page protection mask
+ * @domid:   Domain owning the pages
+ * @pages:   Array of pages if this domain has an auto-translated physmap
+ *
+ * @mfn and @err_ptr may point to the same buffer, the MFNs will be
+ * overwritten by the error codes after they are mapped.
+ *
+ * Returns the number of successfully mapped frames, or a -ve error
+ * code.
+ */
+int xen_remap_domain_mfn_array(struct vm_area_struct *vma,
+			       unsigned long addr, xen_pfn_t *mfn, int nr,
+			       int *err_ptr, pgprot_t prot,
+			       unsigned int domid, struct page **pages);
+
 /* xen_remap_domain_gfn_range() - map a range of foreign frames
  * @vma:     VMA to map the pages into
  * @addr:    Address at which to map the pages
-- 
2.11.0
