Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8C4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09F27644
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5FL72Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A09F27644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934870AbeF1PsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:48:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54121 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966977AbeF1Pp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so4123217wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcmgxRiLyrkswXgHU3qseRb+IEdrpHSwiSXvn0FFVBQ=;
        b=D5FL72LukmNDASiDvkVM2BNLpT29ZErQuBdjkjtpiDANecf6RKnvSj/55e8trsql2d
         YC3xB3Nq8THBfHcYpugL8md7xu6lx4TGunH2EVc1UGj8IoyyPfMgX52sudu9MnoUU9xX
         ONhWRPtn8lTE7405oNyv+KBaPKygsizeOKcEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OcmgxRiLyrkswXgHU3qseRb+IEdrpHSwiSXvn0FFVBQ=;
        b=PsRYhlGfWy3bo+eiwq6eogCMBzWqWlE1Nqm0upxLdFQmbthZoTdYaZRqlTyBBnDzzs
         EIRrVX5PNkbIq8IH7+4hbBEl6Qw9PGk5aTOkmSCVUOKPzTSAWCJ/8poDthUfyAmqy3tG
         3R6d0YfRRJq2cWp7nGh0+vErlJLsK7wlj0xDm0jGX78t0EGRSK7x6dwcsz1PchkSJBpl
         FWjf9xjBv3/6tzGum/azqaq4gzRt84fPQReWAJjKkWYO2MAyPqmtWWyMK7ZAWlrwvC4q
         Y12XAD97bWvlOfk7bbl5DclZ4MpnOLFN95zGIZAAZk4EsJyixN3x/kxZFgPNaSFKhbb7
         P2Qw==
X-Gm-Message-State: APt69E1utYG2GC8x2JfXPV//e/qe3ErLEjTFoFllwvkAiUPOOD+ZPH0d
        0YN4CL5+GwJA9byoy6x16X+31g==
X-Google-Smtp-Source: AAOMgpe1LfCrhhde1kloxeI7yFyAf3HZU95dPh+ShjRBD9/OmEDpMEvqb9oiaHIght2SzXZyUTcFVg==
X-Received: by 2002:a1c:818e:: with SMTP id c136-v6mr8740170wmd.107.1530200726039;
        Thu, 28 Jun 2018 08:45:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:25 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 03/11] cpufreq/schedutil: use rt utilization tracking
Date:   Thu, 28 Jun 2018 17:45:06 +0200
Message-Id: <1530200714-4504-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both cfs and rt utilization when selecting an OPP for cfs tasks as rt
can preempt and steal cfs's running time.

rt util_avg is used to take into account the utilization of rt tasks
on the CPU when selecting OPP. If a rt task migrate, the rt utilization
will not migrate but will decay over time. On an overloaded CPU, cfs
utilization reflects the remaining utilization avialable on CPU. When rt
task migrates, the cfs utilization will increase when tasks will start to
use the newly available capacity. At the same pace, rt utilization will
decay and both variations will compensate each other  to keep unchanged
overall utilization and will prevent any OPP drop.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3cde464..9c5e92e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -186,15 +187,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util;
 
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
+	util = sg_cpu->util_dl;
+	util += sg_cpu->util_cfs;
+	util += sg_cpu->util_rt;
+
 	/*
 	 * Utilization required by DEADLINE must always be granted while, for
 	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
@@ -205,7 +212,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
+	return min(sg_cpu->max, util);
 }
 
 /**
-- 
2.7.4

