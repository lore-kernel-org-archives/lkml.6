Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EAE20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YVmg4TXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfB0KRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:17:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33198 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfB0KQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pkSfpon1imSiB+15pp4wM2Yyqp29Osdh1DHZNquaWQ4=; b=YVmg4TXmeWAKXUWs2ht1EmQ8zX
        Ei1GOrAcRxVs60PmHUz9HgmMFKjRdGwUcTqzb8tjFtLU+aQchUCrTkEHSpqrDSmOq5444QiLQ7yzF
        NNzEQpBGvD05+mgATYSmiGo9qCTsdHEtfNZ470VsxSoBi+4OgN7q0a9KgXagrOgKRM76YBUmd4kBo
        KpCG4CyBcAFs5RhiFFH+/OvUzFX0mvsA2TkGWB4XE8Pn9i07c0sAXosZX9G/TDmm8GxXYQZJDC0FM
        nCicBVq5IzIvILT9tdI8U1J+qpCoc7WHJ5RVGGPIB2cKXFZRSWZ301Sx2ZWHvAmFlWNEYUp110Obm
        FJGDZrbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywGO-0007ns-JE; Wed, 27 Feb 2019 10:16:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0494B20309559; Wed, 27 Feb 2019 11:16:29 +0100 (CET)
Message-Id: <20190227101544.210748832@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 27 Feb 2019 11:12:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit reported that commit:

  b59167ac7baf ("x86/percpu: Fix this_cpu_read()")

added a bunch of constraints to all sorts of code; and while some of
that was correct and desired, some of that seems superfluous.

The thing is, the this_cpu_*() operations are defined IRQ-safe, this
means the values are subject to change from IRQs, and thus must be
reloaded.

Also (the generic form):

  local_irq_save()
  __this_cpu_read()
  local_irq_restore()

would not allow the re-use of previous values; if by nothing else,
then the barrier()s implied by local_irq_*().

Which raises the point that percpu_from_op() and the other also need
that volatile.

OTOH __this_cpu_*() operations are not IRQ-safe and assume external
preempt/IRQ disabling and could thus be allowed more room for
optimization.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h |  224 +++++++++++++++++++++---------------------
 1 file changed, 112 insertions(+), 112 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -87,7 +87,7 @@
  * don't give an lvalue though). */
 extern void __bad_percpu_size(void);
 
