Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E24CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59822077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXs+pJm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59822077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeHaTER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:04:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46307 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbeHaTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:04:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so11460803wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TECpa/2gF2n1GH/OAQhZKAhBZaJkanG/OQBwuoOgloo=;
        b=DXs+pJm4UKBOfaDcbLfsn5HfhvdW+aNkdbXJiQcgzTUpfyGFqREYtv2W10ASywqi4t
         pmYy9nD1WEoCLVVMXx4M1F3/C7lgbet3+AbV9y2fVei53415XQMStB0pyfbVEPXkkYiI
         1FYKgoBtMsqKGZZg2chtv0AtjRYhwWUW0n9rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TECpa/2gF2n1GH/OAQhZKAhBZaJkanG/OQBwuoOgloo=;
        b=Q4Gwcth6mM5Jdh3nO2MSGDVfitpTxcsKIr44iTSk46UBM5CmdhXV4F9O64TVvayeH5
         7/tGyQzHdfpMrAqhRzauHYW0DdTzy8W3JRfiY/K3Af86z8xzS+f/1FsHom/q2/lHN0pg
         xgukD3tPkQGBLHhiLcIf+JzNqEMExvwXLlJ+O+VtW06kttiGTtYZGPrrFg4fRa63S8Ks
         CevqlIP4VTjtrlYUChJDXv3YLf3Tjtou4cF7Pyw9gA+mHVLPwsEFeMdicK7GcQMqqqrW
         ZjFEjZNl7Avx9mBfdrbsIGQJ7FR43y0BEjWnJOtU4XqKZsUkgvQKImM4Xa7WTMjekO0X
         sbBg==
X-Gm-Message-State: APzg51AQV/8Ueisqm6VupQKt0QmebJeZatg8hgZAIu9an+CFGIYzlvlo
        eFto/oAbNDdIzaGCEzqFbAVWMA==
X-Google-Smtp-Source: ANB0VdY2spOUAeI9hv5VQzIdaA3z1vLhIWizyVFDE7HMnaZwodlHTexBc+3GwrCe4Ey/1gygbtsMOg==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr11406666wrt.210.1535727384139;
        Fri, 31 Aug 2018 07:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:646e:b7c4:ab5c:bee7])
        by smtp.gmail.com with ESMTPSA id q16-v6sm8914348wrw.2.2018.08.31.07.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 07:56:23 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/pelt: fix update_blocked_averages() for dl and rt
Date:   Fri, 31 Aug 2018 16:56:19 +0200
Message-Id: <1535727379-17133-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_blocked_averages() is called to periodiccally decay the stalled load
of idle CPUs and to sync all loads before running load balance.

When cfs rq is idle, it trigs a load balance during pick_next_task_fair()
in order to potentially pull tasks and to use this newly idle CPU. This
load balance happens whereas prev task from another class has not been put
and its utilization updated yet. This may lead to wrongly account running
time as idle time for rt or dl classes.

Test that no rt or dl task is running when updating their utilization in
update_blocked_averages().

We still update rt and dl utilization instead of simply skipping them to
make sure that all metrics are synced when used during load balance.

Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

-V2 
  - Add missing fixes tags
  - apply fix to other version of update_blocked_averages


 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..bc1de21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
+	const struct sched_class *curr_class = rq->curr->sched_class;
 	struct rq_flags rf;
 	bool done = true;
 
@@ -7298,8 +7299,8 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7364,13 +7365,14 @@ static inline void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
+	const struct sched_class *curr_class = rq->curr->sched_class;
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-- 
2.7.4

