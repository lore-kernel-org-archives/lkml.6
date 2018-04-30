Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeD3KEq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:04:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeD3KEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:44 -0400
Message-Id: <20180430100344.350507853@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com, stable@kernel.org
Subject: [PATCH v2 1/7] x86,tsc: Always unregister clocksource_tsc_early
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-1.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leave the tsc-early clocksource registered if it errors out
early.

This was reported by Diego, who on his Core2 era machine got TSC
invalidated while it was running with tsc-early (due to C-states).
This results in keeping tsc-early with very bad effects.

Reported-and-Tested-by: Diego Viola <diego.viola@gmail.com>
Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/tsc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1244,7 +1244,7 @@ static void tsc_refine_calibration_work(
 
 	/* Don't bother refining TSC on unstable systems */
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	/*
 	 * Since the work is started early in boot, we may be
@@ -1297,11 +1297,12 @@ static void tsc_refine_calibration_work(
 
 out:
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
 
@@ -1311,8 +1312,8 @@ static int __init init_tsc_clocksource(v
 	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
 		return 0;
 
-	if (check_tsc_unstable())
-		return 0;
+	if (tsc_unstable)
+		goto unreg;
 
 	if (tsc_clocksource_reliable)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
@@ -1328,6 +1329,7 @@ static int __init init_tsc_clocksource(v
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
 	}
