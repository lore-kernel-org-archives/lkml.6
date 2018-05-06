Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeEFTUw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 15:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbeEFTUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 15:20:45 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 7/9] powerpc: Split breakpoint validation into "check" and "commit"
Date: Sun,  6 May 2018 21:19:53 +0200
Message-Id: <1525634395-23380-8-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525634395-23380-1-git-send-email-frederic@kernel.org>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The breakpoint code mixes up attribute check and commit into a single
code entity. Therefore the validation may return an error due to
incorrect atributes while still leaving halfway modified architecture
breakpoint struct.

Prepare fox fixing this misdesign and separate both logics.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 arch/powerpc/kernel/hw_breakpoint.c | 82 ++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 4c1012b..c39fc86 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -138,33 +138,20 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
 	return 0;
 }
 
-/*
- * Validate the arch-specific HW Breakpoint register settings
- */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+static int hw_breakpoint_arch_check(struct perf_event *bp,
+				    const struct perf_event_attr *attr)
 {
-	int ret = -EINVAL, length_max;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	int length_max;
 
 	if (!bp)
-		return ret;
+		return -EINVAL;
 
-	info->type = HW_BRK_TYPE_TRANSLATE;
-	if (bp->attr.bp_type & HW_BREAKPOINT_R)
-		info->type |= HW_BRK_TYPE_READ;
-	if (bp->attr.bp_type & HW_BREAKPOINT_W)
-		info->type |= HW_BRK_TYPE_WRITE;
-	if (info->type == HW_BRK_TYPE_TRANSLATE)
-		/* must set alteast read or write */
-		return ret;
-	if (!(bp->attr.exclude_user))
-		info->type |= HW_BRK_TYPE_USER;
-	if (!(bp->attr.exclude_kernel))
-		info->type |= HW_BRK_TYPE_KERNEL;
-	if (!(bp->attr.exclude_hv))
-		info->type |= HW_BRK_TYPE_HYP;
-	info->address = bp->attr.bp_addr;
-	info->len = bp->attr.bp_len;
+	/* Must set at least read or write */
+	if (!(attr->bp_type & (HW_BREAKPOINT_R | HW_BREAKPOINT_W)))
+		return -EINVAL;
+
+	if (!ppc_breakpoint_available())
+		return -ENODEV;
 
 	/*
 	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
@@ -172,19 +159,56 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
 	 * 'symbolsize' should satisfy the check below.
 	 */
-	if (!ppc_breakpoint_available())
-		return -ENODEV;
 	length_max = 8; /* DABR */
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 10) != 
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
+		if ((attr->bp_addr >> 10) !=
+		    ((attr->bp_addr + attr->bp_len - 1) >> 10))
 			return -EINVAL;
 	}
-	if (info->len >
-	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
+	if (attr->bp_len >
+	    (length_max - (attr->bp_addr & HW_BREAKPOINT_ALIGN)))
 		return -EINVAL;
+
+	return 0;
+}
+
+static void hw_breakpoint_arch_commit(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	struct perf_event_attr *attr = &bp->attr;
+
+	info->type = HW_BRK_TYPE_TRANSLATE;
+	if (attr->bp_type & HW_BREAKPOINT_R)
+		info->type |= HW_BRK_TYPE_READ;
+	if (attr->bp_type & HW_BREAKPOINT_W)
+		info->type |= HW_BRK_TYPE_WRITE;
+
+	if (!attr->exclude_user)
+		info->type |= HW_BRK_TYPE_USER;
+	if (!attr->exclude_kernel)
+		info->type |= HW_BRK_TYPE_KERNEL;
+	if (!attr->exclude_hv)
+		info->type |= HW_BRK_TYPE_HYP;
+
+	info->address = attr->bp_addr;
+	info->len = attr->bp_len;
+}
+
+/*
+ * Validate the arch-specific HW Breakpoint register settings
+ */
+int arch_validate_hwbkpt_settings(struct perf_event *bp)
+{
+	int err;
+
+	err = hw_breakpoint_arch_check(bp, &bp->attr);
+	if (err)
+		return err;
+
+	hw_breakpoint_arch_commit(bp);
+
 	return 0;
 }
 
-- 
2.7.4
