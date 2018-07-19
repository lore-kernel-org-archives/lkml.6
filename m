Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CDD20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGSXTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:19:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbeGSXTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:19:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMYS292439952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:34:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMYScP2439949;
        Thu, 19 Jul 2018 15:34:28 -0700
Date:   Thu, 19 Jul 2018 15:34:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-03821f451d2d2d7599061244734245be139014ea@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, pasha.tatashin@oracle.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, pasha.tatashin@oracle.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180719205545.16512-26-pasha.tatashin@oracle.com>
References: <20180719205545.16512-26-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Split native_calibrate_cpu() into early
 and late parts
Git-Commit-ID: 03821f451d2d2d7599061244734245be139014ea
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

Commit-ID:  03821f451d2d2d7599061244734245be139014ea
Gitweb:     https://git.kernel.org/tip/03821f451d2d2d7599061244734245be139014ea
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:44 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:44 +0200

x86/tsc: Split native_calibrate_cpu() into early and late parts

During early boot TSC and CPU frequency can be calibrated using MSR, CPUID,
and quick PIT calibration methods. The other methods PIT/HPET/PMTIMER are
available only after ACPI is initialized.

Split native_calibrate_cpu() into early and late parts so they can be
called separately during early and late tsc calibration.

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
Link: https://lkml.kernel.org/r/20180719205545.16512-26-pasha.tatashin@oracle.com

---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 54 ++++++++++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c4368ff73652..88140e4f2292 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -40,6 +40,7 @@ extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
 extern unsigned long native_calibrate_cpu(void);
+extern unsigned long native_calibrate_cpu_early(void);
 extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9277ae9b68b3..60586779b02c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -680,30 +680,17 @@ static unsigned long cpu_khz_from_cpuid(void)
 	return eax_base_mhz * 1000;
 }
 
-/**
- * native_calibrate_cpu - calibrate the cpu on boot
+/*
+ * calibrate cpu using pit, hpet, and ptimer methods. They are available
+ * later in boot after acpi is initialized.
  */
-unsigned long native_calibrate_cpu(void)
+static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
-	unsigned long flags, latch, ms, fast_calibrate;
+	unsigned long flags, latch, ms;
 	int hpet = is_hpet_enabled(), i, loopmin;
 
-	fast_calibrate = cpu_khz_from_cpuid();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	fast_calibrate = cpu_khz_from_msr();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	local_irq_save(flags);
-	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
-	if (fast_calibrate)
-		return fast_calibrate;
-
 	/*
 	 * Run 5 calibration loops to get the lowest frequency value
 	 * (the best estimate). We use two different calibration modes
@@ -846,6 +833,37 @@ unsigned long native_calibrate_cpu(void)
 	return tsc_pit_min;
 }
 
+/**
+ * native_calibrate_cpu_early - can calibrate the cpu early in boot
+ */
+unsigned long native_calibrate_cpu_early(void)
+{
+	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
+
+	if (!fast_calibrate)
+		fast_calibrate = cpu_khz_from_msr();
+	if (!fast_calibrate) {
+		local_irq_save(flags);
+		fast_calibrate = quick_pit_calibrate();
+		local_irq_restore(flags);
+	}
+	return fast_calibrate;
+}
+
+
+/**
+ * native_calibrate_cpu - calibrate the cpu
+ */
+unsigned long native_calibrate_cpu(void)
+{
+	unsigned long tsc_freq = native_calibrate_cpu_early();
+
+	if (!tsc_freq)
+		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+
+	return tsc_freq;
+}
+
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
