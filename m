Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C24C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1B20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P51R3Air"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB1B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeIJThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:37:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40406 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:37:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so21632154wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RqdHfSwIcEGc3kFrm7B5Vad4LZFyOytY3dZqs4VyewI=;
        b=P51R3AiryVx8fCbjdAAVS7gGTWZ+8eh2KIvkGARbxTsiEcWajt7FDxvCC92Vl+49gc
         LtoTeUmQ0jZHslOph0+wmMGIc8TNENK4qUEI+5tTdzpK5zF8a5QA2N9QrgzCkiMsmZ0u
         Em0NVb9nHG32VChjdl8SSBfdhm2yBjdfqq7UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RqdHfSwIcEGc3kFrm7B5Vad4LZFyOytY3dZqs4VyewI=;
        b=DHLNIZuyfFp5Fr4Ip68Ew79aPK7iKNi0yB3YbAJUGgcFQ8M6MeXvR73CdpICd//B0X
         qGdFt1od0WabeYVL9NG1myDHs/zIlyvog2MejwGDyLhbfH98DSLuiEq1aO2h1e9L/09x
         B0NO1Wqk/UCv3LmxIpZlz3uCDrA/U/wKmoYMfEOSHIpGOU/WCpHFfe1R/gQRNo7wCKZ+
         L1L1XoBxPK+/FdWFUYfgY+RxbN431oaXBrPC5LaEfZZuUQ848pyv+q8rBUgnXdUzAy2V
         xfV/e4igDrU9791u5pjez+IBS5d7Mk0kX3uuGUH7KXwttx/O/frCbg+cZI0fOJQRV2Qy
         qznA==
X-Gm-Message-State: APzg51A/9LAfaDHAoxb1+DPIJrkExYsWVJRlVG5EBeRNybkM07xG+Odo
        o/SYRjEao86y5fRbsteUVKvaVQ==
X-Google-Smtp-Source: ANB0VdbMZDxqCIXHgl4v48c2mxY/QeK7UfanlpaleUlbvUMcKOcP/T/Fy7XeYdJhdUGaeo1cCOoSqw==
X-Received: by 2002:a1c:3351:: with SMTP id z78-v6mr990678wmz.23.1536590592854;
        Mon, 10 Sep 2018 07:43:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c941:dda8:ce1b:a47c])
        by smtp.gmail.com with ESMTPSA id 14-v6sm28174394wmp.32.2018.09.10.07.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 07:43:12 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix 1 task per CPU
Date:   Mon, 10 Sep 2018 16:43:09 +0200
Message-Id: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPUs have different capacity because of RT/DL tasks or
micro-architecture or max frequency differences, there are situation where
the imbalance is not correctly set to migrate waiting task on the idle CPU.

The UC uses the force_balance case :
	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
	    busiest->group_no_capacity)
		goto force_balance;

But calculate_imbalance fails to set the right amount of load to migrate
a task because of the special condition:
  busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)

Add in fix_small_imbalance, this special case that triggered the force
balance in order to make sure that the amount of load to migrate will be
enough.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..72bc5e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	/*
+	 * There is available capacity in local group and busiest group is
+	 * overloaded but calculate_imbalance can't compute the amount of load
+	 * to migrate because load_avg became meaningless due to asymetric
+	 * capacity between groups. In such case, we only want to migrate at
+	 * least one tasks of the busiest group and rely of the average load
+	 * per task to ensure the migration.
+	 */
+	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
+	    busiest->group_no_capacity) {
+		env->imbalance = busiest->load_per_task;
+		return;
+	}
+
 	if (!local->sum_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
-- 
2.7.4

