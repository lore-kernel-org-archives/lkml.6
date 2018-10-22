Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D86AC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255CA2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gi/Ke1rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255CA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJVX2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJVX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF48sN103992;
        Mon, 22 Oct 2018 15:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=da7PUOoMepjpEtnTf06GesnbDow1qEny5EWxxBlZ/sU=;
 b=Gi/Ke1rsbpl0cwxMCCS6qqC1Mb5CIaqwIOBhbJXlgCZ7kkyGQIDtLH9GBn8vshIJtItc
 wy80/BdM64NZmBXcjIZXXmZN6Z6d8xefnetulh44ZjYodw/+6z0st+3aCbUcs/1IVwvn
 MVtBSikvJQ/F4mwp92Vn2vIMAE6JKyB1akgXnNBgYgYIs8vvMevOyThSYe+uS2kmo2b6
 XwafB/xoP5IvhAXBHBjCyjevV9E7vcNwhBoRjq7boQtvJ29lMzTHL/2IZscCawhVRiuv
 1qdgC0xdZfK2LviSEaX2w094xyRLwKj2Yp2RS+05Mc/YbEIJ+tlPMFvIFA6SqABpOhhP WQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qf4t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF99g6009010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:09 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF99Bx020743;
        Mon, 22 Oct 2018 15:09:09 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:08 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] sched/fair: Hoist idle_stamp up from idle_balance
Date:   Mon, 22 Oct 2018 07:59:36 -0700
Message-Id: <1540220381-424433-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
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
 kernel/sched/fair.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c623338..9f31045 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3724,6 +3724,8 @@ static inline bool within_margin(int value, int margin)
 	WRITE_ONCE(p->se.avg.util_est, ue);
 }
 
+#define IF_SMP(statement)	statement
+
 static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
@@ -3769,6 +3771,8 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+#define IF_SMP(statement)	/* empty */
+
 static inline void overload_clear(struct rq *rq) {}
 static inline void overload_set(struct rq *rq) {}
 
@@ -6740,8 +6744,19 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	return p;
 
 idle:
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
+	schedstat_end_time(rq->find_time, time);
+
 	/*
 	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
@@ -9504,12 +9519,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
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
@@ -9600,9 +9609,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
-	if (pulled_task)
-		this_rq->idle_stamp = 0;
-
 	rq_repin_lock(this_rq, rf);
 
 	return pulled_task;
-- 
1.8.3.1

