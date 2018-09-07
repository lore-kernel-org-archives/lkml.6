Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CECC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD59206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LQh0MoxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD59206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeIHCa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:30:59 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62597 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbeIHCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356881; x=1567892881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eyWbCvSmEW0u0nZQPbssV5pvceLxX6YrkxiINfJ1Biw=;
  b=LQh0MoxKr8hUoU93mMsOPkdv98uUw0gtHXqk3b00MYGzOLUrTzpIRVHT
   dFDWHsWVudOO6FPh6cLo9hveKReCAmG7cPZ7Zeh0+8tFdyul5Ncy2llq/
   kZhYNdiOULUfm6OYqh6BBMkS0RY5xg4XhbJ5wy1MYLYIposQNjYnEPHMy
   A=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="629734803"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:45:30 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lh7cs051707
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:43:09 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lh659027879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:43:06 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lh5h3027878;
        Fri, 7 Sep 2018 23:43:05 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 59/60] cosched: Handle non-atomicity during switches to and from coscheduling
Date:   Fri,  7 Sep 2018 23:40:46 +0200
Message-Id: <20180907214047.26914-60-jschoenh@amazon.de>
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

We cannot switch a task group from regular scheduling to coscheduling
atomically, as it would require locking the whole system. Instead,
the switch is done runqueue by runqueue via cosched_set_scheduled().

This means that other CPUs may see an intermediate state when locking
a bunch of runqueues, where the sdrq->is_root fields do not yield
a consistent picture across a task group.

Handle these cases.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 322a84ec9511..8da2033596ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -646,6 +646,15 @@ static struct cfs_rq *current_cfs(struct rq *rq)
 {
 	struct sdrq *sdrq = READ_ONCE(rq->sdrq_data.current_sdrq);
 
+	/*
+	 * We might race with concurrent is_root-changes, causing
+	 * current_sdrq to reference an sdrq which is no longer
+	 * !is_root. Counter that by ascending the tg-hierarchy
+	 * until we find an sdrq with is_root.
+	 */
+	while (sdrq->is_root && sdrq->tg_parent)
+		sdrq = sdrq->tg_parent;
+
 	return sdrq->cfs_rq;
 }
 #else
@@ -7141,6 +7150,23 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 		se = pick_next_entity(cfs_rq, curr);
 		cfs_rq = pick_next_cfs(se);
+
+#ifdef CONFIG_COSCHEDULING
+		if (cfs_rq && is_sd_se(se) && cfs_rq->sdrq.is_root) {
+			WARN_ON_ONCE(1); /* Untested code path */
+			/*
+			 * Race with is_root update.
+			 *
+			 * We just moved downwards in the hierarchy via an
+			 * SD-SE, the CFS-RQ should have is_root set to zero.
+			 * However, a reconfiguration may be in progress. We
+			 * basically ignore that reconfiguration.
+			 *
+			 * Contrary to the case below, there is nothing to fix
+			 * as all the set_next_entity() calls are done later.
+			 */
+		}
+#endif
 	} while (cfs_rq);
 
 	if (is_sd_se(se))
@@ -7192,6 +7218,48 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		se = pick_next_entity(cfs_rq, NULL);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = pick_next_cfs(se);
+
+#ifdef CONFIG_COSCHEDULING
+		if (cfs_rq && is_sd_se(se) && cfs_rq->sdrq.is_root) {
+			/*
+			 * Race with is_root update.
+			 *
+			 * We just moved downwards in the hierarchy via an
+			 * SD-SE, the CFS-RQ should have is_root set to zero.
+			 * However, a reconfiguration may be in progress. We
+			 * basically ignore that reconfiguration, but we need
+			 * to fix the picked path to correspond to that
+			 * reconfiguration.
+			 *
+			 * Thus, we walk the hierarchy upwards again and do two
+			 * things simultaneously:
+			 *
+			 * 1. put back picked entities which are not on the
+			 *    "correct" path,
+			 * 2. pick the entities along the correct path.
+			 *
+			 * We do this until both paths upwards converge.
+			 */
+			struct sched_entity *se2 = cfs_rq->sdrq.tg_se;
+			bool top = false;
+
+			WARN_ON_ONCE(1); /* Untested code path */
+			while (se && se != se2) {
+				if (!top) {
+					put_prev_entity(cfs_rq_of(se), se);
+					if (cfs_rq_of(se) == top_cfs_rq)
+						top = true;
+				}
+				if (top)
+					se = cfs_rq_of(se)->sdrq.tg_se;
+				else
+					se = parent_entity(se);
+				set_next_entity(cfs_rq_of(se2), se2);
+				se2 = parent_entity(se2);
+			}
+		}
+#endif
+
 	} while (cfs_rq);
 
 retidle: __maybe_unused;
-- 
2.9.3.1.gcba166c.dirty

