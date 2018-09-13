Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674B0C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F52F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="C0Rqg3DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F52F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeINAb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:31:28 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:24318 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeINAb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536866435; x=1568402435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiacIuApp0eSLutNfSR5HNoRyCYtqlklZLpC+GUFnu8=;
  b=C0Rqg3DChxADGMtkxvlVtColnUPFFeqv879b769Wtny21Fo2keH7ytWW
   HNtN4CDy0PepPHSpGEjn4cnlq9lnM0eNMAZZtU9VOkFybaBdTANo4B+t1
   Yy+6EqvTD0ZYW7dgR+rGT9Cr7kjYo6K6Sc8cQZTSO9M9ApvJPzG/YJ+IQ
   4=;
X-IronPort-AV: E=Sophos;i="5.53,370,1531785600"; 
   d="scan'208";a="758125105"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Sep 2018 19:20:33 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8DJKPV7085014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Sep 2018 19:20:28 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w8DJKM1j030743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Sep 2018 21:20:22 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w8DJKJqD030738;
        Thu, 13 Sep 2018 21:20:19 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC 61/60] cosched: Accumulated fixes and improvements
Date:   Thu, 13 Sep 2018 21:19:38 +0200
Message-Id: <20180913191938.30526-1-jschoenh@amazon.de>
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

Here is an "extra" patch containing bug fixes and warning removals,
that I have accumulated up to this point.

It goes on top of the other 60 patches. (When it is time for v2,
these fixes will be integrated into the appropriate patches within
the series.)

The changes are:

1. Avoid a hang with nested scheduled task groups.
2. Get rid of a lockdep warning.
3. Get rid of warnings about missed clock updates.
4. Get rid of "untested code path" warnings/reminders (after testing
   said code paths).

This should make experimenting with this patch series a little less bumpy.

Partly-reported-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/cosched.c |  2 ++
 kernel/sched/fair.c    | 35 ++++++++++-------------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index a1f0d3a7b02a..88b7bc6d4bfa 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -588,6 +588,7 @@ static void sdrq_update_root(struct sdrq *sdrq)
 
 	/* Get proper locks */
 	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
 
 	sdrq->is_root = is_root;
 	if (is_root)
@@ -644,6 +645,7 @@ static void sdrq_update_root(struct sdrq *sdrq)
 		}
 		if (sdrq->cfs_rq->curr) {
 			rq_lock(prq, &prf);
+			update_rq_clock(prq);
 			if (sdrq->data->leader == sdrq->sd_parent->data->leader)
 				put_prev_entity_fair(prq, sdrq->sd_parent->sd_se);
 			rq_unlock(prq, &prf);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da2033596ff..4c823fa367ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7150,23 +7150,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 		se = pick_next_entity(cfs_rq, curr);
 		cfs_rq = pick_next_cfs(se);
-
-#ifdef CONFIG_COSCHEDULING
-		if (cfs_rq && is_sd_se(se) && cfs_rq->sdrq.is_root) {
-			WARN_ON_ONCE(1); /* Untested code path */
-			/*
-			 * Race with is_root update.
-			 *
-			 * We just moved downwards in the hierarchy via an
-			 * SD-SE, the CFS-RQ should have is_root set to zero.
-			 * However, a reconfiguration may be in progress. We
-			 * basically ignore that reconfiguration.
-			 *
-			 * Contrary to the case below, there is nothing to fix
-			 * as all the set_next_entity() calls are done later.
-			 */
-		}
-#endif
 	} while (cfs_rq);
 
 	if (is_sd_se(se))
@@ -7189,23 +7172,26 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
 			int pse_depth = pse->depth;
+			bool work = false;
 
-			if (se_depth <= pse_depth && leader_of(pse) == cpu) {
+			if (se_depth <= pse_depth && __leader_of(pse) == cpu) {
 				put_prev_entity(cfs_rq_of(pse), pse);
 				pse = parent_entity(pse);
+				work = true;
 			}
-			if (se_depth >= pse_depth && leader_of(se) == cpu) {
+			if (se_depth >= pse_depth && __leader_of(se) == cpu) {
 				set_next_entity(cfs_rq_of(se), se);
 				se = parent_entity(se);
+				work = true;
 			}
-			if (leader_of(pse) != cpu && leader_of(se) != cpu)
+			if (!work)
 				break;
 		}
 
-		if (leader_of(pse) == cpu)
-			put_prev_entity(cfs_rq, pse);
-		if (leader_of(se) == cpu)
-			set_next_entity(cfs_rq, se);
+		if (__leader_of(pse) == cpu)
+			put_prev_entity(cfs_rq_of(pse), pse);
+		if (__leader_of(se) == cpu)
+			set_next_entity(cfs_rq_of(se), se);
 	}
 
 	goto done;
@@ -7243,7 +7229,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			struct sched_entity *se2 = cfs_rq->sdrq.tg_se;
 			bool top = false;
 
-			WARN_ON_ONCE(1); /* Untested code path */
 			while (se && se != se2) {
 				if (!top) {
 					put_prev_entity(cfs_rq_of(se), se);
-- 
2.9.3.1.gcba166c.dirty

