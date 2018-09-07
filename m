Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B030C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D13C204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Vcqv9f+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D13C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbeIHCdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:33:15 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55298 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbeIHCZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356564; x=1567892564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGc+7tfgjNsz8T/8mN4E1fpzKHW2V/dwOJvC2L85sqk=;
  b=Vcqv9f+GvOwvzGs9gUKOEXiUfYSYJjHkbdtwihU4SZCq3GbY+NhrSzAz
   OTkXVOza7AfEGtpHmtkLwHKwAmSnXowc2glQeDr0CcHduyXmn+vf+9Hgy
   HGj0Gtn2ZherHGN+CqXkuhWfXSrqCm67fP50OgpM8pk14T9j1z0MUxlTP
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530492"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:43 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lgc2F089294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:40 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgbFB027662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:37 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lga9e027652;
        Fri, 7 Sep 2018 23:42:36 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 43/60] cosched: Add for_each_sched_entity() variant for owned entities
Date:   Fri,  7 Sep 2018 23:40:30 +0200
Message-Id: <20180907214047.26914-44-jschoenh@amazon.de>
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

Add a new loop constuct for_each_owned_sched_entity(), which iterates
over all owned scheduling entities, stopping when it encounters a
leader change.

This allows relatively straight-forward adaptations of existing code,
where the leader only handles that part of the hierarchy it actually
owns.

Include some lockdep goodness, so that we detect incorrect usage.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f72a72c8c3b8..f55954e7cedc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -521,6 +521,76 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
+#ifdef CONFIG_COSCHEDULING
+struct sched_entity *owned_parent_entity(struct sched_entity *se)
+{
+	struct rq *prq, *rq = hrq_of(cfs_rq_of(se));
+
+	lockdep_assert_held(&rq->lock);
+
+	se = parent_entity(se);
+	if (!se)
+		return NULL;
+
+	prq = hrq_of(cfs_rq_of(se));
+	if (rq == prq)
+		return se;
+
+#ifdef CONFIG_SCHED_DEBUG
+	if (!rq->sdrq_data.parent_locked) {
+		int leader = rq->sdrq_data.leader;
+		int pleader = READ_ONCE(prq->sdrq_data.leader);
+
+		SCHED_WARN_ON(leader == pleader);
+	} else {
+		int leader = rq->sdrq_data.leader;
+		int pleader = prq->sdrq_data.leader;
+
+		SCHED_WARN_ON(leader != pleader);
+	}
+#endif
+
+	if (!rq->sdrq_data.parent_locked)
+		return NULL;
+
+	lockdep_assert_held(&prq->lock);
+	return se;
+}
+
+static inline int leader_of(struct sched_entity *se)
+{
+	struct rq *rq = hrq_of(cfs_rq_of(se));
+
+	lockdep_assert_held(&rq->lock);
+	return rq->sdrq_data.leader;
+}
+
+static inline int __leader_of(struct sched_entity *se)
+{
+	struct rq *rq = hrq_of(cfs_rq_of(se));
+
+	return READ_ONCE(rq->sdrq_data.leader);
+}
+#else
+struct sched_entity *owned_parent_entity(struct sched_entity *se)
+{
+	return parent_entity(se);
+}
+
+static inline int leader_of(struct sched_entity *se)
+{
+	return cpu_of(rq_of(cfs_rq_of(se)));
+}
+
+static inline int __leader_of(struct sched_entity *se)
+{
+	return leader_of(se);
+}
+#endif
+
+#define for_each_owned_sched_entity(se) \
+	for (; se; se = owned_parent_entity(se))
+
 /**************************************************************
  * Scheduling class tree data structure manipulation methods:
  */
-- 
2.9.3.1.gcba166c.dirty

