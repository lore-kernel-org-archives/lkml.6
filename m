Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278DAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DAC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qlASG0pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DAC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbeIHCZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:18 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:13024 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeIHCZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536356543; x=1567892543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cf6O7A8NHGLrfGEVJAMW4eEXGii83rNsKysJ+20CSh4=;
  b=qlASG0pkfKr09pQsuB93INLzXPYOi7yandT2mcOtXhPRljG4wGX46hm6
   fOUasJInszq2D/jvl+sokh7m7QhCyDaZnNkGz5ib0/XppdMICfygT9Mrh
   //XMnb0ks9eLYwHiG8z5LM1NlmhPYFZpkqVM2sxFZzZbv2/u3WCxJQAv7
   w=;
X-IronPort-AV: E=Sophos;i="5.53,343,1531785600"; 
   d="scan'208";a="361243196"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 21:42:22 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w87LgHxB023819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 7 Sep 2018 21:42:19 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id w87LgFrp027493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Sep 2018 23:42:15 +0200
Received: (from jschoenh@localhost)
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Submit) id w87LgE4q027489;
        Fri, 7 Sep 2018 23:42:14 +0200
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC 31/60] cosched: Don't disable idle tick for now
Date:   Fri,  7 Sep 2018 23:40:18 +0200
Message-Id: <20180907214047.26914-32-jschoenh@amazon.de>
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

Coscheduling relies on the leader to drive preemption of the
group when the time slice is exhausted. This is also the case,
when the leader is idle but the group as a whole is not.
Because of that, we currently cannot disable the idle tick.

Keep the tick enabled in code. This relieves the user from disabling
NOHZ and allows us to gradually improve the situation later.

Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
---
 kernel/time/tick-sched.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5b33e2f5c0ed..5e9c2a7d4ea9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -861,6 +861,20 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
+#ifdef CONFIG_COSCHEDULING
+	/*
+	 * FIXME: Coscheduling relies on the leader to drive preemption of the
+	 *        group when the time slice is exhausted. This is also the case,
+	 *        when the leader is idle but the group as a whole is not.
+	 *        Because of that, we currently cannot disable the idle tick.
+	 *
+	 *        Short-term, we could disable the idle tick, in cases where the
+	 *        whole group is idle. Long-term, we can consider switching
+	 *        leadership of the group to a non-idle CPU.
+	 */
+	return false;
+#endif
+
 	/*
 	 * If this CPU is offline and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
-- 
2.9.3.1.gcba166c.dirty

