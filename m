Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELuDFI9B/UEie/EX7k21tl0dgM7hcrXfF8yI4wQo0SrebJQl9O6MWsYvCI+APBFbk8fjVCyd
ARC-Seal: i=1; a=rsa-sha256; t=1520945712; cv=none;
        d=google.com; s=arc-20160816;
        b=EX3KRRgk8f/OxDQOrYsmXpJd/sD2F6awowjqeowhrVQFOPQKq7dgSr1X82Nx4spWgD
         3VAJGgxksDuIKYtW9VCqzeXokS/QP0lk6lpXJd15LwdPA6B2uSE5eJYv9jlxYHUTVhpO
         k0NRPR/h5GFxEn3LJgZXHIg/9C+ZSSK99JOJgPmlJZqMfexLk88Jm+YZKNkOG8kLrk+J
         pMU+J552xZ6FzUkOwKKovQEZuaQEATXIXn26AsnJpf1oacm/l+OeauVOu57ctiAbfH0r
         HQ+nVCpLPaqKwUpzhwkYoXN0JrdyzOpmORAJNgoVX5ZLIeWXUM0wuIh4XpdxZINXzymS
         kazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=J41c53x1C+hJkFsUuw8uZLpyQvS187WsQfLSUVFaNuY=;
        b=dQpIEEwU5nBxiy3ya91OOqTOZC9L3WXtjk3rHTDh7Vr0ROR/tktuSk49LrXl4TBwW5
         Zf2YuHr/1VnnGqq2lwHnFFN05WQKYf63tZG+TexrIukCw4O6kWpGH0SI+ni92ZbMOHdJ
         RaGi2U6LEEPIWqcg6oAB3EwmM4KGC8fpSy/6jUBUCwLuim42qF9tsDJ1akNsFR9zMk6M
         tAfD3gZXP0zg485hkZY0Na3SP4QDsHMFMMsqnMEpHznnkVRtVvgNznv3Dp9pGRQbDKvL
         T9YnhPQ+2ByYodxbojPbTMJ0OTkwrsKVaSerGRhdXpmhFHE7p4VHZbLO8LlicocAjEEG
         LanA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 5/8] trace_uprobe: Support SDT markers having reference count (semaphore)
Date: Tue, 13 Mar 2018 18:26:00 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0016-0000-0000-00000530FAE0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0017-0000-0000-0000286E2CC2
Message-Id: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1594827171789714721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. These markers are added by developer at
important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. In case the overhead is more, execution of it can be
ommited by runtime if() condition when no one is tracing on the marker:

    if (reference_counter > 0) {
        Execute marker instructions;
    }

Default value of reference counter is 0. Tracer has to increment the
reference counter before tracing on a marker and decrement it when
done with the tracing.

Implement the reference counter logic in trace_uprobe, leaving core
uprobe infrastructure as is, except one new callback from uprobe_mmap()
to trace_uprobe.

trace_uprobe definition with reference counter will now be:

  <path>:<offset>[(ref_ctr_offset)]

There are two different cases while enabling the marker,
 1. Trace existing process. In this case, find all suitable processes
    and increment the reference counter in them.
 2. Enable trace before running target binary. In this case, all mmaps
    will get notified to trace_uprobe and trace_uprobe will increment
    the reference counter if corresponding uprobe is enabled.

At the time of disabling probes, decrement reference counter in all
existing target processes.

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

Note: 'reference counter' is called as 'semaphore' in original Dtrace
(or Systemtap, bcc and even in ELF) documentation and code. But the
term 'semaphore' is misleading in this context. This is just a counter
used to hold number of tracers tracing on a marker. This is not really
used for any synchronization. So we are referring it as 'reference
counter' in kernel / perf code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
[Fengguang reported/fixed build failure in RFC patch]
---
 include/linux/uprobes.h     |   2 +
 kernel/events/uprobes.c     |   6 ++
 kernel/trace/trace_uprobe.c | 172 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7bd2760..2d4df65 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -122,6 +122,8 @@ struct uprobe_map_info {
 	unsigned long vaddr;
 };
 
+extern void (*uprobe_mmap_callback)(struct vm_area_struct *vma);
+
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e7830b8..06821bb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1041,6 +1041,9 @@ static void build_probe_list(struct inode *inode,
 	spin_unlock(&uprobes_treelock);
 }
 
+/* Rightnow the only user of this is trace_uprobe. */
+void (*uprobe_mmap_callback)(struct vm_area_struct *vma);
+
 /*
  * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
  *
@@ -1053,6 +1056,9 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
 
+	if (uprobe_mmap_callback)
+		uprobe_mmap_callback(vma);
+
 	if (no_uprobe_events() || !valid_vma(vma, true))
 		return 0;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f43..b6c9b48 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -25,6 +25,8 @@
 #include <linux/namei.h>
 #include <linux/string.h>
 #include <linux/rculist.h>
+#include <linux/sched/mm.h>
+#include <linux/highmem.h>
 
 #include "trace_probe.h"
 
@@ -58,6 +60,7 @@ struct trace_uprobe {
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
+	unsigned long			ref_ctr_offset;
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -362,10 +365,10 @@ static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
 	struct inode *inode;
-	char *arg, *event, *group, *filename;
+	char *arg, *event, *group, *filename, *rctr, *rctr_end;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
-	unsigned long offset;
+	unsigned long offset, ref_ctr_offset;
 	bool is_delete, is_return;
 	int i, ret;
 
@@ -375,6 +378,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	is_return = false;
 	event = NULL;
 	group = NULL;
+	ref_ctr_offset = 0;
 
 	/* argc must be >= 1 */
 	if (argv[0][0] == '-')
