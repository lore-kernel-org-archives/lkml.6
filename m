Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2978C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5744E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwIkZU5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5744E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJDOeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:34:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJDOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:34:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so8752597wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G8KE0KJrHfkVSbRNTnKXaz2S9vIBp4IhY5kWUCvJkJ0=;
        b=YwIkZU5/OolhcvzAXeCYyF0DsU1328A0Iagqn37qvWYimqLwH1Esl0Z2HVGQ+ohfiS
         5xCMZHcbu8N+wswCi/A7ZvRFRpg6+kFejCjVaeLJo5XRlQ+2r8IKsIcF3m275EF3kk7u
         h88oQlbeoAOClDWaSa8RDGB0nZBs9xybVnLVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8KE0KJrHfkVSbRNTnKXaz2S9vIBp4IhY5kWUCvJkJ0=;
        b=EEgIiuxZp6LUYmzzmUC6EiKk5Gcea0C0A66s6OASO61Pr+A9hbpeYqm4GQhkRWH3lv
         /f3U6B9p1ueKcze1hCbWRJpV5Cg6AiDaOMLo1Y2uJPg5l3nf5+gFy8YyrRn+G4kSfNuY
         IwRkklRixe7PeWfBPhMw50HBLMWRyRz6qBEZrJQyCTNsxpsDQJsFRr+XITnENzJTc/4q
         YAMPsJ1mol3voT0RBOeJN0cdVEHkCrzYWoaDXeoreqzwBScw6Shwt3PsC+2HOfAhipGD
         9Q03Rff0/670ZhgoFbgQdQzP2YouIlHTR2xMC9MG4uoYVyiKNdz3GxSK29wKuBiucdUL
         N8EA==
X-Gm-Message-State: ABuFfoinkvxD9lXuq8ZQ2odn+q9wWIxdyaP/qYB9F6E+/jnDeybSAWBH
        WTpxD4ervbJZ4z7bcfJb7HnhTg==
X-Google-Smtp-Source: ACcGV63YfD11k7BHm/v62UGp78ccy0vuRTeUI2FX52V/bgrbpChxe4aoblcNqjO6tPpAY7Flv/QzNg==
X-Received: by 2002:a5d:404b:: with SMTP id w11-v6mr3564889wrp.147.1538638936523;
        Thu, 04 Oct 2018 00:42:16 -0700 (PDT)
Received: from localhost.localdomain (225.182.88.92.rev.sfr.net. [92.88.182.225])
        by smtp.gmail.com with ESMTPSA id t82-v6sm651579wme.30.2018.10.04.00.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 00:42:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date:   Thu,  4 Oct 2018 09:42:06 +0200
Message-Id: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function nr_iowait_cpu() can be used directly by nr_iowait() instead
of duplicating code.

Call nr_iowait_cpu() from nr_iowait()

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/core.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..b88a145 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2873,6 +2873,24 @@ unsigned long long nr_context_switches(void)
 
 	return sum;
 }
+/*
+ * Consumers of these two interfaces, like for example the cpufreq menu
+ * governor are using nonsensical data. Boosting frequency for a CPU that has
+ * IO-wait which might not even end up running the task when it does become
+ * runnable.
+ */
+
+unsigned long nr_iowait_cpu(int cpu)
+{
+	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+}
+
+void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
+{
+	struct rq *rq = this_rq();
+	*nr_waiters = atomic_read(&rq->nr_iowait);
+	*load = rq->load.weight;
+}
 
 /*
  * IO-wait accounting, and how its mostly bollocks (on SMP).
@@ -2909,31 +2927,11 @@ unsigned long nr_iowait(void)
 	unsigned long i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += atomic_read(&cpu_rq(i)->nr_iowait);
+		sum += nr_iowait_cpu(i);
 
 	return sum;
 }
 
-/*
- * Consumers of these two interfaces, like for example the cpufreq menu
- * governor are using nonsensical data. Boosting frequency for a CPU that has
- * IO-wait which might not even end up running the task when it does become
- * runnable.
- */
-
-unsigned long nr_iowait_cpu(int cpu)
-{
-	struct rq *this = cpu_rq(cpu);
-	return atomic_read(&this->nr_iowait);
-}
-
-void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
-{
-	struct rq *rq = this_rq();
-	*nr_waiters = atomic_read(&rq->nr_iowait);
-	*load = rq->load.weight;
-}
-
 #ifdef CONFIG_SMP
 
 /*
-- 
2.7.4

