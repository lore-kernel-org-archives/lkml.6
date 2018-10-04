Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7278C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E0021473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD+UNGE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E0021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJDS5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:57:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36815 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:57:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so4753983wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OGHug1XeN4tV030dZreKI6j+zq3kMpiVWtIizPDMgzc=;
        b=UD+UNGE8TOCehJc7k1YIt25sqZRDnAWdeNV65zygb45J0ljOkaSB0+xz/+yNl6TN9a
         Wfq/mXojmTGxEX99uc/WslItA3lW9RTWB/w6d9tjMVqEN7Ejg/tw7qydGwnRBux14WCh
         a/ciaZ9Em61jNKCoHoWXNVtTNtv6ylCyZ1hNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OGHug1XeN4tV030dZreKI6j+zq3kMpiVWtIizPDMgzc=;
        b=o9/mspX/W1eByrkt12okI3XRCHzckWpuYp3dU+nWnzcaYR4AglyI56iJRqWCVtdiyj
         CbCDwpxnIcwu6W7BANcFt7uPSRsuLia0e7G0pbCr0OkVabUeoTL1KqXUMQBPin2EtQD6
         NQnaPHEPiWMuOliYrvBl64sNncMvQN6aPEtpw/1/+PY0x1aZQAm8LWwRpklnEsyXtNYW
         tfc0bd8LFgmfgG8UkWSUVmfUfwWT9K6bWOiq9/DGcEJIOk5C4lURjg2PixxPGi5usyHL
         HZLE6ZUkPw88MrFV9R+lVmPtG5Qd+RP4hWW/WZd2LQK9L5LLfKLW1Vr84iTLPprY+ohX
         gYfw==
X-Gm-Message-State: ABuFfoh3FBU+s7R5GdmkZlrxzZWOl8s+dP+5KochjBQCg3po4ChAGQq/
        IVj6F97MDJ4gmu8ss4RcXGE7EQ==
X-Google-Smtp-Source: ACcGV63ZAMgdWR3dfssHApdKJTvdeHWTls1JksJ+63f6ZanlfpNnjAPPplNmBOF9BjyTP9FVgA1Vfw==
X-Received: by 2002:a1c:f4e:: with SMTP id 75-v6mr4352729wmp.79.1538654659174;
        Thu, 04 Oct 2018 05:04:19 -0700 (PDT)
Received: from localhost.localdomain (101.142.88.92.rev.sfr.net. [92.88.142.101])
        by smtp.gmail.com with ESMTPSA id p11-v6sm4477132wrd.74.2018.10.04.05.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 05:04:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/2] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date:   Thu,  4 Oct 2018 14:04:03 +0200
Message-Id: <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_loadavg() returns almost always zero. To be more
precise, statistically speaking for a total of 1023379 times passing
in the function, the load is equal to zero 1020728 times, greater than
100, 610 times, the remaining is between 0 and 5.

In 2011, the get_loadavg() was removed from the Android tree because
of the above [1]. At this time, the load was:

unsigned long this_cpu_load(void)
{
        struct rq *this = this_rq();
        return this->cpu_load[0];
}

In 2014, the code was changed by commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
runqueues less) and the load is:

void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
{
        struct rq *rq = this_rq();
        *nr_waiters = atomic_read(&rq->nr_iowait);
        *load = rq->load.weight;
}

with the same result.

Both measurements show using the load in this code path does no matter
anymore. Removing it.

[1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Colin Cross <ccross@android.com>
Cc: Ramesh Thomas <ramesh.thomas@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 26 +++++++-------------------
 include/linux/sched/stat.h       |  1 -
 kernel/sched/core.c              |  7 -------
 3 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e26a409..066b01f 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -135,11 +135,6 @@ struct menu_device {
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
-static inline int get_loadavg(unsigned long load)
-{
-	return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
-}
-
 static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters)
 {
 	int bucket = 0;
@@ -173,18 +168,10 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned long load)
+static inline int performance_multiplier(unsigned long nr_iowaiters)
 {
-	int mult = 1;
-
-	/* for higher loadavg, we are more reluctant */
-
-	mult += 2 * get_loadavg(load);
-
-	/* for IO wait tasks (per cpu!) we add 5x each */
-	mult += 10 * nr_iowaiters;
-
-	return mult;
+	/* for IO wait tasks (per cpu!) we add 10x each */
+	return 1 + 10 * nr_iowaiters;
 }
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -290,7 +277,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
-	unsigned long nr_iowaiters, cpu_load;
+	unsigned long nr_iowaiters;
 	ktime_t delta_next;
 
 	if (data->needs_update) {
@@ -307,7 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
 
-	get_iowait_load(&nr_iowaiters, &cpu_load);
+	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
 	/*
@@ -359,7 +346,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 * Use the performance multiplier and the user-configurable
 		 * latency_req to determine the maximum exit latency.
 		 */
-		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		interactivity_req = data->predicted_us /
+			performance_multiplier(nr_iowaiters);
 		if (latency_req > interactivity_req)
 			latency_req = interactivity_req;
 	}
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 04f1321..f30954c 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -20,7 +20,6 @@ extern unsigned long nr_running(void);
 extern bool single_task_running(void);
 extern unsigned long nr_iowait(void);
 extern unsigned long nr_iowait_cpu(int cpu);
-extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43efb74..48a786a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2886,13 +2886,6 @@ unsigned long nr_iowait_cpu(int cpu)
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
 
-void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
-{
-	struct rq *rq = this_rq();
-	*nr_waiters = atomic_read(&rq->nr_iowait);
-	*load = rq->load.weight;
-}
-
 /*
  * IO-wait accounting, and how its mostly bollocks (on SMP).
  *
-- 
2.7.4

