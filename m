Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51820844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="LGypyXNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F51820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeIHC1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:14 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:50633 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbeIHC1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356651; x=1567892651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMWkasYEaZOcKd+jyYJseO+NDd8EiVeCIBz4OWk3XYE=;
  b=LGypyXNY0OgD7fpo4F2Zh+3e9Ed1ogknnoMBSD5YjtlLJijf70HXfdY7
   jI/S1pIs3b6gUV72u2PvyRhuG7JeVxjqwSU3/cxWIB4JJivbzAsxkpr9n
   yncm2a753t66c7nq6BBuO3mKO3VdZVTN/KHvevMeZqN+a1lBUVufHH5lL
   k=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530648"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:44:10 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgTfA042987
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:31 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgStE027600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:28 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgReg027599;
        Fri, 7 Sep 2018 23:42:27 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 38/60] cosched: Skip updates on non-CPU runqueues in cfs_rq_util_change()
Date:   Fri,  7 Sep 2018 23:40:25 +0200
Message-Id: <20180907214047.26914-39-jschoenh@amazon.de>
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

The function cfs_rq_util_change() notifies frequency governors of
utilization changes, so that they can be scheduler driven. This is
coupled to per CPU runqueue statistics. So, don't do anything
when called for non-CPU runqueues.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2945355f823..33e3f759eb99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3015,7 +3015,16 @@ static inline void update_cfs_group(struct sched_entity *se)
 
 static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 {
-	struct rq *rq = rq_of(cfs_rq);
+	struct rq *rq = hrq_of(cfs_rq);
+
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * This function is currently only well defined for per-CPU
+	 * runqueues. Don't execute it for anything else.
+	 */
+	if (rq->sdrq_data.level)
+		return;
+#endif
 
 	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
 		/*
-- 
2.9.3.1.gcba166c.dirty

