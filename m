Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5542083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="h3NRH+m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5542083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbeIHCZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:55 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:42560 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbeIHCZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356579; x=1567892579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=op09vYeh0mDSoqDXqF7Z3qeKyHakV/qzyTHHZmFNFKM=;
  b=h3NRH+m7de78aMcjgog0fuxFB+3Gs+4Snq9vS1d6De7fEE4Yhc/g785J
   FhTfaUimeH5QEINZLSAAf5kJO3E9GTjPLB/zbqOHGQ9ji/g6x3wntn+5T
   V9S7sJL+ptlvqcB0YnouVR36SPmYK2Bx5LDoaIuPYF2eXhjq0Pfta4JeC
   g=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="696510018"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:58 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgrVF111575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:55 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgqxM027786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:52 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgpxR027773;
        Fri, 7 Sep 2018 23:42:51 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 51/60] cosched: Hacky work-around to avoid observing zero weight SD-SE
Date:   Fri,  7 Sep 2018 23:40:38 +0200
Message-Id: <20180907214047.26914-52-jschoenh@amazon.de>
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

The aggregated SD-SE weight is updated lock-free to avoid contention
on the higher level. This also means, that we have to be careful
with intermediate values as another CPU could pick up the value and
perform actions based on it.

Within reweight_entity() there is such a place, where weight is removed,
locally modified, and added back. If another CPU locks the higher level
and observes a zero weight, it will perform incorrect decisions when
it is dequeuing a task: it won't stop dequeuing, although there is still
load in one of the child runqueues.

Prevent this from happening by temporarily bumping the aggregated value.

(A nicer solution would be to apply only the actual difference to the
aggregate instead of doing full removal and a subsequent addition.)

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1eee262ecf88..483db54ee20a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2865,6 +2865,16 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
+#ifdef CONFIG_COSCHEDULING
+		/*
+		 * FIXME: Temporarily adjust the sdse_load to prevent a zero
+		 *        value from being visible over the calls to
+		 *        account_entity_dequeue()/account_entity_enqueue().
+		 *        It leads to incorrect decisions in scheduler code.
+		 */
+		if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+			atomic64_add(NICE_0_LOAD, &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 		account_entity_dequeue(cfs_rq, se);
 		dequeue_runnable_load_avg(cfs_rq, se);
 	}
@@ -2886,6 +2896,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		account_entity_enqueue(cfs_rq, se);
+#ifdef CONFIG_COSCHEDULING
+		/* FIXME: see above */
+		if (!cfs_rq->sdrq.is_root && !cfs_rq->throttled)
+			atomic64_sub(NICE_0_LOAD, &cfs_rq->sdrq.sd_parent->sdse_load);
+#endif
 		enqueue_runnable_load_avg(cfs_rq, se);
 	}
 }
-- 
2.9.3.1.gcba166c.dirty

