Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeBCCdX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:33:23 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33738 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeBCCdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:33:14 -0500
X-Google-Smtp-Source: AH8x227NTu5VG5VCHcJzCyGt0gEtmjpm/H7bUBycJxkXARBhSgAiLzZ3pnsdQ82NoyfUZl3oIRV0qw==
From: Matthew Whitehead <tedheadster@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH v2] x86/perf : Add check for CPUID instruction before using
Date: Fri,  2 Feb 2018 21:33:03 -0500
Message-Id: <1517625183-22295-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still officially support the ancient i486 cpu. First generation
versions of this processor do not have the CPUID instruction, though
later versions do. Therefore you must check that the cpu supports
it before using it. At present it fails with an "Illegal Instruction"
signal on the early processors.

v1: cpuid detection code based on GCC gcc/config/i386/cpuid.h
    https://gcc.gnu.org/git/?p=gcc.git;a=blob_plain;f=gcc/config/i386/cpuid.h;hb=HEAD
v2: cpuid detection code based on Linux kernel arch/x86/kernel/cpu/common.c

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 tools/perf/arch/x86/util/header.c | 54 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h          |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index fb0d71a..d2508b3 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -7,6 +7,57 @@
 
 #include "../../util/header.h"
 
+#ifndef __x86_64__
+
+/* This code based on arch/x86/kernel/cpu/common.c
+ * Standard macro to see if a specific flag is changeable.
+ */
+static inline int flag_is_changeable_p(u32 flag)
+{
+	u32 f1, f2;
+
+	/*
+	 * Cyrix and IDT cpus allow disabling of CPUID
+	 * so the code below may return different results
+	 * when it is executed before and after enabling
+	 * the CPUID. Add "volatile" to not allow gcc to
+	 * optimize the subsequent calls to this function.
+	 */
+	asm volatile ("pushfl		\n\t"
+		      "pushfl		\n\t"
+		      "popl %0		\n\t"
+		      "movl %0, %1	\n\t"
+		      "xorl %2, %0	\n\t"
+		      "pushl %0		\n\t"
+		      "popfl		\n\t"
+		      "pushfl		\n\t"
+		      "popl %0		\n\t"
+		      "popfl		\n\t"
+
+		      : "=&r" (f1), "=&r" (f2)
+		      : "ir" (flag));
+
+	return ((f1^f2) & flag) != 0;
+}
+
+#define X86_EFLAGS_ID 0x00200000
+
+/* Probe for the CPUID instruction */
+int have_cpuid_p(void)
+{
+	return flag_is_changeable_p(X86_EFLAGS_ID);
+}
+
+#else	/* CONFIG_X86_64 */
+
+/* All X86_64 have cpuid instruction */
+int have_cpuid_p(void)
+{
+	return 1;
+}
+
+#endif	/* CONFIG_X86_64 */
+
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
       unsigned int *d)
@@ -28,6 +79,9 @@
 	int nb;
 	char vendor[16];
 
+	if (!have_cpuid_p())
+		return -1;
+
 	cpuid(0, &lvl, &b, &c, &d);
 	strncpy(&vendor[0], (char *)(&b), 4);
 	strncpy(&vendor[4], (char *)(&d), 4);
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index f28aaaa..f4de656 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -171,6 +171,8 @@ int write_padded(struct feat_fd *fd, const void *bf,
 /*
  * arch specific callback
  */
+int have_cpuid_p(void);
+
 int get_cpuid(char *buffer, size_t sz);
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
-- 
1.8.3.1
