Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DBFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9020876
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="oL908vV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD9020876
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeIHCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:34 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:24772 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbeIHCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356559; x=1567892559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLPQgWmLEetVNZVw0m+D3i8Qs5FNZwAHEH5gjzUAwDI=;
  b=oL908vV3Nonpe5VNPIswtidyZmeHVcZnrw1I4EUGjMDo51nMRcmIbeqK
   rpq50qFK/jiAOUMkSmarzU0bBf3iVBCTJRJF5r0DQDHD0iz2s1R49/xV+
   +I9XtrDqqkWNsCNqrc7qwJt5hgpv0tLV6Em/S8otKyi8ZkHaECHwFJYjp
   s=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980887"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:38 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgXX2048348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:35 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgVA6027622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:31 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgUiR027618;
        Fri, 7 Sep 2018 23:42:30 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 40/60] cosched: Keep track of task group hierarchy within each SD-RQ
Date:   Fri,  7 Sep 2018 23:40:27 +0200
Message-Id: <20180907214047.26914-41-jschoenh@amazon.de>
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

At a later point (load balancing and throttling at non-CPU levels), we
will have to iterate through parts of the task group hierarchy, visiting
all SD-RQs at the same position within the SD-hierarchy.

Keep track of the task group hierarchy within each SD-RQ to make that
use case efficient.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/core.c    |  2 ++
 kernel/sched/cosched.c | 19 +++++++++++++++++++
 kernel/sched/sched.h   |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f5339d58cb..b3ff885a88d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6310,6 +6310,7 @@ void sched_online_group(struct task_group *tg, struct task_group *parent)
 	tg->parent = parent;
 	INIT_LIST_HEAD(&tg->children);
 	list_add_rcu(&tg->siblings, &parent->children);
+	cosched_online_group(tg);
 	spin_unlock_irqrestore(&task_group_lock, flags);
 
 	online_fair_sched_group(tg);
@@ -6338,6 +6339,7 @@ void sched_offline_group(struct task_group *tg)
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
+	cosched_offline_group(tg);
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index b897319d046c..1b442e20faad 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -495,3 +495,22 @@ void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs_rq,
 	init_sdrq(tg, &cfs_rq->sdrq, sd_parent ? &sd_parent->sdrq : NULL,
 		  &tg_parent->sdrq, tg_parent->sdrq.data);
 }
+
+void cosched_online_group(struct task_group *tg)
+{
+	struct cfs_rq *cfs;
+
+	/* Track each SD-RQ within the same SD-RQ in the TG parent */
+	taskgroup_for_each_cfsrq(tg, cfs)
+		list_add_tail_rcu(&cfs->sdrq.tg_siblings,
+				  &cfs->sdrq.tg_parent->tg_children);
+}
+
+void cosched_offline_group(struct task_group *tg)
+{
+	struct cfs_rq *cfs;
+
+	/* Remove each SD-RQ from the children list in its TG parent */
+	taskgroup_for_each_cfsrq(tg, cfs)
+		list_del_rcu(&cfs->sdrq.tg_siblings);
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38b4500095ca..0dfefa31704e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1195,6 +1195,8 @@ void cosched_init_topology(void);
 void cosched_init_hierarchy(void);
 void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 		       struct cfs_rq *sd_parent, struct cfs_rq *tg_parent);
+void cosched_online_group(struct task_group *tg);
+void cosched_offline_group(struct task_group *tg);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
 static inline void cosched_init_topology(void) { }
@@ -1202,6 +1204,8 @@ static inline void cosched_init_hierarchy(void) { }
 static inline void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 				     struct cfs_rq *sd_parent,
 				     struct cfs_rq *tg_parent) { }
+static inline void cosched_online_group(struct task_group *tg) { }
+static inline void cosched_offline_group(struct task_group *tg) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

