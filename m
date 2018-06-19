Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B22C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qujezV51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFD120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965352AbeFSGWl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:22:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32863 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755856AbeFSGWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:22:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so9832153plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i/euKh4aL5QYt5ujsp73zYpWHKN8Nyt1smtc8AQstlg=;
        b=qujezV51CxmG1GNjIuGXJCVg7JJe9IGT+xB+az9xc4yqxXhPtdiLD1Cp83OzCuQg7+
         8ZIivYa/zJGM4Re+AOT37Nu8J4txQOxcWdVb7p6L6p5hWhLCB4SrrhC+TjP9tddOHWqR
         85+iN8oSCjNf06t0ksd2X3p2H9qQ5Z0GHbz3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i/euKh4aL5QYt5ujsp73zYpWHKN8Nyt1smtc8AQstlg=;
        b=OfaN6kV6G1njC3TxisVb02GCVVOEDRZ+NSjItrKpkhKOpVIHea8AUFwCVSbg8DEetf
         lq6d5HUusMlzska2AAbhDF97Lfsuw6Llc5RKbjW0xOyE5oD51sSzjrlHhnbhqZ2GWpPa
         xud9P01lXbmKruLBMjPQ2vojo1xYtCdEJIQkQJlTQpwAcChbKwsQkeI3WdwkjGMNorjb
         FUmoPJfn9zfGgEhbBoIx36lwyI/83C0Xkk8d7zA1Ksm9cLo+i8WHdVivRezAdZgmz7Vm
         R/s5DOtMakca9uvA3X4bL5g/8/r0JfVSF0JUtNMRCrdxZHN95HynkKS30rkKp2jyKelV
         n+fw==
X-Gm-Message-State: APt69E0kp/l85Mrp8cDGyoojhEvWxs3dQ80eydxn+yqgcsHP2hF15n5A
        4CfSXIWRtUiNUfLO855o+6rU0EHIO3c=
X-Google-Smtp-Source: ADUXVKIG7VMXMC8LCL4eTKCZeYldP5BJHTM+Aj1pj54NIonAM/fODKuvXQIEPVa4J9iliUarZXeZIg==
X-Received: by 2002:a17:902:7e42:: with SMTP id a2-v6mr17249563pln.151.1529389357673;
        Mon, 18 Jun 2018 23:22:37 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id z19-v6sm19564858pgv.12.2018.06.18.23.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:22:37 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: [PATCH 1/2] rcu: Assign higher priority to RCU threads if its rcutorture
Date:   Mon, 18 Jun 2018 23:22:14 -0700
Message-Id: <20180619062215.221564-1-joel@joelfernandes.org>
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
 kernel/rcu/tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508be923..a141d6314622 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -171,7 +171,7 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp,
 static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
-static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
+static int kthread_prio;
 module_param(kthread_prio, int, 0644);
 
 /* Delay in jiffies for grace-period initialization delays, debug only. */
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

