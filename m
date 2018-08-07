Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C536921885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVUMaxLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C536921885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbeHGSLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:11:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46218 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeHGSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so16230385wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dwnEuOfvwkhUPwkhLMArV3ygXldRpqW8K54UcT0yLyM=;
        b=JVUMaxLVKtdy9L0fArqR+35obj9iXp7E7CdS9ozqBjeFJxQOjxwc9cHSmLAvR9Rjwo
         fiEO7XmM22XiDcweeGF6JP9zyDBIXQMM/5kkH2KzGr/bHAF8/EMYiAvGZSrLVYDj8RsB
         1XRiHElueUJmIBPBUm8eZKbpp5nsFBy/IQwZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dwnEuOfvwkhUPwkhLMArV3ygXldRpqW8K54UcT0yLyM=;
        b=Xp3ZJrM6Oe7UQ6oyi323XYW9Z0EPjsMyEA+eUOBZOlfnzaQVW/BljwYDudNMAZC//W
         46EQi6LT5YhMpy2yxuqq8SbWPkhw3DUQJRkAvo5wbEieMfFJxWES1AEQylJ9zBZxYvNU
         BEEmDy5we+Xyr/JlsSZuTfLgO+1Ni13fD3TtpulIPzhMWUA+uJS2iJz7QH7qfjReaeOD
         OL1vpeE9iowRJkOAAxksOrtG5ub+0RifsGEOPZTea30PGrne+iuA/cxvlfPkQLRhkIdB
         IlyX36x9iobBBT4chGITY+mF/+1gl47O+XxBVf0zvoE07aLddwhQVGxsPwLAlg4Mn9bQ
         YHsg==
X-Gm-Message-State: AOUpUlGvnVKRL4tC9jYVY/hwusp6Ue56W/RCJjft9yxGpWB1uCOo9Q0j
        ii9pmwcoyqNvCWNdCYwE3cfLqw==
X-Google-Smtp-Source: AA+uWPzB0R4E8FOJG0Lfh4WfFzXmq0cosB+eZgPZSAbboNpTUov7Qmp0J3Z44BeE8R9ggUKL44P/SQ==
X-Received: by 2002:adf:8b1e:: with SMTP id n30-v6mr5019651wra.282.1533657394648;
        Tue, 07 Aug 2018 08:56:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:41ad:95bb:4cb8:621f])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2903644wmd.1.2018.08.07.08.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 08:56:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/3] sched/fair: fix rounding issue for asym packing
Date:   Tue,  7 Aug 2018 17:56:25 +0200
Message-Id: <1533657387-29039-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When check_asym_packing() is triggered, the imbalance is set to :
busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
busiest_stat.avg_load also comes from a division and the final rounding
can make imbalance slightly lower than the weighted load of the cfs_rq.
But this is enough to skip the rq in find_busiest_queue and prevents asym
migration to happen.

Add 1 to the avg_load to make sure that the targeted cpu will not be
skipped unexpectidly.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..c376cd0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7780,6 +7780,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Adjust by relative CPU capacity of the group */
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
+	/*
+	 * Prevent division rounding to make the computation of imbalance
+	 * slightly less than original value and to prevent the rq to be then
+	 * selected as busiest queue
+	 */
+	sgs->avg_load += 1;
 
 	if (sgs->sum_nr_running)
 		sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
-- 
2.7.4

