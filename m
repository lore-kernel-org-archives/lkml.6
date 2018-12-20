Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC21C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6QXsA9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeLTHz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:55:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40356 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbeLTHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:55:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so672204wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GFGQxWT3ZkEUOWnk0RCrGbiQU0QOjbOOWUD8Wmo9BcQ=;
        b=M6QXsA9GWl6z9aR19FVXi3McuENNUYA2mQI0RT0Wu8F7sLfqbugsdusqdeKEQubqI1
         hmoEgkK7yi5g6YMv7TuV3IelnjeUTunVmnIodiPykfacP+69Ii9pk5hrMa7whyGDXMga
         DI3qV+LXm5IY/DnowtZtFkKSlSCgV0ZvAE9mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GFGQxWT3ZkEUOWnk0RCrGbiQU0QOjbOOWUD8Wmo9BcQ=;
        b=QGyt98rOgrvXD/RZPUV0b7bF8himF2Tr2EPUjNNdG0/ziXLk0849xhFL89u+XzHbs3
         Tryt2BuWDx63cjTstf1igdriwuCK4BUV4nBBknw0cejOX++u3l39dTl0JKQ29Tad8OMQ
         5zwffb2xktjpaDj7IXSLtvfF5mkbTCQHvKlZwhSd2Xmj6fc/63xcV5qJTCphOcuuzI5l
         bcLEyML5nRB+X3reyRD5FrgwjW4wjER0xcoSExypHUbuJkApkmrlShuDtMUrkMXQTH+Z
         o6yRyjwuqk/oUgtoumZqVTkIYXIbXHmKHx0dqH5TI2vSwMmf8K+EkzMbqCNQMV06tmi4
         M0bQ==
X-Gm-Message-State: AA+aEWZYTUqaWcrRhB1/GKzU6gcDJcLEiCiC6EZnTtgt8k7n8yESjKuq
        ArVdk0IWIY+vhSYwxnxNuFlk4g==
X-Google-Smtp-Source: AFSGD/X+BbyXjZnabGs+P1nNnEBQL5bQS/h0T0FHYPnKLTXhFrc7qMOysOhrzVR0TcivU8KETEpO5g==
X-Received: by 2002:adf:f390:: with SMTP id m16mr20794134wro.71.1545292551921;
        Wed, 19 Dec 2018 23:55:51 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id c10sm8773299wrw.49.2018.12.19.23.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:55:51 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 1/3] sched/fair: fix rounding issue for asym packing
Date:   Thu, 20 Dec 2018 08:55:45 +0100
Message-Id: <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When check_asym_packing() is triggered, the imbalance is set to :
  busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
But busiest_stat.avg_load equals
  sgs->group_load *SCHED_CAPACITY_SCALE / sgs->group_capacity
These divisions can generate a rounding that will make imbalance slightly
lower than the weighted load of the cfs_rq.
But this is enough to skip the rq in find_busiest_queue and prevents asym
migration to happen.

Directly set imbalance to sgs->group_load to remove the rounding.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca46964..9b31247 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8476,9 +8476,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
 	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
 		return 0;
 
-	env->imbalance = DIV_ROUND_CLOSEST(
-		sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
-		SCHED_CAPACITY_SCALE);
+	env->imbalance = sds->busiest_stat.avg_load;
 
 	return 1;
 }
-- 
2.7.4

