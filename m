Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F052083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PS99KC1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F052083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeIHC3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:24 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31852 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbeIHC3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356783; x=1567892783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPBbmqmep3+XtgUFEEskUtxQgZvwKaFpny2qtCURQcE=;
  b=PS99KC1q/ElTGHZj7zf90vwjbjsLLFajDyuzM28iBc5hWUbAGAuBiUyu
   rxhuIfs5TSXi0KSuMT+B9S4Z1qolzCxbdqgoeJ6kMdCEdJtOptnXe+9Ke
   8wsIQQddOez9gHjS2Ha9jnvgqPZHYvPIuEzemOnQp5WOCdADDDEiyF46s
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370704"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:48 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgBNp035985
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:13 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgA8k027458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:10 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg9HB027457;
        Fri, 7 Sep 2018 23:42:09 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 28/60] cosched: Add is_sd_se() to distinguish SD-SEs from TG-SEs
Date:   Fri,  7 Sep 2018 23:40:15 +0200
Message-Id: <20180907214047.26914-29-jschoenh@amazon.de>
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

Add a function is_sd_se() to easily distinguish SD-SEs from a TG-SEs.

Internally, we distinguish tasks, SD-SEs, and TG-SEs based on the my_q
field. For tasks it is empty, for TG-SEs it is a pointer, and for
SD-SEs it is a magic value.

Also modify propagate_entity_load_avg() to not page fault on SD-SEs.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c  | 12 +++++-------
 kernel/sched/sched.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18b1d81951f1..9cbdd027d449 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -279,6 +279,8 @@ static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
 /* runqueue "owned" by this group */
 static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 {
+	if (grp->my_q == INDIRECT_GROUP)
+		return NULL;
 	return grp->my_q;
 }
 
@@ -3240,13 +3242,9 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 /* Update task and its cfs_rq load average */
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq, *gcfs_rq;
-
-	if (entity_is_task(se))
-		return 0;
+	struct cfs_rq *cfs_rq, *gcfs_rq = group_cfs_rq(se);
 
-	gcfs_rq = group_cfs_rq(se);
-	if (!gcfs_rq->propagate)
+	if (!gcfs_rq || !gcfs_rq->propagate)
 		return 0;
 
 	gcfs_rq->propagate = 0;
@@ -9931,7 +9929,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	/* se is NULL for root_task_group */
 	if (se) {
 		set_entity_cfs(se, parent);
-		se->my_q = cfs_rq;
+		se->my_q = cfs_rq ?: INDIRECT_GROUP;
 
 		/* guarantee group entities always have weight */
 		update_load_set(&se->load, NICE_0_LOAD);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 456b266b8a2c..5e2d231b1dbf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1146,6 +1146,13 @@ static inline struct rq *parent_rq(struct rq *rq)
 		return NULL;
 	return container_of(rq->sdrq_data.parent, struct rq, sdrq_data);
 }
+
+#define INDIRECT_GROUP		ERR_PTR(-EREMOTE)
+
+static inline bool is_sd_se(struct sched_entity *se)
+{
+	return se->my_q == INDIRECT_GROUP;
+}
 #else /* !CONFIG_COSCHEDULING */
 static inline int node_of(struct rq *rq)
 {
@@ -1161,6 +1168,13 @@ static inline struct rq *parent_rq(struct rq *rq)
 {
 	return NULL;
 }
+
+#define INDIRECT_GROUP		NULL
+
+static inline bool is_sd_se(struct sched_entity *se)
+{
+	return false;
+}
 #endif /* !CONFIG_COSCHEDULING */
 
 #ifdef CONFIG_COSCHEDULING
-- 
2.9.3.1.gcba166c.dirty

