Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16FEC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B392064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aHnMGrpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B392064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeJVX2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeJVX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4H4q153175;
        Mon, 22 Oct 2018 15:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZclRnbT9oJyHlSRieZxLoQBxLPS6kVf/jZA2weIF9MA=;
 b=aHnMGrpUOxh1+QgyPUqXtp4iFUlfJYtIdqsvjmBZmKjHfIssoZ5K/imBXY4xl2iMyJ40
 19noRTg3Tu1MA8T+lGVeXQTpYAn78bmTh4iUYbS1DA/Kwie3qISsp5dtOo1MZjgrK1iK
 MMtOmIpnmAT0S6/GjMF8xu0uLrn3EvRmGxx8tvmNZ7hQUJ+iZ8SnPjpTCQjsu0JWl/jy
 f+dezGLT/VMtghc+B+4uE6Zbfa9L1U6xTRyJ4paA5G6vX/8XXbXjnnu2wpEOvi6SILfg
 cEMnKa+SHEKftevP1Jb5si2C/YsdRxJXWem0U52ITEvmw9X3o8cnXvME299AG7C4wZqP KQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vapq692-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:11 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9ARP005129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:11 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF99D7029272;
        Mon, 22 Oct 2018 15:09:10 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:09 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] sched/fair: Generalize the detach_task interface
Date:   Mon, 22 Oct 2018 07:59:37 -0700
Message-Id: <1540220381-424433-7-git-send-email-steven.sistare@oracle.com>
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

The detach_task function takes a struct lb_env argument, but only needs a
few of its members.  Pass the rq and cpu arguments explicitly so the
function may be called from code that is not based on lb_env.  No
functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f31045..4acdd8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7168,15 +7168,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
@@ -7196,7 +7196,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			continue;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 
 		/*
 		 * Right now, this is only the second place where
@@ -7263,7 +7263,7 @@ static int detach_tasks(struct lb_env *env)
 		if ((load / 2) > env->imbalance)
 			goto next;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
-- 
1.8.3.1

