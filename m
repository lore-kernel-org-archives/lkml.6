Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A3EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133702081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="as5kQsnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133702081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKIWlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:41:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeKIWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:41:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9Cwu80122076;
        Fri, 9 Nov 2018 13:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=JGeudfDQgoHcScKvHR6v0sxtIhwxlNusrsl0oBZQDrg=;
 b=as5kQsnW92nIkbFJxDQUVXzY5WHvo+0HdSI3JbxNjAD0H8TmrXGUlQglYRKdD4auM/Qo
 BymCAYkhbb/muZ3rS5rzZZ3A9qfFMKbtDO35LxIOQg7Am98Y92b38On0pFxS6g6h/aG4
 yZL6gW47VTCkRKfF+e8EXJie8tOF7L3Ab5FGU01IG0Sw+0SiV25wA+dZjoGBEiq/AS/g
 G5eU7aVmXhIGY3mPPRwWHz6a4sbV8P54JOuDYcUty9L5iMKoQYM9f5xI5FUgG9+iU85U
 0MqJkWgTQlkDcBBjE6kc1sPW73fNG0LJZ63yjpB8tk4Bo0mKvr7gJ8E8WG4mMv8rQA40 bA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mq6x4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 13:00:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA9D0CH6006403
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 13:00:13 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA9D0BMl021756;
        Fri, 9 Nov 2018 13:00:11 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 05:00:11 -0800
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] sched/fair: Provide can_migrate_task_llc
Date:   Fri,  9 Nov 2018 04:50:37 -0800
Message-Id: <1541767840-93588-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9071 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=967
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a simpler version of can_migrate_task called can_migrate_task_llc
which does not require a struct lb_env argument, and judges whether a
migration from one CPU to another within the same LLC should be allowed.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 453d280..dc6224d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7199,6 +7199,34 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 }
 
 /*
+ * Return true if task @p can migrate from @rq to @dst_rq in the same LLC.
+ * No need to test for co-locality, and no need to test task_hot(), as sharing
+ * LLC provides cache warmth at that level.
+ */
+static bool
+can_migrate_task_llc(struct task_struct *p, struct rq *rq, struct rq *dst_rq)
+{
+	int dst_cpu = dst_rq->cpu;
+
+	lockdep_assert_held(&rq->lock);
+
+	if (throttled_lb_pair(task_group(p), cpu_of(rq), dst_cpu))
+		return false;
+
+	if (!cpumask_test_cpu(dst_cpu, &p->cpus_allowed)) {
+		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		return false;
+	}
+
+	if (task_running(rq, p)) {
+		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		return false;
+	}
+
+	return true;
+}
+
+/*
  * detach_task() -- detach the task for the migration from @src_rq to @dst_cpu.
  */
 static void detach_task(struct task_struct *p, struct rq *src_rq, int dst_cpu)
-- 
1.8.3.1

