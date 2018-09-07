Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E3206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XRmR5Z1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37E3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeIHC3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:32267 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeIHC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356799; x=1567892799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMB4V5wK/BxzmjXx2WZsy0dy3j5BDmMkOAQFP/S9lho=;
  b=XRmR5Z1N9Uz3OVQwmlIpfgkKN2JfEy2lFChMdSzvl/VVXM7ZxWO7O+ja
   OiOmj3iA8juA54XNPVnotPhR9XyGvN2r+eb+l0mr0Shi9EoDeswLuoUQG
   nAvfixGXYit4s5EXXu8ujEORNfQXoY0e0GkNNwpYuvpcIRTsFvvje3XRm
   I=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370735"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:03 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgbcf052690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:39 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgZKt027645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:35 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgYNd027640;
        Fri, 7 Sep 2018 23:42:34 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 42/60] cosched: Introduce locking for (mostly) enqueuing and dequeuing
Date:   Fri,  7 Sep 2018 23:40:29 +0200
Message-Id: <20180907214047.26914-43-jschoenh@amazon.de>
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
necessary to get locks at different level. Introduce the second of two
locking strategies, which is suitable for progressing upwards through
the hierarchy with minimal impact on lock contention.

During enqueuing and dequeuing, a scheduling entity is recursively
added or removed from the runqueue hierarchy. This is an upwards only
progression through the hierarchy, which does not care about which CPU
is responsible for a certain part of the hierarchy. Hence, it is not
necessary to hold on to a lock of a lower hierarchy level once we moved
on to a higher one.

Introduce rq_chain_init(), rq_chain_lock(), and rq_chain_unlock(), which
implement lock chaining, where the previous lock is only released after
we acquired the next one, so that concurrent operations cannot overtake
each other. The functions can be used even when parts have already been
locked via rq_lock_owned(), as for example dequeueing might happen
during task selection if a runqueue is throttled.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h   | 14 +++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index df62ee6d0520..f2d51079b3db 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -608,3 +608,56 @@ void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf)
 		rq_unlock(rq, &rq->sdrq_data.rf);
 	}
 }
+
+void rq_chain_init(struct rq_chain *rc, struct rq *rq)
+{
+	bool parent_locked = rq->sdrq_data.parent_locked;
+
+	WARN_ON_ONCE(!irqs_disabled());
+	lockdep_assert_held(&rq->lock);
+
+	rq = parent_rq(rq);
+	while (parent_locked) {
+		lockdep_assert_held(&rq->lock);
+		parent_locked = rq->sdrq_data.parent_locked;
+		rq = parent_rq(rq);
+	}
+
+	rc->next = rq;
+	rc->curr = NULL;
+}
+
+void rq_chain_unlock(struct rq_chain *rc)
+{
+	if (rc->curr)
+		rq_unlock(rc->curr, &rc->rf);
+}
+
+void rq_chain_lock(struct rq_chain *rc, struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = se->cfs_rq;
+	struct rq *rq = cfs_rq->rq;
+
+	if (!is_sd_se(se) || rc->curr == rq) {
+		lockdep_assert_held(&rq->lock);
+		return;
+	}
+
+	if (rq == rc->next) {
+		struct rq_flags rf = rc->rf;
+
+		/* Get the new lock (and release previous lock afterwards) */
+		rq_lock(rq, &rc->rf);
+
+		if (rc->curr) {
+			lockdep_assert_held(&rc->curr->lock);
+			rq_unlock(rc->curr, &rf);
+		}
+
+		rc->curr = rq;
+		rc->next = parent_rq(rq);
+
+		/* FIXME: Only update clock, when necessary */
+		update_rq_clock(rq);
+	}
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7dba8fdc48c7..48939c8e539d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -513,6 +513,14 @@ struct rq_owner_flags {
 #endif
 };
 
+struct rq_chain {
+#ifdef CONFIG_COSCHEDULING
+	struct rq *next;
+	struct rq *curr;
+	struct rq_flags rf;
+#endif
+};
+
 #ifdef CONFIG_COSCHEDULING
 struct sdrq_data {
 	/*
@@ -1206,6 +1214,9 @@ void cosched_online_group(struct task_group *tg);
 void cosched_offline_group(struct task_group *tg);
 struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf);
 void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf);
+void rq_chain_init(struct rq_chain *rc, struct rq *rq);
+void rq_chain_unlock(struct rq_chain *rc);
+void rq_chain_lock(struct rq_chain *rc, struct sched_entity *se);
 #else /* !CONFIG_COSCHEDULING */
 static inline void cosched_init_bottom(void) { }
 static inline void cosched_init_topology(void) { }
@@ -1217,6 +1228,9 @@ static inline void cosched_online_group(struct task_group *tg) { }
 static inline void cosched_offline_group(struct task_group *tg) { }
 static inline struct rq *rq_lock_owned(struct rq *rq, struct rq_owner_flags *orf) { return rq; }
 static inline void rq_unlock_owned(struct rq *rq, struct rq_owner_flags *orf) { }
+static inline void rq_chain_init(struct rq_chain *rc, struct rq *rq) { }
+static inline void rq_chain_unlock(struct rq_chain *rc) { }
+static inline void rq_chain_lock(struct rq_chain *rc, struct sched_entity *se) { }
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_SCHED_SMT
-- 
2.9.3.1.gcba166c.dirty