@@ -454,6 +458,26 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 
+	/* Parse reference counter offset if specified. */
+	rctr = strchr(arg, '(');
+	if (rctr) {
+		rctr_end = strchr(arg, ')');
+		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
+			ret = -EINVAL;
+			pr_info("Invalid reference counter offset.\n");
+			goto fail_address_parse;
+		}
+
+		*rctr++ = 0;
+		*rctr_end = 0;
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
@@ -488,6 +512,7 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 	tu->offset = offset;
+	tu->ref_ctr_offset = ref_ctr_offset;
 	tu->inode = inode;
 	tu->filename = kstrdup(filename, GFP_KERNEL);
 
@@ -620,6 +645,8 @@ static int probes_seq_show(struct seq_file *m, void *v)
 			break;
 		}
 	}
+	if (tu->ref_ctr_offset)
+		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
 
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
@@ -894,6 +921,139 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 	return trace_handle_return(s);
 }
 
+static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
+{
+	unsigned long vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
+
+	return tu->ref_ctr_offset &&
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
+/*
+ * Reference count gate the invocation of probe. If present,
+ * by default reference count is 0. One needs to increment
+ * it before tracing the probe and decrement it when done.
+ */
+static int
+sdt_update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
+{
+	void *kaddr;
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
+	kaddr = kmap_atomic(page);
+	memcpy(&orig, kaddr + (vaddr & ~PAGE_MASK), sizeof(orig));
+	orig += d;
+	memcpy(kaddr + (vaddr & ~PAGE_MASK), &orig, sizeof(orig));
+	kunmap_atomic(kaddr);
+
+	put_page(page);
+	return 0;
+}
+
+static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
+{
+	struct uprobe_map_info *info;
+	struct vm_area_struct *vma;
+	unsigned long vaddr;
+
+	uprobe_start_dup_mmap();
+	info = uprobe_build_map_info(tu->inode->i_mapping,
+				tu->ref_ctr_offset, false);
+	if (IS_ERR(info))
+		goto out;
+
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+
+		vma = sdt_find_vma(info->mm, tu);
+		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
+		sdt_update_ref_ctr(info->mm, vaddr, 1);
+
+		up_write(&info->mm->mmap_sem);
+		mmput(info->mm);
+		info = uprobe_free_map_info(info);
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
+	if (!(vma->vm_flags & VM_WRITE))
+		return;
+
+	mutex_lock(&uprobe_lock);
+	list_for_each_entry(tu, &uprobe_list, list) {
+		if (!sdt_valid_vma(tu, vma) ||
+		    !trace_probe_is_enabled(&tu->tp))
+			continue;
+
+		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
+		sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
+	}
+	mutex_unlock(&uprobe_lock);
+}
+
+static void sdt_decrement_ref_ctr(struct trace_uprobe *tu)
+{
+	struct vm_area_struct *vma;
+	unsigned long vaddr;
+	struct uprobe_map_info *info;
+
+	uprobe_start_dup_mmap();
+	info = uprobe_build_map_info(tu->inode->i_mapping,
+				tu->ref_ctr_offset, false);
+	if (IS_ERR(info))
+		goto out;
+
+	while (info) {
+		down_write(&info->mm->mmap_sem);
+
+		vma = sdt_find_vma(info->mm, tu);
+		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
+		sdt_update_ref_ctr(info->mm, vaddr, -1);
+
+		up_write(&info->mm->mmap_sem);
+		mmput(info->mm);
+		info = uprobe_free_map_info(info);
+	}
+
+out:
+	uprobe_end_dup_mmap();
+}
+
 typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 				enum uprobe_filter_ctx ctx,
 				struct mm_struct *mm);
@@ -939,6 +1099,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 	if (ret)
 		goto err_buffer;
 
+	if (tu->ref_ctr_offset)
+		sdt_increment_ref_ctr(tu);
+
 	return 0;
 
  err_buffer:
@@ -979,6 +1142,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
 
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
 
+	if (tu->ref_ctr_offset)
+		sdt_decrement_ref_ctr(tu);
+
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
 	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
 
@@ -1423,6 +1589,8 @@ static __init int init_uprobe_trace(void)
 	/* Profile interface */
 	trace_create_file("uprobe_profile", 0444, d_tracer,
 				    NULL, &uprobe_profile_ops);
+
+	uprobe_mmap_callback = trace_uprobe_mmap_callback;
 	return 0;
 }
 
-- 
1.8.3.1
