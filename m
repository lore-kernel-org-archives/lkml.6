Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F105C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369520819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1OmtdHtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4369520819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeKFFjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbeKFFjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5KDhlF035789;
        Mon, 5 Nov 2018 20:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=mcasbl+m7bh7mxkGD/4voT06K1QRdM+sEF0KYNW2rQA=;
 b=1OmtdHtVVOAbdkvj4kpi7GofwM5VH6AbQ5+0ssqxomP4wOqfo5wx779bwaqPSkCl5HPE
 MgFbF1AK1pa0BCWDBwUdBGsbCEI8uH7ithCaliKVUGP3+sUrVSoLm+ttvDz+RvH3E8Zq
 xxhxUkbVJ0zT+mhcZIghwpt6pmX5XG4YoPJx7DiLfCeJ64+ix+ZdUZKiJdR35l/psoqz
 mAAzSfoIojFtLW/3Zf5vn9m0P6rjMMRj9kQhyfi0XCGs0etyam/iDvdiyjVAffOY0vwf
 3bL5YRq4OehDjhUKDz5AyG+ptdnz9qLWP1bA7/KYCyangvvd6OfjmMy1pHUhOkEqxq5Z mw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4aqh7e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 20:17:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHFrg015472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 20:17:16 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHFrS032067;
        Mon, 5 Nov 2018 20:17:15 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 12:17:15 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] sched/fair: Hoist idle_stamp up from idle_balance
Date:   Mon,  5 Nov 2018 12:08:04 -0800
Message-Id: <1541448489-19692-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541448489-19692-1-git-send-email-steven.sistare@oracle.com>
References: <1541448489-19692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050180
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
 kernel/sched/fair.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c623338..305edf8 100644
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
 
@@ -6740,8 +6744,17 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
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
 	/*
 	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
@@ -9504,12 +9517,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
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
@@ -9600,9 +9607,6 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
-	if (pulled_task)
-		this_rq->idle_stamp = 0;
-
 	rq_repin_lock(this_rq, rf);
 
 	return pulled_task;
-- 
1.8.3.1

