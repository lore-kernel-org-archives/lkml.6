Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2732083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="e8tDWw0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2732083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeIHCYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:46 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:46720 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbeIHCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356510; x=1567892510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pGmI+l3MuXglCkLcsiCuosfOIMD8ticrtUT6x2TBPSM=;
  b=e8tDWw0Jhs7G7pxcuq1Fn2uwDzJA4zgYzW/1cPYxcvITQmPigwcgVJph
   TDM/vtAfbNz8LGHHj58KF+C293TFqphsZcROTXp0/p6RtGPr1IAQ1e8o9
   tQ1F4MKrmcXIIDgLeNpgUk++AwAxJjjYpFxBdaG3dCF+c42ItQgMG+V3D
   A=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530416"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:49 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LffLC073422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:44 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfefI027256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:40 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lfdtw027255;
        Fri, 7 Sep 2018 23:41:39 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 14/60] sched: Refactor sync_throttle() to accept a CFS runqueue as argument
Date:   Fri,  7 Sep 2018 23:40:01 +0200
Message-Id: <20180907214047.26914-15-jschoenh@amazon.de>
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

Prepare for future changes and refactor sync_throttle() to work with
a different set of arguments.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5cad364e3a88..9f0ce4555c26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4709,18 +4709,17 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 		throttle_cfs_rq(cfs_rq);
 }
 
-static void sync_throttle(struct task_group *tg, int cpu)
+static void sync_throttle(struct cfs_rq *cfs_rq)
 {
-	struct cfs_rq *pcfs_rq, *cfs_rq;
+	struct cfs_rq *pcfs_rq;
 
 	if (!cfs_bandwidth_used())
 		return;
 
-	cfs_rq = tg->cfs_rq[cpu];
-	pcfs_rq = tg->parent->cfs_rq[cpu];
+	pcfs_rq = cfs_rq->tg->parent->cfs_rq[cpu_of(rq_of(cfs_rq))];
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
-	cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
+	cfs_rq->throttled_clock_task = rq_clock_task(rq_of(cfs_rq));
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
@@ -4887,7 +4886,7 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
-static inline void sync_throttle(struct task_group *tg, int cpu) {}
+static inline void sync_throttle(struct cfs_rq *cfs_rq) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
@@ -9866,7 +9865,7 @@ void online_fair_sched_group(struct task_group *tg)
 		raw_spin_lock_irq(&rq->lock);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
-		sync_throttle(tg, i);
+		sync_throttle(tg->cfs_rq[i]);
 		raw_spin_unlock_irq(&rq->lock);
 	}
 }
-- 
2.9.3.1.gcba166c.dirty

