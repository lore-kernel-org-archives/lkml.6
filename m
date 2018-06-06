Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A86860263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeFFIeM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:34:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932520AbeFFIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:10 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 2/7] Uprobes: Support SDT markers having reference count (semaphore)
Date: Wed,  6 Jun 2018 14:03:39 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060608-0016-0000-0000-000001D8A5CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060608-0017-0000-0000-0000322BB0CB
Message-Id: <20180606083344.31320-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. Applications like PostgreSQL, MySQL,
Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
have these markers embedded in them. These markers are added by developer
at important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. In case the overhead is more, execution of it can be
omitted by runtime if() condition when no one is tracing on the marker:

    if (reference_counter > 0) {
        Execute marker instructions;
    }

Default value of reference counter is 0. Tracer has to increment the
reference counter before tracing on a marker and decrement it when
done with the tracing. Implement the reference counter logic in Uprobe.
New function uprobe_register_refctr() has been added for this. Also,
it's not exported so, for now, the interface to use reference counter
is only through trace_uprobe.

trace_uprobe definition with reference counter will now be:

  <path>:<offset>[(ref_ctr_offset)]

where ref_ctr_offset is an optional field.

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

Note: 'reference counter' is called as 'semaphore' in original Dtrace
(or Systemtap, bcc and even in ELF) documentation and code. But the
term 'semaphore' is misleading in this context. This is just a counter
used to hold number of tracers tracing on a marker. This is not really
used for any synchronization. So we are referring it as 'reference
counter' in kernel / perf code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h     |   5 +
 kernel/events/uprobes.c     | 298 +++++++++++++++++++++++++++++++++++++++-----
 kernel/trace/trace_uprobe.c |  38 +++++-
 3 files changed, 309 insertions(+), 32 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..58666c6 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -123,6 +123,7 @@ struct uprobes_state {
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern int uprobe_register_refctr(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, loff_t ref_ctr_offset);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -160,6 +161,10 @@ struct uprobes_state {
 {
 	return -ENOSYS;
 }
+static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, unsigned long ref_ctr_offset)
+{
+	return -ENOSYS;
+}
 static inline int
 uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
 {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c377a85..ed3c588 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,6 +64,11 @@
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
+enum {
+	UPROBE_OFFSET = 0,
+	REF_CTR_OFFSET
+};
+
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	atomic_t		ref;
@@ -73,6 +78,7 @@ struct uprobe {
 	struct uprobe_consumer	*consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	loff_t			offset;
+	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
 	/*
@@ -483,7 +489,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
-static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
+static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
+				   loff_t ref_ctr_offset)
 {
 	struct uprobe *uprobe, *cur_uprobe;
 
@@ -493,6 +500,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
+	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 
@@ -840,11 +848,174 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	return err;
 }
 
-static void
-__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static bool sdt_valid_vma(struct uprobe *uprobe,
+			  struct vm_area_struct *vma,
+			  unsigned long vaddr)
+{
+	return uprobe->ref_ctr_offset &&
+		vma->vm_file &&
+		file_inode(vma->vm_file) == uprobe->inode &&
+		vma->vm_flags & VM_WRITE &&
+		vma->vm_start <= vaddr &&
+		vma->vm_end > vaddr;
+}
+
+static struct vm_area_struct *sdt_find_vma(struct uprobe *uprobe,
+					   struct mm_struct *mm,
+					   unsigned long vaddr)
+{
+	struct vm_area_struct *vma = find_vma(mm, vaddr);
+
+	return (vma && sdt_valid_vma(uprobe, vma, vaddr)) ? vma : NULL;
+}
+
+/*
+ * Reference counter gate the invocation of probe. If present,
+ * by default reference counter is 0. One needs to increment
+ * it before tracing the probe and decrement it when done.
+ */
+static int
+sdt_update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
+{
+	void *kaddr;
+	struct page *page;
+	struct vm_area_struct *vma;
+	int ret = 0;
+	short *ptr;
+
+	if (vaddr == 0 || d == 0)
+		return -EINVAL;
+
+	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
+		FOLL_FORCE | FOLL_WRITE, &page, &vma, NULL);
+	if (unlikely(ret <= 0)) {
+		/*
+		 * We are asking for 1 page. If get_user_pages_remote() fails,
+		 * it may return 0, in that case we have to return error.
+		 */
+		ret = (ret == 0) ? -EBUSY : ret;
+		pr_warn("Failed to %s ref_ctr. (%d)\n",
+			d > 0 ? "increment" : "decrement", ret);
+		return ret;
+	}
+
+	kaddr = kmap_atomic(page);
+	ptr = kaddr + (vaddr & ~PAGE_MASK);
+
+	if (unlikely(*ptr + d < 0)) {
+		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
+			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*ptr += d;
+	ret = 0;
+out:
+	kunmap_atomic(kaddr);
+	put_page(page);
+	return ret;
+}
+
+static int sdt_increment_ref_ctr(struct uprobe *uprobe)
+{
+	struct map_info *info, *first = NULL;
+	int ctr = 0, ret = 0, tmp = 0;
+
+	percpu_down_write(&dup_mmap_sem);
+
+	info = build_map_info(uprobe->inode->i_mapping,
+			      uprobe->ref_ctr_offset, false);
+	if (IS_ERR(info)) {
+		percpu_up_write(&dup_mmap_sem);
+		return PTR_ERR(info);
+	}
+
+	first = info;
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
+			ret = sdt_update_ref_ctr(info->mm, info->vaddr, 1);
+			if (unlikely(ret)) {
+				up_write(&info->mm->mmap_sem);
+				goto rollback;
+			}
+		}
+		up_write(&info->mm->mmap_sem);
+		info = info->next;
+		ctr++;
+	}
+	ret = 0;
+	goto out;
+
+rollback:
+	/*
+	 * We failed to update reference counter in any one of
+	 * the target mm. Rollback alredy updated mms.
+	 */
+	info = first;
+	while (ctr) {
+		down_write(&info->mm->mmap_sem);
+		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
+			tmp = sdt_update_ref_ctr(info->mm, info->vaddr, -1);
+			if (unlikely(tmp))
+				pr_warn("ref_ctr rollback failed. (%d)\n", tmp);
+		}
+		up_write(&info->mm->mmap_sem);
+		info = info->next;
+		ctr--;
+	}
+
+out:
+	info = first;
+	while (info) {
+		mmput(info->mm);
+		info = free_map_info(info);
+	}
+
+	percpu_up_write(&dup_mmap_sem);
+	return ret;
+}
+
+static int sdt_decrement_ref_ctr(struct uprobe *uprobe)
+{
+	struct map_info *info;
+	int ret = 0, err = 0;
+
+	percpu_down_write(&dup_mmap_sem);
+	info = build_map_info(uprobe->inode->i_mapping,
+			      uprobe->ref_ctr_offset, false);
+	if (IS_ERR(info))
+		goto out;
+
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+
+		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
+			ret = sdt_update_ref_ctr(info->mm, info->vaddr, -1);
+			/* Save error and continue. */
+			err = !err && ret ? ret : err;
+		}
+
+		up_write(&info->mm->mmap_sem);
+		mmput(info->mm);
+		info = free_map_info(info);
+	}
+
+out:
+	percpu_up_write(&dup_mmap_sem);
+	return err;
+}
+
+static void __uprobe_unregister(struct uprobe *uprobe,
+				struct uprobe_consumer *uc,
+				bool ref_ctr_dec)
 {
 	int err;
 
+	if (ref_ctr_dec && uprobe->ref_ctr_offset)
+		sdt_decrement_ref_ctr(uprobe);
+
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		return;
 
@@ -869,7 +1040,7 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
 		return;
 
 	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
+	__uprobe_unregister(uprobe, uc, true);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 }
@@ -880,21 +1051,27 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
  * @uc: information on howto handle the probe..
