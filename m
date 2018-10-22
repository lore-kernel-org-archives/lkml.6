Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E2C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314B420645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vu2wPnFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314B420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJVX26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:28:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58610 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbeJVX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:28:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MF4AVw151043;
        Mon, 22 Oct 2018 15:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=8aG2CK9mXYWFr3ZwbNx6SB9bSbnR+nXNgTTu4mWj3Us=;
 b=Vu2wPnFCpxwijynfsDqkdYP0HB+Sp2ZlXTtXWmf4o0frbEP9tykdMcYB5ix7c72qislq
 blEOq83Wq/5nZkexsIJXc8WuGq0N3cyvL/SS0Nj1G0nwKDoXgoQ7vwnDoXLgeHNWIiwf
 Z70i3ruYhlZVh+Ljs9wO8WdJzWuTQaQLLBbGTcgGFMOoo0Qtap/XmtHF4Y61wXg3VgXa
 zC6Gma0OqP0Bbjdghsy/zK948/hSBwiCc02wpW/i8vM2tSVO0flK1bMuz4paZSXQawMS
 E/uEFzCyAbj+iKUaWFG4FgGzSoUxzEe39YWWDLBmq1S/n8p632kOsYVkyRz3nltWZxIY 1Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usty8g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MF9AFT005136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 15:09:10 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MF9AG0008366;
        Mon, 22 Oct 2018 15:09:10 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 08:09:10 -0700
From:   Steve Sistare <steven.sistare@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] sched/fair: Provide can_migrate_task_llc
Date:   Mon, 22 Oct 2018 07:59:38 -0700
Message-Id: <1540220381-424433-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=918
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220129
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
index 4acdd8d..6548bed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7168,6 +7168,34 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
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

