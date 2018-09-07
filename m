Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42222083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="YWg/0cns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42222083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbeIHC2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:52 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:12694 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeIHC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356756; x=1567892756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iU8DLPETpFbm7PekMxidV/bd2shUB/iA98d0tAkCYxk=;
  b=YWg/0cnsD1CFpmXt/Rf2Yz74E0GZr0xKyYz5rIjavsOdlkOJN0HdSEtB
   lsXUh1MTPP7Ofzzrk+F1iG8weqq4XeMKMQmcmmcjvLHJMtncWymm+zz9r
   jZ9e4WHmkzv9YgIq9jI/hES77VuCkzZSWiMkQNTY+lJ9Q6NPRY4PMdWp0
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="752286750"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:24 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgI6C074882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:20 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgHsm027504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:17 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgGn7027500;
        Fri, 7 Sep 2018 23:42:16 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 32/60] cosched: Specialize parent_cfs_rq() for hierarchical runqueues
Date:   Fri,  7 Sep 2018 23:40:19 +0200
Message-Id: <20180907214047.26914-33-jschoenh@amazon.de>
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

Make parent_cfs_rq() coscheduling-aware.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8504790944bf..8cba7b8fb6bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -284,12 +284,25 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
+#ifdef CONFIG_COSCHEDULING
+static inline struct cfs_rq *parent_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	/*
+	 * Only return TG parent (if valid), don't switch levels.
+	 * Callers stay or expect to stay within the same level.
+	 */
+	if (!cfs_rq->sdrq.tg_parent || !cfs_rq->sdrq.is_root)
+		return NULL;
+	return cfs_rq->sdrq.tg_parent->cfs_rq;
+}
+#else /* !CONFIG_COSCHEDULING */
 static inline struct cfs_rq *parent_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (!cfs_rq->tg->parent)
 		return NULL;
 	return cfs_rq->tg->parent->cfs_rq[cpu_of(rq_of(cfs_rq))];
 }
+#endif /* !CONFIG_COSCHEDULING */
 
 static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
-- 
2.9.3.1.gcba166c.dirty

