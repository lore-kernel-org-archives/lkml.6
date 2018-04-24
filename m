Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756453AbeDXGmP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:42:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756195AbeDXGmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:42:09 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/2] mm/ksm: move [set_]page_stable_node from ksm.h to ksm.c
Date: Tue, 24 Apr 2018 09:41:46 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552106-7356-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552106-7356-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0020-0000-0000-0000041527DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0021-0000-0000-000042A9888A
Message-Id: <1524552106-7356-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_stable_node() and set_page_stable_node() are only used in mm/ksm.c
and there is no point to keep them in the include/linux/ksm.h

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/ksm.h | 11 -----------
 mm/ksm.c            | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index bbdfca3..161e816 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -37,17 +37,6 @@ static inline void ksm_exit(struct mm_struct *mm)
 		__ksm_exit(mm);
 }
 
-static inline struct stable_node *page_stable_node(struct page *page)
-{
-	return PageKsm(page) ? page_rmapping(page) : NULL;
-}
-
-static inline void set_page_stable_node(struct page *page,
-					struct stable_node *stable_node)
-{
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
-}
-
 /*
  * When do_swap_page() first faults in from swap what used to be a KSM page,
  * no problem, it will be assigned to this vma's anon_vma; but thereafter,
diff --git a/mm/ksm.c b/mm/ksm.c
index 16451a2..58c2741 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -827,6 +827,18 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
 /*
  * Only called through the sysfs control interface:
  */
+
+static inline struct stable_node *page_stable_node(struct page *page)
+{
+	return PageKsm(page) ? page_rmapping(page) : NULL;
+}
+
+static inline void set_page_stable_node(struct page *page,
+					struct stable_node *stable_node)
+{
+	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+}
+
 static int remove_stable_node(struct stable_node *stable_node)
 {
 	struct page *page;
-- 
2.7.4
