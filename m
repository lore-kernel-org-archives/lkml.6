Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FECC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB220645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeJBQsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:48:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:48:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A5G8a1915379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:05:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A5G0Q1915376;
        Tue, 2 Oct 2018 03:05:16 -0700
Date:   Tue, 2 Oct 2018 03:05:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-7534612123e0f5d020aba1076a6bb505db0e6bfe@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        riel@surriel.com, efault@gmx.de, mingo@kernel.org,
        srikar@linux.vnet.ibm.com, jhladky@redhat.com,
        mgorman@techsingularity.net
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mgorman@techsingularity.net, jhladky@redhat.com,
          srikar@linux.vnet.ibm.com, efault@gmx.de, mingo@kernel.org,
          riel@surriel.com
In-Reply-To: <1537552141-27815-6-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-6-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] mm/migrate: Use spin_trylock() while resetting
 rate limit
Git-Commit-ID: 7534612123e0f5d020aba1076a6bb505db0e6bfe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7534612123e0f5d020aba1076a6bb505db0e6bfe
Gitweb:     https://git.kernel.org/tip/7534612123e0f5d020aba1076a6bb505db0e6bfe
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 21 Sep 2018 23:19:00 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:26 +0200

mm/migrate: Use spin_trylock() while resetting rate limit

Since this spinlock will only serialize the migrate rate limiting,
convert the spin_lock() to a spin_trylock(). If another thread is updating, this
task can move on.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     205332  198512   -3.32145
1     319785  313559   -1.94693

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
8     74912   74761.9  -0.200368
1     206585  214874   4.01239

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     189162  180536   -4.56011
1     213760  210281   -1.62753

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     58736.8  56511.4  -3.78877
1     105419   104899   -0.49327

Avoiding stretching of window intervals may be the reason for the
regression. Also code now uses READ_ONCE/WRITE_ONCE. That may
also be hurting performance to some extent.

Some events stats before and after applying the patch.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        14,285,708      13,818,546
migrations                1,180,621       1,149,960
faults                    339,114         385,583
cache-misses              55,205,631,894  55,259,546,768
sched:sched_move_numa     843             2,257
sched:sched_stick_numa    6               9
sched:sched_swap_numa     219             512
migrate:mm_migrate_pages  365             2,225

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        26907   72692
numa_hint_faults_local  24279   62270
numa_hit                239771  238762
numa_huge_pte_updates   0       48
numa_interleave         68      75
numa_local              239688  238676
numa_other              83      86
numa_pages_migrated     363     2225
numa_pte_updates        27415   98557

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,202,779       3,173,490
migrations                37,186          36,966
faults                    106,076         108,776
cache-misses              12,024,873,744  12,200,075,320
sched:sched_move_numa     931             1,264
sched:sched_stick_numa    0               0
sched:sched_swap_numa     1               0
migrate:mm_migrate_pages  637             899

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        17409   21109
numa_hint_faults_local  14367   17120
numa_hit                73953   72934
numa_huge_pte_updates   20      42
numa_interleave         25      33
numa_local              73892   72866
numa_other              61      68
numa_pages_migrated     668     915
numa_pte_updates        27276   42326

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,474,013    8,312,022
migrations                254,934      231,705
faults                    320,506      310,242
cache-misses              110,580,458  402,324,573
sched:sched_move_numa     725          193
sched:sched_stick_numa    0            0
sched:sched_swap_numa     7            3
migrate:mm_migrate_pages  145          93

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        22797   11838
numa_hint_faults_local  21539   11216
numa_hit                89308   90689
numa_huge_pte_updates   0       0
numa_interleave         865     1579
numa_local              88955   89634
numa_other              353     1055
numa_pages_migrated     149     92
numa_pte_updates        22930   12109

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before     After
cs                        2,195,628  2,170,481
migrations                11,179     10,126
faults                    149,656    160,962
cache-misses              8,117,515  10,834,845
sched:sched_move_numa     49         10
sched:sched_stick_numa    0          0
sched:sched_swap_numa     0          0
migrate:mm_migrate_pages  5          2

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        3577    403
numa_hint_faults_local  3476    358
numa_hit                26142   25898
numa_huge_pte_updates   0       0
numa_interleave         358     207
numa_local              26042   25860
numa_other              100     38
numa_pages_migrated     5       2
numa_pte_updates        3587    400

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        100,602,296      110,339,633
migrations                4,135,630        4,139,812
faults                    789,256          863,622
cache-misses              226,160,621,058  231,838,045,660
sched:sched_move_numa     1,366            2,196
sched:sched_stick_numa    16               33
sched:sched_swap_numa     374              544
migrate:mm_migrate_pages  1,350            2,469

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        47857   85748
numa_hint_faults_local  39768   66831
numa_hit                240165  242213
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              240165  242211
numa_other              0       2
numa_pages_migrated     1224    2376
numa_pte_updates        48354   86233

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        58,515,496      59,331,057
migrations                564,845         552,019
faults                    245,807         266,586
cache-misses              73,603,757,976  73,796,312,990
sched:sched_move_numa     996             981
sched:sched_stick_numa    10              54
sched:sched_swap_numa     193             286
migrate:mm_migrate_pages  646             713

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        13422   14807
numa_hint_faults_local  5619    5738
numa_hit                36118   36230
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              36116   36228
numa_other              2       2
numa_pages_migrated     616     703
numa_pte_updates        13374   14742

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-6-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 mm/migrate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d6a2e89b086a..4f1d894835b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1867,16 +1867,24 @@ static unsigned int ratelimit_pages __read_mostly = 128 << (20 - PAGE_SHIFT);
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
+	if (time_after(jiffies, next_window) &&
+			spin_trylock(&pgdat->numabalancing_migrate_lock)) {
 		pgdat->numabalancing_migrate_nr_pages = 0;
-		pgdat->numabalancing_migrate_next_window = jiffies +
-			msecs_to_jiffies(migrate_interval_millisecs);
+		do {
+			next_window += interval;
+		} while (unlikely(time_after(jiffies, next_window)));
+
+		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, next_window);
 		spin_unlock(&pgdat->numabalancing_migrate_lock);
 	}
 	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
