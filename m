Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 069DF601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeFFIeU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:34:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932520AbeFFIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:14 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/7] Uprobes/sdt: Fix multiple update of same reference counter
Date: Wed,  6 Jun 2018 14:03:40 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060608-0016-0000-0000-000001D8A5CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060608-0017-0000-0000-0000322BB0D2
Message-Id: <20180606083344.31320-4-ravi.bangoria@linux.ibm.com>
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

When virtual memory map for binary/library is being prepared, there is
no direct one to one mapping between mmap() and virtual memory area. Ex,
when loader loads the library, it first calls mmap(size = total_size),
where total_size is addition of size of all elf sections that are going
to be mapped. Then it splits individual vmas with new mmap()/mprotect()
calls. Loader does this to ensure it gets continuous address range for
a library. load_elf_binary() also uses similar tricks while preparing
mappings of binary.

Ex for pyhton library,

  # strace python
    mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
    mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
    mprotect(0x7fff926a0000, 65536, PROT_READ) = 0

Here, the first mmap() maps the whole library into one region. Second
mmap() and third mprotect() split out the whole region into smaller
vmas and sets appropriate protection flags.

Now, in this case, uprobe_mmap() updates the reference counter twice
-- by second mmap() call and by third mprotect() call -- because both
regions contain reference counter.

But while de-registration, reference counter will get decremented only
once leaving reference counter > 0 even if no one is tracing on that
marker.

Example with python library before patch:

    # readelf -n /lib64/libpython2.7.so.1.0 | grep -A1 function__entry
      Name: function__entry
      ... Semaphore: 0x00000000002899d8

  Probe on a marker:
    # echo "p:sdt_python/function__entry /usr/lib64/libpython2.7.so.1.0:0x16a4d4(0x2799d8)" > uprobe_events

  Start tracing:
    # perf record -e sdt_python:function__entry -a

  Run python workload:
    # python
    # cat /proc/`pgrep python`/maps | grep libpython
      7fffadb00000-7fffadd40000 r-xp 00000000 08:05 403934  /usr/lib64/libpython2.7.so.1.0
      7fffadd40000-7fffadd50000 r--p 00230000 08:05 403934  /usr/lib64/libpython2.7.so.1.0
      7fffadd50000-7fffadd90000 rw-p 00240000 08:05 403934  /usr/lib64/libpython2.7.so.1.0

  Reference counter value has been incremented twice:
    # dd if=/proc/`pgrep python`/mem bs=1 count=1 skip=$(( 0x7fffadd899d8 )) 2>/dev/null | xxd
      0000000: 02                                       .

  Kill perf:
    #
      ^C[ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.322 MB perf.data (1273 samples) ]

  Reference conter is still 1 even when no one is tracing on it:
    # dd if=/proc/`pgrep python`/mem bs=1 count=1 skip=$(( 0x7fffadd899d8 )) 2>/dev/null | xxd
      0000000: 01                                       .

Ensure increment and decrement happens in sync by keeping list of
{consumer, mm} tuple in struct uprobe. Check presence of it in the list
before incrementing the reference counter. I.e. for each {consumer, mm}
tuple, reference counter must be incremented only by one. Note that we
don't check the presence of mm in the list at decrement time.

We consider only two cases while _incrementing_ the reference counter:
  1. Target binary is already running when we start tracing. In this
     case, find all mm which maps region of target binary containing
     reference counter. Loop over all mms and increment the counter if
     {consumer, mm} is not already present in the list.
  2. Tracer is already tracing before target binary starts execution. In
     this case, update reference counter only if {consumer, vma->vm_mm}
     is not already present in the list.

  There is also a third case which we don't consider, a fork() case.
  When process with markers forks itself, we don't explicitly increment
  the reference counter in child process because it should be taken care
  by dup_mmap(). We also don't add the child mm in the list. This is
  fine because we don't check presence of mm in the list at decrement
  time.

After patch:

  Start perf record and then run python...
  Reference counter value has been incremented only once:
    # dd if=/proc/`pgrep python`/mem bs=1 count=1 skip=$(( 0x7fff9cbf99d8 )) 2>/dev/null | xxd
      0000000: 01                                       .

  Kill perf:
    #
      ^C[ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.364 MB perf.data (1427 samples) ]

  Reference conter is reset to 0:
    # dd if=/proc/`pgrep python`/mem bs=1 count=1 skip=$(( 0x7fff9cbb99d8 )) 2>/dev/null | xxd
      0000000: 00                                       .

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 150 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ed3c588..279c8fc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -69,6 +69,20 @@ enum {
 	REF_CTR_OFFSET
 };
 
+/*
+ * List of {consumer, mm} tupple. Unlike uprobe->consumers,
+ * uc is not a list here. It's just a single consumer. Ex,
+ * if there are 2 consumers and 3 target mms for a uprobe,
+ * total number of elements in uprobe->sml = 2 * 3 = 6. This
+ * list is used to ensure reference counter increment and
+ * decrement happen in sync.
+ */
+struct sdt_mm_list {
+	struct list_head list;
+	struct uprobe_consumer *uc;
+	struct mm_struct *mm;
+};
+
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
 	atomic_t		ref;
