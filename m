Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94FC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE51120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0UunkNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE51120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLFVi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:38:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLFViy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:38:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6LYMuY154629;
        Thu, 6 Dec 2018 21:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=yqZBtTRoXwILOEt1ZFfSigJQGM5yxS0rVjeLXGYyMkw=;
 b=c0UunkNybG6brUD5gYI9qdVs+bdUGns4vbTzMiMFN3Axr68+AByP6lc6MpSHZISXuKLr
 2KqAsww6pJFFQlj2L8OD0hUVbbPdiH3JPqgmWxZ9/cCiF+p+SjPyskTmp9ycnq+Kq77F
 2Dtk92xEYvoOYi5Six7CQS47eMQVgkcehiXaQWKdWg6jnbKIrLVKZ8TIBa2Q1TpApTe4
 /gpxUHX0iWFAT44k9mPuLaW0CkA5pRUgoNtmb4ewulSWsOawrRkPppms87ZJV4vjyc2P
 OAl30TAsf4IVLY/lxGLxVjnhEelEyO3OJNKlxaOyYMURjKq/8JfuwaiV4oju+tK5EijV 3A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxrtme6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 21:38:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcKPd015491
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 21:38:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB6LcKwq021709;
        Thu, 6 Dec 2018 21:38:20 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:38:20 +0000
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/10] sched/fair: Provide can_migrate_task_llc
Date:   Thu,  6 Dec 2018 13:28:13 -0800
Message-Id: <1544131696-2888-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=996
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060181
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
index 9b7c85b..3804156 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7207,6 +7207,34 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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

