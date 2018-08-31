Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C36DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F341320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLdm1o3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F341320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeHaSGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:06:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHaSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:06:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id o37-v6so11315188wrf.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P/2PE9fwa3N0IyuSfjUhgXsWHAdCpdTQgP8rRp1wPbo=;
        b=PLdm1o3YV6tpIAB273/DtHdIpZoARxib7r+5+fw4WbAflOkQi5tqxq2AOwTNPtxF4h
         ALTxTnoo3OhsShjFWeVmpinZf+eBG4kuhG0etUQP9hx3uN0CWwOXMxJ/38XqfTXE6oP7
         RK2QIURdxUD0xBjqOF9JeSp/SHr/5DR6csL5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/2PE9fwa3N0IyuSfjUhgXsWHAdCpdTQgP8rRp1wPbo=;
        b=R+jKlAMiWp/z8lz9eyXRBjeV9KnJF99bIFgS4nnlA3y+qCf0bPRZCeEW0imWjdKKYQ
         VrvtDjRjAK6L6iPAtM7Dc+FaJBNjTObQNGOtX1si8teKU0xyvBIsrWr8UapvJwd9JSmh
         fQv3QdHM8yxJJBJiVW+JaFyMumzELz9/SOcFaLnwfytq7hG9ss8wdfVQUtRYI6kQjENi
         TNW6XXKlTqeeIqDe9Q8T0Yk5Ykl0gaF0V4QAtk1kHNmHud72h853Xg2R3TptwXzej8qC
         KgKhPsy0z3ZGDa7OJDoMuyN+Th9+DL9kGlTxpTFY2xRSLEEm47KhdiLRZ9AZejPfkj6X
         ekvQ==
X-Gm-Message-State: APzg51CdHtyM3khkdl0+oC5cqmVDQZywb47W8Htpsv7drJ40IBZsyhWN
        CPPpC5+gJBBF2c5wYqNGcjLVhw==
X-Google-Smtp-Source: ANB0VdZr4bCJO8TeRiTRqDujAPoEoXaQKbKJ1+RYliyG1LcAe4aw+94Mdz75UVnn3Nj0wyYIbQmCRQ==
X-Received: by 2002:adf:fd90:: with SMTP id d16-v6mr11341233wrr.276.1535723917260;
        Fri, 31 Aug 2018 06:58:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:840f:e0ae:74c6:97dd])
        by smtp.gmail.com with ESMTPSA id q21-v6sm5090217wmq.3.2018.08.31.06.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 06:58:36 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: fix update_blocked_averages() for dl and rt
Date:   Fri, 31 Aug 2018 15:58:28 +0200
Message-Id: <1535723908-10779-1-git-send-email-vincent.guittot@linaro.org>
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

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..a1babaf 100644
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
-- 
2.7.4

