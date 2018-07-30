Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8905216256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B86A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B86A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeG3TOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:14:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:14:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHbttu2388567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:37:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHbtwl2388564;
        Mon, 30 Jul 2018 10:37:55 -0700
Date:   Mon, 30 Jul 2018 10:37:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-608008a45798fe9e2aee04f99b5270ea57c1376f@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, pasha.tatashin@oracle.com,
        linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com
Reply-To: linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
          douly.fnst@cn.fujitsu.com, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
References: <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Consolidate init code
Git-Commit-ID: 608008a45798fe9e2aee04f99b5270ea57c1376f
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

Commit-ID:  608008a45798fe9e2aee04f99b5270ea57c1376f
Gitweb:     https://git.kernel.org/tip/608008a45798fe9e2aee04f99b5270ea57c1376f
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Mon, 30 Jul 2018 15:54:20 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:33:35 +0200

x86/tsc: Consolidate init code

Split out suplicated code from tsc_early_init() and tsc_init() into a
common helper and fixup some comment typos.

[ tglx: Massaged changelog and renamed function ]

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180730075421.22830-2-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/tsc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 02e416b87ac1..1463468ba9a0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -182,7 +182,7 @@ static void __init cyc2ns_init_boot_cpu(void)
 }
 
 /*
- * Secondary CPUs do not run through cyc2ns_init(), so set up
+ * Secondary CPUs do not run through tsc_init(), so set up
  * all the scale factors for all CPUs, assuming the same
  * speed as the bootup CPU. (cpufreq notifiers will fix this
  * up if their speed diverges)
@@ -1389,7 +1389,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 	}
 
 	/*
-	 * Trust non-zero tsc_khz as authorative,
+	 * Trust non-zero tsc_khz as authoritative,
 	 * and use it to sanity check cpu_khz,
 	 * which will be off if system timer is off.
 	 */
@@ -1421,6 +1421,14 @@ static unsigned long __init get_loops_per_jiffy(void)
 	return lpj;
 }
 
+static void __init tsc_enable_sched_clock(void)
+{
+	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+	tsc_store_and_check_tsc_adjust(true);
+	cyc2ns_init_boot_cpu();
+	static_branch_enable(&__use_tsc);
+}
+
 void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
@@ -1429,10 +1437,7 @@ void __init tsc_early_init(void)
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
 
-	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-	tsc_store_and_check_tsc_adjust(true);
-	cyc2ns_init_boot_cpu();
-	static_branch_enable(&__use_tsc);
+	tsc_enable_sched_clock();
 }
 
 void __init tsc_init(void)
@@ -1456,13 +1461,10 @@ void __init tsc_init(void)
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
 		}
-		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-		tsc_store_and_check_tsc_adjust(true);
-		cyc2ns_init_boot_cpu();
+		tsc_enable_sched_clock();
 	}
 
 	cyc2ns_init_secondary_cpus();
-	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
 		enable_sched_clock_irqtime();
