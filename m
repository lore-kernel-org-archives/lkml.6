Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeBVJYq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:24:46 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38585 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeBVJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:24:45 -0500
X-Google-Smtp-Source: AH8x2254czHQg16FSxib4VI8ra4esgQjV0LAXgij+kr/zKH8YefFkolTIFudIQLFeBw2oAu+HRaAJw==
From: Andrea Parri <parri.andrea@gmail.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] locking/xchg/alpha: Use smp_mb() in place of __ASM__MB
Date: Thu, 22 Feb 2018 10:24:29 +0100
Message-Id: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace each occurrence of __ASM__MB with a (trailing) smp_mb() in
xchg(), cmpxchg(), and remove the now unused __ASM__MB definitions;
this improves readability, with no additional synchronization cost.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/alpha/include/asm/cmpxchg.h |  6 ------
 arch/alpha/include/asm/xchg.h    | 16 ++++++++--------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 46ebf14aed4e5..8a2b331e43feb 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -6,7 +6,6 @@
  * Atomic exchange routines.
  */
 
-#define __ASM__MB
 #define ____xchg(type, args...)		__xchg ## type ## _local(args)
 #define ____cmpxchg(type, args...)	__cmpxchg ## type ## _local(args)
 #include <asm/xchg.h>
@@ -33,10 +32,6 @@
 	cmpxchg_local((ptr), (o), (n));					\
 })
 
-#ifdef CONFIG_SMP
-#undef __ASM__MB
-#define __ASM__MB	"\tmb\n"
-#endif
 #undef ____xchg
 #undef ____cmpxchg
 #define ____xchg(type, args...)		__xchg ##type(args)
@@ -64,7 +59,6 @@
 	cmpxchg((ptr), (o), (n));					\
 })
 
-#undef __ASM__MB
 #undef ____cmpxchg
 
 #endif /* _ALPHA_CMPXCHG_H */
diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
index e2660866ce972..e1facf6fc2446 100644
--- a/arch/alpha/include/asm/xchg.h
+++ b/arch/alpha/include/asm/xchg.h
@@ -28,12 +28,12 @@ ____xchg(_u8, volatile char *m, unsigned long val)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%3)\n"
 	"	beq	%2,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
 	: "r" ((long)m), "1" (val) : "memory");
+	smp_mb();
 
 	return ret;
 }
@@ -52,12 +52,12 @@ ____xchg(_u16, volatile short *m, unsigned long val)
 	"	or	%1,%2,%2\n"
 	"	stq_c	%2,0(%3)\n"
 	"	beq	%2,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br	1b\n"
 	".previous"
 	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
 	: "r" ((long)m), "1" (val) : "memory");
+	smp_mb();
 
 	return ret;
 }
@@ -72,12 +72,12 @@ ____xchg(_u32, volatile int *m, unsigned long val)
 	"	bis $31,%3,%1\n"
 	"	stl_c %1,%2\n"
 	"	beq %1,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
 	: "=&r" (val), "=&r" (dummy), "=m" (*m)
 	: "rI" (val), "m" (*m) : "memory");
+	smp_mb();
 
 	return val;
 }
@@ -92,12 +92,12 @@ ____xchg(_u64, volatile long *m, unsigned long val)
 	"	bis $31,%3,%1\n"
 	"	stq_c %1,%2\n"
 	"	beq %1,2f\n"
-		__ASM__MB
 	".subsection 2\n"
 	"2:	br 1b\n"
 	".previous"
 	: "=&r" (val), "=&r" (dummy), "=m" (*m)
 	: "rI" (val), "m" (*m) : "memory");
+	smp_mb();
 
 	return val;
 }
@@ -150,12 +150,12 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
 	"2:\n"
-		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
 	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
 	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -177,12 +177,12 @@ ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
 	"	stq_c	%2,0(%4)\n"
 	"	beq	%2,3f\n"
 	"2:\n"
-		__ASM__MB
 	".subsection 2\n"
 	"3:	br	1b\n"
 	".previous"
 	: "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
 	: "r" ((long)m), "Ir" (old), "1" (new) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -200,12 +200,12 @@ ____cmpxchg(_u32, volatile int *m, int old, int new)
 	"	stl_c %1,%2\n"
 	"	beq %1,3f\n"
 	"2:\n"
-		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
 	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	smp_mb();
 
 	return prev;
 }
@@ -223,12 +223,12 @@ ____cmpxchg(_u64, volatile long *m, unsigned long old, unsigned long new)
 	"	stq_c %1,%2\n"
 	"	beq %1,3f\n"
 	"2:\n"
-		__ASM__MB
 	".subsection 2\n"
 	"3:	br 1b\n"
 	".previous"
 	: "=&r"(prev), "=&r"(cmp), "=m"(*m)
 	: "r"((long) old), "r"(new), "m"(*m) : "memory");
+	smp_mb();
 
 	return prev;
 }
-- 
2.7.4
