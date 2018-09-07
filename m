Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81706C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3762083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="YbA+NU26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3762083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbeIHCZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:09 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:51306 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbeIHCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356533; x=1567892533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TB86VpgsBjZ3HkPwxpr5+xpe0Juh80Nv2umXTDFAz2k=;
  b=YbA+NU26PDZ5BH9Ff5nKuV0LPh5ZiadU8N7uVOVUY8xEsIGzFhcaThQ+
   lf29kjCDr7kZ7z0YjCeCg5SRPU1/uwRrnYgNS7yDQETTT5GOcZ6dkVP0B
   OgRrgfL2d6feDvjzMsAwdU9VBUro1Zy/AIFm0yD8DuoxI//j9BXkvizMl
   s=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243184"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:13 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg89C031756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:10 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lg6g4027436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:06 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg5mN027435;
        Fri, 7 Sep 2018 23:42:05 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 26/60] cosched: Construct runqueue hierarchy
Date:   Fri,  7 Sep 2018 23:40:13 +0200
Message-Id: <20180907214047.26914-27-jschoenh@amazon.de>
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

With scheduling domains sufficiently prepared, we can now initialize
the full hierarchy of runqueues and link it with the already existing
bottom level, which we set up earlier.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c    |  1 +
 kernel/sched/cosched.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cc801f84bf97..5350cab7ac4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5876,6 +5876,7 @@ void __init sched_init_smp(void)
 	 */
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
+	cosched_init_hierarchy();
 	mutex_unlock(&sched_domains_mutex);
 
 	/* Move init over to a non-isolated CPU */
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 7a793aa93114..48394050ec34 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -351,3 +351,79 @@ void cosched_init_topology(void)
 	/* Make permanent */
 	set_sched_topology(tl);
 }
+
+/*
+ * Build the SD-RQ hierarchy according to the scheduling domains.
+ *
+ * Note, that the scheduler is already live at this point, but the scheduling
+ * domains only just have become available. That means, we only setup everything
+ * above the bottom level of the SD-RQ hierarchy and link it with the already
+ * active bottom level.
+ *
+ * We can do this without any locks, as nothing will automatically traverse into
+ * these data structures. This requires an update of the sdrq.is_root property,
+ * which will happen only later.
+ */
+void cosched_init_hierarchy(void)
+{
+	struct sched_domain *sd;
+	struct sdrq *sdrq;
+	int cpu, level = 1;
+
+	/* Only one CPU in the system, we are finished here */
+	if (cpumask_weight(cpu_possible_mask) == 1)
+		return;
+
+	/* Determine and initialize top */
+	for_each_domain(0, sd) {
+		if (!sd->parent)
+			break;
+		level++;
+	}
+
+	init_sdrq_data(&sd->shared->rq.sdrq_data, NULL, sched_domain_span(sd),
+		       level);
+	init_cfs_rq(&sd->shared->rq.cfs);
+	init_tg_cfs_entry(&root_task_group, &sd->shared->rq.cfs, NULL,
+			  &sd->shared->rq, NULL);
+	init_sdrq(&root_task_group, &sd->shared->rq.cfs.sdrq, NULL, NULL,
+		  &sd->shared->rq.sdrq_data);
+
+	root_task_group.top_cfsrq = &sd->shared->rq.cfs;
+
+	/* Initialize others top-down, per CPU */
+	for_each_possible_cpu(cpu) {
+		/* Find highest not-yet initialized position for this CPU */
+		for_each_domain(cpu, sd) {
+			if (sd->shared->rq.sdrq_data.span_weight)
+				break;
+		}
+		if (WARN(!sd, "SD hierarchy seems to have multiple roots"))
+			continue;
+		sd = sd->child;
+
+		/* Initialize from there downwards */
+		for_each_lower_domain(sd) {
+			init_sdrq_data(&sd->shared->rq.sdrq_data,
+				       &sd->parent->shared->rq.sdrq_data,
+				       sched_domain_span(sd), -1);
+			init_cfs_rq(&sd->shared->rq.cfs);
+			init_tg_cfs_entry(&root_task_group, &sd->shared->rq.cfs,
+					  NULL, &sd->shared->rq, NULL);
+			init_sdrq(&root_task_group, &sd->shared->rq.cfs.sdrq,
+				  &sd->parent->shared->rq.cfs.sdrq, NULL,
+				  &sd->shared->rq.sdrq_data);
+		}
+
+		/* Link up with local data structures */
+		sdrq = &cpu_rq(cpu)->cfs.sdrq;
+		sd = cpu_rq(cpu)->sd;
+
+		/* sdrq_data */
+		sdrq->data->parent = &sd->shared->rq.sdrq_data;
+
+		/* sdrq */
+		sdrq->sd_parent = &sd->shared->rq.cfs.sdrq;
+		list_add_tail(&sdrq->siblings, &sdrq->sd_parent->children);
+	}
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ed9c526b74ee..d65c98c34c13 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1132,9 +1132,11 @@ static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
 #ifdef CONFIG_COSCHEDULING
 void cosched_init_bottom(void);
 void cosched_init_topology(void);
+void cosched_init_hierarchy(void);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
 static inline void cosched_init_topology(void) { }
+static inline void cosched_init_hierarchy(void) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

