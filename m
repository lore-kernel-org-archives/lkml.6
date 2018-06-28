Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F10C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808BC2762F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJGMcBNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808BC2762F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030245AbeF1Ppn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:45:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46569 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030230AbeF1Ppj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id t6-v6so5987972wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJYZdlqUxsEPbpnWuEmMYmdnaFoz3y9OMFnGg+MT9Uw=;
        b=WJGMcBNqZMU7HTVsVxDfPiQLDJVd5BAZLNqCo4GszX70olJDn87dGpOPzCdn8a6RxO
         wyJBCKOO87/Xvs+CVuBeWAcNtNJLfKmo0FOr9YouWH+ol4xccWG3Az5JwVghw7FhOp5a
         k/Mj/SlXXPUc8asrxXzva7cFdVdSYL6ByO+/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJYZdlqUxsEPbpnWuEmMYmdnaFoz3y9OMFnGg+MT9Uw=;
        b=gSe1DQCF8oSkyrtnT2np5TH30f7LwGZFxUIpgBxGmfvi1O1e5yLP+w9vU8Kd7oz+1d
         MQg8fOJZrNGNGrlyCB8ieVRlBTIsjKvlI/sgQYoruPAEmXOXRiD9ePS0pJxLjxVe2f7s
         xZfgjqYtLaVa2fAWdIBudu9qzbnaugY3KRdExYedX32/q1wiYT1heEvzUBvWbgXeIv7O
         32kLRrvExUr7W2soeGhgFUCJqHRpwelc/VgE1Xt4pQ6k4UYYnh4L5XdDzXx5T4u+1WrQ
         c93Bf/uO8BBsL6NDtAQFWdT8GTunGMOdGe8DCUm1rbFnmXFtwZV3+OBcGb5o/GES/4QB
         UNaA==
X-Gm-Message-State: APt69E3KsRjU3LfzI0yh93qXsLB/EFc6vKQYfx3EmwoDrYbLTu8QVBpL
        CGHMfIzte0Tfzdoyp28oAz/CBA==
X-Google-Smtp-Source: AAOMgpeHTyeaU4Lvr3P2TrbX6HC/RQCZVJQjNyMubrzE7Y/yU2L8ItVMQHt2Q2dvmraOY9oFn9cfmA==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr9353815wrc.40.1530200737983;
        Thu, 28 Jun 2018 08:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:37 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 11/11] proc/sched: remove unused sched_time_avg_ms
Date:   Thu, 28 Jun 2018 17:45:14 +0200
Message-Id: <1530200714-4504-12-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sys/kernel/sched_time_avg_ms entry is not used anywhere.
Remove it

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/sysctl.h | 1 -
 kernel/sched/core.c          | 8 --------
 kernel/sched/sched.h         | 1 -
 kernel/sysctl.c              | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a151..913488d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -40,7 +40,6 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-extern __read_mostly unsigned int sysctl_sched_time_avg;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9aae7f..6935691 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -48,14 +48,6 @@ const_debug unsigned int sysctl_sched_features =
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
 /*
- * period over which we average the RT time consumption, measured
- * in ms.
- *
- * default: 1s
- */
-const_debug unsigned int sysctl_sched_time_avg = MSEC_PER_SEC;
-
-/*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c71ea81..47b9175 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1706,7 +1706,6 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
-extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2d9837c..f22f76b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,14 +368,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "sched_time_avg_ms",
-		.data		= &sysctl_sched_time_avg,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.7.4

