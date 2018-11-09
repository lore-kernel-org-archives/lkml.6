Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A6C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739ED2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZ8iDNcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739ED2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeKIWlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:41:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKIWlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:41:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9CxHqY122524;
        Fri, 9 Nov 2018 13:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=CA1TmsxQ2hdX/50oOB9x8d9jT/BwbJBpcony//77R/Y=;
 b=KZ8iDNcCVqNy4QCTvJJlnAkXgih8Egy1dgQcKWKPsPNErWfsNojVPw2QFUeuqfCrgu7A
 pKXPpz6EGQ5fSgxZZlsaxP54N5NbtDKSYdkLr3B6u2KFpNaTEj82eKkFo/aGWQmmuxCA
 +djE1WOBWugdkPCYGMEHQyDB25SvmNsQVkxRzY3BXt+ncsyUQd6YgXASQBKlCp0uQfCL
 OIIPW+feiqQl5M75Y/LWjSXVeFCieUNHkL5EYZ5pq8QganZjMVJ6aGCCkOaiXCRKEvrJ
 MZEEsDSqp25+pAvTpue80MAnvI2BEVbctZFaSnL+Z7Q9yB09j6LmfTACDVY2gEhSVMVm MA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mq6x3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 13:00:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA9D0AZT004527
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 13:00:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9D0AYZ028153;
        Fri, 9 Nov 2018 13:00:10 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 05:00:09 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] sched/fair: Hoist idle_stamp up from idle_balance
Date:   Fri,  9 Nov 2018 04:50:35 -0800
Message-Id: <1541767840-93588-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the update of idle_stamp from idle_balance to the call site in
pick_next_task_fair, to prepare for a future patch that adds work to
pick_next_task_fair which must be included in the idle_stamp interval.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9031d39..da368ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3725,6 +3725,8 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	rq->misfit_task_load = task_h_load(p);
 }
 
+#define IF_SMP(statement)	statement
+
 static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
@@ -3770,6 +3772,8 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+#define IF_SMP(statement)	/* empty */
+
 static inline void overload_clear(struct rq *rq) {}
 static inline void overload_set(struct rq *rq) {}
 
@@ -6764,8 +6768,18 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 idle:
 	update_misfit_status(NULL, rq);
+
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	IF_SMP(rq->idle_stamp = rq_clock(rq);)
+
 	new_tasks = idle_balance(rq, rf);
 
+	if (new_tasks)
+		IF_SMP(rq->idle_stamp = 0;)
+
 	/*
 	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
@@ -9611,12 +9625,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	u64 curr_cost = 0;
 
 	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
-	 */
-	this_rq->idle_stamp = rq_clock(this_rq);
-
-	/*
 	 * Do not pull tasks towards !active CPUs...
 	 */
 	if (!cpu_active(this_cpu))
@@ -9707,9 +9715,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
-	if (pulled_task)
-		this_rq->idle_stamp = 0;
-
 	rq_repin_lock(this_rq, rf);
 
 	return pulled_task;
-- 
1.8.3.1