+ * @ref_ctr_offset: Reference counter offset
  *
  * Apart from the access refcount, __uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
- * inserted into the rbtree (i.e first consumer for a @inode:@offset
- * tuple).  Creation refcount stops uprobe_unregister from freeing the
- * @uprobe even before the register operation is complete. Creation
- * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of __uprobe_register() is required to keep @inode
- * (and the containing mount) referenced.
+ * inserted into the rbtree (i.e first consumer for a
+ * @inode:@offset:@ref_ctr_offset tuple). Creation refcount stops
+ * uprobe_unregister from freeing the @uprobe even before the register
+ * operation is complete. Creation refcount is released when the last
+ * @uc for the @uprobe unregisters. Caller of __uprobe_register() is
+ * required to keep @inode (and the containing mount) referenced.
+ *
+ * Note that, 'refcount' and 'ref_ctr_offset' are totally different
+ * entities and each has it's own purpose. 'ref_ctr_offset' is the file
+ * offset of the counter which gates the uprobe and it has nothing to
+ * do with the value of 'refcount'.
  *
- * Return errno if it cannot successully install probes
- * else return 0 (success)
+ * Return errno if it cannot successully install probes else return 0
+ * (success).
  */
 static int __uprobe_register(struct inode *inode, loff_t offset,
-			     struct uprobe_consumer *uc)
+			     struct uprobe_consumer *uc, loff_t ref_ctr_offset)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -907,11 +1084,11 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!inode->i_mapping->a_ops->readpage && !shmem_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
-	if (offset > i_size_read(inode))
+	if (offset > i_size_read(inode) || ref_ctr_offset > i_size_read(inode))
 		return -EINVAL;
 
  retry:
