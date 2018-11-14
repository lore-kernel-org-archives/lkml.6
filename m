Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A8C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E27223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0t+yXGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E27223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbeKNMsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732756AbeKNMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:17 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3883223CB;
        Wed, 14 Nov 2018 02:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163626;
        bh=rEmj5ckQsAYxiB+ocZB3wTFRkhqc0IPDqo79dV7a29U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0t+yXGWjEnU74qNNNvgRi33RZPm0p/mhNBXGv1z7ZkO0FAgDdqVuH9QUlWhCzX8n
         MNjy0JMpu9QMgKBO+Maf/kenMbHPVG7DotEkJdP440ynwnkuiDmHsffXq2GzrBUK2w
         uGgesP+rPICXKqh7zZKZSR3VlWR7IIK89NNnSg2o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 22/25] cpufreq: Use vtime aware kcpustat accessor
Date:   Wed, 14 Nov 2018 03:46:06 +0100
Message-Id: <1542163569-20047-23-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a vtime safe kcpustat accessor, use it to fix frozen
kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/cpufreq/cpufreq.c          | 18 +++++++++++-------
 drivers/cpufreq/cpufreq_governor.c | 27 ++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dca..e9cff3f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -119,18 +119,22 @@ EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
-	u64 idle_time;
+	struct kernel_cpustat *kcpustat = &kcpustat_cpu(cpu);
+	u64 user, nice, sys, guest, guest_nice;
 	u64 cur_wall_time;
+	u64 idle_time;
 	u64 busy_time;
 
 	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
 
-	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_IRQ];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+	kcpustat_cputime(kcpustat, cpu, &user, &nice, &sys,
+			 &guest, &guest_nice);
+	busy_time = user;
+	busy_time += sys;
+	busy_time += kcpustat->cpustat[CPUTIME_IRQ];
+	busy_time += kcpustat->cpustat[CPUTIME_SOFTIRQ];
+	busy_time += kcpustat->cpustat[CPUTIME_STEAL];
+	busy_time += nice;
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 6d53f7d..5ebe726 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -107,8 +107,13 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
-			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+			if (dbs_data->ignore_nice_load) {
+				u64 user, nice, sys, guest, guest_nice;
+
+				kcpustat_cputime(&kcpustat_cpu(j), j, &user, &nice, &sys,
+						 &guest, &guest_nice);
+				j_cdbs->prev_cpu_nice = nice;
+			}
 		}
 	}
 }
@@ -152,10 +157,13 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+			u64 user, nice, sys, guest, guest_nice;
 
-			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
-			j_cdbs->prev_cpu_nice = cur_nice;
+			kcpustat_cputime(&kcpustat_cpu(j), j, &user, &nice, &sys,
+					 &guest, &guest_nice);
+
+			idle_time += div_u64(nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
+			j_cdbs->prev_cpu_nice = nice;
 		}
 
 		if (unlikely(!time_elapsed)) {
@@ -530,8 +538,13 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		 */
 		j_cdbs->prev_load = 0;
 
-		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+		if (ignore_nice) {
+			u64 user, nice, sys, guest, guest_nice;
+
+			kcpustat_cputime(&kcpustat_cpu(j), j, &user, &nice, &sys,
+					 &guest, &guest_nice);
+			j_cdbs->prev_cpu_nice = nice;
+		}
 	}
 
 	gov->start(policy);
-- 
2.7.4

