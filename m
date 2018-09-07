Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE33C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4702083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="fiEwA7ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4702083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeIHCYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25381 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbeIHCY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356494; x=1567892494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coqOdefSRcgS8/PtGvLyBD+pkyND5+g1U3mo6EtjRg8=;
  b=fiEwA7ha10uA21u/QodJwWGdgLn1lWrzoV/iDH3X1KHL0v3iCu8D9atS
   P8H1lM1r260QRw9gVzlzvin3YidPYHdVi+37p1daHTzLM9n9Qy2prIJ3P
   zUTktd/y3Q2WoNdkjbsWdHBQ4fVEqfJNTb7MQm9EUxD2Zn3WnSU1rgS2d
   E=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243118"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:41:33 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfRxT034578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:30 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfPuF027183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:25 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfOHq027181;
        Fri, 7 Sep 2018 23:41:24 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 09/60] sched: Do not require a CFS in init_tg_cfs_entry()
Date:   Fri,  7 Sep 2018 23:39:56 +0200
Message-Id: <20180907214047.26914-10-jschoenh@amazon.de>
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

Just like init_tg_cfs_entry() does something useful without a scheduling
entity, let it do something useful without a CFS runqueue.

This prepares for the addition of new types of SEs.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b3fd7cd9fde..bccd7a66858e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9903,21 +9903,23 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 		       struct sched_entity *se, struct rq *rq,
 		       struct cfs_rq *parent)
 {
-	cfs_rq->tg = tg;
-	cfs_rq->rq = rq;
-	cfs_rq->my_se = se;
-	init_cfs_rq_runtime(cfs_rq);
-
-	/* se could be NULL for root_task_group */
-	if (!se)
-		return;
+	/* cfs_rq may be NULL for certain types of SE */
+	if (cfs_rq) {
+		cfs_rq->tg = tg;
+		cfs_rq->rq = rq;
+		cfs_rq->my_se = se;
+		init_cfs_rq_runtime(cfs_rq);
+	}
 
-	set_entity_cfs(se, parent);
-	se->my_q = cfs_rq;
+	/* se is NULL for root_task_group */
+	if (se) {
+		set_entity_cfs(se, parent);
+		se->my_q = cfs_rq;
 
-	/* guarantee group entities always have weight */
-	update_load_set(&se->load, NICE_0_LOAD);
-	init_entity_runnable_average(se);
+		/* guarantee group entities always have weight */
+		update_load_set(&se->load, NICE_0_LOAD);
+		init_entity_runnable_average(se);
+	}
 }
 
 static DEFINE_MUTEX(shares_mutex);
-- 
2.9.3.1.gcba166c.dirty

