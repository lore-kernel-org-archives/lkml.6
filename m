Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELtUDFYKnw75OPpdaPay/9nG7GGkwvEYlz2zG4wFdbVCG4GzQDZaJCMmkPN9Bsdwjhz8ilWY
ARC-Seal: i=1; a=rsa-sha256; t=1520945726; cv=none;
        d=google.com; s=arc-20160816;
        b=phhJj8ezD0ZK7/M9FAkVQ1okhKsJvJ2uXjv8j4D96EB1Uo0/8/amgsSMJ3pzODzDOs
         WXj6m4XZsXmkwIFf04Oita/ZfNtC6e8iuC3YKc3Zn9nl1uclAcRymhWDOrRONf4nfY4M
         FC6yTqbm3WwM236UPQMBGwIXwU7l+Tk1R+G/tsWQE0nXlYRMVNE4jIFhQ2B0J/sT+no7
         Jc8F0W7Kt/epSSpMh4oA2USQ6L2UZ4Aduh/ij12MpABDHVcGfS0YwNXF8/RCRDyfUXth
         n4mtD88bq/eera3N5puBAY16jvjpmXBHPE0P+h8FoblmzUgZub2aC6pVU0jTxOvVaWgl
         232w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hnD7mBfGc75S4c/jERf2u3y6Hf1yFZGwhcffD/hMB7s=;
        b=ft0o0JUW3tYsk16kPlqYMfJpXmq/0qxs+/fAKY9kb5XsCIVV+lDISVuJYYKgYa4tbW
         6ZI7w9PfDokGplmh8VCEwWKTP9pjlpxrQepJDG6/LMC1Ao/QnNfVPIG3E+9yx73fydx5
         mu0cNU+Mc2BC7FafUH7JYysV/Fs50Ndtk6VNzRi0MzHFzQWzxrXXcdRNnuhfFu+mGKFl
         WHY0FRcICnU0M7J5Nv/GPhgsvtNN7xXaPvsHYL3qBqBeS/bslR+AsH/RHJ0CX/y9b4yF
         EmyakNthRzxq89autfQ2Hy5LqPpnKqw16GLPd5J1ZC9qGz+oEwSLHdVWdAIqPNHVEiuh
         Ejrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
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
Subject: [PATCH 6/8] trace_uprobe/sdt: Fix multiple update of same reference counter
Date: Tue, 13 Mar 2018 18:26:01 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0016-0000-0000-00000530FAEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0017-0000-0000-0000286E2CCD
Message-Id: <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1594827186487084438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For tiny binaries/libraries, different mmap regions points to the
same file portion. In such cases, we may increment reference counter
multiple times. But while de-registration, reference counter will get
decremented only by once leaving reference counter > 0 even if no one
is tracing on that marker.

Ensure increment and decrement happens in sync by keeping list of
mms in trace_uprobe. Increment reference counter only if mm is not
present in the list and decrement only if mm is present in the list.

Example

  # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4(0x10036)" > uprobe_events

Before patch:

  # perf stat -a -e sdt_tick:loop2
  # /tmp/tick
  # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
   0000000: 02                                       .

  # pkill perf
  # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
  0000000: 01                                       .

After patch:

  # perf stat -a -e sdt_tick:loop2
  # /tmp/tick
  # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
  0000000: 01                                       .

  # pkill perf
  # dd if=/proc/`pgrep tick`/mem bs=1 count=1 skip=$(( 0x10020036 )) 2>/dev/null | xxd
  0000000: 00                                       .

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/trace/trace_uprobe.c | 105 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b6c9b48..9bf3f7a 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -50,6 +50,11 @@ struct trace_uprobe_filter {
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
@@ -61,6 +66,8 @@ struct trace_uprobe {
 	char				*filename;
 	unsigned long			offset;
 	unsigned long			ref_ctr_offset;
+	struct sdt_mm_list		*sml;
+	struct rw_semaphore		sml_rw_sem;
 	unsigned long			nhit;
 	struct trace_probe		tp;
 };
@@ -274,6 +281,7 @@ static inline bool is_ret_probe(struct trace_uprobe *tu)
 	if (is_ret)
 		tu->consumer.ret_handler = uretprobe_dispatcher;
 	init_trace_uprobe_filter(&tu->filter);
+	init_rwsem(&tu->sml_rw_sem);
 	return tu;
 
 error:
@@ -921,6 +929,74 @@ static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 	return trace_handle_return(s);
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
+	if (!tmp)
+		return;
+
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
 static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
 {
 	unsigned long vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
@@ -989,17 +1065,25 @@ static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
 	if (IS_ERR(info))
 		goto out;
 
+	down_write(&tu->sml_rw_sem);
 	while (info) {
+		if (sdt_check_mm_list(tu, info->mm))
+			goto cont;
+
 		down_write(&info->mm->mmap_sem);
 
 		vma = sdt_find_vma(info->mm, tu);
 		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
-		sdt_update_ref_ctr(info->mm, vaddr, 1);
+		if (!sdt_update_ref_ctr(info->mm, vaddr, 1))
+			sdt_add_mm_list(tu, info->mm);
 
 		up_write(&info->mm->mmap_sem);
+
+cont:
 		mmput(info->mm);
 		info = uprobe_free_map_info(info);
 	}
+	up_write(&tu->sml_rw_sem);
 
 out:
 	uprobe_end_dup_mmap();
@@ -1020,8 +1104,16 @@ void trace_uprobe_mmap_callback(struct vm_area_struct *vma)
 		    !trace_probe_is_enabled(&tu->tp))
 			continue;
 
+		down_write(&tu->sml_rw_sem);
+		if (sdt_check_mm_list(tu, vma->vm_mm))
+			goto cont;
+
 		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
-		sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
+		if (!sdt_update_ref_ctr(vma->vm_mm, vaddr, 1))
+			sdt_add_mm_list(tu, vma->vm_mm);
+
+cont:
+		up_write(&tu->sml_rw_sem);
 	}
 	mutex_unlock(&uprobe_lock);
 }
@@ -1038,7 +1130,11 @@ static void sdt_decrement_ref_ctr(struct trace_uprobe *tu)
 	if (IS_ERR(info))
 		goto out;
 
+	down_write(&tu->sml_rw_sem);
 	while (info) {
+		if (!sdt_check_mm_list(tu, info->mm))
+			goto cont;
+
 		down_write(&info->mm->mmap_sem);
 
 		vma = sdt_find_vma(info->mm, tu);
@@ -1046,9 +1142,14 @@ static void sdt_decrement_ref_ctr(struct trace_uprobe *tu)
 		sdt_update_ref_ctr(info->mm, vaddr, -1);
 
 		up_write(&info->mm->mmap_sem);
+		sdt_del_mm_list(tu, info->mm);
+
+cont:
 		mmput(info->mm);
 		info = uprobe_free_map_info(info);
 	}
+	sdt_flush_mm_list(tu);
+	up_write(&tu->sml_rw_sem);
 
 out:
 	uprobe_end_dup_mmap();
-- 
1.8.3.1
