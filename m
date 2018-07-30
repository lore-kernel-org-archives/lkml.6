Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D6C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB4F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB4F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeG3J3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:29:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51155 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbeG3J3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:29:02 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42811497"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2018 15:55:03 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 154934B69E15;
        Mon, 30 Jul 2018 15:55:02 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Mon, 30 Jul 2018 15:55:04 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH 1/2] x86/tsc: Avoid a double call if TSC initializes earlier.
Date:   Mon, 30 Jul 2018 15:54:20 +0800
Message-ID: <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com>
References: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 154934B69E15.A0516
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_branch_enable(&__use_tsc) may be called twice in common case, that
is redundant. And there are also some common functions both in
tsc_early_init() and tsc_init().

Move them into a separate helper function, only call it once.
Also fix comments:
 -s/authorative/authoritative
 -s/cyc2ns_init/tsc_init

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/tsc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 02e416b87ac1..ba0a6b6e0726 100644
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
 
+static void __init enable_use_tsc(void)
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
+	enable_use_tsc();
 }
 
 void __init tsc_init(void)
@@ -1456,13 +1461,10 @@ void __init tsc_init(void)
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
 		}
-		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-		tsc_store_and_check_tsc_adjust(true);
-		cyc2ns_init_boot_cpu();
+		enable_use_tsc();
 	}
 
 	cyc2ns_init_secondary_cpus();
-	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
 		enable_sched_clock_irqtime();
-- 
2.14.3



