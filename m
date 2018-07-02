Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B190724F7A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B190724F7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeGBQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:49:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbeGBQtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:49:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98CA480D;
        Mon,  2 Jul 2018 09:48:59 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 468303F5BA;
        Mon,  2 Jul 2018 09:48:59 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9A1B91AE559D; Mon,  2 Jul 2018 17:49:38 +0100 (BST)
Date:   Mon, 2 Jul 2018 17:49:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peter maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for arm64
Message-ID: <20180702164937.GA23687@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
 <20180626151427.GF23375@arm.com>
 <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
 <20180628164700.GD10751@arm.com>
 <176714835.9396.1530219040151.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176714835.9396.1530219040151.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 04:50:40PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 28, 2018, at 12:47 PM, Will Deacon will.deacon@arm.com wrote:
> > On Tue, Jun 26, 2018 at 12:11:52PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon@arm.com wrote:
> >> > On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
> >> >> I notice you are using the instructions
> >> >> 
> >> >>   adrp
> >> >>   add
> >> >>   str
> >> >> 
> >> >> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
> >> >> performance-wise with an approach using a literal pool
> >> >> near the instruction pointer like I did on arm32 ?
> >> > 
> >> > I didn't, no. Do you have a benchmark to hand so I can give this a go?
> >> 
> >> see tools/testing/selftests/rseq/param_test_benchmark --help
> >> 
> >> It's a stripped-down version of param_test, without all the code for
> >> delay loops and testing checks.
> >> 
> >> Example use for counter increment with 4 threads, doing 5G counter
> >> increments per thread:
> >> 
> >> time ./param_test_benchmark -T i -t 4 -r 5000000000
> > 
> > Thanks. I ran that on a few arm64 systems I have access to, with three
> > configurations of the selftest:
> > 
> > 1. As I posted
> > 2. With the abort signature and branch in-lined, so as to avoid the CBNZ
> >   address limitations in large codebases
> > 3. With both the abort handler and the table inlined (i.e. the same thing
> >   as 32-bit).
> > 
> > There isn't a reliably measurable difference between (1) and (2), but I take
> > between 12% and 27% hit between (2) and (3).
> 
> Those results puzzle me. Do you have the actual code snippets of each
> implementation nearby ?

Sure, I've included the diffs for (2) and (3) below. They both apply on top
of my branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git rseq

Will

--->8

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 599788f74137..954f34671ca6 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -104,11 +104,11 @@ do {										\
 	__rseq_str(label) ":\n"
 
 #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
-	"	.pushsection	__rseq_failure, \"ax\"\n"			\
-	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
+	"	b	222f\n"							\
+	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
-	"	.popsection\n"
+	"222:\n"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
 	"	str	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"

--->8

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 599788f74137..2554aa17acf3 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -80,35 +80,37 @@ do {										\
 #define RSEQ_ASM_TMP_REG	"x15"
 #define RSEQ_ASM_TMP_REG_2	"x14"
 
-#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
+#define __RSEQ_ASM_DEFINE_TABLE(version, flags, start_ip,			\
 				post_commit_offset, abort_ip)			\
-	"	.pushsection	__rseq_table, \"aw\"\n"				\
-	"	.balign	32\n"							\
-	__rseq_str(label) ":\n"							\
 	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
 	"	.quad	" __rseq_str(start_ip) ", "				\
 			  __rseq_str(post_commit_offset) ", "			\
-			  __rseq_str(abort_ip) "\n"				\
-	"	.popsection\n"
+			  __rseq_str(abort_ip) "\n"
 
-#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
-	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
-				(post_commit_ip - start_ip), abort_ip)
+#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip)		\
+	"	.pushsection	__rseq_table, \"aw\"\n"				\
+	"	.balign	32\n"							\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,				\
+				(post_commit_ip - start_ip), abort_ip)		\
+	"	.popsection\n"
 
-#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+#define RSEQ_ASM_STORE_RSEQ_CS(label, table_label, rseq_cs)			\
 	RSEQ_INJECT_ASM(1)							\
-	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
-	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
-			", :lo12:" __rseq_str(cs_label) "\n"			\
+	"	adr	" RSEQ_ASM_TMP_REG ", " __rseq_str(table_label) "\n"	\
 	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
 	__rseq_str(label) ":\n"
 
-#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
-	"	.pushsection	__rseq_failure, \"ax\"\n"			\
-	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
+#define RSEQ_ASM_DEFINE_ABORT(table_label, start_ip, post_commit_ip, label,	\
+			      abort_label)					\
+	"	b	222f\n"							\
+	"	.balign 32\n"							\
+	__rseq_str(table_label) ":\n"						\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,				\
+				(post_commit_ip - start_ip), label ## f)	\
+	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
-	"	.popsection\n"
+	"222:\n"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
 	"	str	%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n"
@@ -181,8 +183,8 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -191,9 +193,9 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
 #endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -230,8 +232,8 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
@@ -243,9 +245,9 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		RSEQ_ASM_OP_R_LOAD(v)
 		RSEQ_ASM_OP_R_STORE(load)
 		RSEQ_ASM_OP_R_LOAD_OFF(voffp)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -281,8 +283,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 #ifdef RSEQ_COMPARE_TWICE
@@ -290,9 +292,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 #endif
 		RSEQ_ASM_OP_R_LOAD(v)
 		RSEQ_ASM_OP_R_ADD(count)
-		RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
 		RSEQ_INJECT_ASM(4)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -324,8 +326,8 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -336,9 +338,9 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_STORE(newv2, v2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -378,8 +380,8 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -390,9 +392,9 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_STORE(newv2, v2)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -432,8 +434,8 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -445,9 +447,9 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
 		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
 #endif
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -489,8 +491,8 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -501,9 +503,9 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
@@ -544,8 +546,8 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	RSEQ_INJECT_C(9)
 
 	__asm__ __volatile__ goto (
-		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
-		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f)
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
 		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
@@ -556,9 +558,9 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 		RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
 		RSEQ_INJECT_ASM(5)
-		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 3)
+		RSEQ_ASM_OP_FINAL_STORE_RELEASE(newv, v, 2)
 		RSEQ_INJECT_ASM(6)
-		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		RSEQ_ASM_DEFINE_ABORT(3, 1b, 2b, 4, abort)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (__rseq_abi.cpu_id),