@@ -79,6 +93,8 @@ struct uprobe {
 	struct inode		*inode;		/* Also hold a ref to inode */
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
+	struct sdt_mm_list	sml;
+	struct mutex		sml_lock;
 	unsigned long		flags;
 
 	/*
@@ -503,6 +519,8 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	uprobe->ref_ctr_offset = ref_ctr_offset;
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
+	mutex_init(&uprobe->sml_lock);
+	INIT_LIST_HEAD(&(uprobe->sml.list));
 
 	/* add to uprobes_tree, sorted on inode:offset */
 	cur_uprobe = insert_uprobe(uprobe);
@@ -848,6 +866,49 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	return err;
 }
 
+static bool sdt_check_mm_list(struct uprobe *uprobe, struct mm_struct *mm,
+			      struct uprobe_consumer *uc)
+{
+	struct sdt_mm_list *sml;
+
+	list_for_each_entry(sml, &(uprobe->sml.list), list)
+		if (sml->mm == mm && sml->uc == uc)
+			return true;
+
+	return false;
+}
+
+static int sdt_add_mm_list(struct uprobe *uprobe, struct mm_struct *mm,
+			   struct uprobe_consumer *uc)
+{
+	struct sdt_mm_list *sml  = kzalloc(sizeof(*sml), GFP_KERNEL);
+
+	if (!sml) {
+		pr_info("Failed to add mm into list.\n");
+		return -ENOMEM;
+	}
+
+	sml->mm = mm;
+	sml->uc = uc;
+	list_add(&(sml->list), &(uprobe->sml.list));
+	return 0;
+}
+
+static void sdt_del_mm_list(struct uprobe *uprobe, struct mm_struct *mm,
+			    struct uprobe_consumer *uc)
+{
+	struct list_head *pos, *q;
+	struct sdt_mm_list *sml;
+
+	list_for_each_safe(pos, q, &(uprobe->sml.list)) {
+		sml = list_entry(pos, struct sdt_mm_list, list);
+		if (sml->mm == mm && sml->uc == uc) {
+			list_del(pos);
+			kfree(sml);
+		}
+	}
+}
+
 static bool sdt_valid_vma(struct uprobe *uprobe,
 			  struct vm_area_struct *vma,
 			  unsigned long vaddr)
@@ -917,7 +978,8 @@ static struct vm_area_struct *sdt_find_vma(struct uprobe *uprobe,
 	return ret;
 }
 
-static int sdt_increment_ref_ctr(struct uprobe *uprobe)
+static int
+sdt_increment_ref_ctr(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	struct map_info *info, *first = NULL;
 	int ctr = 0, ret = 0, tmp = 0;
@@ -934,16 +996,35 @@ static int sdt_increment_ref_ctr(struct uprobe *uprobe)
 	first = info;
 	while (info) {
 		down_write(&info->mm->mmap_sem);
+		mutex_lock(&uprobe->sml_lock);
+
+		if (sdt_check_mm_list(uprobe, info->mm, uc)) {
+			mutex_unlock(&uprobe->sml_lock);
+			up_write(&info->mm->mmap_sem);
+			info = info->next;
+			continue;
+		}
+
 		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
 			ret = sdt_update_ref_ctr(info->mm, info->vaddr, 1);
 			if (unlikely(ret)) {
+				mutex_unlock(&uprobe->sml_lock);
+				up_write(&info->mm->mmap_sem);
+				goto rollback;
+			}
+
+			ctr++;
+
+			ret = sdt_add_mm_list(uprobe, info->mm, uc);
+			if (unlikely(ret)) {
+				mutex_unlock(&uprobe->sml_lock);
 				up_write(&info->mm->mmap_sem);
 				goto rollback;
 			}
 		}
+		mutex_unlock(&uprobe->sml_lock);
 		up_write(&info->mm->mmap_sem);
 		info = info->next;
-		ctr++;
 	}
 	ret = 0;
 	goto out;
@@ -956,11 +1037,15 @@ static int sdt_increment_ref_ctr(struct uprobe *uprobe)
 	info = first;
 	while (ctr) {
 		down_write(&info->mm->mmap_sem);
+		mutex_lock(&uprobe->sml_lock);
 		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
 			tmp = sdt_update_ref_ctr(info->mm, info->vaddr, -1);
 			if (unlikely(tmp))
 				pr_warn("ref_ctr rollback failed. (%d)\n", tmp);
+
+			sdt_del_mm_list(uprobe, info->mm, uc);
 		}
+		mutex_unlock(&uprobe->sml_lock);
 		up_write(&info->mm->mmap_sem);
 		info = info->next;
 		ctr--;
@@ -977,7 +1062,12 @@ static int sdt_increment_ref_ctr(struct uprobe *uprobe)
 	return ret;
 }
 
