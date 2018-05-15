Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeEOV2u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:28:50 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:54610 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752669AbeEOV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:13 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC 6/8] x86: removing unneeded new-lines
Date: Tue, 15 May 2018 07:11:13 -0700
Message-ID: <20180515141124.84254-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

This patch removes unneeded new-lines and semicolons to prevent such
distortion.

Functions such as nfs_io_completion_put() get inlined. Its overall
effect is not shown in the absolute numbers, but it seems to enable
slightly better inlining:

   text	   data	    bss	    dec	    hex	filename
18148228 10063968 2936832 31149028 1db4be4 ./vmlinux before
18148888 10064016 2936832 31149736 1db4ea8 ./vmlinux after (+708)

Static text symbols:
Before:	39649
After:	39650	(+1)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/asm.h           |  4 ++--
 arch/x86/include/asm/cmpxchg.h       | 10 +++++-----
 arch/x86/include/asm/special_insns.h | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..571ceec97976 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -51,10 +51,10 @@
  * The output operand must be type "bool".
  */
 #ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
+# define CC_SET(c) "\n\t/* output condition code " #c "*/"
 # define CC_OUT(c) "=@cc" #c
 #else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
+# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]"
 # define CC_OUT(c) [_cc_ ## c] "=qm"
 #endif
 
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index e3efd8a06066..2be9582fcb2e 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -44,22 +44,22 @@ extern void __add_wrong_size(void)
 	        __typeof__ (*(ptr)) __ret = (arg);			\
 		switch (sizeof(*(ptr))) {				\
 		case __X86_CASE_B:					\
-			asm volatile (lock #op "b %b0, %1\n"		\
+			asm volatile (lock #op "b %b0, %1"		\
 				      : "+q" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_W:					\
-			asm volatile (lock #op "w %w0, %1\n"		\
+			asm volatile (lock #op "w %w0, %1"		\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_L:					\
-			asm volatile (lock #op "l %0, %1\n"		\
+			asm volatile (lock #op "l %0, %1"		\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
 		case __X86_CASE_Q:					\
-			asm volatile (lock #op "q %q0, %1\n"		\
+			asm volatile (lock #op "q %q0, %1"		\
 				      : "+r" (__ret), "+m" (*(ptr))	\
 				      : : "memory", "cc");		\
 			break;						\
@@ -134,7 +134,7 @@ extern void __add_wrong_size(void)
 	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
 
 #define __sync_cmpxchg(ptr, old, new, size)				\
-	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
+	__raw_cmpxchg((ptr), (old), (new), (size), "lock ")
 
 #define __cmpxchg_local(ptr, old, new, size)				\
 	__raw_cmpxchg((ptr), (old), (new), (size), "")
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 317fc59b512c..9c56059aaf24 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -19,7 +19,7 @@ extern unsigned long __force_order;
 static inline unsigned long native_read_cr0(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr0,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr0,%0" : "=r" (val), "=m" (__force_order));
 	return val;
 }
 
@@ -31,7 +31,7 @@ static inline void native_write_cr0(unsigned long val)
 static inline unsigned long native_read_cr2(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr2,%0" : "=r" (val), "=m" (__force_order));
 	return val;
 }
 
@@ -43,7 +43,7 @@ static inline void native_write_cr2(unsigned long val)
 static inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
-	asm volatile("mov %%cr3,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr3,%0" : "=r" (val), "=m" (__force_order));
 	return val;
 }
 
@@ -67,7 +67,7 @@ static inline unsigned long native_read_cr4(void)
 		     : "=r" (val), "=m" (__force_order) : "0" (0));
 #else
 	/* CR4 always exists on x86_64. */
-	asm volatile("mov %%cr4,%0\n\t" : "=r" (val), "=m" (__force_order));
+	asm volatile("mov %%cr4,%0" : "=r" (val), "=m" (__force_order));
 #endif
 	return val;
 }
@@ -101,7 +101,7 @@ static inline u32 __read_pkru(void)
 	 * "rdpkru" instruction.  Places PKRU contents in to EAX,
 	 * clears EDX and requires that ecx=0.
 	 */
-	asm volatile(".byte 0x0f,0x01,0xee\n\t"
+	asm volatile(".byte 0x0f,0x01,0xee"
 		     : "=a" (pkru), "=d" (edx)
 		     : "c" (ecx));
 	return pkru;
@@ -115,7 +115,7 @@ static inline void __write_pkru(u32 pkru)
 	 * "wrpkru" instruction.  Loads contents in EAX to PKRU,
 	 * requires that ecx = edx = 0.
 	 */
-	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+	asm volatile(".byte 0x0f,0x01,0xef"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
 #else
-- 
2.17.0
