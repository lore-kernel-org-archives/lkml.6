Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE9C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1702086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKEh9MUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfANGr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:47:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44796 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:47:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so9864979pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 22:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qH5zCBuFyYHHUeMJH0xcmpcpFWWUE+Tp8XFywfK8hf0=;
        b=oKEh9MUyq1ZjYRm1VYOWhc43mtm5YngCWMC2vEHOnFsTt4Qx5Oif4mCQJW0C4xZ/Rr
         Z0EqfKTokuZOGMXl0eKtF6d0uLGJW287bOOjFj5Ur9jlcwVamrlWrwBr9UHHxGLVU1gm
         lAkWfAUW6eARwFCQcCcMVRxvdohUjvyqT/23L4E7XJCaF8/XnwvGWkDRSSD+6xHf1zJ8
         i9on2rzItZss1J4O4qStYNrSoIwY9pcOHD68uW3lEXpuMWJz/uhyEKJD3UDhEHKtRcJE
         nCfawhZ2kpkkCXnuK065itkDyEp8NBsom/6drp9ocZx3I9Lb3YZzRy2Trt54fqNIR/pR
         IXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qH5zCBuFyYHHUeMJH0xcmpcpFWWUE+Tp8XFywfK8hf0=;
        b=RAPwpjyFBOAEzgmRPyGn/IuvCJKTg8M+d1kn18bwZ4iYbXuVmRul6gUr+cJ1n4M1EE
         tBwM3aCFVjIY3stbHX/ilMBLvdR1IHgTADty74vjVgPCKUogZ1JtmeiKonvEAI4T6EYf
         YgtcadtH9H32Bkor+ce3U0jCrWJgkqhfAYQhzNm0KQ2kqRKNilmntPId+Y/oakFY5JiT
         tkrnk4bT4RmqoE0077yAT4jPfNVUyWYp1op4UEWbcYYQquruBRt6ntKxJGzIA3UfXBRq
         XQWqpShC9tW7qLON9anj7NDFxts4DcMffGouG2G5/fCFBq1aEHia6byCDrq6We3TDSLZ
         VARg==
X-Gm-Message-State: AJcUukdkmJxhf/meZEzih9f+wXkEtaxPlO1z36BTc9Tx9D9QyEMhBSJQ
        3pFGOO7CrT6boGI927o24mk=
X-Google-Smtp-Source: ALg8bN4YnlFWx4Sz1Yo1Wi2tJGFJGvUQ4Azl76S+2TizaPClrOg3WkHZG6aVluM0M8ctttw9UuLe4A==
X-Received: by 2002:a63:6906:: with SMTP id e6mr21345249pgc.144.1547448476639;
        Sun, 13 Jan 2019 22:47:56 -0800 (PST)
Received: from roar.local0.net (193-116-118-220.tpgi.com.au. [193.116.118.220])
        by smtp.gmail.com with ESMTPSA id 22sm107474083pgd.85.2019.01.13.22.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:47:55 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Michael Neuling <mikey@neuling.org>
Subject: [RFC PATCH] time/nohz: allow the boot CPU to be nohz_full
Date:   Mon, 14 Jan 2019 16:47:45 +1000
Message-Id: <20190114064745.27306-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a supercomputer site testing nohz_full to reduce jitter with
good results, but they want CPU0 to be nohz_full. That happens to be
the boot CPU, which is disallowed by the nohz_full code.

They have existing job scheduling code which wants this, I don't know
too much detail beyond that, but I hope the kernel can be made to
work with their config.

This patch has the boot CPU take over the jiffies update in the low
res timer before SMP is brought up, after which the nohz CPU will take
over.

It also modifies the housekeeping check code a bit to ensure at least
one !nohz CPU is in the present map so it comes up at boot, rather
than having the nohz code take the boot CPU out of the nohz mask.

This keeps jiffies incrementing on the nohz_full boot CPU before SMP
init, but I'm not sure if this is covering all races and platform
considerations. Sorry I don't know the timer code too well, I would
appreciate any help.

