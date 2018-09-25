Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4208C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1CE20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CasFVd6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1CE20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIYPY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:24:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeIYPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:24:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so12836338wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=losYyGOJDEM/XPg/N3zcbVczQF60rRLzWGnSh8DVG1M=;
        b=CasFVd6+Fgx1Cu0UHT77TWvNAwYqE2yD1pVEELrgnXaRF9JEWwbFYuqYaoRws8P2lJ
         +XFH3L7etVxc2qHdscZjK5rYiCQ0MoxLzJiW0uXQq3/GxpOumTKO91J+Fm6t+iZ+GcGE
         cehe/4UjC57vvEdOlcoag5TB13wI3IK/XEZxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=losYyGOJDEM/XPg/N3zcbVczQF60rRLzWGnSh8DVG1M=;
        b=sAwmlGzBTH26x/79MdG5sWWIXsPjkFmCt3FJRbOMO5i9q1GmOeXoq5lqzG9m7Pb4DO
         7VvCwVYWCrQwXFm5xa8lTNft1VYjeEBolYVYcYUPGKRdumuD7PHo/6L8EWEuR+LNmbeg
         2hdmf6F9csBMB6R5zD+dHC1JkC6Q++FbjfFArETW8f6IpnulvmdGM7DE1UQMTXlR9xTV
         2xZYe5T/yBS2TlaoSMC3D8pScQ249I1FbqcJut6rk/WXTCvBw8vz4t3cw5RL1wM23cCq
         wHMTgDYd8VAcyoB7tzW8ya7KBAOkGW8cCx0HXL7wOSf+4o0aPoUdZfj8LI3hsbwIfcSZ
         aDsA==
X-Gm-Message-State: ABuFfohb8BDnaW5YSbS7RYqr+aOA/0iK8LzweOumVYwyVpzUjOdMxHFa
        jKTO1GrxaPNADnMdCxBZWzpMzgBbJWA=
X-Google-Smtp-Source: ACcGV62DDwDcKHsYt2vw0fzLnTiqQWbO6TVVD2cyslyaFMC4nA3NTYjx8YWf3RcaVEoD0+lOZ2NMiw==
X-Received: by 2002:a1c:dac7:: with SMTP id r190-v6mr79750wmg.137.1537867070352;
        Tue, 25 Sep 2018 02:17:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:2036:ba06:388c:5f31])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1399149wru.42.2018.09.25.02.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:17:49 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     miguel.ojeda.sandonis@gmail.com, bp@alien8.de, dou_liyang@163.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: fix warning and cleanup irq pelt config
Date:   Tue, 25 Sep 2018 11:17:42 +0200
Message-Id: <1537867062-27285-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a config for enabling irq load tracking in the scheduler.
irq load tracking is useful only when irq or paravirtual time is
accounted but it's only possible with SMP for now.

Also use __maybe_unused to remove the compilation warning in
update_rq_clock_task() that has been introduced by:
  commit 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")

Reported-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/Kconfig         | 5 +++++
 kernel/sched/core.c  | 7 +++----
 kernel/sched/fair.c  | 2 +-
 kernel/sched/pelt.c  | 2 +-
 kernel/sched/pelt.h  | 2 +-
 kernel/sched/sched.h | 5 ++---
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2..317d5cc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -415,6 +415,11 @@ config IRQ_TIME_ACCOUNTING
 
 	  If in doubt, say N here.
 
+config HAVE_SCHED_AVG_IRQ
+	def_bool y
+	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
+	depends on SMP
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	depends on MULTIUSER
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..bf7b745 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -135,9 +135,8 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	s64 steal = 0, irq_delta = 0;
-#endif
+	s64 __maybe_unused steal = 0, irq_delta = 0;
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
@@ -177,7 +176,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6bd142d..2c05aac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7249,7 +7249,7 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
 #endif
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0..48a1264 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -358,7 +358,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
  *
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index d2894db..7e56b48 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,7 +6,7 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
 #else
 static inline int
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a4ef8f..f3477e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -861,8 +861,7 @@ struct rq {
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-#define HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
 	u64			idle_stamp;
@@ -2222,7 +2221,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 }
 #endif
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
-- 
2.7.4

