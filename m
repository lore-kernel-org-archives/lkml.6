Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B161206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="aA1i0PZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B161206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbeIHC2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:13460 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbeIHC2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356745; x=1567892745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jSdII5XYgMwyKZmnZkG1NLLVn+DiYke8PMRuChFkl4=;
  b=aA1i0PZoDFvs5WNFBYLeIXqQv5W4anii04wU07A9S9Boc+vbDjEy2CE/
   Rm/6+xHbC8/lm4x3CJsvk4WvPS8GkWw2fsFsALq/L6H+Bb1wUL8Ggiabw
   IFdX9S9z3lsrLymROxX42EpzpolyHnDbE4UgctB7Q0Zmh1QjU8IeNcFi9
   c=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="629734606"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:43:13 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87Lg9vh020494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:12 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87Lg83U027447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:08 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87Lg7QB027446;
        Fri, 7 Sep 2018 23:42:07 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 27/60] cosched: Add some small helper functions for later use
Date:   Fri,  7 Sep 2018 23:40:14 +0200
Message-Id: <20180907214047.26914-28-jschoenh@amazon.de>
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

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/sched.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d65c98c34c13..456b266b8a2c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1130,6 +1130,40 @@ static inline struct cfs_rq *taskgroup_next_cfsrq(struct task_group *tg,
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_COSCHEDULING
+static inline int node_of(struct rq *rq)
+{
+	return rq->sdrq_data.numa_node;
+}
+
+static inline bool is_cpu_rq(struct rq *rq)
+{
+	return !rq->sdrq_data.level;
+}
+
+static inline struct rq *parent_rq(struct rq *rq)
+{
+	if (!rq->sdrq_data.parent)
+		return NULL;
+	return container_of(rq->sdrq_data.parent, struct rq, sdrq_data);
+}
+#else /* !CONFIG_COSCHEDULING */
+static inline int node_of(struct rq *rq)
+{
+	return cpu_to_node(cpu_of(rq));
+}
+
+static inline bool is_cpu_rq(struct rq *rq)
+{
+	return true;
+}
+
+static inline struct rq *parent_rq(struct rq *rq)
+{
+	return NULL;
+}
+#endif /* !CONFIG_COSCHEDULING */
+
+#ifdef CONFIG_COSCHEDULING
 void cosched_init_bottom(void);
 void cosched_init_topology(void);
 void cosched_init_hierarchy(void);
-- 
2.9.3.1.gcba166c.dirty