-	uprobe = alloc_uprobe(inode, offset);
+	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
 	/*
@@ -922,9 +1099,13 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
+
 		ret = register_for_each_vma(uprobe, uc);
+		if (!ret && ref_ctr_offset)
+			ret = sdt_increment_ref_ctr(uprobe);
+
 		if (ret)
-			__uprobe_unregister(uprobe, uc);
+			__uprobe_unregister(uprobe, uc, false);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
@@ -937,10 +1118,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 int uprobe_register(struct inode *inode, loff_t offset,
 		    struct uprobe_consumer *uc)
 {
-	return __uprobe_register(inode, offset, uc);
+	return __uprobe_register(inode, offset, uc, 0);
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
+/* Currently, the only user of this is trace_uprobe. */
+int uprobe_register_refctr(struct inode *inode, loff_t offset,
+			   struct uprobe_consumer *uc, loff_t ref_ctr_offset)
+{
+	return __uprobe_register(inode, offset, uc, ref_ctr_offset);
+}
+
 /*
  * uprobe_apply - unregister a already registered probe.
  * @inode: the file in which the probe has to be removed.
@@ -997,22 +1185,30 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 	return err;
 }
 
+static loff_t uprobe_get_offset(struct uprobe *u, int off_type)
+{
+	return (off_type == UPROBE_OFFSET) ? u->offset : u->ref_ctr_offset;
+}
+
 static struct rb_node *
-find_node_in_range(struct inode *inode, loff_t min, loff_t max)
+find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
 {
 	struct rb_node *n = uprobes_tree.rb_node;
+	struct uprobe *u;
+	loff_t offset;
 
 	while (n) {
-		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
+		u = rb_entry(n, struct uprobe, rb_node);
+		offset = uprobe_get_offset(u, off_type);
 
 		if (inode < u->inode) {
 			n = n->rb_left;
 		} else if (inode > u->inode) {
 			n = n->rb_right;
 		} else {
-			if (max < u->offset)
+			if (max < offset)
 				n = n->rb_left;
-			else if (min > u->offset)
+			else if (min > offset)
 				n = n->rb_right;
 			else
 				break;
@@ -1025,7 +1221,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 /*
  * For a given range in vma, build a list of probes that need to be inserted.
  */
