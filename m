Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD22C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D93620874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t6auXQDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D93620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756106AbeFSGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:34:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34698 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFSGeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:34:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so10396478plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vYm79VAUitHC3cX1Dn2t4UMwjK5wJvxtsHjQGVTlMT8=;
        b=t6auXQDSGptYtUSIJ9+UrwBXkCYU5nm+XE6mn2iKVx8yhY8N4PpPn9iEq6WW/hFOwc
         /sdvio1tn4QpxdZfw9mmi5t2eVtO85bY0iA7FaxlQndm2CwwrJ/pZLrVT/JVYig2ep+6
         MbKZe0kUShqWYhiYPaKiZcMffBomQvnwCBoMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYm79VAUitHC3cX1Dn2t4UMwjK5wJvxtsHjQGVTlMT8=;
        b=iNEgIrYizzC2V9R6QNvKRRyYT96cOBfxmGBtJcyllErJbDqX4JKEu7E5ttW5zCgX6y
         Jrq2fnrlw66LmZMmMYiJdoC2R3JgGCdrjmEKcfhnjdLZS3sOUR5JNMuy9pz/GQsS3PdM
         MioeUyCJgTW4oLqm+boTiRb5+AMDGH2Wsq2euo0UajuMiVggEn2aL4D+ml3d3vCPJ2YS
         GcZyadDSKgII87gh2bozV+T/lUonm3NSSGD2mWe9dQnRt55+qmVktGMBFfAzOXHkS40Q
         E76pJITiWLjhj6kKyEpyVot6IfduPBqp+RcRIVI8WznoWXI9ZIgqXc6suXxO2niFoEOM
         Ik1g==
X-Gm-Message-State: APt69E2z0RxvxcKM10KsT16CTl3kxzwf2w1zV6VX4Bw48K3/2x17P6ZT
        NUHLDQl67wcmrbLETL/oFQox22fK6/U=
X-Google-Smtp-Source: ADUXVKKevBzTS5uVWHvGvZiuMFVaMu0xGPy5R/9CriyFNH3ey1ueDzLMFDdZX3+pzCEvdPduPaqdDg==
X-Received: by 2002:a17:902:b683:: with SMTP id c3-v6mr17435664pls.158.1529390062260;
        Mon, 18 Jun 2018 23:34:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k12-v6sm5024784pff.31.2018.06.18.23.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 23:34:21 -0700 (PDT)
Date:   Mon, 18 Jun 2018 23:34:21 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 1/2] rcu: Assign higher priority to RCU threads if its
 rcutorture
Message-ID: <20180619063421.GA221670@joelaf.mtv.corp.google.com>
References: <20180619062215.221564-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619062215.221564-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:22:14PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> rcutorture's threads are equal priority to the default RCU kthreads (RT
> class with priority of 1).

Sorry for the weird subject line, I meant "rcu: Assign higher prio if
rcutorture is built into kernel". I have included the patch with the subject
line fixed up below (if you prefer to take that instead).

Also one question, incase rcutorture is a module, we can't raise the priority
of the kthreads because it would be too late to do at module load time. In
this case, do you have any ideas on what we can do? I was thinking we can
access the kernel command line from within rcutorture module and check if
'rcutree.kthread_prio' was passed. And if it is and isn't sufficiently high,
then we avoid testing boost feature at all (and print a nice message telling
the user about the issue).

OTOH, we can just let rcutorture module loaders fail the test if you feel
very few automation tests do the module loading way of rcutorture and so a
boost test failure there is tolerable. For me, I will likely be running
rcutorture only as a built-in so I am Ok with not special casing it within
rcutorture.

thanks!

 - Joel

-----8<---------

From 8cb7c2ac98e510abac35fdf2419a3212a587095a Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Mon, 18 Jun 2018 15:13:10 -0700
Subject: [PATCH 1/2] rcu: Assign higher prio if rcutorture is built into kernel

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

