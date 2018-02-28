Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeB1Hvx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:51:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751646AbeB1Hvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:51:50 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [RFC 1/4] Uprobe: Rename map_info to uprobe_map_info
Date: Wed, 28 Feb 2018 13:23:42 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022807-0008-0000-0000-000004D55D1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022807-0009-0000-0000-00001E688047
Message-Id: <20180228075345.674-2-ravi.bangoria@linux.vnet.ibm.com>
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

map_info is very generic name, rename it to uprobe_map_info.
Renaming will help to export this structure outside of the
file.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/events/uprobes.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 267f6ef..fcce25dd 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -705,27 +705,29 @@ static void delete_uprobe(struct uprobe *uprobe)
 	put_uprobe(uprobe);
 }
 
-struct map_info {
-	struct map_info *next;
+struct uprobe_map_info {
+	struct uprobe_map_info *next;
 	struct mm_struct *mm;
 	unsigned long vaddr;
 };
 
-static inline struct map_info *free_map_info(struct map_info *info)
+static inline struct uprobe_map_info *
+free_uprobe_map_info(struct uprobe_map_info *info)
 {
-	struct map_info *next = info->next;
+	struct uprobe_map_info *next = info->next;
 	kfree(info);
 	return next;
 }
 
-static struct map_info *
-build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
+static struct uprobe_map_info *
+build_uprobe_map_info(struct address_space *mapping, loff_t offset,
+		      bool is_register)
 {
 	unsigned long pgoff = offset >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
-	struct map_info *curr = NULL;
-	struct map_info *prev = NULL;
-	struct map_info *info;
+	struct uprobe_map_info *curr = NULL;
+	struct uprobe_map_info *prev = NULL;
+	struct uprobe_map_info *info;
 	int more = 0;
 
  again:
@@ -739,7 +741,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 			 * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
 			 * reclaim. This is optimistic, no harm done if it fails.
 			 */
-			prev = kmalloc(sizeof(struct map_info),
+			prev = kmalloc(sizeof(struct uprobe_map_info),
 					GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (prev)
 				prev->next = NULL;
@@ -772,7 +774,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	}
 
 	do {
-		info = kmalloc(sizeof(struct map_info), GFP_KERNEL);
+		info = kmalloc(sizeof(struct uprobe_map_info), GFP_KERNEL);
 		if (!info) {
 			curr = ERR_PTR(-ENOMEM);
 			goto out;
@@ -784,7 +786,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	goto again;
  out:
 	while (prev)
-		prev = free_map_info(prev);
+		prev = free_uprobe_map_info(prev);
 	return curr;
 }
 
@@ -792,11 +794,11 @@ static inline struct map_info *free_map_info(struct map_info *info)
 register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 {
 	bool is_register = !!new;
-	struct map_info *info;
+	struct uprobe_map_info *info;
 	int err = 0;
 
 	percpu_down_write(&dup_mmap_sem);
-	info = build_map_info(uprobe->inode->i_mapping,
+	info = build_uprobe_map_info(uprobe->inode->i_mapping,
 					uprobe->offset, is_register);
 	if (IS_ERR(info)) {
 		err = PTR_ERR(info);
@@ -835,7 +837,7 @@ static inline struct map_info *free_map_info(struct map_info *info)
 		up_write(&mm->mmap_sem);
  free:
 		mmput(mm);
-		info = free_map_info(info);
+		info = free_uprobe_map_info(info);
 	}
  out:
 	percpu_up_write(&dup_mmap_sem);
-- 
1.8.3.1
