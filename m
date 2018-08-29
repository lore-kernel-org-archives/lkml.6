Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F995C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D591B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQfcSDSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D591B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeH2RQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44388 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2RQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so4798434wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=myZ+tXdnhZIQMc2mbqEZMm0G4kQH/y2eGsmXNy1+iJc=;
        b=AQfcSDSJgJu23/p0HZUDntapwzg9r2cjzvtOHzV9SUYFJz85r6ErAThZjejGTCwKvI
         tKrBYEsqfXLmG5rf6xxf2r4dLEhYo2Fdot5Yh9j/DQP+vJZwCcbyy1OqUTDlggQmAb0h
         eb/pZaRpYAAu8BEUpw2tp53pqLs/c1tZP2cdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=myZ+tXdnhZIQMc2mbqEZMm0G4kQH/y2eGsmXNy1+iJc=;
        b=naHZgRBWzZxpUHB0y+rqpJ9i3NdMccHF3NemXE93INcCCvuV+HPsScMCu1HhI932g8
         lG6QrRznLwzmOqSHAiOL6f6BVlWECvbLSWnIkr3n9xYz6Kk8Ddy0hYc0tV2+uf08UHij
         3tiEUz6IxEP/ocWCZ+5YoQvuTNSEvCz3x2s3KnGT8jGyWUn3ebXLPGCsMrd17GVt6lzl
         /GHLbpWsSpGWHexjO0RueQt9G3eO8fj/2XksVpj2IiqiZnJ+p3tmqhjOvHx1G2ltWUmZ
         bLPsVYGTLfD+we5aeTXhtJVqs7fZp3rCY/hKDupI0NJM7SiJqx210Q7uUwqWAnBQvRQF
         7LHA==
X-Gm-Message-State: APzg51ABPab4S6f/dPCxQYNMnvf2+++4ZZlQE5P/3s1kmyKb7OOdn9Sd
        5qk+zfIZuffR5dy7aXq14Rj68g==
X-Google-Smtp-Source: ANB0VdaNWoVUn8mgG8vhH3UFjae5G5U6hk0U+V31W9Efletuwjp77GFO4gIqj85Spst1Xmf+PCMnhQ==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr4342512wre.13.1535548759793;
        Wed, 29 Aug 2018 06:19:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id a37-v6sm9532723wrc.21.2018.08.29.06.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:19:19 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/4] sched/numa: remove unused code from update_numa_stats()
Date:   Wed, 29 Aug 2018 15:19:09 +0200
Message-Id: <1535548752-4434-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With :
  commit 2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")

the local variables smt, cpus and capacity and their results are not used
anymore in numa_has_capacity()

Remove this unused code

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..c2b8bf4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1463,8 +1463,7 @@ struct numa_stats {
  */
 static void update_numa_stats(struct numa_stats *ns, int nid)
 {
-	int smt, cpu, cpus = 0;
-	unsigned long capacity;
+	int cpu;
 
 	memset(ns, 0, sizeof(*ns));
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
@@ -1473,26 +1472,8 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 		ns->nr_running += rq->nr_running;
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
-
-		cpus++;
 	}
 
-	/*
-	 * If we raced with hotplug and there are no CPUs left in our mask
-	 * the @ns structure is NULL'ed and task_numa_compare() will
-	 * not find this node attractive.
-	 *
-	 * We'll detect a huge imbalance and bail there.
-	 */
-	if (!cpus)
-		return;
-
-	/* smt := ceil(cpus / capacity), assumes: 1 < smt_power < 2 */
-	smt = DIV_ROUND_UP(SCHED_CAPACITY_SCALE * cpus, ns->compute_capacity);
-	capacity = cpus / smt; /* cores */
-
-	capacity = min_t(unsigned, capacity,
-		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
 }
 
 struct task_numa_env {
-- 
2.7.4

