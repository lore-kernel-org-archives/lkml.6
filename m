Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDQEda (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 00:33:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750738AbeDQEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 00:33:27 -0400
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
Subject: [PATCH v3 1/9] Uprobe: Export vaddr <-> offset conversion functions
Date: Tue, 17 Apr 2018 10:02:36 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041704-0044-0000-0000-0000054900B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041704-0045-0000-0000-000028890C02
Message-Id: <20180417043244.7501-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

These are generic functions which operates on file offset
and virtual address. Make these functions available outside
of uprobe code so that other can use it as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 include/linux/mm.h      | 12 ++++++++++++
 kernel/events/uprobes.c | 10 ----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ccac106..de0cc08 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,6 +2272,18 @@ struct vm_unmapped_area_info {
 		return unmapped_area(info);
 }
 
+static inline unsigned long
+offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
+{
+	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+}
+
+static inline loff_t
+vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
+{
+	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
+}
+
 /* truncate.c */
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ce6848e..bd6f230 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -130,16 +130,6 @@ static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
 }
 
-static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
-{
-	return vma->vm_start + offset - ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-}
-
-static loff_t vaddr_to_offset(struct vm_area_struct *vma, unsigned long vaddr)
-{
-	return ((loff_t)vma->vm_pgoff << PAGE_SHIFT) + (vaddr - vma->vm_start);
-}
-
 /**
  * __replace_page - replace page in vma by new page.
  * based on replace_page in mm/ksm.c
-- 
1.8.3.1
