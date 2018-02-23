Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBWI2f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:28:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBWI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:28:33 -0500
Date: Fri, 23 Feb 2018 00:27:54 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-79d442461df7478cdd0c50d9b8a76f431f150fa3@git.kernel.org>
Cc: will.deacon@arm.com, rth@twiddle.net, mattst88@gmail.com,
        tglx@linutronix.de, hpa@zytor.com, parri.andrea@gmail.com,
        ink@jurassic.park.msu.ru, stern@rowland.harvard.edu,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Reply-To: mattst88@gmail.com, rth@twiddle.net, will.deacon@arm.com,
        tglx@linutronix.de, hpa@zytor.com, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, ink@jurassic.park.msu.ru,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org
In-Reply-To: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
References: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/xchg/alpha: Clean up barrier usage by
 using smp_mb() in place of __ASM__MB
Git-Commit-ID: 79d442461df7478cdd0c50d9b8a76f431f150fa3
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

Commit-ID:  79d442461df7478cdd0c50d9b8a76f431f150fa3
Gitweb:     https://git.kernel.org/tip/79d442461df7478cdd0c50d9b8a76f431f150fa3
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Thu, 22 Feb 2018 10:24:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:38:15 +0100

locking/xchg/alpha: Clean up barrier usage by using smp_mb() in place of __ASM__MB

Replace each occurrence of __ASM__MB with a (trailing) smp_mb() in
xchg(), cmpxchg(), and remove the now unused __ASM__MB definitions;
this improves readability, with no additional synchronization cost.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-alpha@vger.kernel.org
Link: http://lkml.kernel.org/r/1519291469-5702-1-git-send-email-parri.andrea@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/alpha/include/asm/cmpxchg.h |  6 ------
 arch/alpha/include/asm/xchg.h    | 16 ++++++++--------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 46ebf14aed4e..8a2b331e43fe 100644
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
index e2660866ce97..e1facf6fc244 100644
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
