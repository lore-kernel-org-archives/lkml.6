Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeDAUlu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754249AbeDAUlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:47 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/45] C++: Need space between string and symbol
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:45 +0100
Message-ID: <152261530574.30503.8486723819346783664.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C++ requires a space between a string and a following symbol.  For example,
the following is not permitted:

	asm volatile("btl "__percpu_arg(2)",%1"

but this is:

	asm volatile("btl " __percpu_arg(2) ",%1"

The former produces warnings like the following:

	arch/x86/include/asm/alternative.h:95:42: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]

This ought to be possible to script conversion for.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/alternative.h  |   10 ++--
 arch/x86/include/asm/arch_hweight.h |    4 +
 arch/x86/include/asm/percpu.h       |   94 ++++++++++++++++++-----------------
 arch/x86/include/asm/perf_event.h   |    2 -
 include/linux/spinlock.h            |    2 -
 5 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index cf5961ca8677..cc200eb8288e 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -85,14 +85,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
-#define b_replacement(num)	"664"#num
-#define e_replacement(num)	"665"#num
+#define b_replacement(num)	"664" #num
+#define e_replacement(num)	"665" #num
 
 #define alt_end_marker		"663"
 #define alt_slen		"662b-661b"
-#define alt_pad_len		alt_end_marker"b-662b"
-#define alt_total_slen		alt_end_marker"b-661b"
-#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
+#define alt_pad_len		alt_end_marker "b-662b"
+#define alt_total_slen		alt_end_marker "b-661b"
+#define alt_rlen(num)		e_replacement(num) "f-" b_replacement(num) "f"
 
 #define __OLDINSTR(oldinstr, num)					\
 	"661:\n\t" oldinstr "\n662:\n"					\
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index 34a10b2d5b73..75c4038ea63a 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -25,7 +25,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", POPCNT32, X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
+			 : "=" REG_OUT (res)
 			 : REG_IN (w));
 
 	return res;
@@ -53,7 +53,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", POPCNT64, X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
+			 : "=" REG_OUT (res)
 			 : REG_IN (w));
 
 	return res;
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a06b07399d17..10b63180fb27 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -46,7 +46,7 @@
 #include <linux/stringify.h>
 
 #ifdef CONFIG_SMP