-static void build_probe_list(struct inode *inode,
+static void build_probe_list(struct inode *inode, int off_type,
 				struct vm_area_struct *vma,
 				unsigned long start, unsigned long end,
 				struct list_head *head)
@@ -1033,24 +1229,27 @@ static void build_probe_list(struct inode *inode,
 	loff_t min, max;
 	struct rb_node *n, *t;
 	struct uprobe *u;
+	loff_t offset;
 
 	INIT_LIST_HEAD(head);
 	min = vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
-	n = find_node_in_range(inode, min, max);
+	n = find_node_in_range(inode, off_type, min, max);
 	if (n) {
 		for (t = n; t; t = rb_prev(t)) {
 			u = rb_entry(t, struct uprobe, rb_node);
-			if (u->inode != inode || u->offset < min)
+			offset = uprobe_get_offset(u, off_type);
+			if (u->inode != inode || offset < min)
 				break;
 			list_add(&u->pending_list, head);
 			get_uprobe(u);
 		}
 		for (t = n; (t = rb_next(t)); ) {
 			u = rb_entry(t, struct uprobe, rb_node);
-			if (u->inode != inode || u->offset > max)
+			offset = uprobe_get_offset(u, off_type);
+			if (u->inode != inode || offset > max)
 				break;
 			list_add(&u->pending_list, head);
 			get_uprobe(u);
@@ -1059,6 +1258,39 @@ static void build_probe_list(struct inode *inode,
 	spin_unlock(&uprobes_treelock);
 }
 
+/* Called with down_write(&vma->vm_mm->mmap_sem) */
+static int sdt_uprobe_mmap(struct vm_area_struct *vma, struct inode *inode)
+{
+	struct list_head tmp_list;
+	struct uprobe *uprobe, *u;
+	struct uprobe_consumer *uc;
+	unsigned long vaddr;
+	int ret = 0, err = 0;
+
+	build_probe_list(inode, REF_CTR_OFFSET, vma, vma->vm_start,
+			 vma->vm_end, &tmp_list);
+
+	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
+		if (!uprobe->ref_ctr_offset || !uprobe_is_active(uprobe))
+			continue;
+
+		vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
+		if (!sdt_valid_vma(uprobe, vma, vaddr))
+			continue;
+
+		/* Increment reference counter for each consumer. */
+		down_read(&uprobe->consumer_rwsem);
+		for (uc = uprobe->consumers; uc; uc = uc->next) {
+			ret = sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
+			err = !err && ret ? ret : err;
+		}
+		up_read(&uprobe->consumer_rwsem);
+		put_uprobe(uprobe);
+	}
+
+	return err;
+}
+
 /*
  * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
  *
@@ -1071,7 +1303,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
-	if (no_uprobe_events() || !valid_vma(vma, true))
+	if (no_uprobe_events())
 		return 0;
 
 	inode = file_inode(vma->vm_file);
@@ -1079,7 +1311,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		return 0;
 
 	mutex_lock(uprobes_mmap_hash(inode));
-	build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_list);
+	if (vma->vm_flags & VM_WRITE)
+		sdt_uprobe_mmap(vma, inode);
+
+	if (!valid_vma(vma, true))
+		goto out;
+
+	build_probe_list(inode, UPROBE_OFFSET, vma, vma->vm_start,
+			 vma->vm_end, &tmp_list);
 	/*
 	 * We can race with uprobe_unregister(), this uprobe can be already
 	 * removed. But in this case filter_chain() must return false, all
@@ -1093,8 +1332,9 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		}
 		put_uprobe(uprobe);
 	}
-	mutex_unlock(uprobes_mmap_hash(inode));
 
+out:
+	mutex_unlock(uprobes_mmap_hash(inode));
 	return 0;
 }
 
@@ -1111,7 +1351,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
-	n = find_node_in_range(inode, min, max);
+	n = find_node_in_range(inode, UPROBE_OFFSET, min, max);
 	spin_unlock(&uprobes_treelock);
 
 	return !!n;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index ac89287..d5b6ca9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -59,6 +59,7 @@ struct trace_uprobe {
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
+	unsigned long			ref_ctr_offset;
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -364,10 +365,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	char *arg, *event, *group, *filename;
+	char *arg, *event, *group, *filename, *rctr, *rctr_end;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
-	unsigned long offset;
+	unsigned long offset, ref_ctr_offset;
 	bool is_delete, is_return;
 	int i, ret;
 
@@ -376,6 +377,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	is_return = false;
 	event = NULL;
 	group = NULL;
+	ref_ctr_offset = 0;
 
 	/* argc must be >= 1 */
 	if (argv[0][0] == '-')
@@ -450,6 +452,26 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 
+	/* Parse reference counter offset if specified. */
+	rctr = strchr(arg, '(');
+	if (rctr) {
+		rctr_end = strchr(rctr, ')');
+		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
+			ret = -EINVAL;
+			pr_info("Invalid reference counter offset.\n");
+			goto fail_address_parse;
+		}
+
+		*rctr++ = '\0';
+		*rctr_end = '\0';
+		ret = kstrtoul(rctr, 0, &ref_ctr_offset);
+		if (ret) {
+			pr_info("Invalid reference counter offset.\n");
+			goto fail_address_parse;
+		}
+	}
+
+	/* Parse uprobe offset. */
 	ret = kstrtoul(arg, 0, &offset);
 	if (ret)
 		goto fail_address_parse;
@@ -484,6 +506,7 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
+	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->path = path;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
@@ -602,6 +625,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
 			trace_event_name(&tu->tp.call), tu->filename,
 			(int)(sizeof(void *) * 2), tu->offset);
 
+	if (tu->ref_ctr_offset)
+		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
+
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
 
@@ -917,7 +943,13 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 	tu->consumer.filter = filter;
 	tu->inode = d_real_inode(tu->path.dentry);
-	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	if (tu->ref_ctr_offset) {
+		ret = uprobe_register_refctr(tu->inode, tu->offset,
+				&tu->consumer, tu->ref_ctr_offset);
+	} else {
+		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	}
+
 	if (ret)
 		goto err_buffer;
 
-- 
1.8.3.1
