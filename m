Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BF32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="L1DE5Ll7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BF32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbeIHCdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:33:44 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23728 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbeIHCZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356549; x=1567892549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugQIEbaBLUBrzFHszTzTXnnGqJsYXPyt89EWjgB+6ZQ=;
  b=L1DE5Ll7BC13dZ9/p3LbEmNo75q8xZL7tFLWUMVUkGhVo7TpDAWqxjaF
   uQPEXhMuHdGgGRPRt18t7U3DzTboXI65wvCpSc2fdJaKGQUIKarduWgBi
   fqVc8ly22efazNz0U+viC3s3tVeUCCAEs6lPf+tJH9PoAcxT+RkopO4km
   k=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243212"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:29 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgMQY110961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:25 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgKP9027530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:21 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgJEu027525;
        Fri, 7 Sep 2018 23:42:19 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 34/60] cosched: Add rq_of() variants for different use cases
Date:   Fri,  7 Sep 2018 23:40:21 +0200
Message-Id: <20180907214047.26914-35-jschoenh@amazon.de>
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

The rq_of() function is used everywhere. With the introduction of
hierarchical runqueues, we could modify rq_of() to return the
corresponding queue. In fact, no change would be necessary for that.

However, many code paths do not handle a hierarchical runqueue
adequately. Thus, we introduce variants of rq_of() to catch and
handle these code paths on a case by case basis.

The normal rq_of() will complain loudly if used with a hierarchical
runqueue. If a code path was audited for hierarchical use, it can be
switched to hrq_of(), which returns the proper hierarchical runqueue,
or to cpu_rq_of(), which returns the leader's CPU runqueue.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8cba7b8fb6bd..24d01bf8f796 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -249,9 +249,44 @@ const struct sched_class fair_sched_class;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
+/* Variant of rq_of() that always returns a per-CPU runqueue */
+static inline struct rq *cpu_rq_of(struct cfs_rq *cfs_rq)
+{
+#ifdef CONFIG_COSCHEDULING
+	if (cfs_rq->sdrq.data->level) {
+		struct rq *rq = cpu_rq(cfs_rq->sdrq.data->leader);
+
+		/* We should have this lock already. */
+		lockdep_assert_held(&rq->lock);
+		return rq;
+	}
+#endif
+	return cfs_rq->rq;
+}
+
 /* cpu runqueue to which this cfs_rq is attached */
 static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 {
+#ifdef CONFIG_COSCHEDULING
+	if (SCHED_WARN_ON(cfs_rq->sdrq.data->level)) {
+		/*
+		 * This should be only called for the bottom level.
+		 * If not, then it's an indicator of a not yet adjusted
+		 * code path. Return the CPU runqueue as this is more likely
+		 * to work than the proper hierarchical runqueue.
+		 *
+		 * Note, that we don't necessarily have the lock for
+		 * this bottom level, which may lead to weird issues.
+		 */
+		return cpu_rq_of(cfs_rq);
+	}
+#endif
+	return cfs_rq->rq;
+}
+
+/* Hierarchical variant of rq_of() */
+static inline struct rq *hrq_of(struct cfs_rq *cfs_rq)
+{
 	return cfs_rq->rq;
 }
 
-- 
2.9.3.1.gcba166c.dirty

