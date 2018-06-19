Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D1C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC7C2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WCOhSCEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC7C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757416AbeFSWOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:14:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36557 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757390AbeFSWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:14:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so496616pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z5FylTl1GKpHMD8KXZY7XMXKtWuyXYtYBR5x2vz5c9w=;
        b=WCOhSCEPfmvuW5rWS6/f4KnAmb1JdpjmCE/a10dukHfBNEuhEslGt+QV/arV40ZDz/
         lajcQAC5EsFylTSh0suENMZFy8/LkpkaGAuI8d96Zdfl5SU5W/puzX/LjvzWnVZv4osy
         rti8YcgRhMlVsR1axj/Pxst3ZxU2OABbLfYPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z5FylTl1GKpHMD8KXZY7XMXKtWuyXYtYBR5x2vz5c9w=;
        b=qNAW2ECgk1uLLPFglcgMJC4qdZJUrUhz3Ispmyz38WBsTz6JKK96bYq0wp6sLAGXJV
         QQPa0iblJpAKXzP+xs9SvnQBd/RR9uWF7gcV5NtbE05+u/Rv3+swv3m7h9v2tJ+ErbEM
         J+NY8quNEFJxDFo9yAB/F6wmFbHVuJAt0xvq46Gkgnx1UvlEuitg8bt5S9mciamFkSVa
         itsqrY2p6yzWettb0NzrObkfkGi1LtanNMUXSdqhMhZrAcWhTlb0IRXH8oLAKUalIR+2
         RK+LQXzWI0PudIjCqXCxD7JsyBjNFxa+5hhAEE+tjJSCfx2kdJRyQLaa5QpOk6PNRxgm
         pTZg==
X-Gm-Message-State: APt69E2f9CJdnb/aDyr+nVQ1qmS5TI8AveSvV+OAYqDZCawBJhNRYiQu
        Ke8eEYNLD3hm7qO5qhiRW6Xgxt4xxYY=
X-Google-Smtp-Source: ADUXVKKGJkFDNNqrtO1pf2iFnCL8sxTOStLBp2+CBcf5BxD3aSB19V8dWPYtgHZL7RU1wIfTyt2QTg==
X-Received: by 2002:a63:6ecb:: with SMTP id j194-v6mr16598623pgc.158.1529446466775;
        Tue, 19 Jun 2018 15:14:26 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n85-v6sm841389pfa.146.2018.06.19.15.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 15:14:26 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/3] rcu: Assign higher prio to RCU threads if rcutorture is built-in
Date:   Tue, 19 Jun 2018 15:14:17 -0700
Message-Id: <20180619221419.41340-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
rcutorture's threads are equal priority to the default RCU kthreads (RT
class with priority of 1).

This patch checks if RCU torture is built into the kernel and if so,
assigns a higher priority to the RCU threads. With this the rcutorture
boost tests pass.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508be923..92c29439eba6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3884,12 +3884,16 @@ static int __init rcu_spawn_gp_kthread(void)
 	struct task_struct *t;
 
 	/* Force priority into range. */
-	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
+	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 2
+	    && IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
+		kthread_prio = 2;
+	else if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
 		kthread_prio = 1;
 	else if (kthread_prio < 0)
 		kthread_prio = 0;
 	else if (kthread_prio > 99)
 		kthread_prio = 99;
+
 	if (kthread_prio != kthread_prio_in)
 		pr_alert("rcu_spawn_gp_kthread(): Limited prio to %d from %d\n",
 			 kthread_prio, kthread_prio_in);
-- 
2.18.0.rc1.244.gcf134e6275-goog

