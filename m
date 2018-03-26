Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeCZVYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:24:44 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:41073 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbeCZVWH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 26 Mar 2018 17:22:07 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/6] perf,x86: Update rdpmc_always_available static key to modern api
Date: Mon, 26 Mar 2018 14:09:27 -0700
Message-Id: <20180326210929.5244-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180326210929.5244-1-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No changes in refcount semantics -- key init is false; replace

static_key_slow_inc|dec   with   static_branch_inc|dec
static_key_false          with   static_branch_unlikely

Added a '_key' suffix to rdpmc_always_available, for better self
documentation.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/events/core.c             | 6 +++---
 arch/x86/include/asm/mmu_context.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c5f3d83c04ad..7a987e6c7c35 100644
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
-- 
2.13.6
