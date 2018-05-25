Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936149AbeEYNO1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:14:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38705 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934595AbeEYNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:46 -0400
X-Google-Smtp-Source: ADUXVKJHTf/nR7TEOlhumMM+Armc3u0l0yoNwH7P7Lz1bVncJ8XK1mJYglu20yO+PqBKaijSC2PE1g==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Date: Fri, 25 May 2018 15:12:26 +0200
Message-Id: <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have both the dl class bandwidth requirement and the dl class
utilization, we can use the max of the 2 values when agregating the
utilization of the CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/sched.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4526ba6..0eb07a8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2194,7 +2194,11 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
-	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+	unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+
+	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
+
+	return util;
 }
 
 static inline unsigned long cpu_util_cfs(struct rq *rq)
-- 
2.7.4
