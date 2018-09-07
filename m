Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E98C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0355206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="H7Dqdqq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0355206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeIHCYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:46 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:62448 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbeIHCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356510; x=1567892510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHgdqofGPw7S35H43SLYQDxxWOv3XzAe65kUZqWe60I=;
  b=H7Dqdqq9gNHwxKvO6h5wTGidjh0SMm7O1awLgQrV9DmFVcv0oxfUGy8A
   vbpBvdodKygE62S+Hwsy9lnj0EgeTGChkLZlob/yeCyKgvqRKsZQgVdIa
   pLBjKs0MW7OfgzYRZtHTIigdpe1Y3WquXkoKmtweuy01dvpGXhGvXUyuS
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="355980823"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:48 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfhIF005892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:45 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LffTL027270
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:42 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LffjU027269;
        Fri, 7 Sep 2018 23:41:41 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 15/60] sched: Introduce parent_cfs_rq() and use it
Date:   Fri,  7 Sep 2018 23:40:02 +0200
Message-Id: <20180907214047.26914-16-jschoenh@amazon.de>
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

Factor out the logic to retrieve the parent CFS runqueue of another
CFS runqueue into its own function and replace open-coded variants.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f0ce4555c26..82cdd75e88b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -282,11 +282,18 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+static inline struct cfs_rq *parent_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	if (!cfs_rq->tg->parent)
+		return NULL;
+	return cfs_rq->tg->parent->cfs_rq[cpu_of(rq_of(cfs_rq))];
+}
+
 static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (!cfs_rq->on_list) {
 		struct rq *rq = rq_of(cfs_rq);
-		int cpu = cpu_of(rq);
+		struct cfs_rq *pcfs_rq = parent_cfs_rq(cfs_rq);
 		/*
 		 * Ensure we either appear before our parent (if already
 		 * enqueued) or force our parent to appear after us when it is
@@ -296,8 +303,7 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * tmp_alone_branch either when the branch is connected
 		 * to a tree or when we reach the beg of the tree
 		 */
-		if (cfs_rq->tg->parent &&
-		    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
+		if (pcfs_rq && pcfs_rq->on_list) {
 			/*
 			 * If parent is already on the list, we add the child
 			 * just before. Thanks to circular linked property of
@@ -305,14 +311,14 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 			 * of the list that starts by parent.
 			 */
 			list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-				&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
+					  &pcfs_rq->leaf_cfs_rq_list);
 			/*
 			 * The branch is now connected to its tree so we can
 			 * reset tmp_alone_branch to the beginning of the
 			 * list.
 			 */
 			rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		} else if (!cfs_rq->tg->parent) {
+		} else if (!pcfs_rq) {
 			/*
 			 * cfs rq without parent should be put
 			 * at the tail of the list.
@@ -4716,7 +4722,7 @@ static void sync_throttle(struct cfs_rq *cfs_rq)
 	if (!cfs_bandwidth_used())
 		return;
 
-	pcfs_rq = cfs_rq->tg->parent->cfs_rq[cpu_of(rq_of(cfs_rq))];
+	pcfs_rq = parent_cfs_rq(cfs_rq);
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_task = rq_clock_task(rq_of(cfs_rq));
-- 
2.9.3.1.gcba166c.dirty

