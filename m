Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DEFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Hbv30rMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0C62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbeIHC3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:31852 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbeIHC3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356776; x=1567892776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JGKYGfdb0hC2kfmZzRQE7diPafx0OTb2fU7Ebd15r9U=;
  b=Hbv30rMDhmniZ+mj0E75F9Cgy26kszsrmCSAOKsup/n08W3FzY3NWG7j
   gV8vAzYRBHwDdhgrTBV88vtzVYb3MRxot57QTMueFc+hHJVI1x1X+gu9I
   gL3LYJLVOy3NFsTbbgNDdwABeeeYohcsg5yIruLTLPHhg9Nzlxddxh83R
   A=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="757370695"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:41 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfTY6031006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:32 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfRZo027194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:27 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfQMi027193;
        Fri, 7 Sep 2018 23:41:26 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 10/60] sched: Use parent_entity() in more places
Date:   Fri,  7 Sep 2018 23:39:57 +0200
Message-Id: <20180907214047.26914-11-jschoenh@amazon.de>
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

Replace open-coded cases of parent_entity() with actual parent_entity()
invocations.

This will make later checks within parent_entity() more useful.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bccd7a66858e..5d6225aedbfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -263,7 +263,7 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
-		for (; se; se = se->parent)
+		for (; se; se = parent_entity(se))
 
 static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
 {
@@ -9653,7 +9653,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	struct cfs_rq *cfs_rq;
 
 	/* Start to propagate at parent */
-	se = se->parent;
+	se = parent_entity(se);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-- 
2.9.3.1.gcba166c.dirty

