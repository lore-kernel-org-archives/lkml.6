Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33221C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60DA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="b16If6Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60DA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbeIHC2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:05 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29622 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbeIHC2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356708; x=1567892708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4VlKEIzQ9ghjlQStoWzZ/biYxOTK2TcK4e+GD5ynd0=;
  b=b16If6KtKQNzb7hZ84s15j9yitGkDBCqz/C4zGbCOpnVzTN3K1OBM30o
   VWnCbefq40rQP4m7oT0Sr+rDWhxOIbwpVXLyE6a1MlkjC0F4RupxkZjQ2
   TTovJGAkcBdbacwaHeTDGkLjKWCaSacovHIiCI31/XqVoVZ3GZphjwf3/
   U=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286674"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:34 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfNmS019688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:25 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfLKK027160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:21 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfKwv027159;
        Fri, 7 Sep 2018 23:41:20 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 07/60] sched: Reduce dependencies of init_tg_cfs_entry()
Date:   Fri,  7 Sep 2018 23:39:54 +0200
Message-Id: <20180907214047.26914-8-jschoenh@amazon.de>
X-Mailer: git-send-email 2.9.3.1.gcba166c.dirty
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple init_tg_cfs_entry() from other structures' implementation
details, so that it only updates/accesses task group related fields
of the CFS runqueue and its SE.

This prepares calling this function in slightly different contexts.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c  |  3 ++-
 kernel/sched/fair.c  | 13 +++++--------
 kernel/sched/sched.h |  4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c38a54f57e90..48e37c3baed1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6019,7 +6019,8 @@ void __init sched_init(void)
 		 * directly in rq->cfs (i.e root_task_group->se[] = NULL).
 		 */
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
-		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
+		root_task_group.cfs_rq[i] = &rq->cfs;
+		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, rq, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 		rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3de0158729a6..c0dd5825556c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9843,8 +9843,9 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		if (!se)
 			goto err_free_rq;
 
+		tg->cfs_rq[i] = cfs_rq;
 		init_cfs_rq(cfs_rq);
-		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->cfs_rq[i]);
+		init_tg_cfs_entry(tg, cfs_rq, se, cpu_rq(i), parent->cfs_rq[i]);
 		init_entity_runnable_average(se);
 	}
 
@@ -9900,17 +9901,13 @@ void unregister_fair_sched_group(struct task_group *tg)
 }
 
 void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
-			struct sched_entity *se, int cpu,
-			struct cfs_rq *parent)
+		       struct sched_entity *se, struct rq *rq,
+		       struct cfs_rq *parent)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	cfs_rq->tg = tg;
 	cfs_rq->rq = rq;
-	init_cfs_rq_runtime(cfs_rq);
-
-	tg->cfs_rq[cpu] = cfs_rq;
 	cfs_rq->my_se = se;
+	init_cfs_rq_runtime(cfs_rq);
 
 	/* se could be NULL for root_task_group */
 	if (!se)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 926a26d816a2..b8c8dfd0e88d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -427,8 +427,8 @@ extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *pare
 extern void online_fair_sched_group(struct task_group *tg);
 extern void unregister_fair_sched_group(struct task_group *tg);
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
-			struct sched_entity *se, int cpu,
-			struct cfs_rq *parent);
+			      struct sched_entity *se, struct rq *rq,
+			      struct cfs_rq *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
-- 
2.9.3.1.gcba166c.dirty

