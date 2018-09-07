Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC94C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1252083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ul91v0eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1252083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeIHCZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:25 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26485 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbeIHCZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356549; x=1567892549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=joqvvsSFTjime50bAsocxHF0anIX+QiAH7cQP3678XQ=;
  b=ul91v0eLqa00XrhfYIHBbPDr9IeOOsZpcV66tXZXnItzW2rQ5lOuYNH2
   HZInBN1oV1Eao5bqHCWgvlhVAn0mO860FUPCy/IWYhkWT8BnKJ2xd929U
   MgWG722juxy1rWKWV5Rva5Qh0R7Xl/fANzqgbUkVFBgW7VEwr0AHStcIr
   8=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696509969"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:29 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgOeJ021423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:26 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgMYt027541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:23 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgLM1027537;
        Fri, 7 Sep 2018 23:42:21 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 35/60] cosched: Adjust rq_lock() functions to work with hierarchical runqueues
Date:   Fri,  7 Sep 2018 23:40:22 +0200
Message-Id: <20180907214047.26914-36-jschoenh@amazon.de>
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

Locks within the runqueue hierarchy are always taken from bottom to top
to avoid deadlocks. Let the lock validator know about this by declaring
different runqueue levels as distinct lock classes.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/sched.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 594eb9489f3d..bc3631b8b955 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2083,11 +2083,26 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+#ifdef CONFIG_COSCHEDULING
+/*
+ * The hierarchical runqueues have locks which are taken from bottom to
+ * top. For lock validation, we use the level to calculate the subclass.
+ * As it is sometimes necessary to take two locks on the same level, we
+ * leave some space in the subclass values for that purpose.
+ */
+#define RQ_LOCK_SUBCLASS(rq)		(2 * (rq)->sdrq_data.level)
+#define RQ_LOCK_SUBCLASS_NESTED(rq)	(2 * (rq)->sdrq_data.level + 1)
+#else
+#define RQ_LOCK_SUBCLASS(rq)		0
+#define RQ_LOCK_SUBCLASS_NESTED(rq)	SINGLE_DEPTH_NESTING
+#endif
+
 static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock_irqsave(&rq->lock, rf->flags);
+	raw_spin_lock_irqsave_nested(&rq->lock, rf->flags,
+				     RQ_LOCK_SUBCLASS(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -2095,6 +2110,14 @@ static inline void
 rq_lock_irq(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
+	/*
+	 * There's no raw_spin_lock_irq_nested(). This is probably fine, as at
+	 * most the first lock should be acquired this way. There might be some
+	 * false negatives, though, if we start with a non-bottom lock and
+	 * classify it incorrectly.
+	 */
+	SCHED_WARN_ON(RQ_LOCK_SUBCLASS(rq));
+
 	raw_spin_lock_irq(&rq->lock);
 	rq_pin_lock(rq, rf);
 }
@@ -2103,7 +2126,7 @@ static inline void
 rq_lock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock_nested(&rq->lock, RQ_LOCK_SUBCLASS(rq));
 	rq_pin_lock(rq, rf);
 }
 
@@ -2111,7 +2134,7 @@ static inline void
 rq_relock(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {
-	raw_spin_lock(&rq->lock);
+	raw_spin_lock_nested(&rq->lock, RQ_LOCK_SUBCLASS(rq));
 	rq_repin_lock(rq, rf);
 }
 
-- 
2.9.3.1.gcba166c.dirty

