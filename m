Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeEBON0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:13:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:13:23 -0400
Date: Wed, 2 May 2018 07:12:45 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e9088adda13cd23249d4b0abb97ff8a81bf5573a@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        mingo@kernel.org, diego.viola@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        diego.viola@gmail.com, rafael.j.wysocki@intel.com, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20180430100344.350507853@infradead.org>
References: <20180430100344.350507853@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] x86/tsc: Always unregister
 clocksource_tsc_early
Git-Commit-ID: e9088adda13cd23249d4b0abb97ff8a81bf5573a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e9088adda13cd23249d4b0abb97ff8a81bf5573a
Gitweb:     https://git.kernel.org/tip/e9088adda13cd23249d4b0abb97ff8a81bf5573a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:10:40 +0200

x86/tsc: Always unregister clocksource_tsc_early

Don't leave the tsc-early clocksource registered if it errors out
early.

This was reported by Diego, who on his Core2 era machine got TSC
invalidated while it was running with tsc-early (due to C-states).
This results in keeping tsc-early with very bad effects.

Reported-and-Tested-by: Diego Viola <diego.viola@gmail.com>
Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.350507853@infradead.org

---
 arch/x86/kernel/tsc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 91e6da48cbb6..23f36bc236ba 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1244,7 +1244,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 	/* Don't bother refining TSC on unstable systems */
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	/*
 	 * Since the work is started early in boot, we may be
@@ -1297,11 +1297,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
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
 
@@ -1311,8 +1312,8 @@ static int __init init_tsc_clocksource(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
 		return 0;
 
-	if (check_tsc_unstable())
-		return 0;
+	if (tsc_unstable)
+		goto unreg;
 
 	if (tsc_clocksource_reliable)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
@@ -1328,6 +1329,7 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
 	}
