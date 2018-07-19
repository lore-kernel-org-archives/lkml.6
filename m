Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07F020671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07F020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGSXMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:12:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:12:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMREXx2439120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:27:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMRDQ32439117;
        Thu, 19 Jul 2018 15:27:13 -0700
Date:   Thu, 19 Jul 2018 15:27:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-fe9af81e524e8a86bdd59c0cc0d9e2b0ccaf840f@git.kernel.org>
Cc:     douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        pasha.tatashin@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          douly.fnst@cn.fujitsu.com, pasha.tatashin@oracle.com
In-Reply-To: <20180719205545.16512-12-pasha.tatashin@oracle.com>
References: <20180719205545.16512-12-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Redefine notsc to behave as tsc=unstable
Git-Commit-ID: fe9af81e524e8a86bdd59c0cc0d9e2b0ccaf840f
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

Commit-ID:  fe9af81e524e8a86bdd59c0cc0d9e2b0ccaf840f
Gitweb:     https://git.kernel.org/tip/fe9af81e524e8a86bdd59c0cc0d9e2b0ccaf840f
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:30 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:39 +0200

x86/tsc: Redefine notsc to behave as tsc=unstable

Currently, the notsc kernel parameter disables the use of the TSC by
sched_clock(). However, this parameter does not prevent the kernel from
accessing tsc in other places.

The only rationale to boot with notsc is to avoid timing discrepancies on
multi-socket systems where TSC are not properly synchronized, and thus
exclude TSC from being used for time keeping. But that prevents using TSC
as sched_clock() as well, which is not necessary as the core sched_clock()
implementation can handle non synchronized TSC based sched clocks just
fine.

However, there is another method to solve the above problem: booting with
tsc=unstable parameter. This parameter allows sched_clock() to use TSC and
just excludes it from timekeeping.

So there is no real reason to keep notsc, but for compatibility reasons the
parameter has to stay. Make it behave like 'tsc=unstable' instead.

[ tglx: Massaged changelog ]

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-12-pasha.tatashin@oracle.com

---
 Documentation/admin-guide/kernel-parameters.txt |  2 --
 Documentation/x86/x86_64/boot-options.txt       |  4 +---
 arch/x86/kernel/tsc.c                           | 18 +++---------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c68970..5aed30cd0350 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2835,8 +2835,6 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	notsc		[BUGS=X86-32] Disable Time Stamp Counter
-
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index 8d109ef67ab6..66114ab4f9fe 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -92,9 +92,7 @@ APICs
 Timing
 
   notsc
-  Don't use the CPU time stamp counter to read the wall time.
-  This can be used to work around timing problems on multiprocessor systems
-  with not properly synchronized CPUs.
+  Deprecated, use tsc=unstable instead.
 
   nohpet
   Don't use the HPET timer.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9d51e0..186395041725 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -38,11 +38,6 @@ EXPORT_SYMBOL(tsc_khz);
  */
 static int __read_mostly tsc_unstable;
 
-/* native_sched_clock() is called before tsc_init(), so
-   we must start with the TSC soft disabled to prevent
-   erroneous rdtsc usage on !boot_cpu_has(X86_FEATURE_TSC) processors */
-static int __read_mostly tsc_disabled = -1;
-
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
@@ -248,8 +243,7 @@ EXPORT_SYMBOL_GPL(check_tsc_unstable);
 #ifdef CONFIG_X86_TSC
 int __init notsc_setup(char *str)
 {
-	pr_warn("Kernel compiled with CONFIG_X86_TSC, cannot disable TSC completely\n");
-	tsc_disabled = 1;
+	mark_tsc_unstable("boot parameter notsc");
 	return 1;
 }
 #else
@@ -1307,7 +1301,7 @@ unreg:
 
 static int __init init_tsc_clocksource(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
+	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
 
 	if (tsc_unstable)
@@ -1414,12 +1408,6 @@ void __init tsc_init(void)
 		set_cyc2ns_scale(tsc_khz, cpu, cyc);
 	}
 
-	if (tsc_disabled > 0)
-		return;
-
-	/* now allow native_sched_clock() to use rdtsc */
-
-	tsc_disabled = 0;
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
@@ -1455,7 +1443,7 @@ unsigned long calibrate_delay_is_known(void)
 	int constant_tsc = cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask = topology_core_cpumask(cpu);
 
-	if (tsc_disabled || !constant_tsc || !mask)
+	if (!constant_tsc || !mask)
 		return 0;
 
 	sibling = cpumask_any_but(mask, cpu);
