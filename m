Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeDQEeF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:34:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752326AbeDQEeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:34:02 -0400
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3 5/9] Uprobe: Export uprobe_map_info along with uprobe_{build/free}_map_info()
Date: Tue, 17 Apr 2018 10:02:40 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041704-0012-0000-0000-000005CBA367
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0013-0000-0000-00001947EB43
Message-Id: <20180417043244.7501-6-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Given the file(inode) and offset, build_map_info() finds all
existing mm that map the portion of file containing offset.

Exporting these functions and data structure will help to use
them in other set of files.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 include/linux/uprobes.h |  9 +++++++++
 kernel/events/uprobes.c | 14 +++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..7bd2760 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -109,12 +109,19 @@ enum rp_check {
 	RP_CHECK_RET,
 };
 
+struct address_space;
 struct xol_area;
 
 struct uprobes_state {
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
@@ -149,6 +156,8 @@ struct uprobes_state {
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info);
+extern struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping, loff_t offset, bool is_register);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 477dc42..096d1e6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -695,14 +695,7 @@ static void delete_uprobe(struct uprobe *uprobe)
 	put_uprobe(uprobe);
 }
 
-struct uprobe_map_info {
-	struct uprobe_map_info *next;
-	struct mm_struct *mm;
-	unsigned long vaddr;
-};
-
-static inline struct uprobe_map_info *
-uprobe_free_map_info(struct uprobe_map_info *info)
+struct uprobe_map_info *uprobe_free_map_info(struct uprobe_map_info *info)
 {
 	struct uprobe_map_info *next = info->next;
 	mmput(info->mm);
@@ -710,9 +703,8 @@ struct uprobe_map_info {
 	return next;
 }
 
-static struct uprobe_map_info *
-uprobe_build_map_info(struct address_space *mapping, loff_t offset,
-		      bool is_register)
+struct uprobe_map_info *uprobe_build_map_info(struct address_space *mapping,
+					      loff_t offset, bool is_register)
 {
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
-- 
1.8.3.1
