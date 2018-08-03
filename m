Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC0221700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC0221700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeHCIJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbeHCIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EIkn120564
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:15:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmfm3v2bf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:15:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:57 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736Eu3A25362582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7C0AE056;
        Fri,  3 Aug 2018 09:14:55 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D112BAE04D;
        Fri,  3 Aug 2018 09:14:53 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:53 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6/6] sched/numa: Limit the conditions where scan period is reset
Date:   Fri,  3 Aug 2018 11:44:01 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080306-0012-0000-0000-00000293343C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-0013-0000-0000-000020C54476
Message-Id: <1533276841-16341-7-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

migrate_task_rq_fair resets the scan rate for NUMA balancing on every
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

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     208862  209029   0.0799571
1     307007  326585   6.37705


on 2 Socket/4 Node Power8 (PowerNV)
JVMS  Prev     Current  %Change
8     89911.4  89627.8  -0.315422
1     216176   221299   2.36983


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     196078  195444   -0.323341
1     214664  222390   3.59911


on 4 Socket/4 Node Power7
JVMS  Prev     Current  %Change
8     60719.2  60152.4  -0.933477
1     112615   111458   -1.02739


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      12511.7  12559.4  12539.5  15.5883
5      12904.6  12969    12942.6  23.9053   3.21464


on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      4709.28  4979.28  4919.32  105.126
5      4984.25  5025.95  5004.5   14.2253   1.73154


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      9388.38  9406.29  9395.1   5.98959
5      9277.64  9357.22  9322.07  26.3558   -0.77732


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      157.71   184.929  174.754  10.7275
5      160.632  175.558  168.655  5.26823   -3.49005


Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ea0eff..6e251e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6357,6 +6357,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 	p->se.exec_start = 0;
 
 #ifdef CONFIG_NUMA_BALANCING
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
 	if (!p->mm || (p->flags & PF_EXITING))
 		return;
 
@@ -6364,8 +6367,26 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 		int src_nid = cpu_to_node(task_cpu(p));
 		int dst_nid = cpu_to_node(new_cpu);
 
-		if (src_nid != dst_nid)
-			p->numa_scan_period = task_scan_start(p);
+		if (src_nid == dst_nid)
+			return;
+
+		/*
+		 * Allow resets if faults have been trapped before one scan
+		 * has completed. This is most likely due to a new task that
+		 * is pulled cross-node due to wakeups or load balancing.
+		 */
+		if (p->numa_scan_seq) {
+			/*
+			 * Avoid scan adjustments if moving to the preferred
+			 * node or if the task was not previously running on
+			 * the preferred node.
+			 */
+			if (dst_nid == p->numa_preferred_nid ||
+			    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))
+				return;
+		}
+
+		p->numa_scan_period = task_scan_start(p);
 	}
 #endif
 }
-- 
1.8.3.1

