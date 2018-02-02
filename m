Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBBJPk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:15:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750799AbeBBJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:15:27 -0500
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, mhocko@suse.com
Subject: [PATCH] mm/migrate: Change migration reason MR_CMA as MR_CONTIG_RANGE
Date: Fri,  2 Feb 2018 14:45:18 +0530
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
References: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020209-0040-0000-0000-0000040BAA57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020209-0041-0000-0000-0000260F4DA4
Message-Id: <20180202091518.18798-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020110
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range() initiates compaction and eventual migration for
the purpose of either CMA or HugeTLB allocation. At present, reason
code remains the same MR_CMA for either of these cases. Lets make it
MR_CONTIG_RANGE which will appropriately reflect reason code in both
these cases.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmu_context_iommu.c | 2 +-
 include/linux/migrate.h             | 2 +-
 include/trace/events/migrate.h      | 2 +-
 mm/page_alloc.c                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 91ee2231c527..4c615fcb0cf0 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -111,7 +111,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	put_page(page); /* Drop the gup reference */
 
 	ret = migrate_pages(&cma_migrate_pages, new_iommu_non_cma_page,
-				NULL, 0, MIGRATE_SYNC, MR_CMA);
+				NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE);
 	if (ret) {
 		if (!list_empty(&cma_migrate_pages))
 			putback_movable_pages(&cma_migrate_pages);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index a732598fcf83..7e7e2606bb4c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -25,7 +25,7 @@ enum migrate_reason {
 	MR_SYSCALL,		/* also applies to cpusets */
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
-	MR_CMA,
+	MR_CONTIG_RANGE,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index bcf4daccd6be..711372845945 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -20,7 +20,7 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CMA,		"cma")
+	EMe(MR_CONTIG_RANGE,	"contig_range")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 242565855d05..b9a22e16b4cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7622,7 +7622,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, new_page_alloc_contig,
-				    NULL, 0, cc->mode, MR_CMA);
+				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
-- 
2.11.0
