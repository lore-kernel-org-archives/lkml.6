Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuWDTVILyfgoHORxkXw4r1Jb72PkcNTCIBJW0Jg7a1nfc96Pw37LY7OlZo8eOIWZHtND2Ru
ARC-Seal: i=1; a=rsa-sha256; t=1520824065; cv=none;
        d=google.com; s=arc-20160816;
        b=U3xT29meWwWtQY169uMSvjaQXOvG7gQ5iYoU0VfA2xEXLqG+vs70kL2gQYc18Gn51L
         LPjAorcE0Mk9pCyY5t33TJY0UCygdJAyzL8eFTie4yIEao1cFF0NA/kBwjbnFrkt0/Af
         3ifjgfhFhH9lGxI4+R5eQmMN1dE9L0XgHc4wSxdsUTbk+0PRCetEu0yrK9SFGSJFBVyU
         ghD1AblHjDYiuWZSyOaFEnmNOIA1pYfcFyIq+Oujpdso9rxuZJjHDNwuth3krwVgmLku
         8p0b1ip0/dmQJbAOU1qtopBWI51d4EyWkanoZvCQnLuUE4jK7YYDnzzPtNQNJszxKZ5L
         yx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zkePWTPpheReo2XFqATeov04mQ24DA/EzzNo5KobTLg=;
        b=MkI4L958WvDpLQUnJWJ6gw8ZvX1ph4KJrx/YKuEbw7LgxuWf+vzuYPVIUR79bnQV1t
         jDeUgLa+KlORfb2nEAYmh4rnDG8kFK154f+UK6ihb8DmF2rYMu0zuXbBlz9AvHZnamXb
         96MQXWFiuGBdPuFUu11snWzpdGL+S0LsdwP6cLALQ/itZeN8QfyUk5iT4/uKikIzyKiJ
         IOer/VvHR02sWGT90yHsIIDDQAWyShGtH2KAEwQad+DEje5yvaMs7HqE5ruHdaaple2M
         qWIhUSHgI8pQu2BEJ6xBNrkw52MxaFvDLSzdLIzzXPRL8Hsl1z/X3pkd3l7Ad3Wvkjvs
         BiYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.ku>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Razvan Ghitulete" <rga@amazon.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.937283006@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 057/104] x86/asm: Use register variable to get stack
 pointer value
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614585005549?=
X-GMAIL-MSGID: =?utf-8?q?1594699614585005549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 196bd485ee4f03ce4c690bfcf38138abfcd0a4bc upstream.

Currently we use current_stack_pointer() function to get the value
of the stack pointer register. Since commit:

  f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")

... we have a stack register variable declared. It can be used instead of
current_stack_pointer() function which allows to optimize away some
excessive "mov %rsp, %<dst>" instructions:

 -mov    %rsp,%rdx
 -sub    %rdx,%rax
 -cmp    $0x3fff,%rax
 -ja     ffffffff810722fd <ist_begin_non_atomic+0x2d>

 +sub    %rsp,%rax
 +cmp    $0x3fff,%rax
 +ja     ffffffff810722fa <ist_begin_non_atomic+0x2a>

Remove current_stack_pointer(), rename __asm_call_sp to current_stack_pointer
and use it instead of the removed function.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170929141537.29167-1-aryabinin@virtuozzo.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[dwmw2: We want ASM_CALL_CONSTRAINT for retpoline]
Signed-off-by: David Woodhouse <dwmw@amazon.co.ku>
Signed-off-by: Razvan Ghitulete <rga@amazon.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: current_stack_pointer was never changed to a function,
 but was only defined for x86_32]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -59,4 +59,15 @@
 	" .previous\n"
 #endif
 
+#ifndef __ASSEMBLY__
+/*
+ * This output constraint should be used for any inline asm which has a "call"
+ * instruction.  Otherwise the asm may be inserted before the frame pointer
+ * gets set up by the containing function.  If you forget to do this, objtool
+ * may print a "call without frame pointer save/setup" warning.
+ */
+register unsigned long current_stack_pointer asm(_ASM_SP);
+#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
+#endif
+
 #endif /* _ASM_X86_ASM_H */
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -181,9 +181,6 @@ struct thread_info {
 #ifndef __ASSEMBLY__
 
 
-/* how to get the current stack pointer from C */
-register unsigned long current_stack_pointer asm("esp") __used;
-
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
