Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F99C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC9920684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXKUDqF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC9920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJDS5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:57:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34649 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:57:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so1415748wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x4J7xQAH031mjKHecE55aBySuA5+RK8ZxvbBGd/a5Lg=;
        b=kXKUDqF1MBWFEBNw+mIUqUAZqpJ+WENtc/vqic+3IR/vuAtf6dwWz7RkrBN8axWJYu
         223pXr+fxONGIiXE1sDrqKq2MbbqOyIBcdmvagLOetrW2eGvqULHxh67bqL+hJ9vg8//
         74xOxLT2bVn8O34hKuVgMtV7ylDsUymiLvCTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x4J7xQAH031mjKHecE55aBySuA5+RK8ZxvbBGd/a5Lg=;
        b=VAOj05H0NrBEy53/FiGImvlRufpFIZUcmo8U7XCCpCT1LEbJOgUbEVUmon2mzoALR8
         RQJ5sjbJU/uUjBa4nIolGc/ygJX4sh6wrlrr9trZnHFEsLEerCkpI92JfO/QsAt9xpOe
         MAprTAoVtu6672dpQXbQ6zqOqgJdMRHfIuR2Us/a1TlAj+t3ZEo3z2pIUCDdCEfojFUb
         snQhZk5MoB47+LW3vFtQpU2NKcuo+OPbepPkahxpmsbSFfwBLgxf5Jmbos63JRYOJ6i2
         JFf7SR9m008laWo1FTRcuq00yOXlSiMDgfPU8nkLadgi5UpL9Y0DqLQiRq9AoG9w2UzO
         D79Q==
X-Gm-Message-State: ABuFfogeeBX7iQp2hwwbiC2C0F/zWrrSqyBcIWElTH04h4FV1C2uj5tU
        DRMf+PZLJHZrxhbvVJwU4C4lpg==
X-Google-Smtp-Source: ACcGV61ckI2zNfd7HPWQOnopKq3Iq1VLlicRHcBYh2ZvqhPMjrvX/N29TK/OdpHhdCyQeGZyWmYYsw==
X-Received: by 2002:a1c:c784:: with SMTP id x126-v6mr4757189wmf.90.1538654652811;
        Thu, 04 Oct 2018 05:04:12 -0700 (PDT)
Received: from localhost.localdomain (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id p11-v6sm4477132wrd.74.2018.10.04.05.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 05:04:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH V2 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date:   Thu,  4 Oct 2018 14:04:02 +0200
Message-Id: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function nr_iowait_cpu() can be used directly by nr_iowait() instead
of duplicating code.

Call nr_iowait_cpu() from nr_iowait()

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/core.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..43efb74 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2875,6 +2875,25 @@ unsigned long long nr_context_switches(void)
 }
 
 /*
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
+
+/*
  * IO-wait accounting, and how its mostly bollocks (on SMP).
  *
  * The idea behind IO-wait account is to account the idle time that we could
@@ -2909,31 +2928,11 @@ unsigned long nr_iowait(void)
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

