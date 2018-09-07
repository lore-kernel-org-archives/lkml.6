Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F59C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0C4206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="VZbTXyQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0C4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeIHC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:51 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22745 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbeIHC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356813; x=1567892813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTeHYQR7DGn6ghhStncnoCma2/XhRiJT7+kV5ocIjUM=;
  b=VZbTXyQYEHkmScQixIzDmovsB4M6VMLMqlxl+d+TU5RWIEdro9iA9Pgb
   TsA5gyiW320NaVfZ9Qg7cFNOFLx1Vx55Fh4yHWMMwKYmwQDOJG04D1LW5
   5oyzhMBunmeHF1uEi6M40EQWamnVCOOHBxSJgFcgeVBFhcfSHSwRIdKjq
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286829"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:24 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgiUg061268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:46 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LggiV027708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:43 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgfSZ027707;
        Fri, 7 Sep 2018 23:42:41 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 46/60] cosched: Warn on throttling attempts of non-CPU runqueues
Date:   Fri,  7 Sep 2018 23:40:33 +0200
Message-Id: <20180907214047.26914-47-jschoenh@amazon.de>
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

Initially, coscheduling won't support throttling of CFS runqueues that
are not at CPU level. Print a warning to remind us of this fact and note
down everything that's currently known to be broken, if we wanted to
throttle higher level CFS runqueues (which would totally make sense
from a coscheduling perspective).

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0bba924b40ba..2aa3a60dfca5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4493,12 +4493,25 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 
 static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
+	struct rq *rq = hrq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, dequeue = 1;
 	bool empty;
 
+	/*
+	 * FIXME: We can only handle CPU runqueues at the moment.
+	 *
+	 * rq->nr_running adjustments are incorrect for higher levels,
+	 * as well as tg_throttle_down/up() functionality. Also
+	 * update_runtime_enabled(), unthrottle_offline_cfs_rqs()
+	 * have not been adjusted (used for CPU hotplugging).
+	 *
+	 * Ideally, we would apply throttling only to is_root runqueues,
+	 * instead of the bottom level.
+	 */
+	SCHED_WARN_ON(!is_cpu_rq(rq));
+
 	se = cfs_rq->my_se;
 
 	/* freeze hierarchy runnable averages while throttled */
@@ -4547,12 +4560,14 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
-	struct rq *rq = rq_of(cfs_rq);
+	struct rq *rq = hrq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
 	long task_delta;
 
+	SCHED_WARN_ON(!is_cpu_rq(rq));
+
 	se = cfs_rq->my_se;
 
 	cfs_rq->throttled = 0;
@@ -5171,6 +5186,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	throttled = enqueue_entity_fair(rq, &p->se, flags, 1);
 
+	/* FIXME: assumes, that only bottom level runqueues get throttled */
 	if (!throttled)
 		add_nr_running(rq, 1);
 
@@ -5237,6 +5253,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	bool throttled = dequeue_entity_fair(rq, &p->se, flags, 1);
 
+	/* FIXME: assumes, that only bottom level runqueues get throttled */
 	if (!throttled)
 		sub_nr_running(rq, 1);
 
-- 
2.9.3.1.gcba166c.dirty

