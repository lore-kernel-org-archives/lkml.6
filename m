Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5F6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97C820693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeFTD5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754600AbeFTD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:57:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K3tImL100266
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:57:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqcn1dart-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:57:03 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 20 Jun 2018 04:57:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 04:56:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5K3usks34799780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 03:56:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C462AAE045;
        Wed, 20 Jun 2018 04:45:36 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C9DAE04D;
        Wed, 20 Jun 2018 04:45:34 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 04:45:33 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v4 5/9] Uprobes: Support SDT markers having reference count (semaphore)
Date:   Wed, 20 Jun 2018 09:26:25 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620035629.7844-1-ravi.bangoria@linux.ibm.com>
References: <20180620035629.7844-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062003-0020-0000-0000-0000029CC52D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062003-0021-0000-0000-000020E91453
Message-Id: <20180620035629.7844-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200044
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
 include/linux/uprobes.h     |   5 +
 kernel/events/uprobes.c     | 277 +++++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_uprobe.c |  38 +++++-
 3 files changed, 302 insertions(+), 18 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a179b59..21d9e18 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -123,6 +123,7 @@ struct uprobes_state {
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t opcode);
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
+extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_mmap(struct vm_area_struct *vma);
@@ -160,6 +161,10 @@ struct uprobes_state {
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
index de5258e..efa1e04 100644
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
@@ -88,6 +94,15 @@ struct uprobe {
 	struct arch_uprobe	arch;
 };
 
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
@@ -282,6 +297,158 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
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
@@ -305,7 +472,9 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret;
+	int ret, is_register, ref_ctr_updated = 0;
+
+	is_register = is_swbp_insn(&opcode);
 
 retry:
 	/* Read the page with vaddr into memory */
@@ -318,6 +487,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
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
@@ -338,6 +516,11 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
 
 	if (unlikely(ret == -EAGAIN))
 		goto retry;
+
+	/* Revert back reference counter if instruction update failed. */
+	if (ret && is_register && ref_ctr_updated)
+		update_ref_ctr(uprobe, mm, false);
+
 	return ret;
 }
 
@@ -485,7 +668,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
-static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
+static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
+				   loff_t ref_ctr_offset)
 {
 	struct uprobe *uprobe, *cur_uprobe;
 
@@ -495,6 +679,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
+	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
 
@@ -896,7 +1081,7 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
  * else return 0 (success)
  */
 static int __uprobe_register(struct inode *inode, loff_t offset,
-			     struct uprobe_consumer *uc)
+			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -913,7 +1098,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		return -EINVAL;
 
  retry:
-	uprobe = alloc_uprobe(inode, offset);
+	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
 	/*
@@ -939,10 +1124,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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
@@ -1000,21 +1192,22 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
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
@@ -1028,6 +1221,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
  * For a given range in vma, build a list of probes that need to be inserted.
  */
 static void build_probe_list(struct inode *inode,
+				int off_type,
 				struct vm_area_struct *vma,
 				unsigned long start, unsigned long end,
 				struct list_head *head)
@@ -1035,24 +1229,29 @@ static void build_probe_list(struct inode *inode,
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
@@ -1061,6 +1260,43 @@ static void build_probe_list(struct inode *inode,
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
@@ -1073,7 +1309,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
-	if (no_uprobe_events() || !valid_vma(vma, true))
+	if (no_uprobe_events())
 		return 0;
 
 	inode = file_inode(vma->vm_file);
@@ -1081,7 +1317,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
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
@@ -1095,8 +1338,8 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		}
 		put_uprobe(uprobe);
 	}
+out:
 	mutex_unlock(uprobes_mmap_hash(inode));
-
 	return 0;
 }
 
@@ -1113,7 +1356,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
-	n = find_node_in_range(inode, min, max);
+	n = find_node_in_range(inode, UPROBE_OFFSET, min, max);
 	spin_unlock(&uprobes_treelock);
 
 	return !!n;
@@ -1247,6 +1490,10 @@ void uprobe_clear_state(struct mm_struct *mm)
 {
 	struct xol_area *area = mm->uprobes_state.xol_area;
 
+	mutex_lock(&delayed_uprobe_lock);
+	delayed_uprobe_remove(NULL, mm);
+	mutex_unlock(&delayed_uprobe_lock);
+
 	if (!area)
 		return;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51..bf2be09 100644
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
+				tu->ref_ctr_offset, &tu->consumer);
+	} else {
+		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+	}
+
 	if (ret)
 		goto err_buffer;
 
-- 
1.8.3.1

