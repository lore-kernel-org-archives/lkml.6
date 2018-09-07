Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85F02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FysMSi5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85F02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeIHC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20095 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbeIHC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356650; x=1567892650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ipAECLih7CepDqAomzNw17Micat2prinpA6B6Pe+8po=;
  b=FysMSi5UqVApVp1ue/aUxe5HEY8T6qH4CtAgGA+IplL/jvXVVWMIVh7o
   GDtJ5VRBmW4nX1lOhe30tPLViYtM4MnSWyOb7H0tTLQST5YSFId3SA4gl
   +w/j8g9aeOhpJT1S6B+78+BgZiPQeMVGfBrc9Ft6m9xwu2lMGUhA6aUfE
   g=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696510135"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:09 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgYBX107341
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:37 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgXGt027633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:33 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgWKQ027629;
        Fri, 7 Sep 2018 23:42:32 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 41/60] cosched: Introduce locking for leader activities
Date:   Fri,  7 Sep 2018 23:40:28 +0200
Message-Id: <20180907214047.26914-42-jschoenh@amazon.de>
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

With hierarchical runqueues and locks at each level, it is often
necessary to get multiple locks. Introduce the first of two locking
strategies, which is suitable for typical leader activities.

To avoid deadlocks the general rule is that multiple locks have to be
taken from bottom to top. Leaders make scheduling decisions and the
necessary maintenance for their part of the runqueue hierarchy.  Hence,
they need to gather locks for all runqueues they own to operate freely
on them.

Provide two functions that do that: rq_lock_owned() and
rq_unlock_owned(). Typically, they walk from the already locked per-CPU
runqueue upwards, locking/unlocking runqueues as they go along, stopping
when they would leave their area of responsibility.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   | 11 ++++++
 2 files changed, 105 insertions(+)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index 1b442e20faad..df62ee6d0520 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -514,3 +514,97 @@ void cosched_offline_group(struct task_group *tg)
 	taskgroup_for_each_cfsrq(tg, cfs)
 		list_del_rcu(&cfs->sdrq.tg_siblings);
 }
+
+/*****************************************************************************
+ * Locking related functions
+ *****************************************************************************/
+
+/*
+ * Lock owned part of the runqueue hierarchy from the specified runqueue
+ * upwards.
+ *
+ * You may call rq_lock_owned() again in some nested code path. Currently, this
+ * is needed for put_prev_task(), which is sometimes called from within
+ * pick_next_task_fair(), and for throttle_cfs_rq(), which is sometimes called
+ * during enqueuing and dequeuing.
+ *
+ * When not called nested, returns the uppermost locked runqueue; used by
+ * pick_next_task_fair() to avoid going up the hierarchy again.
+ */
+struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf)
+{
+	int cpu = rq->sdrq_data.leader;
+	struct rq *ret = rq;
+
+	lockdep_assert_held(&rq->lock);
+
+	orf->nested = rq->sdrq_data.parent_locked;
+	if (orf->nested)
+		return NULL;
+
+	orf->cookie = lockdep_cookie();
+
+	WARN_ON_ONCE(!irqs_disabled());
+
+	/* Lowest level is already locked, begin with next level */
+	rq = parent_rq(rq);
+
+	while (rq) {
+		/*
+		 * FIXME: This avoids ascending the hierarchy, if upper
+		 * levels are not in use. Can we do this with leader==-1
+		 * instead?
+		 */
+		if (root_task_group.scheduled < rq->sdrq_data.level)
+			break;
+
+		/*
+		 * Leadership is always taken, never given; if we're not
+		 * already the leader, we won't be after taking the lock.
+		 */
+		if (cpu != READ_ONCE(rq->sdrq_data.leader))
+			break;
+
+		rq_lock(rq, &rq->sdrq_data.rf);
+
+		/* Did we race with a leadership change? */
+		if (cpu != READ_ONCE(rq->sdrq_data.leader)) {
+			rq_unlock(rq, &rq->sdrq_data.rf);
+			break;
+		}
+
+		/* Apply the cookie that's not stored with the data structure */
+		lockdep_repin_lock(&rq->lock, orf->cookie);
+
+		ret->sdrq_data.parent_locked = true;
+		update_rq_clock(rq);
+		ret = rq;
+
+		rq = parent_rq(rq);
+	}
+
+	return ret;
+}
+
+void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf)
+{
+	bool parent_locked = rq->sdrq_data.parent_locked;
+
+	if (orf->nested)
+		return;
+
+	/* Lowest level must stay locked, begin with next level */
+	lockdep_assert_held(&rq->lock);
+	rq->sdrq_data.parent_locked = false;
+
+	while (parent_locked) {
+		rq = parent_rq(rq);
+		lockdep_assert_held(&rq->lock);
+
+		parent_locked = rq->sdrq_data.parent_locked;
+		rq->sdrq_data.parent_locked = false;
+
+		lockdep_unpin_lock(&rq->lock, orf->cookie);
+		rq_unlock(rq, &rq->sdrq_data.rf);
+	}
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0dfefa31704e..7dba8fdc48c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -506,6 +506,13 @@ struct rq_flags {
 #endif
 };
 
+struct rq_owner_flags {
+#ifdef CONFIG_COSCHEDULING
+	bool nested;
+	struct pin_cookie cookie;
+#endif
+};
+
 #ifdef CONFIG_COSCHEDULING
 struct sdrq_data {
 	/*
@@ -1197,6 +1204,8 @@ void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 		       struct cfs_rq *sd_parent, struct cfs_rq *tg_parent);
 void cosched_online_group(struct task_group *tg);
 void cosched_offline_group(struct task_group *tg);
+struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf);
+void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
 static inline void cosched_init_topology(void) { }
@@ -1206,6 +1215,8 @@ static inline void cosched_init_sdrq(struct task_group *tg, struct cfs_rq *cfs,
 				     struct cfs_rq *tg_parent) { }
 static inline void cosched_online_group(struct task_group *tg) { }
 static inline void cosched_offline_group(struct task_group *tg) { }
+static inline struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf) { return rq; }
+static inline void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

