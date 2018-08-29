Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B46C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98642084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+wbfEvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98642084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeH2RQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:16:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32841 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2RQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:16:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so4496750wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RP6kCwNOibKOgIJWhXXcFj4YF7N90rBS1ViaOhyM7Zc=;
        b=h+wbfEvgSC+cDZM+1nbd8aw0c8mIYYeTysKD+8GGjLD2gzzkyY6TbfGpCTquRCCViC
         u0rLLyLhUksnOD3YEBDOORY6wa13HwPIua84iQ7ai0W/tXRWggFerBhk0HJmk1WDvebW
         vtib+KMqTL3+uvEGt8AeQ+I+SXV9DKTHbb91g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RP6kCwNOibKOgIJWhXXcFj4YF7N90rBS1ViaOhyM7Zc=;
        b=MjW3Kl4unUAa9GRmSU1ai9KBipSB+rIwNeaYt21qLi6I7Uh8pmcowUFlOBB336s4Ya
         WGLMU0ZhpdmYfs8zVvGhI3A8GWVm11sDa1bdXHvYBidDFG3mA5/0MdnfCdm2rlnTQoqV
         bziMgDh17+618DBIwjzZQI9DwmL8WQ18nziDRQubRhbw/BRD67uLLgqIlIapaRv0gDPU
         UcK2MYrzuUb7fGmm4NzBpgvekHFDHddxgEQpcHzsyBGp6CATYleVh2ASf86aU4WczXbf
         WKWBJvLlPLvAO672sVxfsFUljhvOgSXg8dS4Lrm3ei/hlFmjrYqu8oITZmfet+IbL0WY
         6BfQ==
X-Gm-Message-State: APzg51ACrzVxfWmlgxq+uB/QBS7NFsoaHFwH2wJj5yuNdTrTCyGF++/2
        aspq0isnV/+ga53gr/auFip/Qw==
X-Google-Smtp-Source: ANB0VdbRX96Vpzkeu8L7VA8UMULheHBNUADyB/pzpXyOvyYYVJO4WfXl87N3l1BYAIlikudLb9rnDg==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr4119018wmf.115.1535548761059;
        Wed, 29 Aug 2018 06:19:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id a37-v6sm9532723wrc.21.2018.08.29.06.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:19:20 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/4] sched/numa: remove unused nr_running field
Date:   Wed, 29 Aug 2018 15:19:10 +0200
Message-Id: <1535548752-4434-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_running in struct numa_stats is not used anywhere in the code.

Remove it.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c2b8bf4..cff1682 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1454,8 +1454,6 @@ struct numa_stats {
 
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
-
-	unsigned int nr_running;
 };
 
 /*
@@ -1469,7 +1467,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
-		ns->nr_running += rq->nr_running;
 		ns->load += weighted_cpuload(rq);
 		ns->compute_capacity += capacity_of(cpu);
 	}
-- 
2.7.4

