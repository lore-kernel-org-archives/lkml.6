Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82C92075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UnHiM6SN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82C92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbeIHC2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:19 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29647 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeIHC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356722; x=1567892722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5TVCAbCNQimEbznS0QNotFWxXrVtXPfzujB44VzEifU=;
  b=UnHiM6SNIgNYWlElYZ7kFiUFZpCdZQxEezYYUn6xKn4BC6Gf+Y7jq2k+
   gQpPXDM+EJiHLGuzhMnELzhdqIoVSfihzTZSjPtHPO59FAT9zyrwC/Csg
   zPbQ1XNtRuCjhm4gvRlp4VgeMYwFCUmdJNnbkkHYCM0XV6W31wQY6J19e
   o=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286694"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:47 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfeR9038340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:42 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lfchq027245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:38 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfWT3027226;
        Fri, 7 Sep 2018 23:41:32 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 13/60] sched: Remove useless checks for root task-group
Date:   Fri,  7 Sep 2018 23:40:00 +0200
Message-Id: <20180907214047.26914-14-jschoenh@amazon.de>
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

The functions sync_throttle() and unregister_fair_sched_group() are
called during the creation and destruction of cgroups. They are never
called for the root task-group. Remove checks that always yield the
same result when operating on non-root task groups.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d6225aedbfe..5cad364e3a88 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4716,9 +4716,6 @@ static void sync_throttle(struct task_group *tg, int cpu)
 	if (!cfs_bandwidth_used())
 		return;
 
-	if (!tg->parent)
-		return;
-
 	cfs_rq = tg->cfs_rq[cpu];
 	pcfs_rq = tg->parent->cfs_rq[cpu];
 
@@ -9881,8 +9878,7 @@ void unregister_fair_sched_group(struct task_group *tg)
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		if (tg->cfs_rq[cpu]->my_se)
-			remove_entity_load_avg(tg->cfs_rq[cpu]->my_se);
+		remove_entity_load_avg(tg->cfs_rq[cpu]->my_se);
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
-- 
2.9.3.1.gcba166c.dirty

