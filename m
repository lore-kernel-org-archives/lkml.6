Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeC0Hr1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:47:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeC0HrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:47:24 -0400
Date: Tue, 27 Mar 2018 00:47:01 -0700
From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-631fe154edb0a37308d0116a0f9b7bba9dca6218@git.kernel.org>
Cc: tglx@linutronix.de, dbueso@suse.de, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dave@stgolabs.net
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        dbueso@suse.de, tglx@linutronix.de
In-Reply-To: <20180326210929.5244-5-dave@stgolabs.net>
References: <20180326210929.5244-5-dave@stgolabs.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Update rdpmc_always_available static key
 to the modern API
Git-Commit-ID: 631fe154edb0a37308d0116a0f9b7bba9dca6218
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

Commit-ID:  631fe154edb0a37308d0116a0f9b7bba9dca6218
Gitweb:     https://git.kernel.org/tip/631fe154edb0a37308d0116a0f9b7bba9dca6218
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Mon, 26 Mar 2018 14:09:27 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Mar 2018 07:53:00 +0200

perf/x86: Update rdpmc_always_available static key to the modern API

No changes in refcount semantics -- use DEFINE_STATIC_KEY_FALSE()
for initialization and replace:

  static_key_slow_inc|dec()   =>   static_branch_inc|dec()
  static_key_false()          =>   static_branch_unlikely()

Added a '_key' suffix to rdpmc_always_available, for better self-documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Link: http://lkml.kernel.org/r/20180326210929.5244-5-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c             | 6 +++---
 arch/x86/include/asm/mmu_context.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4823695c459f..a6006e7bb729 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -48,7 +48,7 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
 };
 
-struct static_key rdpmc_always_available = STATIC_KEY_INIT_FALSE;
+DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 u64 __read_mostly hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -2206,9 +2206,9 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		 * but only root can trigger it, so it's okay.
 		 */
 		if (val == 2)
-			static_key_slow_inc(&rdpmc_always_available);
+			static_branch_inc(&rdpmc_always_available_key);
 		else
-			static_key_slow_dec(&rdpmc_always_available);
+			static_branch_dec(&rdpmc_always_available_key);
 		on_each_cpu(refresh_pce, NULL, 1);
 	}
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 1de72ce514cd..57e3785d0d26 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -24,11 +24,12 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
 #endif	/* !CONFIG_PARAVIRT */
 
 #ifdef CONFIG_PERF_EVENTS
-extern struct static_key rdpmc_always_available;
+
+DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
 static inline void load_mm_cr4(struct mm_struct *mm)
 {
-	if (static_key_false(&rdpmc_always_available) ||
+	if (static_branch_unlikely(&rdpmc_always_available_key) ||
 	    atomic_read(&mm->context.perf_rdpmc_allowed))
 		cr4_set_bits(X86_CR4_PCE);
 	else
