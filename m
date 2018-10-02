Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29BF2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIqySdi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29BF2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJBOIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:08:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeJBOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:08:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so904564wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+letnrUftggUuNnWV9VjgurJvKNvmDW3KXCaTcLkec=;
        b=LIqySdi/hQNddNF7iZF72vB/x/20T8hK6twDHDrumNqp/ltArrhJ3cQcFcC8yw7KWS
         rif+//CB/1/GhzGpa3ROaKUYK9G9DqcZdk9y2oTaFhX1t4Iemf4scpLwntPc58mXV4Ss
         mHQYIJbfMOU2FDfA/IutuJuoogKaVBzftKakQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+letnrUftggUuNnWV9VjgurJvKNvmDW3KXCaTcLkec=;
        b=suk7hiG4hBaPBMnREVncOm2pd8JX2fN4csiLCzS2fQ7u29Bxq0BuIdvIO+DM7SZ4xu
         vh71jWEgALvtaWsNjvjsc72S5p7ZcbES+SRhbonda1xCRaBlSFU7gX1srjRZB8460v7Y
         Dl6mVkhIzyDaueWbQeAByaRluheXXZwkE35B54B2d1k+ilfwHlGJg/CgXwbRW+kgR9Q7
         g2ZLPkt1QzgQWUu9YJhn/XSaShbz52kMRuPrLqztENvRRDtYOiCvl2sVeYuuAxcLyS0p
         TxYoUFft+bZCOEABlLagKeuPEj6XUtSPYGHep5tqeXS72EsgQuHUOXMOotykzX3EIk3j
         Qd0A==
X-Gm-Message-State: ABuFfoiBLDqXASC8ByC0hz9+6oXOKTcpH1FOW8XxLGB13o74kBc5313B
        Dl1y3qYa5hj6oVsP+mfqpxcQK7atNF4=
X-Google-Smtp-Source: ACcGV60uvU3izG0PAv9RkxeE/WnIUOj7iDw15j/YXk+nG546vZ+p2qgjaLb/FCb2qZxmlV4nX/1pcg==
X-Received: by 2002:a5d:5002:: with SMTP id e2-v6mr9954337wrt.210.1538465216390;
        Tue, 02 Oct 2018 00:26:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99b3:4272:8254:6430])
        by smtp.gmail.com with ESMTPSA id t24-v6sm3550552wra.5.2018.10.02.00.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 00:26:55 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RESEND PATCH 1/3] sched/fair: fix rounding issue for asym packing
Date:   Tue,  2 Oct 2018 09:26:37 +0200
Message-Id: <1538465199-20176-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
References: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
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
index 6bd142d..0ed99ad2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7824,6 +7824,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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

