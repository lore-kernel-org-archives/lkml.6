Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43407206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="d9oF7+jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43407206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeIHC1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:07 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:50633 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbeIHC1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356651; x=1567892651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/vGj0B19D0H1MdtRjFdlg2C9y+M3DPWRVbChq4yUy9M=;
  b=d9oF7+jziuysG6g5tUU8ABtJLrW6aqLvtzUDVZpBc9z3AeXvoiXcfr0T
   mwRIGGFER4vLc9Z2B9fSbFyxm7ZNCSoXvLFq7uPUfh8dtAxMuG/L5qVpN
   XZLT8KwFuD5FWB8NiSKE8xa3BeR/nuUH7sLotLxxUc8628wJIOCekZfr6
   Q=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530643"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LfjCS085562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:41:46 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LfhGC027281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:41:43 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LfgYA027280;
        Fri, 7 Sep 2018 23:41:42 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 16/60] sched: Preparatory code movement
Date:   Fri,  7 Sep 2018 23:40:03 +0200
Message-Id: <20180907214047.26914-17-jschoenh@amazon.de>
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

Move struct rq_flags around to keep future commits crisp.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/sched.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b8c8dfd0e88d..cd3a32ce8fc6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -472,6 +472,19 @@ struct cfs_bandwidth { };
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+struct rq_flags {
+	unsigned long flags;
+	struct pin_cookie cookie;
+#ifdef CONFIG_SCHED_DEBUG
+	/*
+	 * A copy of (rq::clock_update_flags & RQCF_UPDATED) for the
+	 * current pin context is stashed here in case it needs to be
+	 * restored in rq_repin_lock().
+	 */
+	unsigned int clock_update_flags;
+#endif
+};
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -1031,19 +1044,6 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
-struct rq_flags {
-	unsigned long flags;
-	struct pin_cookie cookie;
-#ifdef CONFIG_SCHED_DEBUG
-	/*
-	 * A copy of (rq::clock_update_flags & RQCF_UPDATED) for the
-	 * current pin context is stashed here in case it needs to be
-	 * restored in rq_repin_lock().
-	 */
-	unsigned int clock_update_flags;
-#endif
-};
-
 static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	rf->cookie = lockdep_pin_lock(&rq->lock);
-- 
2.9.3.1.gcba166c.dirty

