Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4755220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4755220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGSXSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:18:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeGSXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:18:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMXLHG2439893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:33:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMXLgj2439890;
        Thu, 19 Jul 2018 15:33:21 -0700
Date:   Thu, 19 Jul 2018 15:33:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-857baa87b6422bcfb84ed3631d6839920cb5b09d@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180719205545.16512-24-pasha.tatashin@oracle.com>
References: <20180719205545.16512-24-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] sched/clock: Enable sched clock early
Git-Commit-ID: 857baa87b6422bcfb84ed3631d6839920cb5b09d
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

Commit-ID:  857baa87b6422bcfb84ed3631d6839920cb5b09d
Gitweb:     https://git.kernel.org/tip/857baa87b6422bcfb84ed3631d6839920cb5b09d
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:42 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:43 +0200

sched/clock: Enable sched clock early

Allow sched_clock() to be used before schec_clock_init() is called.  This
provides a way to get early boot timestamps on machines with unstable
clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-24-pasha.tatashin@oracle.com

---
 init/main.c          |  2 +-
 kernel/sched/clock.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 162d931c9511..ff0a24170b95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_init();
 	printk_safe_init();
 	perf_event_init();
 	profile_init();
@@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
+	sched_clock_init();
 	calibrate_delay();
 	pid_idr_init();
 	anon_vma_init();
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 0e9dbb2d9aea..422cd63f8f17 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -202,7 +202,25 @@ static void __sched_clock_gtod_offset(void)
 
 void __init sched_clock_init(void)
 {
+	unsigned long flags;
+
+	/*
+	 * Set __gtod_offset such that once we mark sched_clock_running,
+	 * sched_clock_tick() continues where sched_clock() left off.
+	 *
+	 * Even if TSC is buggered, we're still UP at this point so it
+	 * can't really be out of sync.
+	 */
+	local_irq_save(flags);
+	__sched_clock_gtod_offset();
+	local_irq_restore(flags);
+
 	sched_clock_running = 1;
+
+	/* Now that sched_clock_running is set adjust scd */
+	local_irq_save(flags);
+	sched_clock_tick();
+	local_irq_restore(flags);
 }
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
@@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
 		return sched_clock() + __sched_clock_offset;
 
 	if (unlikely(!sched_clock_running))
-		return 0ull;
+		return sched_clock();
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