-static int sdt_decrement_ref_ctr(struct uprobe *uprobe)
+/*
+ * We don't check presence of {uc,mm} in sml here. We just decrement
+ * the reference counter if we find vma holding the reference counter.
+ */
+static int
+sdt_decrement_ref_ctr(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	struct map_info *info;
 	int ret = 0, err = 0;
@@ -990,6 +1080,7 @@ static int sdt_decrement_ref_ctr(struct uprobe *uprobe)
 
 	while (info) {
 		down_write(&info->mm->mmap_sem);
+		mutex_lock(&uprobe->sml_lock);
 
 		if (sdt_find_vma(uprobe, info->mm, info->vaddr)) {
 			ret = sdt_update_ref_ctr(info->mm, info->vaddr, -1);
@@ -997,6 +1088,8 @@ static int sdt_decrement_ref_ctr(struct uprobe *uprobe)
 			err = !err && ret ? ret : err;
 		}
 
+		sdt_del_mm_list(uprobe, info->mm, uc);
+		mutex_unlock(&uprobe->sml_lock);
 		up_write(&info->mm->mmap_sem);
 		mmput(info->mm);
 		info = free_map_info(info);
@@ -1014,7 +1107,7 @@ static void __uprobe_unregister(struct uprobe *uprobe,
 	int err;
 
 	if (ref_ctr_dec && uprobe->ref_ctr_offset)
-		sdt_decrement_ref_ctr(uprobe);
+		sdt_decrement_ref_ctr(uprobe, uc);
 
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		return;
@@ -1102,7 +1195,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 
 		ret = register_for_each_vma(uprobe, uc);
 		if (!ret && ref_ctr_offset)
-			ret = sdt_increment_ref_ctr(uprobe);
+			ret = sdt_increment_ref_ctr(uprobe, uc);
 
 		if (ret)
 			__uprobe_unregister(uprobe, uc, false);
@@ -1258,6 +1351,26 @@ static void build_probe_list(struct inode *inode, int off_type,
 	spin_unlock(&uprobes_treelock);
 }
 
+static int __sdt_uprobe_mmap(struct uprobe *uprobe, struct mm_struct *mm,
+			     unsigned long vaddr, struct uprobe_consumer *uc)
+{
+	int ret;
+
+	if (sdt_check_mm_list(uprobe, mm, uc))
+		return 0;
+
+	ret = sdt_update_ref_ctr(mm, vaddr, 1);
+	if (unlikely(ret))
+		return ret;
+
+	ret = sdt_add_mm_list(uprobe, mm, uc);
+	if (likely(!ret))
+		return ret;
+
+	/* Failed to add mm into the list. Rollback ref_ctr update */
+	return sdt_update_ref_ctr(mm, vaddr, -1);
+}
+
 /* Called with down_write(&vma->vm_mm->mmap_sem) */
 static int sdt_uprobe_mmap(struct vm_area_struct *vma, struct inode *inode)
 {
@@ -1280,10 +1393,14 @@ static int sdt_uprobe_mmap(struct vm_area_struct *vma, struct inode *inode)
 
 		/* Increment reference counter for each consumer. */
 		down_read(&uprobe->consumer_rwsem);
+		mutex_lock(&uprobe->sml_lock);
+
 		for (uc = uprobe->consumers; uc; uc = uc->next) {
-			ret = sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
+			ret = __sdt_uprobe_mmap(uprobe, vma->vm_mm, vaddr, uc);
 			err = !err && ret ? ret : err;
 		}
+
+		mutex_unlock(&uprobe->sml_lock);
 		up_read(&uprobe->consumer_rwsem);
 		put_uprobe(uprobe);
 	}
@@ -1477,6 +1594,29 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
 
+static void sdt_mm_release(struct rb_node *n, struct mm_struct *mm)
+{
+	struct uprobe *uprobe;
+	struct uprobe_consumer *uc;
+
+	if (!n)
+		return;
+
+	uprobe = rb_entry(n, struct uprobe, rb_node);
+
+	down_read(&uprobe->consumer_rwsem);
+	mutex_lock(&uprobe->sml_lock);
+
+	for (uc = uprobe->consumers; uc; uc = uc->next)
+		sdt_del_mm_list(uprobe, mm, uc);
+
+	mutex_unlock(&uprobe->sml_lock);
+	up_read(&uprobe->consumer_rwsem);
+
+	sdt_mm_release(n->rb_left, mm);
+	sdt_mm_release(n->rb_right, mm);
+}
+
 /*
  * uprobe_clear_state - Free the area allocated for slots.
  */
@@ -1484,6 +1624,10 @@ void uprobe_clear_state(struct mm_struct *mm)
 {
 	struct xol_area *area = mm->uprobes_state.xol_area;
 
+	spin_lock(&uprobes_treelock);
+	sdt_mm_release(uprobes_tree.rb_node, mm);
+	spin_unlock(&uprobes_treelock);
+
 	if (!area)
 		return;
 
-- 
1.8.3.1
