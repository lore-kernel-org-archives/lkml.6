Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeDDIbG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:31:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeDDIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:31:03 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, rostedt@goodmis.org
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, jolsa@redhat.com,
        kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 2/9] mm: Prefix vma_ to vaddr_to_offset() and offset_to_vaddr()
Date: Wed,  4 Apr 2018 14:01:03 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040408-0044-0000-0000-000005434467
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040408-0045-0000-0000-0000288359DE
Message-Id: <20180404083110.18647-3-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function names more meaningful by adding vma_ prefix
to them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 include/linux/mm.h      |  4 ++--
 kernel/events/uprobes.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 95909f2..d7ee526 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2275,13 +2275,13 @@ struct vm_unmapped_area_info {
 }
 
 static inline unsigned long
-offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+vma_offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
 {
 	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 }
 
 static inline loff_t
-vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
+vma_vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
 {
 	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bd6f230..535fd39 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -748,7 +748,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 		curr = info;
 
 		info->mm = vma->vm_mm;
-		info->vaddr = offset_to_vaddr(vma, offset);
+		info->vaddr = vma_offset_to_vaddr(vma, offset);
 	}
 	i_mmap_unlock_read(mapping);
 
@@ -807,7 +807,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 			goto unlock;
 
 		if (vma->vm_start > info->vaddr ||
-		    vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
+		    vma_vaddr_to_offset(vma, info->vaddr) != uprobe->offset)
 			goto unlock;
 
 		if (is_register) {
@@ -977,7 +977,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 		    uprobe->offset >= offset + vma->vm_end - vma->vm_start)
 			continue;
 
-		vaddr = offset_to_vaddr(vma, uprobe->offset);
+		vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
 		err |= remove_breakpoint(uprobe, mm, vaddr);
 	}
 	up_read(&mm->mmap_sem);
@@ -1023,7 +1023,7 @@ static void build_probe_list(struct inode *inode,
 	struct uprobe *u;
 
 	INIT_LIST_HEAD(head);
-	min = vaddr_to_offset(vma, start);
+	min = vma_vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
@@ -1076,7 +1076,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, UPROBE_FILTER_MMAP, vma->vm_mm)) {
-			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
+			unsigned long vaddr = vma_offset_to_vaddr(vma, uprobe->offset);
 			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
 		}
 		put_uprobe(uprobe);
@@ -1095,7 +1095,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 
 	inode = file_inode(vma->vm_file);
 
-	min = vaddr_to_offset(vma, start);
+	min = vma_vaddr_to_offset(vma, start);
 	max = min + (end - start) - 1;
 
 	spin_lock(&uprobes_treelock);
@@ -1730,7 +1730,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 	if (vma && vma->vm_start <= bp_vaddr) {
 		if (valid_vma(vma, false)) {
 			struct inode *inode = file_inode(vma->vm_file);
-			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
+			loff_t offset = vma_vaddr_to_offset(vma, bp_vaddr);
 
 			uprobe = find_uprobe(inode, offset);
 		}
-- 
1.8.3.1
