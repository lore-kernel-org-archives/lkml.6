Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CA20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ah31KtCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfB0R2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:28:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfB0R2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZfWlWq9tt0d9KZgwjj4ydT0bW8jVMCsNg2AmVIRiYUU=; b=Ah31KtCFK4gpfhap7l20JAFjO
        fAcM/TCij1kJovIOOP6x06nOM7n/mzJn+f1Kp0r9oCJWWkPkIET5WMmhgl5BOSWjjQ0O+28QTTWig
        RNf0jGtTCKtu3VonxhaOo3XBmhtLTo3lJbJoiVpVlEV+kko84l4K2ynoawjRRMZLCM6ZKmsoXiAse
        7nUNU+XtjXB06I+iux1z4BPxR6lusQs2c2CX9pbjQebokIIGDK2ES0e4WQ9F2aUhF2ZWlI6gqX2QB
        vrbAxHCnaM39g/odlSMpqcpIhYqDBQLUSb3QqFJc3pQsY8ULT3A94rZJWa/KRpFmfcc/ZeqVfuAH7
        CDOhN7dVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gz30E-0005Sg-NU; Wed, 27 Feb 2019 17:28:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B610528523BB0; Wed, 27 Feb 2019 18:28:16 +0100 (CET)
Date:   Wed, 27 Feb 2019 18:28:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
Message-ID: <20190227172816.GT32494@hirez.programming.kicks-ass.net>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
 <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
 <20190227142623.GR32494@hirez.programming.kicks-ass.net>
 <20190227143313.GK32534@hirez.programming.kicks-ass.net>
 <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a9yJvwzwVcjhyOkJUdMp05mxW1++EduLLa2M_buQ7OhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 04:40:28PM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 27, 2019 at 3:33 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Urgh, kasan_report() is definitely unsafe. Now, admitedly we should
> > 'never' hit that, but it does leave us up a creek without a paddle.

> If SMAP detects additional bugs, then it would be pity to disable it
> with KASAN (detect bugs in production but not during testing).
> 
> You mentioned that exception save/restore the UACCESS state. Is it
> possible to do the same in kasan_report? At the very least we need to
> survive report printing, what happens after that does not matter much
> (we've corrupted memory by now anyway).

Ideally we'll put all of kasan_report() in an exception, much like we do
for WARN. But there's a distinct lack of arch hooks there to play with.
I suppose I can try and create some.

On top of that we'll have to mark these __asan functions with notrace.

Maybe a little something horrible like so... completely untested.

---
 arch/x86/include/asm/bug.h   | 28 ++++++++++++++--------------
 arch/x86/include/asm/kasan.h | 11 +++++++++++
 include/asm-generic/bug.h    |  1 +
 include/linux/kasan.h        |  6 +++++-
 lib/bug.c                    |  8 +++++++-
 mm/kasan/generic.c           |  4 ++--
 mm/kasan/kasan.h             |  2 +-
 mm/kasan/report.c            |  2 +-
 8 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..ead3e6ad4eb6 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -30,33 +30,33 @@
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, ...)					\
 do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
+		     "2:\t" __BUG_REL(1b)      "\t# bug_entry::bug_addr\n" \
+		     "\t"  __BUG_REL(%c[file]) "\t# bug_entry::file\n"	\
+		     "\t.word %c[line]"        "\t# bug_entry::line\n"	\
+		     "\t.word %c[flags]"       "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c[size]\n"				\
 		     ".popsection"					\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
-			 "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+		     : : [file] "i" (__FILE__), [line] "i" (__LINE__),	\
+			 [flags] "i" (flags),				\
+			 [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__);	\
 } while (0)
 
 #else /* !CONFIG_DEBUG_BUGVERBOSE */
 
-#define _BUG_FLAGS(ins, flags)						\
+#define _BUG_FLAGS(ins, flags, ...)					\
 do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
+		     "\t.word %c[flags]"  "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c[size]\n"				\
 		     ".popsection"					\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+		     : : [flags] "i" (flags),				\
