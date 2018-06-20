Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A66C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9B2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F9B2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFTRE6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:04:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42791 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933015AbeFTREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:04:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGwwh4045377
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsvfk4et-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:05 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:04:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:04:01 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH40l321364768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:04:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF23FA404D;
        Wed, 20 Jun 2018 17:54:40 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 631B4A405B;
        Wed, 20 Jun 2018 17:54:39 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:39 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 17/19] sched/numa: Pass destination cpu as a parameter to migrate_task_rq
Date:   Wed, 20 Jun 2018 22:32:58 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-0012-0000-0000-000002819989
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0013-0000-0000-000020B2DA65
Message-Id: <1529514181-9842-18-git-send-email-srikar@linux.vnet.ibm.com>
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

This additional parameter (new_cpu) is used later for identifying if
task migration is across nodes.

No functional change.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    26015.6     26251.7     0.90
1     73484       74108       0.84

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 36f1c7c..d6b5a64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1189,7 +1189,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 
 	if (task_cpu(p) != new_cpu) {
 		if (p->sched_class->migrate_task_rq)
-			p->sched_class->migrate_task_rq(p);
+			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		perf_event_task_migrate(p);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1..1c1fbaa 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1608,7 +1608,7 @@ static void yield_task_dl(struct rq *rq)
 	return cpu;
 }
 
-static void migrate_task_rq_dl(struct task_struct *p)
+static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c07ac30..7350f09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6615,7 +6615,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
  * cfs_rq_of(p) references at time of call are still valid and identify the
  * previous CPU. The caller guarantees p->pi_lock or task_rq(p)->lock is held.
  */
-static void migrate_task_rq_fair(struct task_struct *p)
+static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	/*
 	 * As blocked tasks retain absolute vruntime the migration needs to
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b15c52..5b10d24 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1487,7 +1487,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
-	void (*migrate_task_rq)(struct task_struct *p);
+	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
-- 
1.8.3.1

