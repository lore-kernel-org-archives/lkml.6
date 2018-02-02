Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeBBObP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:31:15 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42703 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBBObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:31:06 -0500
X-Google-Smtp-Source: AH8x2258mG8tVBL6VWEPtXqIEjYya8kD1rz/iaU2aJy+E48tGyQndifQDK2HXsp0IceS28KOHzldBA==
From: Matthew Whitehead <tedheadster@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH] x86/perf : Add check for CPUID instruction before using
Date: Fri,  2 Feb 2018 09:30:51 -0500
Message-Id: <1517581851-6600-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still officially support the ancient i486 cpu. First generation
versions of this processor do not have the CPUID instruction, though
later versions do. Therefore you must check that the cpu supports
it before using it. At present it fails with an "Illegal Instruction"
signal on the early processors.

This code was based on similar code in the gcc package.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 tools/perf/arch/x86/util/header.c | 51 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h          |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
index fb0d71afee8b..d4d12894c64d 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -7,6 +7,54 @@
 
 #include "../../util/header.h"
 
+/* This code based on gcc cpuid.h __get_cpuid_max() */
+unsigned int have_cpuid(void)
+{
+	unsigned int __eax, __ebx;
+
+#ifndef __x86_64__
+/* See if we can use cpuid.  On AMD64 we always can.  */
+#if __GNUC__ >= 3
+	__asm__ ("pushf{l|d}\n\t"
+		"pushf{l|d}\n\t"
+		"pop{l}\t%0\n\t"
+		"mov{l}\t{%0, %1|%1, %0}\n\t"
+		"xor{l}\t{%2, %0|%0, %2}\n\t"
+		"push{l}\t%0\n\t"
+		"popf{l|d}\n\t"
+		"pushf{l|d}\n\t"
+		"pop{l}\t%0\n\t"
+		"popf{l|d}\n\t"
+		: "=&r" (__eax), "=&r" (__ebx)
+		: "i" (0x00200000));
+#else
+/* Host GCCs older than 3.0 weren't supporting Intel asm syntax
+ * nor alternatives in i386 code.
+ */
+	__asm__ ("pushfl\n\t"
+		"pushfl\n\t"
+		"popl\t%0\n\t"
+		"movl\t%0, %1\n\t"
+		"xorl\t%2, %0\n\t"
+		"pushl\t%0\n\t"
+		"popfl\n\t"
+		"pushfl\n\t"
+		"popl\t%0\n\t"
+		"popfl\n\t"
+		: "=&r" (__eax), "=&r" (__ebx)
+		: "i" (0x00200000));
+#endif
+
+	if (!((__eax ^ __ebx) & 0x00200000))
+		return 0;
+	else
+		return 1;
+#endif
+
+/* All x86_64 support cpuid */
+	return 1;
+}
+
 static inline void
 cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
       unsigned int *d)
@@ -28,6 +76,9 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
 	int nb;
 	char vendor[16];
 
+	if (!have_cpuid())
+		return -1;
+
 	cpuid(0, &lvl, &b, &c, &d);
 	strncpy(&vendor[0], (char *)(&b), 4);
 	strncpy(&vendor[4], (char *)(&d), 4);
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index f28aaaa3a440..ce31fca36077 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -171,6 +171,8 @@ int write_padded(struct feat_fd *fd, const void *bf,
 /*
  * arch specific callback
  */
+unsigned int have_cpuid(void);
+
 int get_cpuid(char *buffer, size_t sz);
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
-- 
2.13.6