-#define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
+#define __percpu_prefix		"%%" __stringify(__percpu_seg) ":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
 /*
@@ -97,22 +97,22 @@ do {							\
 	}						\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b %1,"__percpu_arg(0)		\
+		asm(op "b %1," __percpu_arg(0)		\
 		    : "+m" (var)			\
 		    : "qi" ((pto_T__)(val)));		\
 		break;					\
 	case 2:						\
-		asm(op "w %1,"__percpu_arg(0)		\
+		asm(op "w %1," __percpu_arg(0)		\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 4:						\
-		asm(op "l %1,"__percpu_arg(0)		\
+		asm(op "l %1," __percpu_arg(0)		\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 8:						\
-		asm(op "q %1,"__percpu_arg(0)		\
+		asm(op "q %1," __percpu_arg(0)		\
 		    : "+m" (var)			\
 		    : "re" ((pto_T__)(val)));		\
 		break;					\
@@ -138,41 +138,41 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		if (pao_ID__ == 1)					\
-			asm("incb "__percpu_arg(0) : "+m" (var));	\
+			asm("incb " __percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decb "__percpu_arg(0) : "+m" (var));	\
+			asm("decb " __percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addb %1, "__percpu_arg(0)			\
+			asm("addb %1, " __percpu_arg(0)			\
 			    : "+m" (var)				\
 			    : "qi" ((pao_T__)(val)));			\
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
-			asm("incw "__percpu_arg(0) : "+m" (var));	\
+			asm("incw " __percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decw "__percpu_arg(0) : "+m" (var));	\
+			asm("decw " __percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addw %1, "__percpu_arg(0)			\
+			asm("addw %1, " __percpu_arg(0)			\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 4:								\
 		if (pao_ID__ == 1)					\
-			asm("incl "__percpu_arg(0) : "+m" (var));	\
+			asm("incl " __percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decl "__percpu_arg(0) : "+m" (var));	\
+			asm("decl " __percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addl %1, "__percpu_arg(0)			\
+			asm("addl %1, " __percpu_arg(0)			\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 8:								\
 		if (pao_ID__ == 1)					\
-			asm("incq "__percpu_arg(0) : "+m" (var));	\
+			asm("incq " __percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decq "__percpu_arg(0) : "+m" (var));	\
+			asm("decq " __percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addq %1, "__percpu_arg(0)			\
+			asm("addq %1, " __percpu_arg(0)			\
 			    : "+m" (var)				\
 			    : "re" ((pao_T__)(val)));			\
 		break;							\
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm(op "b " __percpu_arg(1)",%0"		\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm(op "w " __percpu_arg(1)",%0"		\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm(op "l " __percpu_arg(1)",%0"		\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm(op "q " __percpu_arg(1)",%0"		\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
@@ -214,22 +214,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(P1)",%0"	\
+		asm(op "b " __percpu_arg(P1)",%0"	\
 		    : "=q" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(P1)",%0"	\
+		asm(op "w " __percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(P1)",%0"	\
+		asm(op "l " __percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(P1)",%0"	\
+		asm(op "q " __percpu_arg(P1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "p" (&(var)));			\
 		break;					\
@@ -242,19 +242,19 @@ do {									\
 ({							\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(0)		\
+		asm(op "b " __percpu_arg(0)		\
 		    : "+m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(0)		\
+		asm(op "w " __percpu_arg(0)		\
 		    : "+m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(0)		\
+		asm(op "l " __percpu_arg(0)		\
 		    : "+m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(0)		\
+		asm(op "q " __percpu_arg(0)		\
 		    : "+m" (var));			\
 		break;					\
 	default: __bad_percpu_size();			\
@@ -269,22 +269,22 @@ do {									\
 	typeof(var) paro_ret__ = val;					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("xaddb %0, "__percpu_arg(1)				\
+		asm("xaddb %0, " __percpu_arg(1)				\
 			    : "+q" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 2:								\
-		asm("xaddw %0, "__percpu_arg(1)				\
+		asm("xaddw %0, " __percpu_arg(1)				\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 4:								\
-		asm("xaddl %0, "__percpu_arg(1)				\
+		asm("xaddl %0, " __percpu_arg(1)				\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 8:								\
-		asm("xaddq %0, "__percpu_arg(1)				\
+		asm("xaddq %0, " __percpu_arg(1)				\
 			    : "+re" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
@@ -305,32 +305,32 @@ do {									\
 	typeof(var) pxo_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("\n\tmov "__percpu_arg(1)",%%al"			\
-		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
+		asm("\n\tmov " __percpu_arg(1)",%%al"			\
+		    "\n1:\tcmpxchgb %2, " __percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
 			    : "q" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("\n\tmov "__percpu_arg(1)",%%ax"			\
-		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
+		asm("\n\tmov " __percpu_arg(1)",%%ax"			\
+		    "\n1:\tcmpxchgw %2, " __percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
 			    : "r" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("\n\tmov "__percpu_arg(1)",%%eax"			\
-		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
+		asm("\n\tmov " __percpu_arg(1)",%%eax"			\
+		    "\n1:\tcmpxchgl %2, " __percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
 			    : "r" (pxo_new__)				\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("\n\tmov "__percpu_arg(1)",%%rax"			\
-		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
+		asm("\n\tmov " __percpu_arg(1)",%%rax"			\
+		    "\n1:\tcmpxchgq %2, " __percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
 			    : "r" (pxo_new__)				\
@@ -352,25 +352,25 @@ do {									\
 	typeof(var) pco_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("cmpxchgb %2, "__percpu_arg(1)			\
+		asm("cmpxchgb %2, " __percpu_arg(1)			\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "q" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("cmpxchgw %2, "__percpu_arg(1)			\
+		asm("cmpxchgw %2, " __percpu_arg(1)			\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("cmpxchgl %2, "__percpu_arg(1)			\
+		asm("cmpxchgl %2, " __percpu_arg(1)			\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("cmpxchgq %2, "__percpu_arg(1)			\
+		asm("cmpxchgq %2, " __percpu_arg(1)			\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
@@ -450,7 +450,7 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	asm volatile("cmpxchg8b "__percpu_arg(1)"\n\tsetz %0\n\t"	\
+	asm volatile("cmpxchg8b " __percpu_arg(1)"\n\tsetz %0\n\t"	\
 		    : "=a" (__ret), "+m" (pcp1), "+m" (pcp2), "+d" (__o2) \
 		    :  "b" (__n1), "c" (__n2), "a" (__o1));		\
 	__ret;								\
@@ -526,7 +526,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 {
 	bool oldbit;
 
-	asm volatile("btl "__percpu_arg(2)",%1"
+	asm volatile("btl " __percpu_arg(2) ",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
 			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..7c8c8797932e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -256,7 +256,7 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->cs = __KERNEL_CS;				\
 	regs->flags = 0;					\
 	asm volatile(						\
-		_ASM_MOV "%%"_ASM_SP ", %0\n"			\
+		_ASM_MOV "%%" _ASM_SP ", %0\n"			\
 		: "=m" ((regs)->sp)				\
 		:: "memory"					\
 	);							\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d258..84b77941ee11 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -62,7 +62,7 @@
 /*
  * Must define these before including other files, inline functions need them
  */
-#define LOCK_SECTION_NAME ".text..lock."KBUILD_BASENAME
+#define LOCK_SECTION_NAME ".text..lock." KBUILD_BASENAME
 
 #define LOCK_SECTION_START(extra)               \
         ".subsection 1\n\t"                     \
