Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeB1Hv6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:51:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751080AbeB1Hvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:51:55 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC 2/4] Uprobe: Export few functions / data structures
Date: Wed, 28 Feb 2018 13:23:43 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022807-0008-0000-0000-000004D55D20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0009-0000-0000-00001E68804A
Message-Id: <20180228075345.674-3-ravi.bangoria@linux.vnet.ibm.com>
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

These functions and data structures will be used by other files
in later patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 include/linux/uprobes.h | 23 +++++++++++++++++++++++
 kernel/events/uprobes.c | 20 ++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..06c169e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,6 +115,12 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+struct uprobe_map_info {
+	struct uprobe_map_info *next;
+	struct mm_struct *mm;
+	unsigned long vaddr;
+};
+
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
@@ -149,6 +155,11 @@ struct uprobes_state {
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset);
+void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len);
+struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info);
+
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
@@ -203,5 +214,17 @@ static inline void uprobe_copy_process(struct task_struct *t, unsigned long flag
 static inline void uprobe_clear_state(struct mm_struct *mm)
 {
 }
+unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+{
+}
+void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+{
+}
+void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
+{
+}
+struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info)
+{
+}
 #endif /* !CONFIG_UPROBES */
 #endif	/* _LINUX_UPROBES_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fcce25dd..56dd7af 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -130,7 +130,7 @@ static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
 }
 
-static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
 {
 	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 }
@@ -240,14 +240,14 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
 	kunmap_atomic(kaddr);
 }
 
-static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
+void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
@@ -705,23 +705,15 @@ static void delete_uprobe(struct uprobe *uprobe)
 	put_uprobe(uprobe);
 }
 
-struct uprobe_map_info {
-	struct uprobe_map_info *next;
-	struct mm_struct *mm;
-	unsigned long vaddr;
-};
-
-static inline struct uprobe_map_info *
-free_uprobe_map_info(struct uprobe_map_info *info)
+struct uprobe_map_info *free_uprobe_map_info(struct uprobe_map_info *info)
 {
 	struct uprobe_map_info *next = info->next;
 	kfree(info);
 	return next;
 }
 
-static struct uprobe_map_info *
-build_uprobe_map_info(struct address_space *mapping, loff_t offset,
-		      bool is_register)
+struct uprobe_map_info *build_uprobe_map_info(struct address_space *mapping,
+					      loff_t offset, bool is_register)
 {
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
-- 
1.8.3.1
