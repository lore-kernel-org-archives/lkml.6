Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeB1HwC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:52:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751080AbeB1Hv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:51:59 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC 3/4] trace_uprobe: Support SDT markers having semaphore
Date: Wed, 28 Feb 2018 13:23:44 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022807-0008-0000-0000-000004D55D22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0009-0000-0000-00001E68804B
Message-Id: <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280094
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. These markers are added by developer at
important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. If this computaion is quite more, execution of it can be
ommited by runtime if() condition when no one is tracing on the marker:

    if (semaphore > 0) {
        Execute marker instructions;
    }   

Default value of semaphore is 0. Tracer has to increment the semaphore
before recording on a marker and decrement it at the end of tracing.

Implement the semaphore flip logic in trace_uprobe, leaving core uprobe
infrastructure as is, except one new callback from uprobe_mmap() to
trace_uprobe.

There are two major scenarios while enabling the marker,
 1. Trace already running process. In this case, find all suitable
    processes and increment the semaphore value in them.
 2. Trace is already enabled when target binary is executed. In this
    case, all mmaps will get notified to trace_uprobe and trace_uprobe
    will increment the semaphore if corresponding uprobe is enabled.

At the time of disabling probes, decrement semaphore in all existing
target processes.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 include/linux/uprobes.h     |   2 +
 kernel/events/uprobes.c     |   5 ++
 kernel/trace/trace_uprobe.c | 145 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 06c169e..04e9d57 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -121,6 +121,8 @@ struct uprobe_map_info {
 	unsigned long vaddr;
 };
 
+extern void (*uprobe_mmap_callback)(struct vm_area_struct *vma);
+
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 56dd7af..81d8aaf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1051,6 +1051,8 @@ static void build_probe_list(struct inode *inode,
 	spin_unlock(&uprobes_treelock);
 }
 
+void (*uprobe_mmap_callback)(struct vm_area_struct *vma) = NULL;
+
 /*
  * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
  *
@@ -1063,6 +1065,9 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
+	if (vma->vm_flags & VM_WRITE && uprobe_mmap_callback)
+		uprobe_mmap_callback(vma);
+
 	if (no_uprobe_events() || !valid_vma(vma, true))
 		return 0;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 40592e7b..d14aafc 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -25,6 +25,7 @@
 #include <linux/namei.h>
 #include <linux/string.h>
 #include <linux/rculist.h>
+#include <linux/sched/mm.h>
 
 #include "trace_probe.h"
 
@@ -58,6 +59,7 @@ struct trace_uprobe {
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
+	unsigned long			sdt_offset; /* sdt semaphore offset */
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -502,6 +504,16 @@ static int create_trace_uprobe(int argc, char **argv)
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
 		struct probe_arg *parg = &tu->tp.args[i];
 
+		/* This is not really an argument. */
+		if (argv[i][0] == '*') {
+			ret = kstrtoul(&(argv[i][1]), 0, &tu->sdt_offset);
+			if (ret) {
+				pr_info("Invalid semaphore address.\n");
+				goto error;
+			}
+			continue;
+		}
+
 		/* Increment count for freeing args in error case */
 		tu->tp.nr_args++;
 
@@ -894,6 +906,131 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 	return trace_handle_return(s);
 }
 
