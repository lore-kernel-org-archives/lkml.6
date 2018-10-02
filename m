Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9ADC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED120645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCED120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJBQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:47:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:47:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A4gS11915314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:04:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A4gvb1915311;
        Tue, 2 Oct 2018 03:04:42 -0700
Date:   Tue, 2 Oct 2018 03:04:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-05cbdf4f5c191ff378c47bbf66d7230beb725bdb@git.kernel.org>
Cc:     torvalds@linux-foundation.org, srikar@linux.vnet.ibm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jhladky@redhat.com, mgorman@techsingularity.net, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com, efault@gmx.de,
        hpa@zytor.com
Reply-To: srikar@linux.vnet.ibm.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jhladky@redhat.com, mgorman@techsingularity.net, efault@gmx.de,
          riel@surriel.com, mingo@kernel.org, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <1537552141-27815-5-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-5-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Limit the conditions where scan period
 is reset
Git-Commit-ID: 05cbdf4f5c191ff378c47bbf66d7230beb725bdb
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

Commit-ID:  05cbdf4f5c191ff378c47bbf66d7230beb725bdb
Gitweb:     https://git.kernel.org/tip/05cbdf4f5c191ff378c47bbf66d7230beb725bdb
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Fri, 21 Sep 2018 23:18:59 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:24 +0200

sched/numa: Limit the conditions where scan period is reset

migrate_task_rq_fair() resets the scan rate for NUMA balancing on every
cross-node migration. In the event of excessive load balancing due to
saturation, this may result in the scan rate being pegged at maximum and
further overloading the machine.

This patch only resets the scan if NUMA balancing is active, a preferred
node has been selected and the task is being migrated from the preferred
node as these are the most harmful. For example, a migration to the preferred
node does not justify a faster scan rate. Similarly, a migration between two
nodes that are not preferred is probably bouncing due to over-saturation of
the machine.  In that case, scanning faster and trapping more NUMA faults
will further overload the machine.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     203370  205332   0.964744
1     328431  319785   -2.63252

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
1     206070  206585   0.249915

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     188386  189162   0.41192
1     201566  213760   6.04963

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     59157.4  58736.8  -0.710985
1     105495   105419   -0.0720413

Some events stats before and after applying the patch.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        13,825,492      14,285,708
migrations                1,152,509       1,180,621
faults                    371,948         339,114
cache-misses              55,654,206,041  55,205,631,894
sched:sched_move_numa     1,856           843
sched:sched_stick_numa    4               6
sched:sched_swap_numa     428             219
migrate:mm_migrate_pages  898             365

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        57146   26907
numa_hint_faults_local  51612   24279
numa_hit                238164  239771
numa_huge_pte_updates   16      0
numa_interleave         63      68
numa_local              238085  239688
numa_other              79      83
numa_pages_migrated     883     363
numa_pte_updates        67540   27415

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,288,525       3,202,779
migrations                38,652          37,186
faults                    111,678         106,076
cache-misses              12,111,197,376  12,024,873,744
sched:sched_move_numa     900             931
sched:sched_stick_numa    0               0
sched:sched_swap_numa     5               1
migrate:mm_migrate_pages  714             637

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        18572   17409
numa_hint_faults_local  14850   14367
numa_hit                73197   73953
numa_huge_pte_updates   11      20
numa_interleave         25      25
numa_local              73138   73892
numa_other              59      61
numa_pages_migrated     712     668
numa_pte_updates        24021   27276

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,451,543    8,474,013
migrations                202,804      254,934
faults                    310,024      320,506
cache-misses              253,522,507  110,580,458
sched:sched_move_numa     213          725
sched:sched_stick_numa    0            0
sched:sched_swap_numa     2            7
migrate:mm_migrate_pages  88           145

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        11830   22797
numa_hint_faults_local  11301   21539
numa_hit                90038   89308
numa_huge_pte_updates   0       0
numa_interleave         855     865
numa_local              89796   88955
numa_other              242     353
numa_pages_migrated     88      149
numa_pte_updates        12039   22930

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before     After
cs                        2,049,153  2,195,628
migrations                11,405     11,179
faults                    162,309    149,656
cache-misses              7,203,343  8,117,515
sched:sched_move_numa     22         49
sched:sched_stick_numa    0          0
sched:sched_swap_numa     0          0
migrate:mm_migrate_pages  1          5

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        1693    3577
numa_hint_faults_local  1669    3476
numa_hit                25177   26142
numa_huge_pte_updates   0       0
numa_interleave         194     358
numa_local              24993   26042
numa_other              184     100
numa_pages_migrated     1       5
numa_pte_updates        1577    3587

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        94,515,937       100,602,296
migrations                4,203,554        4,135,630
faults                    832,697          789,256
cache-misses              226,248,698,331  226,160,621,058
sched:sched_move_numa     1,730            1,366
sched:sched_stick_numa    14               16
sched:sched_swap_numa     432              374
migrate:mm_migrate_pages  1,398            1,350

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        80079   47857
numa_hint_faults_local  68620   39768
numa_hit                241187  240165
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              241186  240165
numa_other              1       0
numa_pages_migrated     1347    1224
numa_pte_updates        80729   48354

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        63,704,961      58,515,496
migrations                573,404         564,845
faults                    230,878         245,807
cache-misses              76,568,222,781  73,603,757,976
sched:sched_move_numa     509             996
sched:sched_stick_numa    31              10
sched:sched_swap_numa     182             193
migrate:mm_migrate_pages  541             646

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        8501    13422
numa_hint_faults_local  2960    5619
numa_hit                35526   36118
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              35526   36116
numa_other              0       2
numa_pages_migrated     539     616
numa_pte_updates        8433    13374

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-5-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cbfb3068bc6..3529bf61826b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2617,11 +2617,32 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
 		return;
 
-	if (src_nid != dst_nid)
-		p->numa_scan_period = task_scan_start(p);
+	if (src_nid == dst_nid)
+		return;
+
+	/*
+	 * Allow resets if faults have been trapped before one scan
+	 * has completed. This is most likely due to a new task that
+	 * is pulled cross-node due to wakeups or load balancing.
+	 */
+	if (p->numa_scan_seq) {
+		/*
+		 * Avoid scan adjustments if moving to the preferred
+		 * node or if the task was not previously running on
+		 * the preferred node.
+		 */
+		if (dst_nid == p->numa_preferred_nid ||
+		    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))
+			return;
+	}
+
+	p->numa_scan_period = task_scan_start(p);
 }
 
 #else
