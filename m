Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DEC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850B20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D850B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJBQrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:47:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJBQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:47:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A3ZDZ1913586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:03:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A3ZHF1913583;
        Tue, 2 Oct 2018 03:03:35 -0700
Date:   Tue, 2 Oct 2018 03:03:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-1327237a5978b00bcc665c33046c9bae75da1154@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org, efault@gmx.de,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        riel@surriel.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        mingo@kernel.org, tglx@linutronix.de, jhladky@redhat.com
Reply-To: srikar@linux.vnet.ibm.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, jhladky@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, riel@surriel.com,
          mgorman@techsingularity.net, efault@gmx.de
In-Reply-To: <1537552141-27815-3-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-3-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Pass destination CPU as a parameter to
 migrate_task_rq
Git-Commit-ID: 1327237a5978b00bcc665c33046c9bae75da1154
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

Commit-ID:  1327237a5978b00bcc665c33046c9bae75da1154
Gitweb:     https://git.kernel.org/tip/1327237a5978b00bcc665c33046c9bae75da1154
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 21 Sep 2018 23:18:57 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:42:21 +0200

sched/numa: Pass destination CPU as a parameter to migrate_task_rq

This additional parameter (new_cpu) is used later for identifying if
task migration is across nodes.

No functional change.

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     203353  200668   -1.32036
1     328205  321791   -1.95427

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
1     214384  204848   -4.44809

2 Socket - 2  Node Power9 - PowerNV
JVMS  Prev    Current  %Change
4     188553  188098   -0.241311
1     196273  200351   2.07772

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     57581.2  58145.9  0.980702
1     103468   103798   0.318939

Brings out the variance between different specjbb2005 runs.

Some events stats before and after applying the patch.

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        13,941,377      13,912,183
migrations                1,157,323       1,155,931
faults                    382,175         367,139
cache-misses              54,993,823,500  54,240,196,814
sched:sched_move_numa     2,005           1,571
sched:sched_stick_numa    14              9
sched:sched_swap_numa     529             463
migrate:mm_migrate_pages  1,573           703

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        67099   50155
numa_hint_faults_local  58456   45264
numa_hit                240416  239652
numa_huge_pte_updates   18      36
numa_interleave         65      68
numa_local              240339  239576
numa_other              77      76
numa_pages_migrated     1574    680
numa_pte_updates        77182   71146

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                     Before          After
cs                        3,176,453       3,156,720
migrations                30,238          30,354
faults                    87,869          97,261
cache-misses              12,544,479,391  12,400,026,826
sched:sched_move_numa     23              4
sched:sched_stick_numa    0               0
sched:sched_swap_numa     6               1
migrate:mm_migrate_pages  10              20

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Haswell - X86
Event                   Before  After
numa_hint_faults        236     272
numa_hint_faults_local  201     186
numa_hit                72293   71362
numa_huge_pte_updates   0       0
numa_interleave         26      23
numa_local              72233   71299
numa_other              60      63
numa_pages_migrated     8       2
numa_pte_updates        0       0

perf stats 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before       After
cs                        8,478,820    8,606,824
migrations                171,323      155,352
faults                    307,499      301,409
cache-misses              240,353,599  157,759,224
sched:sched_move_numa     214          168
sched:sched_stick_numa    0            0
sched:sched_swap_numa     4            3
migrate:mm_migrate_pages  89           125

vmstat 8th warehouse Multi JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        5301    4650
numa_hint_faults_local  4745    3946
numa_hit                92943   90489
numa_huge_pte_updates   0       0
numa_interleave         899     892
numa_local              92345   90034
numa_other              598     455
numa_pages_migrated     88      124
numa_pte_updates        5505    4818

perf stats 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                     Before      After
cs                        2,066,172   2,113,167
migrations                11,076      10,533
faults                    149,544     142,727
cache-misses              10,398,067  5,594,192
sched:sched_move_numa     43          10
sched:sched_stick_numa    0           0
sched:sched_swap_numa     0           0
migrate:mm_migrate_pages  6           6

vmstat 8th warehouse Single JVM 2 Socket - 2  Node Power9 - PowerNV
Event                   Before  After
numa_hint_faults        3552    744
numa_hint_faults_local  3347    584
numa_hit                25611   25551
numa_huge_pte_updates   0       0
numa_interleave         213     263
numa_local              25583   25302
numa_other              28      249
numa_pages_migrated     6       6
numa_pte_updates        3535    744

perf stats 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before           After
cs                        99,358,136       101,227,352
migrations                4,041,607        4,151,829
faults                    749,653          745,233
cache-misses              225,562,543,251  224,669,561,766
sched:sched_move_numa     771              617
sched:sched_stick_numa    14               2
sched:sched_swap_numa     204              187
migrate:mm_migrate_pages  1,180            316

vmstat 8th warehouse Multi JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        27409   24195
numa_hint_faults_local  20677   21639
numa_hit                239988  238331
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              239983  238331
numa_other              5       0
numa_pages_migrated     1016    204
numa_pte_updates        27916   24561

perf stats 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                     Before          After
cs                        60,899,307      62,738,978
migrations                544,668         562,702
faults                    270,834         228,465
cache-misses              74,543,455,635  75,778,067,952
sched:sched_move_numa     735             648
sched:sched_stick_numa    25              13
sched:sched_swap_numa     174             137
migrate:mm_migrate_pages  816             733

vmstat 8th warehouse Single JVM 4 Socket - 4  Node Power7 - PowerVM
Event                   Before  After
numa_hint_faults        11059   10281
numa_hint_faults_local  4733    3242
numa_hit                41384   36338
numa_huge_pte_updates   0       0
numa_interleave         0       0
numa_local              41383   36338
numa_other              1       0
numa_pages_migrated     815     706
numa_pte_updates        11323   10176

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jirka Hladky <jhladky@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537552141-27815-3-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..ad97f3ba5ec5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1167,7 +1167,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 
 	if (task_cpu(p) != new_cpu) {
 		if (p->sched_class->migrate_task_rq)
-			p->sched_class->migrate_task_rq(p);
+			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		rseq_migrate(p);
 		perf_event_task_migrate(p);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 997ea7b839fa..91e4202b0634 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1607,7 +1607,7 @@ out:
 	return cpu;
 }
 
-static void migrate_task_rq_dl(struct task_struct *p)
+static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b0b75de1141..bc768156239f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6297,7 +6297,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  * cfs_rq_of(p) references at time of call are still valid and identify the
  * previous CPU. The caller guarantees p->pi_lock or task_rq(p)->lock is held.
  */
-static void migrate_task_rq_fair(struct task_struct *p)
+static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0b9161241bda..455fa330de04 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1524,7 +1524,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
-	void (*migrate_task_rq)(struct task_struct *p);
+	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
