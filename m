Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD9BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBEF2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2i1qfhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBEF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeIGUVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:21:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38770 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:21:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so15041116wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TDIYKfs/DFRXrdALwFO9VHbg9/a0LdJU7lrBgi2IlTs=;
        b=O2i1qfhKG8SnezN2vuoqeCYEYFnd1MsTN676IVqD9jELHPXaFE2Dl44pQiqozpgcNK
         pyi65e6JLJp4iDfIsLkrL4UEUCUL0W8iSFHUQftfOZqmSPGqVFfil+S4eoDCloUzE2+R
         dJ8oU2D0WUnt5C8F+U9lL9st+WH/x5WjksMaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TDIYKfs/DFRXrdALwFO9VHbg9/a0LdJU7lrBgi2IlTs=;
        b=nZjmhveUfCMMxeII8C/xz361oREefIXSWpSD5XwTjalv6KnVtFbeVFXndQ3l/aWYri
         sNoYHQAsF/77W+jMml6IUzy1F3boBXJqiebhFMa86p1RtdG4Lgubp87cEq0PBksNBQ+8
         1TUPHAumGBRM6OZOjSHtrk1malr0Fzjl84ZfQCe81mwGi9KmIqF1P7o8ZeaDX1DUJ5r8
         huCHMVT5OF4qi3rg/pi/vr7N2Sekz6/IeO2tt+/dRYbAlDHUmh3RsHJ+svqvuxWG2WRK
         xfNDh1RALRnuwibbMTma3LeftuRc7ySWyDzg6j6uBGZPp0n1SWHKN4wcyzg0Jk4Wenv1
         OyDA==
X-Gm-Message-State: APzg51DyDuCjHvH3xjYMFSSg6EtvOAHCUajM8B85MPakbwmJrMhXnQqM
        B+KK4Pjt0bp9d8m3xv5wF4HYxA==
X-Google-Smtp-Source: ANB0Vdb3bodFYuCpxIrgQOxwV11wtxPjPQEq4sjgMODObbiisI9Fus1b78IWW6XKj0YvuuZdrsTtAQ==
X-Received: by 2002:a1c:760d:: with SMTP id r13-v6mr5245235wmc.22.1536334818943;
        Fri, 07 Sep 2018 08:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5981:ec43:6d36:934e])
        by smtp.gmail.com with ESMTPSA id r140-v6sm11584477wmd.7.2018.09.07.08.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 08:40:18 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix 1 task per CPU
Date:   Fri,  7 Sep 2018 17:40:03 +0200
Message-Id: <1536334803-21059-1-git-send-email-vincent.guittot@linaro.org>
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
index 309c93f..57b4d83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	/*
+	 * There is available capacity in local group and busiest group is
+	 * overloaded but calculate_imbalance can't compute the amount of load
+	 * to migrate because they became meaningless because asymetric
+	 * capacity between group. In such case, we only want to migrate at
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

