Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4007C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684DF20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2XUrtgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684DF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbeHaTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:31:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40766 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:31:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so5683838wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aLyoDtzvDZ2u3fmB+LGivek917r5FP0y2AfAab0oyKI=;
        b=M2XUrtgFid1D1ts2wY2m+60sTmbmPr4PnTY4AWK3FN16dk+QAqOuo7mdE5pNl0PqBg
         gz/mPkwjMwxqOCbPOnqbhyvmXYsOBwgZn/PHqUzWaiPF836Py9U9YmrBEPSdzQqdLIB6
         PY+cN/788JnYpWKA/Z8+acsteKMRbMSAHpnu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aLyoDtzvDZ2u3fmB+LGivek917r5FP0y2AfAab0oyKI=;
        b=Dxp107XkScvZVEn4AUCZCeNMnsHQj27KjvQV2JAxCFIjOs4BO6ySifEWSEw1fPZ9e5
         rH6KPFId0oPy5wyPs8WDY+j6U5bfvejQJwtsQ5SyYGgh3ahrWyKpImMGEteRioDUHQ5E
         ZXlPicoVInrHa3DkGkeTDsXMssRVJCTK+o2pml9K2pd0dvovruvo2N6wWlXig5DMUXuJ
         AtnM0RW57hX2g30mm4QZpV/I5EA6DJkH2a59j1gcazBg9uvAbDgAKsVwjg0Zh6RZqvQe
         wdYNJ/hZcUTr9nU738EZAnouvVdwhSEwldS91qnDTUCFdtRfd1z8K/lb5zGRLudOaIEJ
         Hm8w==
X-Gm-Message-State: APzg51Cb5oFBbKlUpL8SRIgMqQPkUdHBlLWPhb1FFor4ioRwk59yJ9W9
        Tlliuk4coVueq/nxj2e5twk8Mw==
X-Google-Smtp-Source: ANB0VdZ7TU5BUE2XUQti/kMPJeUwKUYyRiIBjIbEryNnJFhjNOuPf1xpA2M7KFOBXvhjJoJnS8sRSA==
X-Received: by 2002:a1c:8145:: with SMTP id c66-v6mr5283842wmd.139.1535728981504;
        Fri, 31 Aug 2018 08:23:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:646e:b7c4:ab5c:bee7])
        by smtp.gmail.com with ESMTPSA id z16-v6sm8639449wrq.78.2018.08.31.08.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 08:23:00 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/pelt: fix update_blocked_averages() for dl and rt
Date:   Fri, 31 Aug 2018 17:22:55 +0200
Message-Id: <1535728975-22799-1-git-send-email-vincent.guittot@linaro.org>
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

-V3
  - move rq->curr dereference under the rq->lock

-V2 
  - Add missing fixes tags
  - apply fix to other version of update_blocked_averages

 kernel/sched/fair.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..53bbcd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
 
@@ -7298,8 +7299,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7364,13 +7367,16 @@ static inline void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-- 
2.7.4

