Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeELVKr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:10:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:10:45 -0400
Date: Sat, 12 May 2018 14:10:17 -0700
From: tip-bot for Suravee Suthikulpanit <tipbot@zytor.com>
Message-ID: <tip-812af433038f984fd951224e8239b09188e36a13@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        suravee.suthikulpanit@amd.com, Janakarajan.Natarajan@amd.com,
        bp@suse.de, mingo@kernel.org, peterz@infradead.org
Reply-To: tglx@linutronix.de, suravee.suthikulpanit@amd.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
        Janakarajan.Natarajan@amd.com, bp@suse.de
In-Reply-To: <1524864877-111962-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-3-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] perf/events/amd/uncore: Fix amd_uncore_llc ID to use
 pre-defined cpu_llc_id
Git-Commit-ID: 812af433038f984fd951224e8239b09188e36a13
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

Commit-ID:  812af433038f984fd951224e8239b09188e36a13
Gitweb:     https://git.kernel.org/tip/812af433038f984fd951224e8239b09188e36a13
Author:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate: Fri, 27 Apr 2018 16:34:35 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:15 +0200

perf/events/amd/uncore: Fix amd_uncore_llc ID to use pre-defined cpu_llc_id

Current logic iterates over CPUID Fn8000001d leafs (Cache Properties)
to detect the last level cache, and derive the last-level cache ID.
However, this information is already available in the cpu_llc_id.
Therefore, make use of it instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Link: http://lkml.kernel.org/r/1524864877-111962-3-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/events/amd/uncore.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f5cbbba99283..981ba5e8241b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
+#include <asm/smp.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
@@ -399,26 +400,8 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 	}
 
 	if (amd_uncore_llc) {
-		unsigned int apicid = cpu_data(cpu).apicid;
-		unsigned int nshared, subleaf, prev_eax = 0;
-
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		/*
-		 * Iterate over Cache Topology Definition leaves until no
-		 * more cache descriptions are available.
-		 */
-		for (subleaf = 0; subleaf < 5; subleaf++) {
-			cpuid_count(0x8000001d, subleaf, &eax, &ebx, &ecx, &edx);
-
-			/* EAX[0:4] gives type of cache */
-			if (!(eax & 0x1f))
-				break;
-
-			prev_eax = eax;
-		}
-		nshared = ((prev_eax >> 14) & 0xfff) + 1;
-
-		uncore->id = apicid - (apicid % nshared);
+		uncore->id = per_cpu(cpu_llc_id, cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
