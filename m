Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159AECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B169620673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B169620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeGSXT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:19:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbeGSXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:19:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMXtKj2439926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:33:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMXtst2439922;
        Thu, 19 Jul 2018 15:33:55 -0700
Date:   Thu, 19 Jul 2018 15:33:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-46457ea464f5341d1f9dad8dd213805d45f7f117@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, pasha.tatashin@oracle.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, pasha.tatashin@oracle.com, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20180719205545.16512-25-pasha.tatashin@oracle.com>
References: <20180719205545.16512-25-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] sched/clock: Use static key for
 sched_clock_running
Git-Commit-ID: 46457ea464f5341d1f9dad8dd213805d45f7f117
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  46457ea464f5341d1f9dad8dd213805d45f7f117
Gitweb:     https://git.kernel.org/tip/46457ea464f5341d1f9dad8dd213805d45f7f117
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:43 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:43 +0200

sched/clock: Use static key for sched_clock_running

sched_clock_running may be read every time sched_clock_cpu() is called.
Yet, this variable is updated only twice during boot, and never changes
again, therefore it is better to make it a static key.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-25-pasha.tatashin@oracle.com

---
 kernel/sched/clock.c | 16 ++++++++--------
 kernel/sched/debug.c |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 422cd63f8f17..c5c47ad3f386 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -67,7 +67,7 @@ unsigned long long __weak sched_clock(void)
 }
 EXPORT_SYMBOL_GPL(sched_clock);
 
-__read_mostly int sched_clock_running;
+static DEFINE_STATIC_KEY_FALSE(sched_clock_running);
 
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
@@ -191,7 +191,7 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (sched_clock_running == 2)
+	if (static_key_count(&sched_clock_running.key) == 2)
 		__clear_sched_clock_stable();
 }
 
@@ -215,7 +215,7 @@ void __init sched_clock_init(void)
 	__sched_clock_gtod_offset();
 	local_irq_restore(flags);
 
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 
 	/* Now that sched_clock_running is set adjust scd */
 	local_irq_save(flags);
@@ -228,7 +228,7 @@ void __init sched_clock_init(void)
  */
 static int __init sched_clock_init_late(void)
 {
-	sched_clock_running = 2;
+	static_branch_inc(&sched_clock_running);
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
 	 *
@@ -373,7 +373,7 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return sched_clock();
 
 	preempt_disable_notrace();
@@ -396,7 +396,7 @@ void sched_clock_tick(void)
 	if (sched_clock_stable())
 		return;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -455,13 +455,13 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
 void __init sched_clock_init(void)
 {
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 	generic_sched_clock_init();
 }
 
 u64 sched_clock_cpu(int cpu)
 {
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return 0;
 
 	return sched_clock();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e593b4118578..b0212f489a33 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -623,8 +623,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 #undef PU
 }
 
-extern __read_mostly int sched_clock_running;
-
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