Thanks,
Nick
---
 kernel/sched/isolation.c  | 18 ++++++++++++------
 kernel/time/tick-common.c | 30 +++++++++++++++++++++++++-----
 kernel/time/tick-sched.c  | 14 +++++---------
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index e6802181900f..6f8ac38d39a0 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -65,6 +65,7 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
+	cpumask_var_t tmp;
 	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
@@ -75,25 +76,30 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
-		if (cpumask_empty(housekeeping_mask))
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp)) {
+			pr_warn("Housekeeping: must include one present CPU, "
+				"using boot CPU:%d\n", smp_processor_id());
 			cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		}
 	} else {
-		cpumask_var_t tmp;
-
-		alloc_bootmem_cpumask_var(&tmp);
-		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp))
+			cpumask_set_cpu(smp_processor_id(), tmp);
 		if (!cpumask_equal(tmp, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
 			free_bootmem_cpumask_var(tmp);
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
-		free_bootmem_cpumask_var(tmp);
 	}
+	free_bootmem_cpumask_var(tmp);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 14de3727b18e..c971278dbe95 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -50,6 +50,9 @@ ktime_t tick_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
+#ifdef CONFIG_NO_HZ_FULL
+static int tick_do_timer_boot_cpu __read_mostly = -1;
+#endif
 
 /*
  * Debugging: see timer_list.c
@@ -78,7 +81,11 @@ int tick_is_oneshot_available(void)
  */
 static void tick_periodic(int cpu)
 {
+#ifdef CONFIG_NO_HZ_FULL
+	if (tick_do_timer_cpu == cpu || tick_do_timer_boot_cpu == cpu) {
+#else
 	if (tick_do_timer_cpu == cpu) {
+#endif
 		write_seqlock(&jiffies_lock);
 
 		/* Keep track of the next tick event */
@@ -190,12 +197,25 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			if (!tick_nohz_full_cpu(cpu))
+			/*
+			 * The boot CPU may be nohz_full, in which case just
+			 * leave it set to TICK_DO_TIMER_BOOT for the next
+			 * CPU. tick_do_timer_boot_cpu is set to run the
+			 * tick at early boot until the housekeeping CPU
+			 * comes up.
+			 */
+			if (!tick_nohz_full_cpu(cpu)) {
 				tick_do_timer_cpu = cpu;
-			else
-				tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-			tick_next_period = ktime_get();
-			tick_period = NSEC_PER_SEC / HZ;
+#ifdef CONFIG_NO_HZ_FULL
+				tick_do_timer_boot_cpu = -1;
+			} else {
+				tick_do_timer_boot_cpu = cpu;
+#endif
+			}
+			if (!tick_period) {
+				tick_period = NSEC_PER_SEC / HZ;
+				tick_next_period = ktime_get();
+			}
 		}
 
 		/*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b88474..42f77231d0dc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -398,8 +398,8 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 static int tick_nohz_cpu_down(unsigned int cpu)
 {
 	/*
-	 * The boot CPU handles housekeeping duty (unbound timers,
-	 * workqueues, timekeeping, ...) on behalf of full dynticks
+	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
@@ -428,12 +428,6 @@ void __init tick_nohz_init(void)
 
 	cpu = smp_processor_id();
 
-	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
-			cpu);
-		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
-	}
-
 	for_each_cpu(cpu, tick_nohz_full_mask)
 		context_tracking_cpu_set(cpu);
 
@@ -907,8 +901,10 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		/*
 		 * Boot safety: make sure the timekeeping duty has been
 		 * assigned before entering dyntick-idle mode,
+		 * tick_do_timer_cpu is TICK_DO_TIMER_NONE or
+		 * TICK_DO_TIMER_BOOT
 		 */
-		if (tick_do_timer_cpu == TICK_DO_TIMER_NONE)
+		if (tick_do_timer_cpu < 0)
 			return false;
 	}
 
-- 
2.18.0

