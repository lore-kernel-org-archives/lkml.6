Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE052087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE052087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeIJRN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:13:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:53290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbeIJRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:13:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 05:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="72003878"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 10 Sep 2018 05:19:25 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 10 Sep 2018 15:19:25 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, hpa@zytor.com,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] Revert "x86/tsc: Consolidate init code"
Date:   Mon, 10 Sep 2018 15:19:25 +0300
Message-Id: <20180910121925.27682-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

This reverts commit 608008a45798fe9e2aee04f99b5270ea57c1376f.

It breaks wifi on my pentium 3 Fujitsu-Siemens Lifebook S6010
laptop. Scanning for APs doesn't seem to work most of the time,
and, even when it manages to find some APs it never manages to
authenticate successfully. dmesg is just littered with:
"wlan0: send auth to ... (try 1/3)
 wlan0: send auth to ... (try 2/3)
 wlan0: send auth to ... (try 3/3)
 wlan0: authentication with ... timed out"

Presumably also USB is broken on account of the following noise
in dmesg:
"usb usb2-port2: Cannot enable. Maybe the USB cable is bad?".

Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 arch/x86/kernel/tsc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6490f618e096..203edfabe813 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -182,7 +182,7 @@ static void __init cyc2ns_init_boot_cpu(void)
 }
 
 /*
- * Secondary CPUs do not run through tsc_init(), so set up
+ * Secondary CPUs do not run through cyc2ns_init(), so set up
  * all the scale factors for all CPUs, assuming the same
  * speed as the bootup CPU. (cpufreq notifiers will fix this
  * up if their speed diverges)
@@ -1389,7 +1389,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 	}
 
 	/*
-	 * Trust non-zero tsc_khz as authoritative,
+	 * Trust non-zero tsc_khz as authorative,
 	 * and use it to sanity check cpu_khz,
 	 * which will be off if system timer is off.
 	 */
@@ -1421,14 +1421,6 @@ static unsigned long __init get_loops_per_jiffy(void)
 	return lpj;
 }
 
-static void __init tsc_enable_sched_clock(void)
-{
-	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-	tsc_store_and_check_tsc_adjust(true);
-	cyc2ns_init_boot_cpu();
-	static_branch_enable(&__use_tsc);
-}
-
 void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
@@ -1437,7 +1429,10 @@ void __init tsc_early_init(void)
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
 
-	tsc_enable_sched_clock();
+	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+	tsc_store_and_check_tsc_adjust(true);
+	cyc2ns_init_boot_cpu();
+	static_branch_enable(&__use_tsc);
 }
 
 void __init tsc_init(void)
@@ -1461,10 +1456,13 @@ void __init tsc_init(void)
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
 		}
-		tsc_enable_sched_clock();
+		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+		tsc_store_and_check_tsc_adjust(true);
+		cyc2ns_init_boot_cpu();
 	}
 
 	cyc2ns_init_secondary_cpus();
+	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
 		enable_sched_clock_irqtime();
-- 
2.16.4

