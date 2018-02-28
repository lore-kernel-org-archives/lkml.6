Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeB1HwL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:52:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752170AbeB1HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:52:01 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC 4/4] trace_uprobe: Fix multiple update of same semaphores
Date: Wed, 28 Feb 2018 13:23:45 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022807-0016-0000-0000-0000052AAF5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0017-0000-0000-00002866DFA4
Message-Id: <20180228075345.674-5-ravi.bangoria@linux.vnet.ibm.com>
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

For tiny binaries/libraries, different mmap regions points to
the same file portion. In such cases, we may increment semaphore
multiple times. But while de-registration, semaphore will get
decremented only once, leaving semaphore > 0 even if no one is
tracing on that marker.

Ensure increment and decrement happens in sync by keeping list
of mms in trace_uprobe. Increment semaphore only if mm is not
present in the list and decrement only if mm is present in the
list.

Example

  # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events

Before patch:

  # echo 1 > events/sdt_tick/loop2/enable
  # ./Workspace/sdt_prog/tick &
  # dd if=/proc//mem bs=1 count=1 skip=268566582 2>/dev/null | xxd
    0000000: 02                                       .

  # echo 0 > events/sdt_tick/loop2/enable
  # dd if=/proc//mem bs=1 count=1 skip=268566582 2>/dev/null | xxd
    0000000: 01                                       .

After patch:

  # echo 1 > events/sdt_tick/loop2/enable
  # ./Workspace/sdt_prog/tick &
  # dd if=/proc//mem bs=1 count=1 skip=268566582 2>/dev/null | xxd
    0000000: 01                                       .

  # echo 0 > events/sdt_tick/loop2/enable
  # dd if=/proc//mem bs=1 count=1 skip=268566582 2>/dev/null | xxd
    0000000: 00                                       .

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/trace/trace_uprobe.c | 105 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d14aafc..3f1e8bd 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -49,6 +49,11 @@ struct trace_uprobe_filter {
 	struct list_head	perf_events;
 };
 
+struct sdt_mm_list {
+	struct mm_struct *mm;
+	struct sdt_mm_list *next;
+};
+
 /*
  * uprobe event core functions
  */
@@ -60,6 +65,8 @@ struct trace_uprobe {
 	char				*filename;
 	unsigned long			offset;
 	unsigned long			sdt_offset; /* sdt semaphore offset */
+	struct sdt_mm_list		*sml;
+	struct rw_semaphore		sml_rw_sem;
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -273,6 +280,7 @@ static inline bool is_ret_probe(struct trace_uprobe *tu)
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
 	init_trace_uprobe_filter(&tu->filter);
+	init_rwsem(&tu->sml_rw_sem);
 	return tu;
 
 error:
@@ -953,6 +961,75 @@ static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
 	return 0;
 }
 
+static bool sdt_check_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
+{
+	struct sdt_mm_list *tmp = tu->sml;
+
+	if (!tu->sml || !mm)
+		return false;
+
+	while (tmp) {
+		if (tmp->mm == mm)
+			return true;
+		tmp = tmp->next;
+	}
+
+	return false;
+}
+
+static void sdt_add_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
+{
+	struct sdt_mm_list *tmp;
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp) {
+		pr_info("sdt_add_mm_list failed.\n");
+		return;
+	}
+	tmp->mm = mm;
+	tmp->next = tu->sml;
+	tu->sml = tmp;
+}
+
+static void sdt_del_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
+{
+	struct sdt_mm_list *prev, *curr;
+
+	if (!tu->sml)
+		return;
+
+	if (tu->sml->mm == mm) {
+		curr = tu->sml;
+		tu->sml = tu->sml->next;
+		kfree(curr);
+		return;
+	}
+
+	prev = tu->sml;
+	curr = tu->sml->next;
+	while (curr) {
+		if (curr->mm == mm) {
+			prev->next = curr->next;
+			kfree(curr);
+			return;
+		}
+		prev = curr;
+		curr = curr->next;
+	}
+}
+
+static void sdt_flush_mm_list(struct trace_uprobe *tu)
+{
+	struct sdt_mm_list *next, *curr = tu->sml;
+
+	while (curr) {
+		next = curr->next;
+		kfree(curr);
+		curr = next;
+	}
+	tu->sml = NULL;
+}
+
 /*
  * TODO: Adding this defination in include/linux/uprobes.h throws
  * warnings about address_sapce. Adding it here for the time being.
@@ -970,20 +1047,26 @@ static void sdt_increment_sem(struct trace_uprobe *tu)
 	if (IS_ERR(info))
 		goto out;
 
+	down_write(&tu->sml_rw_sem);
 	while (info) {
 		down_write(&info->mm->mmap_sem);
 		vma = sdt_find_vma(info->mm, tu);
 		if (!vma)
 			goto cont;
 
+		if (sdt_check_mm_list(tu, info->mm))
+			goto cont;
+
 		vaddr = offset_to_vaddr(vma, tu->sdt_offset);
-		sdt_update_sem(info->mm, vaddr, 1);
+		if (!sdt_update_sem(info->mm, vaddr, 1))
+			sdt_add_mm_list(tu, info->mm);
 
 cont:
 		up_write(&info->mm->mmap_sem);
 		mmput(info->mm);
 		info = free_uprobe_map_info(info);
 	}
+	up_write(&tu->sml_rw_sem);
 
 out:
 	uprobe_end_dup_mmap();
@@ -1001,8 +1084,16 @@ void trace_uprobe_mmap_callback(struct vm_area_struct *vma)
 		    !trace_probe_is_enabled(&tu->tp))
 			continue;
 
+		down_write(&tu->sml_rw_sem);
+		if (sdt_check_mm_list(tu, vma->vm_mm))
+			goto cont;
+
 		vaddr = offset_to_vaddr(vma, tu->sdt_offset);
-		sdt_update_sem(vma->vm_mm, vaddr, 1);
+		if (!sdt_update_sem(vma->vm_mm, vaddr, 1))
+			sdt_add_mm_list(tu, vma->vm_mm);
+
+cont:
+		up_write(&tu->sml_rw_sem);
 	}
 	mutex_unlock(&uprobe_lock);
 }
@@ -1017,7 +1108,11 @@ static void sdt_decrement_sem(struct trace_uprobe *tu)
 	if (IS_ERR(info))
 		return;
 
+	down_write(&tu->sml_rw_sem);
 	while (info) {
+		if (!sdt_check_mm_list(tu, info->mm))
+			goto cont;
+
 		down_write(&info->mm->mmap_sem);
 		vma = sdt_find_vma(info->mm, tu);
 		if (vma) {
@@ -1025,10 +1120,14 @@ static void sdt_decrement_sem(struct trace_uprobe *tu)
 			sdt_update_sem(info->mm, vaddr, -1);
 		}
 		up_write(&info->mm->mmap_sem);
-
+		sdt_del_mm_list(tu, info->mm);
+
+cont:
 		mmput(info->mm);
 		info = free_uprobe_map_info(info);
 	}
+	sdt_flush_mm_list(tu);
+	up_write(&tu->sml_rw_sem);
 }
 
 typedef bool (*filter_func_t)(struct uprobe_consumer *self,
-- 
1.8.3.1
