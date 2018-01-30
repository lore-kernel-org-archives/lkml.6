Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeA3DHX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 22:07:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752076AbeA3DHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 22:07:22 -0500
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, mhocko@suse.com
Subject: [RFC] mm/migrate: Add new migration reason MR_HUGETLB
Date: Tue, 30 Jan 2018 08:37:14 +0530
X-Mailer: git-send-email 2.9.3
X-TM-AS-GCONF: 00
x-cbid: 18013003-0012-0000-0000-000005A932F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013003-0013-0000-0000-00001924CED2
Message-Id: <20180130030714.6790-1-khandual@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300038
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_contig_range() initiates compaction and eventual migration for
the purpose of either CMA or HugeTLB allocation. At present, reason
code remains the same MR_CMA for either of those cases. Lets add a
new reason code which will differentiate the purpose of migration
as HugeTLB allocation instead.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/linux/migrate.h        |  1 +
 include/trace/events/migrate.h |  3 ++-
 mm/page_alloc.c                | 14 ++++++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index a732598fcf83..44381c33a2bd 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -26,6 +26,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CMA,
+	MR_HUGETLB,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index bcf4daccd6be..61474c93f8f3 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CMA,		"cma")
+	EM( MR_CMA,		"cma")				\
+	EMe(MR_HUGETLB,		"hugetlb")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 242565855d05..ce8a2f2d4994 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7588,13 +7588,14 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
 
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					unsigned migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned long nr_reclaimed;
 	unsigned long pfn = start;
 	unsigned int tries = 0;
-	int ret = 0;
+	int ret = 0, migrate_reason = 0;
 
 	migrate_prep();
 
@@ -7621,8 +7622,13 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
+		if (migratetype == MIGRATE_CMA)
+			migrate_reason = MR_CMA;
+		else
+			migrate_reason = MR_HUGETLB;
+
 		ret = migrate_pages(&cc->migratepages, new_page_alloc_contig,
-				    NULL, 0, cc->mode, MR_CMA);
+				    NULL, 0, cc->mode, migrate_reason);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
@@ -7710,7 +7716,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret =0;
-- 
2.11.0