+			 [size] "i" (sizeof(struct bug_entry)), ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* CONFIG_DEBUG_BUGVERBOSE */
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da38bed..b7d563965b4d 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_KASAN_H
 #define _ASM_X86_KASAN_H
 
+#include <asm/bug.h>
+
 #include <linux/const.h>
 #define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 #define KASAN_SHADOW_SCALE_SHIFT 3
@@ -26,8 +28,17 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_KASAN
+
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+
+static __always_inline void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
+{
+	unsigned long rdi = addr, rsi = size, rdx = is_write, rdx = ip;
+
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN, "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
+}
+
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 0e9bd9c83870..6c829e80ea2a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -10,6 +10,7 @@
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
+#define BUGFLAG_KASAN		(1 << 3)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b40ea104dd36..0ab50faedc9e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -177,7 +177,7 @@ void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
-void kasan_report(unsigned long addr, size_t size,
+void __kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 
 #else /* CONFIG_KASAN_SW_TAGS */
@@ -191,4 +191,8 @@ static inline void *kasan_reset_tag(const void *addr)
 
 #endif /* CONFIG_KASAN_SW_TAGS */
 
+#ifndef kasan_report
+#define kasan_report(addr, size, is_write, ip) __kasan_report(addr, size, is_write, ip)
+#endif
+
 #endif /* LINUX_KASAN_H */
diff --git a/lib/bug.c b/lib/bug.c
index 1077366f496b..c9c005a35b76 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -144,7 +144,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	const char *file;
-	unsigned line, warning, once, done;
+	unsigned line, warning, once, done, kasan;
 
 	if (!is_valid_bugaddr(bugaddr))
 		return BUG_TRAP_TYPE_NONE;
@@ -167,6 +167,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		line = bug->line;
 #endif
 		warning = (bug->flags & BUGFLAG_WARNING) != 0;
+		kasan = (bug->flags & BUGFLAG_KASAN) != 0;
 		once = (bug->flags & BUGFLAG_ONCE) != 0;
 		done = (bug->flags & BUGFLAG_DONE) != 0;
 
@@ -188,6 +189,11 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_WARN;
 	}
 
+	if (kasan) {
+		__kasan_report(regs->di, regs->si, regs->dx, regs->cx);
+		return BUG_TRAP_TYPE_WARN;
+	}
+
 	printk(KERN_DEFAULT CUT_HERE);
 
 	if (file)
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index ccb6207276e3..84be578e2591 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -228,7 +228,7 @@ void __asan_unregister_globals(struct kasan_global *globals, size_t size)
 EXPORT_SYMBOL(__asan_unregister_globals);
 
 #define DEFINE_ASAN_LOAD_STORE(size)					\
-	void __asan_load##size(unsigned long addr)			\
+	notrace void __asan_load##size(unsigned long addr)		\
 	{								\
 		check_memory_region_inline(addr, size, false, _RET_IP_);\
 	}								\
@@ -236,7 +236,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
 	__alias(__asan_load##size)					\
 	void __asan_load##size##_noabort(unsigned long);		\
 	EXPORT_SYMBOL(__asan_load##size##_noabort);			\
-	void __asan_store##size(unsigned long addr)			\
+	notrace void __asan_store##size(unsigned long addr)		\
 	{								\
 		check_memory_region_inline(addr, size, true, _RET_IP_);	\
 	}								\
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ea51b2d898ec..7bc954b4fc2d 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -130,7 +130,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
 void *find_first_bad_addr(void *addr, size_t size);
 const char *get_bug_type(struct kasan_access_info *info);
 
-void kasan_report(unsigned long addr, size_t size,
+void __kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip);
 
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ca9418fe9232..1d5050659388 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -281,7 +281,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags);
 }
 
-void kasan_report(unsigned long addr, size_t size,
+void __kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip)
 {
 	struct kasan_access_info info;
