Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B17A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B17A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeK3G2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:28:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbeK3G2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:28:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A35E3309B7DD;
        Thu, 29 Nov 2018 19:22:15 +0000 (UTC)
Received: from treble (ovpn-123-4.rdu2.redhat.com [10.10.123.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 165A5104C53B;
        Thu, 29 Nov 2018 19:22:12 +0000 (UTC)
Date:   Thu, 29 Nov 2018 13:22:11 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181129192211.ndzj2ltzx5t6x2qe@treble>
References: <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
 <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home>
 <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home>
 <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home>
 <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <20181129141648.6ef944a9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181129141648.6ef944a9@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 29 Nov 2018 19:22:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:16:48PM -0500, Steven Rostedt wrote:
> > and honestly, the way "static_call()" works now, can you guarantee
> > that the call-site doesn't end up doing that, and calling the
> > trampoline function for two different static calls from one indirect
> > call?
> > 
> > See what I'm talking about? Saying "callers are wrapped in macros"
> > doesn't actually protect you from the compiler doing things like that.
> > 
> > In contrast, if the call was wrapped in an inline asm, we'd *know* the
> > compiler couldn't turn a "call wrapper(%rip)" into anything else.
> 
> But then we need to implement all numbers of parameters.

I actually have an old unfinished patch which (ab)used C macros to
detect the number of parameters and then setup the asm constraints
accordingly.  At the time, the goal was to optimize the BUG code.

I had wanted to avoid this kind of approach for static calls, because
"ugh", but now it's starting to look much more appealing.

Behold:

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index aa6b2023d8f8..d63e9240da77 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -32,10 +32,59 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+#define __BUG_ARGS_0(ins, ...) \
+({\
+	asm volatile("1:\t" ins "\n"); \
+})
+#define __BUG_ARGS_1(ins, ...) \
+({\
+	asm volatile("1:\t" ins "\n" \
+		     : : "D" (ARG1(__VA_ARGS__))); \
+})
+#define __BUG_ARGS_2(ins, ...) \
+({\
+	asm volatile("1:\t" ins "\n" \
+		     : : "D" (ARG1(__VA_ARGS__)), \
+			 "S" (ARG2(__VA_ARGS__))); \
+})
+#define __BUG_ARGS_3(ins, ...) \
+({\
+	asm volatile("1:\t" ins "\n" \
+		     : : "D" (ARG1(__VA_ARGS__)), \
+			 "S" (ARG2(__VA_ARGS__)), \
+			 "d" (ARG3(__VA_ARGS__))); \
+})
+#define __BUG_ARGS_4(ins, ...) \
+({\
+	asm volatile("1:\t" ins "\n" \
+		     : : "D" (ARG1(__VA_ARGS__)), \
+			 "S" (ARG2(__VA_ARGS__)), \
+			 "d" (ARG3(__VA_ARGS__)), \
+			 "c" (ARG4(__VA_ARGS__))); \
+})
+#define __BUG_ARGS_5(ins, ...) \
+({\
+	register u64 __r8 asm("r8") = (u64)ARG5(__VA_ARGS__); \
+	asm volatile("1:\t" ins "\n" \
+		     : : "D" (ARG1(__VA_ARGS__)), \
+			 "S" (ARG2(__VA_ARGS__)), \
+			 "d" (ARG3(__VA_ARGS__)), \
+			 "c" (ARG4(__VA_ARGS__)), \
+			 "r" (__r8)); \
+})
+#define __BUG_ARGS_6 foo
+#define __BUG_ARGS_7 foo
+#define __BUG_ARGS_8 foo
+#define __BUG_ARGS_9 foo
+
+#define __BUG_ARGS(ins, num, ...) __BUG_ARGS_ ## num(ins, __VA_ARGS__)
+
+#define _BUG_ARGS(ins, num, ...) __BUG_ARGS(ins, num, __VA_ARGS__)
+
+#define _BUG_FLAGS(ins, flags, ...)					\
 do {									\
-	asm volatile("1:\t" ins "\n"					\
-		     ".pushsection __bug_table,\"aw\"\n"		\
+	_BUG_ARGS(ins, NUM_ARGS(__VA_ARGS__), __VA_ARGS__);	\
+	asm volatile(".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
 		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
 		     "\t.word %c1"        "\t# bug_entry::line\n"	\
@@ -76,7 +125,7 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags, ...)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags), __VA_ARGS__)
 
 #include <asm-generic/bug.h>
 
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 70c7732c9594..0cb16e912c02 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -58,8 +58,8 @@ struct bug_entry {
 #endif
 
 #ifdef __WARN_FLAGS
-#define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
-#define __WARN_ONCE_TAINT(taint)	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_TAINT(taint))
+#define __WARN_TAINT(taint, args...)		__WARN_FLAGS(BUGFLAG_TAINT(taint), args)
+#define __WARN_ONCE_TAINT(taint, args...)	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_TAINT(taint), args)
 
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
@@ -84,11 +84,12 @@ void warn_slowpath_fmt_taint(const char *file, const int line, unsigned taint,
 extern void warn_slowpath_null(const char *file, const int line);
 #ifdef __WARN_TAINT
 #define __WARN()		__WARN_TAINT(TAINT_WARN)
+#define __WARN_printf(args...)	__WARN_TAINT(TAINT_WARN, args)
 #else
 #define __WARN()		warn_slowpath_null(__FILE__, __LINE__)
+#define __WARN_printf(arg...)	warn_slowpath_fmt(__FILE__, __LINE__, arg)
 #endif
 
-#define __WARN_printf(arg...)	warn_slowpath_fmt(__FILE__, __LINE__, arg)
 #define __WARN_printf_taint(taint, arg...)				\
 	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
 /* used internally by panic.c */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2d2721756abf..e641552e17cf 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -192,6 +192,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define unreachable() do { } while (1)
 #endif
 
+#define __NUM_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, N, ...) N
+#define NUM_ARGS(...) __NUM_ARGS(0, ## __VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+#define ARG1(_1, ...) _1
+#define ARG2(_1, _2, ...) _2
+#define ARG3(_1, _2, _3, ...) _3
+#define ARG4(_1, _2, _3, _4, ...) _4
+#define ARG5(_1, _2, _3, _4, _5, ...) _5
+
 /*
  * KENTRY - kernel entry point
  * This can be used to annotate symbols (functions or data) that are used

-- 
Josh
