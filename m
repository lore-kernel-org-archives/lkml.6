Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A367B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="AQhjO7xY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A367B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeIHCZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:45 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55298 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeIHCZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356569; x=1567892569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iEzeSY3HXZePtDrTXPKWmRO6bwBvGIC8DYKkivdhMJc=;
  b=AQhjO7xYzMc2BoEwcfC8X//cdzpU3fvbn5Peabwjc37viSrguaqFJmgJ
   ZZGxVuKz8f3L55nc1NYx+rW6CwSBkrw8/qABnDLJ48YVj5gK91Q8IeciM
   zwqgnADiLtFXgMGLc2uI0FZcxUK8+emHs/dGHgV1anbTmauZqPvHGRqm4
   4=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530499"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:49 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lggh7013102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:45 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lgf2C027687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:41 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lgeqh027680;
        Fri, 7 Sep 2018 23:42:40 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 45/60] cosched: Continue to account all load on per-CPU runqueues
Date:   Fri,  7 Sep 2018 23:40:32 +0200
Message-Id: <20180907214047.26914-46-jschoenh@amazon.de>
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

Even with coscheduling, we define the fields rq->nr_running and rq->load
of per-CPU runqueues to represent the total amount of tasks and the
total amount of load on that CPU, respectively, so that existing code
continues to work as expected.

Make sure to still account load changes on per-CPU runqueues.

The change in set_next_entity() just silences a warning. The code looks
bogus even without coscheduling, as the weight of an SE is independent
from the weight of the runqueue, when task groups are involved. It's
just for statistics anyway.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fff88694560c..0bba924b40ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2741,8 +2741,8 @@ static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_add(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_add(&rq_of(cfs_rq)->load, se->load.weight);
+	if (!parent_entity(se) || is_sd_se(parent_entity(se)))
+		update_load_add(&hrq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -2758,8 +2758,8 @@ static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_sub(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_sub(&rq_of(cfs_rq)->load, se->load.weight);
+	if (!parent_entity(se) || is_sd_se(parent_entity(se)))
+		update_load_sub(&hrq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
@@ -4122,7 +4122,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * least twice that of our own weight (i.e. dont track it
 	 * when there are only lesser-weight tasks around):
 	 */
-	if (schedstat_enabled() && rq_of(cfs_rq)->load.weight >= 2*se->load.weight) {
+	if (schedstat_enabled() &&
+	    hrq_of(cfs_rq)->load.weight >= 2 * se->load.weight) {
 		schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
-- 
2.9.3.1.gcba166c.dirty

