Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9NbN1Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A9D20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLFVip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:38:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeLFVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:38:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6LYKm6154595;
        Thu, 6 Dec 2018 21:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XGUsui2HUxGP5oXFniVNhiaofCv5bz7yaBSmgECxx7o=;
 b=d9NbN1BlFoSeljJs4XsEkY8bZ4MiFk2Veb2zlmkcLVycLA3WFdGExAhaexTPcbttv9XO
 rrZdNdhDIcLRgcwH84GCv4vDugWmf9bFJ/8m0UpAKloJs7t1h79jI0Q0/5naGFkFxgsJ
 YTUQGnT1r/6QNLi4PqDAnXMn9VMMq79vFWTd2gnGJaZBz4k2ZSb7OQKDWrvJbnT8+tZC
 zIPDg6z68Fz3aL7yAUP68oakavR6aOtSx19abo3uy/1K6AMQTY4O3HM67Wu80qaiJ1S5
 yZ3HnVroK0V8IcE0/2eHjIjilvFRGpslkdzmSbHBC54vUr+l7dwNoDzalOqr0rQYSrh2 UA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxrtmdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 21:38:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcKjZ004629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 21:38:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcJQU023563;
        Thu, 6 Dec 2018 21:38:19 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:38:19 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] sched/fair: Generalize the detach_task interface
Date:   Thu,  6 Dec 2018 13:28:12 -0800
Message-Id: <1544131696-2888-7-git-send-email-steven.sistare@oracle.com>
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

The detach_task function takes a struct lb_env argument, but only needs a
few of its members.  Pass the rq and cpu arguments explicitly so the
function may be called from code that is not based on lb_env.  No
functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a33ad9..9b7c85b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7207,15 +7207,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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
@@ -7235,7 +7235,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		if (!can_migrate_task(p, env))
 			continue;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 
 		/*
 		 * Right now, this is only the second place where
@@ -7302,7 +7302,7 @@ static int detach_tasks(struct lb_env *env)
 		if ((load / 2) > env->imbalance)
 			goto next;
 
-		detach_task(p, env);
+		detach_task(p, env->src_rq, env->dst_cpu);
 		list_add(&p->se.group_node, &env->tasks);
 
 		detached++;
-- 
1.8.3.1

