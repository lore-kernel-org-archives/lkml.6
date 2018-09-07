Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDBAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9710820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzZAyCYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9710820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeIGMaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:30:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38751 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:30:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so13605349wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U7rlz81RYPigwV+o2zgu9XiXkFpocxCgtLMOlpQ/v2A=;
        b=hzZAyCYyZlXuT5G4TeKfd9gbGkmQgGuA95QhQT9hBLG/gHhJaPtf2sCpZQ8zZWkndt
         ESPdrHdkyyDZMDUv4DN6k74xwEETJ72C7/na2EtgOMpfnqYwf7ZddsH/y5bcuw2Gigch
         n3s9h5z+nLtDp9Nbop0NKF9/xLgg+XU+SXVUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U7rlz81RYPigwV+o2zgu9XiXkFpocxCgtLMOlpQ/v2A=;
        b=umVFhsm9bcYsVnME6FQMCZfSOZRJbdNkfQsvELGOJQwAr/hPFwXSfJIVjwbX/WWhwH
         M3BZnNpDFPha9kxuSLDkW1m4wLRcWkNM857aEzcQh1/OiQHzYw+DIdOA1PnQvteSg8lv
         LAUEwxvyaCTGHLtVUXGYrAhM/TQuuLcPaxrX063rsz3OsIBk/S/ic67T8wt2YAlLZl2x
         7cn3pLfEKmemUFvqIKLeTG5TfHyWxZZ48GFCXfbZ6/lIgtEfryEnU6Bs8P+yGFMYvo1l
         HnST+9kkKR/q0GdAKWtBCrUdNl6N64CO5K3V9IqM5djXSIXrgXIsbpcFwANUXdeqMNEH
         fACw==
X-Gm-Message-State: APzg51Bru/w7aYMxNH13jBMwNMhS+0xvdGxEObLViivwnKQgCC+PLEzL
        KLxAAnhFullXLEu9x1IOG3POUg==
X-Google-Smtp-Source: ANB0VdaZItTAJh9XksMtiBtXKQjaJ34sTeVdBgaf6wnHtrGe62RvP8poH4724DGwPgticwtThkhRyA==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr4012336wmg.74.1536306671203;
        Fri, 07 Sep 2018 00:51:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5981:ec43:6d36:934e])
        by smtp.gmail.com with ESMTPSA id h8-v6sm10814247wre.15.2018.09.07.00.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 00:51:10 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, jhugo@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix load_balance redo for null imbalance
Date:   Fri,  7 Sep 2018 09:51:04 +0200
Message-Id: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can happen that load_balance finds a busiest group and then a busiest rq
but the calculated imbalance is in fact null.

In such situation, detach_tasks returns immediately and lets the flag
LBF_ALL_PINNED set. The busiest CPU is then wrongly assumed to have pinned
tasks and removed from the load balance mask. then, we redo a load balance
without the busiest CPU. This creates wrong load balance situation and
generates wrong task migration.

If the calculated imbalance is null, it's useless to try to find a busiest
rq as no task will be migrated and we can return immediately.

This situation can happen with heterogeneous system or smp system when RT
tasks are decreasing the capacity of some CPUs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..224bfae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8464,7 +8464,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	}
 
 	group = find_busiest_group(&env);
-	if (!group) {
+	if (!group || !env.imbalance) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
 		goto out_balanced;
 	}
-- 
2.7.4