-#define percpu_to_op(op, var, val)			\
+#define percpu_to_op(qual, op, var, val)		\
 do {							\
 	typedef typeof(var) pto_T__;			\
 	if (0) {					\
@@ -97,22 +97,22 @@ do {							\
 	}						\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b %1,"__percpu_arg(0)		\
+		asm qual (op "b %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "qi" ((pto_T__)(val)));		\
 		break;					\
 	case 2:						\
-		asm(op "w %1,"__percpu_arg(0)		\
+		asm qual (op "w %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 4:						\
-		asm(op "l %1,"__percpu_arg(0)		\
+		asm qual (op "l %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "ri" ((pto_T__)(val)));		\
 		break;					\
 	case 8:						\
-		asm(op "q %1,"__percpu_arg(0)		\
+		asm qual (op "q %1,"__percpu_arg(0)	\
 		    : "+m" (var)			\
 		    : "re" ((pto_T__)(val)));		\
 		break;					\
@@ -124,7 +124,7 @@ do {							\
  * Generate a percpu add to memory instruction and optimize code
  * if one is added or subtracted.
  */
-#define percpu_add_op(var, val)						\
+#define percpu_add_op(qual, var, val)					\
 do {									\
 	typedef typeof(var) pao_T__;					\
 	const int pao_ID__ = (__builtin_constant_p(val) &&		\
@@ -138,41 +138,41 @@ do {									\
 	switch (sizeof(var)) {						\
 	case 1:								\
 		if (pao_ID__ == 1)					\
-			asm("incb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incb "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decb "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decb "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addb %1, "__percpu_arg(0)			\
+			asm qual ("addb %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "qi" ((pao_T__)(val)));			\
 		break;							\
 	case 2:								\
 		if (pao_ID__ == 1)					\
-			asm("incw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incw "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decw "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decw "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addw %1, "__percpu_arg(0)			\
+			asm qual ("addw %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 4:								\
 		if (pao_ID__ == 1)					\
-			asm("incl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incl "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decl "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decl "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addl %1, "__percpu_arg(0)			\
+			asm qual ("addl %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "ri" ((pao_T__)(val)));			\
 		break;							\
 	case 8:								\
 		if (pao_ID__ == 1)					\
-			asm("incq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("incq "__percpu_arg(0) : "+m" (var));	\
 		else if (pao_ID__ == -1)				\
-			asm("decq "__percpu_arg(0) : "+m" (var));	\
+			asm qual ("decq "__percpu_arg(0) : "+m" (var));	\
 		else							\
-			asm("addq %1, "__percpu_arg(0)			\
+			asm qual ("addq %1, "__percpu_arg(0)		\
 			    : "+m" (var)				\
 			    : "re" ((pao_T__)(val)));			\
 		break;							\
@@ -180,27 +180,27 @@ do {									\
 	}								\
 } while (0)
 
-#define percpu_from_op(op, var)				\
+#define percpu_from_op(qual, op, var)			\
 ({							\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm volatile(op "b "__percpu_arg(1)",%0"\
+		asm qual (op "b "__percpu_arg(1)",%0"	\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm volatile(op "w "__percpu_arg(1)",%0"\
+		asm qual (op "w "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm volatile(op "l "__percpu_arg(1)",%0"\
+		asm qual (op "l "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm volatile(op "q "__percpu_arg(1)",%0"\
+		asm qual (op "q "__percpu_arg(1)",%0"	\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
@@ -238,23 +238,23 @@ do {									\
 	pfo_ret__;					\
 })
 
-#define percpu_unary_op(op, var)			\
+#define percpu_unary_op(qual, op, var)			\
 ({							\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(0)		\
+		asm qual (op "b "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(0)		\
+		asm qual (op "w "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(0)		\
+		asm qual (op "l "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(0)		\
+		asm qual (op "q "__percpu_arg(0)	\
 		    : "+m" (var));			\
 		break;					\
 	default: __bad_percpu_size();			\
@@ -264,27 +264,27 @@ do {									\
 /*
  * Add return operation
  */
-#define percpu_add_return_op(var, val)					\
+#define percpu_add_return_op(qual, var, val)				\
 ({									\
 	typeof(var) paro_ret__ = val;					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("xaddb %0, "__percpu_arg(1)				\
+		asm qual ("xaddb %0, "__percpu_arg(1)			\
 			    : "+q" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 2:								\
-		asm("xaddw %0, "__percpu_arg(1)				\
+		asm qual ("xaddw %0, "__percpu_arg(1)			\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 4:								\
-		asm("xaddl %0, "__percpu_arg(1)				\
+		asm qual ("xaddl %0, "__percpu_arg(1)			\
 			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	case 8:								\
-		asm("xaddq %0, "__percpu_arg(1)				\
+		asm qual ("xaddq %0, "__percpu_arg(1)			\
 			    : "+re" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
@@ -299,13 +299,13 @@ do {									\
  * expensive due to the implied lock prefix.  The processor cannot prefetch
  * cachelines if xchg is used.
  */
-#define percpu_xchg_op(var, nval)					\
+#define percpu_xchg_op(qual, var, nval)					\
 ({									\
 	typeof(var) pxo_ret__;						\
 	typeof(var) pxo_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("\n\tmov "__percpu_arg(1)",%%al"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%al"		\
 		    "\n1:\tcmpxchgb %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -313,7 +313,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("\n\tmov "__percpu_arg(1)",%%ax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%ax"		\
 		    "\n1:\tcmpxchgw %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -321,7 +321,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("\n\tmov "__percpu_arg(1)",%%eax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%eax"		\
 		    "\n1:\tcmpxchgl %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -329,7 +329,7 @@ do {									\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("\n\tmov "__percpu_arg(1)",%%rax"			\
+		asm qual ("\n\tmov "__percpu_arg(1)",%%rax"		\
 		    "\n1:\tcmpxchgq %2, "__percpu_arg(1)		\
 		    "\n\tjnz 1b"					\
 			    : "=&a" (pxo_ret__), "+m" (var)		\
@@ -345,32 +345,32 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(var, oval, nval)				\
+#define percpu_cmpxchg_op(qual, var, oval, nval)			\
 ({									\
 	typeof(var) pco_ret__;						\
 	typeof(var) pco_old__ = (oval);					\
 	typeof(var) pco_new__ = (nval);					\
 	switch (sizeof(var)) {						\
 	case 1:								\
-		asm("cmpxchgb %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgb %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "q" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 2:								\
-		asm("cmpxchgw %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgw %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 4:								\
-		asm("cmpxchgl %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgl %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
 		break;							\
 	case 8:								\
-		asm("cmpxchgq %2, "__percpu_arg(1)			\
+		asm qual ("cmpxchgq %2, "__percpu_arg(1)		\
 			    : "=a" (pco_ret__), "+m" (var)		\
 			    : "r" (pco_new__), "0" (pco_old__)		\
 			    : "memory");				\
@@ -391,58 +391,58 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
-#define raw_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
-
-#define raw_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define raw_cpu_add_1(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_add_2(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_add_4(pcp, val)		percpu_add_op((pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
-#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(pcp, val)
-
-#define this_cpu_read_1(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op("mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_1(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_2(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_add_4(pcp, val)	percpu_add_op((pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op("and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op("or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(pcp, nval)
-
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-
-#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
+#define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
+
+#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_xchg_1(pcp, val)	percpu_xchg_op(, pcp, val)
+#define raw_cpu_xchg_2(pcp, val)	percpu_xchg_op(, pcp, val)
+#define raw_cpu_xchg_4(pcp, val)	percpu_xchg_op(, pcp, val)
+
+#define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
+
+#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+
+#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -466,23 +466,23 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define raw_cpu_add_8(pcp, val)			percpu_add_op((pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op("and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
-#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
-#define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
-
-#define this_cpu_read_8(pcp)			percpu_from_op("mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op("mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op((pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op("and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op("or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(pcp, oval, nval)
+#define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
+#define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_xchg_8(pcp, nval)		percpu_xchg_op(, pcp, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
+
+#define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction


