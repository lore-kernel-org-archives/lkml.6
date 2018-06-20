Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78433C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2609020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2609020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFTRFf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:05:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933023AbeFTRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGwxbL061450
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqsnmbuj1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3nqe32440348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C881DA4055;
        Wed, 20 Jun 2018 17:54:29 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E931A4040;
        Wed, 20 Jun 2018 17:54:28 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:28 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 13/19] mm/migrate: Use xchg instead of spinlock
Date:   Wed, 20 Jun 2018 22:32:54 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0012-0000-0000-000002819988
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0013-0000-0000-000020B2DA62
Message-Id: <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently resetting the migrate rate limit is under a spinlock.
The spinlock will only serialize the migrate rate limiting and something
similar can actually be achieved by a simpler xchg.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25804.1     25355.9     -1.73
1     73413       72812       -0.81

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     101748      110199      8.30
1     170818      176303      3.21

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      435.67      707.28      527.49       97.85
numa01.sh       Sys:       76.41      231.19      162.49       56.13
numa01.sh      User:    38247.36    59033.52    45129.31     7642.69
numa02.sh      Real:       60.35       62.09       61.09        0.69
numa02.sh       Sys:       15.01       30.20       20.64        5.56
numa02.sh      User:     5195.93     5294.82     5240.99       40.55
numa03.sh      Real:      752.04      919.89      836.81       63.29
numa03.sh       Sys:      115.10      133.35      125.46        7.78
numa03.sh      User:    58736.44    70084.26    65103.67     4416.10
numa04.sh      Real:      418.43      709.69      512.53      104.17
numa04.sh       Sys:      242.99      370.47      297.39       42.20
numa04.sh      User:    34916.14    48429.54    38955.65     4928.05
numa05.sh      Real:      379.27      434.05      403.70       17.79
numa05.sh       Sys:      145.94      344.50      268.72       68.53
numa05.sh      User:    32679.32    35449.75    33989.10      913.19

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      490.04      774.86      596.26       96.46 	 -11.5%
numa01.sh       Sys:      151.52      242.88      184.82       31.71 	 -12.0%
numa01.sh      User:    41418.41    60844.59    48776.09     6564.27 	 -7.47%
numa02.sh      Real:       60.14       62.94       60.98        1.00 	 0.180%
numa02.sh       Sys:       16.11       30.77       21.20        5.28 	 -2.64%
numa02.sh      User:     5184.33     5311.09     5228.50       44.24 	 0.238%
numa03.sh      Real:      790.95      856.35      826.41       24.11 	 1.258%
numa03.sh       Sys:      114.93      118.85      117.05        1.63 	 7.184%
numa03.sh      User:    60990.99    64959.28    63470.43     1415.44 	 2.573%
numa04.sh      Real:      434.37      597.92      504.87       59.70 	 1.517%
numa04.sh       Sys:      237.63      397.40      289.74       55.98 	 2.640%
numa04.sh      User:    34854.87    41121.83    38572.52     2615.84 	 0.993%
numa05.sh      Real:      386.77      448.90      417.22       22.79 	 -3.24%
numa05.sh       Sys:      149.23      379.95      303.04       79.55 	 -11.3%
numa05.sh      User:    32951.76    35959.58    34562.18     1034.05 	 -1.65%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
Fix stretch every interval pointed by Peter Zijlstra.

 include/linux/mmzone.h |  3 ---
 mm/migrate.c           | 20 ++++++++++++++------
 mm/page_alloc.c        |  1 -
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b0767703..0dbe1d5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -669,9 +669,6 @@ struct zonelist {
 	struct task_struct *kcompactd;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-	/* Lock serializing the migrate rate limiting window */
-	spinlock_t numabalancing_migrate_lock;
-
 	/* Rate limiting time interval */
 	unsigned long numabalancing_migrate_next_window;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8c0af0f..c774990 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1868,17 +1868,25 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
 					unsigned long nr_pages)
 {
+	unsigned long next_window, interval;
+
+	next_window = READ_ONCE(pgdat->numabalancing_migrate_next_window);
+	interval = msecs_to_jiffies(migrate_interval_millisecs);
+
 	/*
 	 * Rate-limit the amount of data that is being migrated to a node.
 	 * Optimal placement is no good if the memory bus is saturated and
 	 * all the time is being spent migrating!
 	 */
-	if (time_after(jiffies, pgdat->numabalancing_migrate_next_window)) {
-		spin_lock(&pgdat->numabalancing_migrate_lock);
-		pgdat->numabalancing_migrate_nr_pages = 0;
-		pgdat->numabalancing_migrate_next_window = jiffies +
-			msecs_to_jiffies(migrate_interval_millisecs);
-		spin_unlock(&pgdat->numabalancing_migrate_lock);
+	if (time_after(jiffies, next_window)) {
+		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0)) {
+			do {
+				next_window += interval;
+			} while (unlikely(time_after(jiffies, next_window)));
+
+			WRITE_ONCE(pgdat->numabalancing_migrate_next_window,
+							       next_window);
+		}
 	}
 	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
 		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a522d2..ff8e730 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6207,7 +6207,6 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	pgdat_resize_init(pgdat);
 #ifdef CONFIG_NUMA_BALANCING
-	spin_lock_init(&pgdat->numabalancing_migrate_lock);
 	pgdat->numabalancing_migrate_nr_pages = 0;
 	pgdat->active_node_migrate = 0;
 	pgdat->numabalancing_migrate_next_window = jiffies;
-- 
1.8.3.1

