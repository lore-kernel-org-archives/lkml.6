Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AAAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775526D17
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B775526D17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeF1FWz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:22:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932799AbeF1FWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:22:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5J9UJ057202
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvsa68eaw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:50 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:42 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5Mfgp23724238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 583C342049;
        Thu, 28 Jun 2018 06:22:32 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09E3342042;
        Thu, 28 Jun 2018 06:22:29 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:28 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference count (semaphore)
Date:   Thu, 28 Jun 2018 10:52:05 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0008-0000-0000-0000024CAA4D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0009-0000-0000-000021B32227
Message-Id: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
done with the tracing.

Implement the reference counter logic in core uprobe. User will be
able to use it from trace_uprobe as well as from kernel module. New
trace_uprobe definition with reference counter will now be:

    <path>:<offset>[(ref_ctr_offset)]

where ref_ctr_offset is an optional field. For kernel module, new
variant of uprobe_register() has been introduced:

    uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)

No new variant for uprobe_unregister() because it's assumed to have
only one reference counter for one uprobe.

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

Note: 'reference counter' is called as 'semaphore' in original Dtrace
(or Systemtap, bcc and even in ELF) documentation and code. But the
term 'semaphore' is misleading in this context. This is just a counter
used to hold number of tracers tracing on a marker. This is not really
used for any synchronization. So we are referring it as 'reference
counter' in kernel / perf code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h     |   6 +
 kernel/events/uprobes.c     | 276 +++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_uprobe.c |  38 +++++-
 3 files changed, 302 insertions(+), 18 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 88942b1f0a3e..3ef21f546c1f 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -71,6 +71,7 @@ struct uprobe {
 	struct uprobe_consumer	*consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
 	loff_t			offset;
+	loff_t			ref_ctr_offset;
 	unsigned long		flags;
 
 	/*
@@ -148,6 +149,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t opcode);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -185,6 +187,10 @@ uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
 {
 	return -ENOSYS;
 }
+static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+{
+	return -ENOSYS;
+}
 static inline int
 uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
 {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3e0426c76376..61f9b0024794 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,6 +64,20 @@ static struct percpu_rw_semaphore dup_mmap_sem;
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
+enum {
+	UPROBE_OFFSET = 0,
+	REF_CTR_OFFSET
+};
+
+struct delayed_uprobe {
+	struct list_head list;
+	struct uprobe *uprobe;
+	struct mm_struct *mm;
+};
+
+static DEFINE_MUTEX(delayed_uprobe_lock);
+static LIST_HEAD(delayed_uprobe_list);
+
 /*
  * Execute out of line area: anonymous executable mapping installed
  * by the probed task to execute the copy of the original instruction
@@ -258,6 +272,158 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	return 1;
 }
 
+static loff_t uprobe_get_offset(struct uprobe *u, int off_type)
+{
+	return (off_type == UPROBE_OFFSET) ? u->offset : u->ref_ctr_offset;
+}
+
+static struct delayed_uprobe *
+delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct delayed_uprobe *du;
+
+	list_for_each_entry(du, &delayed_uprobe_list, list)
+		if (du->uprobe == uprobe && du->mm == mm)
+			return du;
+	return NULL;
+}
+
+static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct delayed_uprobe *du;
+
+	if (delayed_uprobe_check(uprobe, mm))
+		return 0;
+
+	du  = kzalloc(sizeof(*du), GFP_KERNEL);
+	if (!du)
+		return -ENOMEM;
+
+	du->uprobe = uprobe;
+	du->mm = mm;
+	list_add(&du->list, &delayed_uprobe_list);
+	return 0;
+}
+
+static void delayed_uprobe_delete(struct delayed_uprobe *du)
+{
+	if (!du)
+		return;
+	list_del(&du->list);
+	kfree(du);
+}
+
+static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct list_head *pos, *q;
+	struct delayed_uprobe *du;
+
+	list_for_each_safe(pos, q, &delayed_uprobe_list) {
+		du = list_entry(pos, struct delayed_uprobe, list);
+		if (uprobe) {
+			if (du->uprobe == uprobe && du->mm == mm)
+				delayed_uprobe_delete(du);
+		} else if (du->mm == mm) {
+			delayed_uprobe_delete(du);
+		}
+	}
+}
+
+static bool valid_ref_ctr_vma(struct uprobe *uprobe,
+			      struct vm_area_struct *vma)
+{
+	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
+
+	return uprobe->ref_ctr_offset &&
+		vma->vm_file &&
+		file_inode(vma->vm_file) == uprobe->inode &&
+		vma->vm_flags & VM_WRITE &&
+		vma->vm_start <= vaddr &&
+		vma->vm_end > vaddr;
+}
+
+static struct vm_area_struct *
+find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
+{
+	struct vm_area_struct *tmp;
+
+	for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
+		if (valid_ref_ctr_vma(uprobe, tmp))
+			return tmp;
+
+	return NULL;
+}
+
+static int
+__update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
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
+static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
+			  bool is_register)
+{
+	struct vm_area_struct *rc_vma;
+	unsigned long rc_vaddr;
+	int ret = 0;
+
+	rc_vma = find_ref_ctr_vma(uprobe, mm);
+
+	if (rc_vma) {
+		rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
+		ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
+
+		if (is_register)
+			return ret;
+	}
+
+	mutex_lock(&delayed_uprobe_lock);
+	if (is_register)
+		ret = delayed_uprobe_add(uprobe, mm);
+	else
+		delayed_uprobe_remove(uprobe, mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
+	return ret;
+}
+
 /*
  * NOTE:
  * Expect the breakpoint instruction to be the smallest size instruction for
@@ -281,7 +447,9 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret;
+	int ret, is_register, ref_ctr_updated = 0;
+
+	is_register = is_swbp_insn(&opcode);
 
 retry:
 	/* Read the page with vaddr into memory */
@@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
+	/* Update the ref_ctr if we are going to replace instruction. */
+	if (!ref_ctr_updated) {
+		ret = update_ref_ctr(uprobe, mm, is_register);
+		if (ret)
+			goto put_old;
+
+		ref_ctr_updated = 1;
+	}
+
 	ret = anon_vma_prepare(vma);
 	if (ret)
 		goto put_old;
@@ -314,6 +491,11 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
+
+	/* Revert back reference counter if instruction update failed. */
+	if (ret && is_register && ref_ctr_updated)
+		update_ref_ctr(uprobe, mm, false);
+
 	return ret;
 }
 
