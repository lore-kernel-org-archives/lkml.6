Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2A42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaxsDPQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeLNQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:02:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40713 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeLNQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:02:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so6269055wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfiRUdDr+TqI7TV0rLeVcx1oIP63u9FOItmohRxuqAU=;
        b=SaxsDPQGDfyKGuUp3x6n0RHJglokYsIg6NYMmkUqYEW6KdsjrgVW6ezqfb/xpSnZbj
         ih07cayFOVLuU1Dk/B2IgGZanbTS434FjwfpahfWihQt4ICdMhF74RxvCvWTRP1gjbUj
         zxqCW8Inz+/sijvUmdczcLYjOeWZxAxjJsYAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfiRUdDr+TqI7TV0rLeVcx1oIP63u9FOItmohRxuqAU=;
        b=lkbCaKSsk5sYbN3h3jJKoziRPxMdMv4dovxe4RPQmuwgLLY/pqqbtTqLbpkrR4S/Uh
         ksXRkQekJzSaUnpTN2a7UNq7L30xNk+kr+8wC9NJdhXmGLBzl37Xd/K3mKl6PO4jHuBE
         fu28ogBKY1hTDZ6JdNhfm+HU+Pe1Fs/EApNjtJ0YGtSG7Gys0wz5HGP63FVxqfBmxnlK
         Z+ygrUVxAJGhxELPLyHd82fgZbNCm8f4r4RUnTNCyiNz03HXdhPIGcArMJLFHR7DuXX9
         OLlnK7N68F93OdUirdxCo34NylAHUA5JgR5sEhW4m2pgYPJK1FwYWmQ3t9klDVuZPgvi
         2/sw==
X-Gm-Message-State: AA+aEWYl0zHehv2dtsb5mjbLgiseonGeOdBNQMw4wbZejXM86obF9sSA
        K8ofFmcFmn5R8C90vSLrDW+X2Q==
X-Google-Smtp-Source: AFSGD/XGEA83De9F1TCTqhe1dv7GI83IxwmmeKk+bMw85sxbsV42yoKDlYqjmxYo83oBIQXg4qs76w==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr4008104wmf.144.1544803325423;
        Fri, 14 Dec 2018 08:02:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id e17sm7888738wri.36.2018.12.14.08.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 08:02:04 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/3] sched/fair: fix rounding issue for asym packing
Date:   Fri, 14 Dec 2018 17:01:55 +0100
Message-Id: <1544803317-7610-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
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
index ca46964..c215f7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8215,6 +8215,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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

