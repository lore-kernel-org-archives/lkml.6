Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD3DC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4CD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4CD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeFTRDi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:03:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932808AbeFTRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:03:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGx1uG139324
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqrc6qrck-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:03:31 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:03:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:03:25 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH3OSI19792038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:03:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E0A9A4051;
        Wed, 20 Jun 2018 17:54:04 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18FF0A4053;
        Wed, 20 Jun 2018 17:54:03 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:02 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 04/19] sched/numa: Set preferred_node based on best_cpu
Date:   Wed, 20 Jun 2018 22:32:45 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0020-0000-0000-0000029D08B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0021-0000-0000-000020E95CFE
Message-Id: <1529514181-9842-5-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently preferred node is set to dst_nid which is the last node in the
iteration whose group weight or task weight is greater than the current
node. However it doesn't guarantee that dst_nid has the numa capacity
to move. It also doesn't guarantee that dst_nid has the best_cpu which
is the cpu/node ideal for node migration.

Lets consider faults on a 4 node system with group weight numbers
in different nodes being in 0 < 1 < 2 < 3 proportion. Consider the task
is running on 3 and 0 is its preferred node but its capacity is full.
Consider nodes 1, 2 and 3 have capacity. Then the task should be
migrated to node 1. Currently the task gets moved to node 2. env.dst_nid
points to the last node whose faults were greater than current node.

Modify to set the preferred node based of best_cpu. Earlier setting
preferred node was skipped if nr_active_nodes is 1. This could result in
the task being moved out of the preferred node to a random node during
regular load balancing.

Also while modifying task_numa_migrate(), use sched_setnuma to set
preferred node. This ensures out numa accounting is correct.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25122.9     25549.6     1.698
1     73850       73190       -0.89

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
8     105930      113437      7.08676
1     178624      196130      9.80047

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      435.78      653.81      534.58       83.20
numa01.sh       Sys:      121.93      187.18      145.90       23.47
numa01.sh      User:    37082.81    51402.80    43647.60     5409.75
numa02.sh      Real:       60.64       61.63       61.19        0.40
numa02.sh       Sys:       14.72       25.68       19.06        4.03
numa02.sh      User:     5210.95     5266.69     5233.30       20.82
numa03.sh      Real:      746.51      808.24      780.36       23.88
numa03.sh       Sys:       97.26      108.48      105.07        4.28
numa03.sh      User:    58956.30    61397.05    60162.95     1050.82
numa04.sh      Real:      465.97      519.27      484.81       19.62
numa04.sh       Sys:      304.43      359.08      334.68       20.64
numa04.sh      User:    37544.16    41186.15    39262.44     1314.91
numa05.sh      Real:      411.57      457.20      433.29       16.58
numa05.sh       Sys:      230.05      435.48      339.95       67.58
numa05.sh      User:    33325.54    36896.31    35637.84     1222.64

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      506.35      794.46      599.06      104.26 	 -10.76%
numa01.sh       Sys:      150.37      223.56      195.99       24.94 	 -25.55%
numa01.sh      User:    43450.69    61752.04    49281.50     6635.33 	 -11.43%
numa02.sh      Real:       60.33       62.40       61.31        0.90 	 -0.195%
numa02.sh       Sys:       18.12       31.66       24.28        5.89 	 -21.49%
numa02.sh      User:     5203.91     5325.32     5260.29       49.98 	 -0.513%
numa03.sh      Real:      696.47      853.62      745.80       57.28 	 4.6339%
numa03.sh       Sys:       85.68      123.71       97.89       13.48 	 7.3347%
numa03.sh      User:    55978.45    66418.63    59254.94     3737.97 	 1.5323%
numa04.sh      Real:      444.05      514.83      497.06       26.85 	 -2.464%
numa04.sh       Sys:      230.39      375.79      316.23       48.58 	 5.8343%
numa04.sh      User:    35403.12    41004.10    39720.80     2163.08 	 -1.153%
numa05.sh      Real:      423.09      460.41      439.57       13.92 	 -1.428%
numa05.sh       Sys:      287.38      480.15      369.37       68.52 	 -7.964%
numa05.sh      User:    34732.12    38016.80    36255.85     1070.51 	 -1.704%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
Fix setting sched_setnuma under !sd pointed by Peter Zijlstra.
Modify commit message to describe the reason for change.

 kernel/sched/fair.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 285d7ae..2366fda2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1726,7 +1726,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 * elsewhere, so there is no point in (re)trying.
 	 */
 	if (unlikely(!sd)) {
-		p->numa_preferred_nid = task_node(p);
+		sched_setnuma(p, task_node(p));
 		return -EINVAL;
 	}
 
@@ -1785,15 +1785,13 @@ static int task_numa_migrate(struct task_struct *p)
 	 * trying for a better one later. Do not set the preferred node here.
 	 */
 	if (p->numa_group) {
-		struct numa_group *ng = p->numa_group;
-
 		if (env.best_cpu == -1)
 			nid = env.src_nid;
 		else
-			nid = env.dst_nid;
+			nid = cpu_to_node(env.best_cpu);
 
-		if (ng->active_nodes > 1 && numa_is_active_node(env.dst_nid, ng))
-			sched_setnuma(p, env.dst_nid);
+		if (nid != p->numa_preferred_nid)
+			sched_setnuma(p, nid);
 	}
 
 	/* No better CPU than the current one was found. */
-- 
1.8.3.1

