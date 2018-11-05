Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0966C5ACCC
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654032081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKI/lf/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654032081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeKFFjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeKFFjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5KDtmB035990;
        Mon, 5 Nov 2018 20:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=co1khOG/XvJ6xjU8IQ5R+RfQWUuw3101E94rB5i4iMw=;
 b=UKI/lf/yAHTSRbmR7Ns0oH7eafO9fIw9E5z3xstQmhcQ/pT9TZ5QvSke11PLZRsO4Ogh
 xKEu8/C25v+qwd/MYPjYHNuMdqKVaxIJeyDL23QY/0FaNDUsKOkLH0KNY7HP/yd+ongv
 MtuKnbZmtXU2dl9uPM5YjGtgqPbzw2L9WHhP4kPgA1Yti/sihtSgEjRXtqIWKUI7O8S7
 VDdDVU35HqogIAZLHcj4+Km80MEXjiZDkmgeEACQvGrBKRjtGAm6+GPazNOmJcTqUlQF
 Kw5vaQOboW0v99MIZBPxnZ4bGtYNzV2Tj09d9Io9Xk0VXw4M/kRRD6p2XNP7CbgtwFb9 uA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4aqh7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 20:17:17 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5KHGxf008474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 20:17:17 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5KHGkB018856;
        Mon, 5 Nov 2018 20:17:16 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 12:17:16 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] sched/fair: Generalize the detach_task interface
Date:   Mon,  5 Nov 2018 12:08:05 -0800
Message-Id: <1541448489-19692-7-git-send-email-steven.sistare@oracle.com>
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

The detach_task function takes a struct lb_env argument, but only needs a
few of its members.  Pass the rq and cpu arguments explicitly so the
function may be called from code that is not based on lb_env.  No
functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 305edf8..eb6e6cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7166,15 +7166,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 }
 
 /*
- * detach_task() -- detach the task for the migration specified in env
+ * detach_task() -- detach the task for the migration from @src_rq to @dst_cpu.
  */
-static void detach_task(struct task_struct *p, struct lb_env *env)
+static void detach_task(struct task_struct *p, struct rq *src_rq, int dst_cpu)
 {
-	lockdep_assert_held(&env->src_rq->lock);
+	lockdep_assert_held(&src_rq->lock);
 
 	p->on_rq = TASK_ON_RQ_MIGRATING;
-	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
-	set_task_cpu(p, env->dst_cpu);
+	deactivate_task(src_rq, p, DEQUEUE_NOCLOCK);
+	set_task_cpu(p, dst_cpu);
 }
 
 /*
@@ -7194,7 +7194,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			continue;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 
 		/*
 		 * Right now, this is only the second place where
@@ -7261,7 +7261,7 @@ static int detach_tasks(struct lb_env *env)
 		if ((load / 2) > env->imbalance)
 			goto next;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
-- 
1.8.3.1