+static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
+{
+	unsigned long vaddr = offset_to_vaddr(vma, tu->sdt_offset);
+
+	return tu->sdt_offset &&
+		vma->vm_file &&
+		file_inode(vma->vm_file) == tu->inode &&
+		vma->vm_flags & VM_WRITE &&
+		vma->vm_start <= vaddr &&
+		vma->vm_end > vaddr;
+}
+
+static struct vm_area_struct *
+sdt_find_vma(struct mm_struct *mm, struct trace_uprobe *tu)
+{
+	struct vm_area_struct *tmp;
+
+	for (tmp = mm->mmap; tmp != NULL; tmp = tmp->vm_next)
+		if (sdt_valid_vma(tu, tmp))
+			return tmp;
+
+	return NULL;
+}
+
+static int
+sdt_update_sem(struct mm_struct *mm, unsigned long vaddr, short val)
+{
+	struct page *page;
+	struct vm_area_struct *vma;
+	int ret = 0;
+	unsigned short orig = 0;
+
+	if (vaddr == 0)
+		return -EINVAL;
+
+	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
+		FOLL_FORCE | FOLL_WRITE, &page, &vma, NULL);
+	if (ret <= 0)
+		return ret;
+
+	copy_from_page(page, vaddr, &orig, sizeof(orig));
+	orig += val;
+	copy_to_page(page, vaddr, &orig, sizeof(orig));
+	put_page(page);
+	return 0;
+}
+
+/*
+ * TODO: Adding this defination in include/linux/uprobes.h throws
+ * warnings about address_sapce. Adding it here for the time being.
+ */
+struct uprobe_map_info *build_uprobe_map_info(struct address_space *mapping, loff_t offset, bool is_register);
+
+static void sdt_increment_sem(struct trace_uprobe *tu)
+{
+	struct uprobe_map_info *info;
+	struct vm_area_struct *vma;
+	unsigned long vaddr;
+
+	uprobe_start_dup_mmap();
+	info = build_uprobe_map_info(tu->inode->i_mapping, tu->sdt_offset, false);
+	if (IS_ERR(info))
+		goto out;
+
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+		vma = sdt_find_vma(info->mm, tu);
+		if (!vma)
+			goto cont;
+
+		vaddr = offset_to_vaddr(vma, tu->sdt_offset);
+		sdt_update_sem(info->mm, vaddr, 1);
+
+cont:
+		up_write(&info->mm->mmap_sem);
+		mmput(info->mm);
+		info = free_uprobe_map_info(info);
+	}
+
+out:
+	uprobe_end_dup_mmap();
+}
+
+/* Called with down_write(&vma->vm_mm->mmap_sem) */
+void trace_uprobe_mmap_callback(struct vm_area_struct *vma)
+{
+	struct trace_uprobe *tu;
+	unsigned long vaddr;
+
+	mutex_lock(&uprobe_lock);
+	list_for_each_entry(tu, &uprobe_list, list) {
+		if (!sdt_valid_vma(tu, vma) ||
+		    !trace_probe_is_enabled(&tu->tp))
+			continue;
+
+		vaddr = offset_to_vaddr(vma, tu->sdt_offset);
+		sdt_update_sem(vma->vm_mm, vaddr, 1);
+	}
+	mutex_unlock(&uprobe_lock);
+}
+
+static void sdt_decrement_sem(struct trace_uprobe *tu)
+{
+	struct vm_area_struct *vma;
+	unsigned long vaddr;
+	struct uprobe_map_info *info;
+
+	info = build_uprobe_map_info(tu->inode->i_mapping, tu->sdt_offset, false);
+	if (IS_ERR(info))
+		return;
+
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+		vma = sdt_find_vma(info->mm, tu);
+		if (vma) {
+			vaddr = offset_to_vaddr(vma, tu->sdt_offset);
+			sdt_update_sem(info->mm, vaddr, -1);
+		}
+		up_write(&info->mm->mmap_sem);
+
+		mmput(info->mm);
+		info = free_uprobe_map_info(info);
+	}
+}
+
 typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
@@ -939,6 +1076,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 	if (ret)
 		goto err_buffer;
 
+	if (tu->sdt_offset)
+		sdt_increment_sem(tu);
+
 	return 0;
 
  err_buffer:
@@ -979,6 +1119,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
+	if (tu->sdt_offset)
+		sdt_decrement_sem(tu);
+
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
@@ -1353,6 +1496,8 @@ static __init int init_uprobe_trace(void)
 	/* Profile interface */
 	trace_create_file("uprobe_profile", 0444, d_tracer,
 				    NULL, &uprobe_profile_ops);
+
+	uprobe_mmap_callback = trace_uprobe_mmap_callback;
 	return 0;
 }
 
-- 
1.8.3.1
