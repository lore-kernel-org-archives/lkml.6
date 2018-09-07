Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4294FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB620204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qAqpVklG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB620204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeIHCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:33:25 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:55298 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbeIHCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356558; x=1567892558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aud30RhSUeWi9W7z7vrw6k/jq/YDJbWIpNOBgtiW3to=;
  b=qAqpVklGaQSrkl4e3wihkE+TYtCHNPpZzxeLUlW02mbeVB8lur1VEVCz
   +JR2+GuK7dLlHTM6cuMia/VQELzmCBpYgYLk33d4P4ft6LK2OIS6b3PmE
   vaU9qROL/WuY72jVTrASR9MNG6y73hSUENro0+/v6V1WOpESyF0a/S2Ka
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="737530488"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:38 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgW17052671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:35 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgQDp027587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:26 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgP6L027586;
        Fri, 7 Sep 2018 23:42:25 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 37/60] cosched: Use hrq_of() for (indirect calls to) ___update_load_sum()
Date:   Fri,  7 Sep 2018 23:40:24 +0200
Message-Id: <20180907214047.26914-38-jschoenh@amazon.de>
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

The cpu argument supplied to all callers of ___update_load_sum() is used
in accumulate_sum() to scale load values according to the CPU capacity.
While we should think about that at some point, it is out-of-scope for now.
Also, it does not matter on homogeneous system topologies.

Update all callers to use hrq_of() instead of rq_of() to derive the cpu
argument.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fde1c4ba4bb4..a2945355f823 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3114,7 +3114,7 @@ void set_task_rq_fair(struct sched_entity *se,
 	p_last_update_time = prev->avg.last_update_time;
 	n_last_update_time = next->avg.last_update_time;
 #endif
-	__update_load_avg_blocked_se(p_last_update_time, cpu_of(rq_of(prev)), se);
+	__update_load_avg_blocked_se(p_last_update_time, cpu_of(hrq_of(prev)), se);
 	se->avg.last_update_time = n_last_update_time;
 }
 
@@ -3397,7 +3397,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		decayed = 1;
 	}
 
-	decayed |= __update_load_avg_cfs_rq(now, cpu_of(rq_of(cfs_rq)), cfs_rq);
+	decayed |= __update_load_avg_cfs_rq(now, cpu_of(hrq_of(cfs_rq)), cfs_rq);
 
 #ifndef CONFIG_64BIT
 	smp_wmb();
@@ -3487,7 +3487,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_task(cfs_rq);
-	struct rq *rq = rq_of(cfs_rq);
+	struct rq *rq = hrq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 	int decayed;
 
@@ -3548,7 +3548,7 @@ void sync_entity_load_avg(struct sched_entity *se)
 	u64 last_update_time;
 
 	last_update_time = cfs_rq_last_update_time(cfs_rq);
-	__update_load_avg_blocked_se(last_update_time, cpu_of(rq_of(cfs_rq)), se);
+	__update_load_avg_blocked_se(last_update_time, cpu_of(hrq_of(cfs_rq)), se);
 }
 
 /*
-- 
2.9.3.1.gcba166c.dirty