@@ -461,7 +643,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
-static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
+static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
+				   loff_t ref_ctr_offset)
 {
 	struct uprobe *uprobe, *cur_uprobe;
 
@@ -471,6 +654,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
+	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 
@@ -872,7 +1056,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * else return 0 (success)
  */
 static int __uprobe_register(struct inode *inode, loff_t offset,
-			     struct uprobe_consumer *uc)
+			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -889,7 +1073,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		return -EINVAL;
 
  retry:
-	uprobe = alloc_uprobe(inode, offset);
+	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
 	/*
@@ -915,10 +1099,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 int uprobe_register(struct inode *inode, loff_t offset,
 		    struct uprobe_consumer *uc)
 {
-	return __uprobe_register(inode, offset, uc);
+	return __uprobe_register(inode, offset, 0, uc);
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
+int uprobe_register_refctr(struct inode *inode, loff_t offset,
+			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
+{
+	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
+}
+EXPORT_SYMBOL_GPL(uprobe_register_refctr);
+
 /*
  * uprobe_apply - unregister a already registered probe.
  * @inode: the file in which the probe has to be removed.
@@ -976,21 +1167,22 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 }
 
 static struct rb_node *
-find_node_in_range(struct inode *inode, loff_t min, loff_t max)
+find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
 {
 	struct rb_node *n = uprobes_tree.rb_node;
 
 	while (n) {
 		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
+		loff_t offset = uprobe_get_offset(u, off_type);
 
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
@@ -1004,6 +1196,7 @@ find_node_in_range(struct inode *inode, loff_t min, loff_t max)
  * For a given range in vma, build a list of probes that need to be inserted.
  */
 static void build_probe_list(struct inode *inode,
+				int off_type,
 				struct vm_area_struct *vma,
 				unsigned long start, unsigned long end,
 				struct list_head *head)
@@ -1011,24 +1204,29 @@ static void build_probe_list(struct inode *inode,
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
+
+			if (u->inode != inode || offset < min)
 				break;
 			list_add(&u->pending_list, head);
 			get_uprobe(u);
 		}
 		for (t = n; (t = rb_next(t)); ) {
 			u = rb_entry(t, struct uprobe, rb_node);
-			if (u->inode != inode || u->offset > max)
+			offset = uprobe_get_offset(u, off_type);
+
+			if (u->inode != inode || offset > max)
 				break;
 			list_add(&u->pending_list, head);
 			get_uprobe(u);
@@ -1037,6 +1235,43 @@ static void build_probe_list(struct inode *inode,
 	spin_unlock(&uprobes_treelock);
 }
 
+static int
+delayed_uprobe_install(struct vm_area_struct *vma, struct inode *inode)
+{
+	struct list_head tmp_list;
+	struct uprobe *uprobe, *u;
+	struct delayed_uprobe *du;
+	unsigned long vaddr;
+	int ret = 0, err = 0;
+
+	build_probe_list(inode, REF_CTR_OFFSET, vma, vma->vm_start,
+			 vma->vm_end, &tmp_list);
+
+	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
+		if (!uprobe->ref_ctr_offset ||
+		    !uprobe_is_active(uprobe) ||
+		    !valid_ref_ctr_vma(uprobe, vma))
+			goto cont;
+
+		mutex_lock(&delayed_uprobe_lock);
+		du = delayed_uprobe_check(uprobe, vma->vm_mm);
+		if (!du) {
+			mutex_unlock(&delayed_uprobe_lock);
+			goto cont;
+		}
+
+		vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
+		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
+		/* Record an error and continue. */
+		err = ret & !err ? ret : err;
+		delayed_uprobe_delete(du);
+		mutex_unlock(&delayed_uprobe_lock);
+cont:
+		put_uprobe(uprobe);
+	}
+	return err;
+}
+
 /*
  * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
  *
@@ -1049,7 +1284,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
-	if (no_uprobe_events() || !valid_vma(vma, true))
+	if (no_uprobe_events())
 		return 0;
 
 	inode = file_inode(vma->vm_file);
@@ -1057,7 +1292,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		return 0;
 
 	mutex_lock(uprobes_mmap_hash(inode));
-	build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_list);
+	if (vma->vm_flags & VM_WRITE)
+		delayed_uprobe_install(vma, inode);
+
+	if (!valid_vma(vma, true))
+		goto out;
+
+	build_probe_list(inode, UPROBE_OFFSET, vma, vma->vm_start,
+			 vma->vm_end, &tmp_list);
 	/*
 	 * We can race with uprobe_unregister(), this uprobe can be already
 	 * removed. But in this case filter_chain() must return false, all
@@ -1071,8 +1313,8 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		}
 		put_uprobe(uprobe);
 	}
+out:
 	mutex_unlock(uprobes_mmap_hash(inode));
-
 	return 0;
 }
 
@@ -1089,7 +1331,7 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
-	n = find_node_in_range(inode, min, max);
+	n = find_node_in_range(inode, UPROBE_OFFSET, min, max);
 	spin_unlock(&uprobes_treelock);
 
 	return !!n;
@@ -1223,6 +1465,10 @@ void uprobe_clear_state(struct mm_struct *mm)
 {
 	struct xol_area *area = mm->uprobes_state.xol_area;
 
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(NULL, mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
 	if (!area)
 		return;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51e740d..bf2be098eb08 100644
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
 
@@ -917,7 +943,13 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
 
 	tu->consumer.filter = filter;
 	tu->inode = d_real_inode(tu->path.dentry);
-	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	if (tu->ref_ctr_offset) {
+		ret = uprobe_register_refctr(tu->inode, tu->offset,
+				tu->ref_ctr_offset, &tu->consumer);
+	} else {
+		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	}
+
 	if (ret)
 		goto err_buffer;
 
-- 
2.14.4

