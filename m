Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF7FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E5520878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXw/Zh8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E5520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJBOQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:16:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36066 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:16:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id n23-v6so1111208wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pLII2LRqsWid2S759f1Dke3ghEEXgn8dyYxpyWLSt/o=;
        b=gXw/Zh8ULL7jJJLgMe3+hxjUUgCWwFzVhWrscGLPfOoRLi9KXlNjHauUPzpHpJislk
         HAKUotctt36OVdLfw4Kl8IF67lKZJkPDsq554CBWYp+PW9J4rn0LcCLNOGgA+Ni/Q/Qc
         MXkcmlQsxF0HGeV7TYTDWpDsrDbPBO3tIbQtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pLII2LRqsWid2S759f1Dke3ghEEXgn8dyYxpyWLSt/o=;
        b=QIRF3oGKx9/US3WnU6PZZfRyHwNWFRWCV+nEgeKCKIG0JQPDiWn9JX9NPqKDJkeEq6
         KnAI2CX+MWvSvlEYxwpjwfLgc52d2I9D9S7VgFp3ZiaUuukT3gGvGwXknmDuLfGol0xs
         a65R+iG/y4EVj2CbqGbVx9TBp9+9PwOXV87c8zDOnx456ryQjNiYTzaz7CrSRZt3i321
         hniS+aHMzjt6RaGtaKRp/dC6W9wrpuV0fPkm+VXwqRXSOGQZvBTCyOcQ8n5EAA0SUkKL
         9wc8YB5b/wiDTqov0VTtcMivgrJJOi1+QWvs77t4dkFSomI1tl8y5iTVg9yNWHwpW4eO
         loxw==
X-Gm-Message-State: ABuFfojsr1wpcJTvIdBaWqynRuMM+QwkfXKIJx7tUWnmypJE3OoR+bnQ
        xQtwciMxeSkHRaO/9zvuzMLaWA==
X-Google-Smtp-Source: ACcGV60JlmTYNUNedE6qh7C7d9r4Cqn1k6Q17ZcqwkJh7xwunjU1or4M/kQSYjBwFkTQ2o3wH27rPQ==
X-Received: by 2002:a1c:4406:: with SMTP id r6-v6mr1002756wma.4.1538465663860;
        Tue, 02 Oct 2018 00:34:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99b3:4272:8254:6430])
        by smtp.gmail.com with ESMTPSA id w2-v6sm16967782wre.46.2018.10.02.00.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 00:34:23 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernellwp@gmail.com, rjw@rjwysocki.net,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/schedutil : optimize computation of utilization in schedutil
Date:   Tue,  2 Oct 2018 09:34:17 +0200
Message-Id: <1538465657-20605-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scaling the utilization of CPUs with irq util_avg in schedutil doesn't give
any benefit and just waste CPU cycles when irq time is not accounted but
only steal time.
Skip the irq scaling when irq time is not accounted

Suggested-by: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3..edbc4d2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -238,6 +238,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	/*
 	 * There is still idle time; further improve the number by using the
 	 * irq metric. Because IRQ/steal time is hidden from the task clock we
@@ -249,6 +250,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 */
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
+#endif
 
 	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
-- 
2.7.4

