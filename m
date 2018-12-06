Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24330C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8495208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0dF37mAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8495208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLFVio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:38:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35848 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:38:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6LYKm7154595;
        Thu, 6 Dec 2018 21:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1H0cnsYb2pjvphtDltxS9gQX0MswaFUiXZebE1P4KR4=;
 b=0dF37mAay/rc0PDEvMrd1SdgDHjo1ngzAekrs4L+mTKv4Mxoxi76sacOuHnLCevFGPFB
 yy5zQxs1VA7k9RERRiOTUwuUyOUX7SjE8E+Hl0nzsXgR8qeVz5FcNigkfJcpHyHzt67D
 BaNtJuThIU/gyCVt4SuBMeBCphFgKdIWQII9JKJ/PoJQaAVkvxphqbZ83RQuf5tJYWbs
 anRPmneNp9w6JzxA/Gji4ONz3sMNpfKlayJm/BqS4uuUYle8xLO95n7R7AW7FrXNB8nM
 YvIKL0w2CnIzgWzCj/JGO/u9b58hueqb/GjUoC60gM8Xfs7kRaOcoH3qWCpumxmwFOZq NQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrtmdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 21:38:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcJC7007299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 21:38:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB6LcIie001102;
        Thu, 6 Dec 2018 21:38:19 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:38:18 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/10] sched/fair: Hoist idle_stamp up from idle_balance
Date:   Thu,  6 Dec 2018 13:28:11 -0800
Message-Id: <1544131696-2888-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060181
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
 kernel/sched/fair.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e105db..8a33ad9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3725,6 +3725,16 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	rq->misfit_task_load = task_h_load(p);
 }
 
+static inline void rq_idle_stamp_update(struct rq *rq)
+{
+	rq->idle_stamp = rq_clock(rq);
+}
+
+static inline void rq_idle_stamp_clear(struct rq *rq)
+{
+	rq->idle_stamp = 0;
+}
+
 static void overload_clear(struct rq *rq)
 {
 	struct sparsemask *overload_cpus;
@@ -3770,6 +3780,8 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+static inline void rq_idle_stamp_update(struct rq *rq) {}
+static inline void rq_idle_stamp_clear(struct rq *rq) {}
 static inline void overload_clear(struct rq *rq) {}
 static inline void overload_set(struct rq *rq) {}
 
@@ -6764,8 +6776,18 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 idle:
 	update_misfit_status(NULL, rq);
+
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	rq_idle_stamp_update(rq);
+
 	new_tasks = idle_balance(rq, rf);
 
+	if (new_tasks)
+		rq_idle_stamp_clear(rq);
+
 	/*
 	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
@@ -9611,12 +9633,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
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
@@ -9707,9 +9723,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
-	if (pulled_task)
-		this_rq->idle_stamp = 0;
-
 	rq_repin_lock(this_rq, rf);
 
 	return pulled_task;
-- 
1.8.3.1

