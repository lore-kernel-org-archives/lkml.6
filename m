Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE121557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCE121557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391211AbeIUXjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:39:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391053AbeIUXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:39:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHnJa9020380
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn4ya0wvs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 18:49:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 18:49:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LHnZfY57212952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 17:49:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C129AAE04D;
        Fri, 21 Sep 2018 20:48:39 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D947AAE053;
        Fri, 21 Sep 2018 20:48:37 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.199.39.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 20:48:37 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jirka Hladky <jhladky@redhat.com>
Subject: [PATCH v2 2/6] sched/numa: Pass destination CPU as a parameter to migrate_task_rq
Date:   Fri, 21 Sep 2018 23:18:57 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537552141-27815-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1537552141-27815-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092117-0020-0000-0000-000002C9E6CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092117-0021-0000-0000-00002117F103
Message-Id: <1537552141-27815-3-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changelog v1->v2:
Rename cpu to CPU
Rename numa to NUMA

 kernel/sched/core.c     | 2 +-
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..ad97f3b 100644
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
index 997ea7b..91e4202 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1607,7 +1607,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
 	return cpu;
 }
 
-static void migrate_task_rq_dl(struct task_struct *p)
+static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b0b75d..bc768156 100644
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
index 0b91612..455fa33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1524,7 +1524,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
-	void (*migrate_task_rq)(struct task_struct *p);
+	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-- 
2.7.4

