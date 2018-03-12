Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsgr2wzFQNPK0GBn1ZxQXQQGyDDvnk9X3JNX/tjETXNS01bUbLwq1ORhUI0hgwO4E1l+ofR
ARC-Seal: i=1; a=rsa-sha256; t=1520824075; cv=none;
        d=google.com; s=arc-20160816;
        b=cnei4KKZzMDVxklV1DxeXOrAGZPv/6gGZqjAR2pd1Wij27EIh+4cwEYCM7YE2v1FyQ
         S++QqhqXdRxfJT5juS5GtAo1zgMGcWBlWzHTEp7NJYSvrWt5FVGBInPWfe0CfjH0WVb9
         0sVVDXpU0YgapiLCh3NgwcPnAIgusEmwETCW/8q4t6SHmmMmut2/96zkibF2uSh3Ma0Y
         mYIiRTp+L/QlAHMNRzzmJG0Y8JUNuyoCvbMIiTXCQWuJQBsc0K1jMDpWg60YsEbkqrHC
         wJrXBhJ0M0wXqniGjslj0vw341KacHC2mDqNLkON5Bfmbkxi+ziB4NZ+Fner/SYlC6Qm
         QsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=/jThiTNOUO4/AVEGirvmVKeKyuo5jPMDmF2zHtOmg4w=;
        b=gw9t7Tjyl5nmt6Tsbv3Iew3S77D8/SSuy+lJlzejClmTc5KRxjbFQme01SfSqrVoWQ
         dOtxHen7aCntroPdmrDQVo+kfduMZDNZzncw5hODU/+iqYgzSjzfPFBfZGoAuY5zMKRn
         uKQFCZWyzZ+VkYwbmpMjnRFMT/Xmc3jdjXRmBI3FQWweB6oCe4SEs4cug4L3hLYSBKPY
         nkmB9VV2UQjwaalP5NciZMlDM6oc8HLWWpOhr69KVLx0LY2gYgS8MmITY5Zfs2fF0cUu
         VB8GbZ51H1JddSpygXiQzX8VTCW5glXycr9+BuIojv5FB7TR3J2Zs+EsOZZWIaWhZ7DL
         eedg==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
 "David Woodhouse" <dwmw@amazon.co.ku>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Razvan Ghitulete" <rga@amazon.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.192694988@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 22/76] x86/asm: Use register variable to get stack
 pointer value
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614585005549?=
X-GMAIL-MSGID: =?utf-8?q?1594699625495423159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: drop change in ist_begin_non_atomic()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -80,4 +80,15 @@
 /* For C file, we already have NOKPROBE_SYMBOL macro */
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
@@ -170,17 +170,6 @@ static inline struct thread_info *curren
 	return ti;
 }
 
-static inline unsigned long current_stack_pointer(void)
-{
-	unsigned long sp;
-#ifdef CONFIG_X86_64
-	asm("mov %%rsp,%0" : "=g" (sp));
-#else
-	asm("mov %%esp,%0" : "=g" (sp));
-#endif
-	return sp;
-}
-
 #else /* !__ASSEMBLY__ */
 
 /* how to get the thread information struct from ASM */
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -71,7 +71,7 @@ static void call_on_stack(void *func, vo
 
 static inline void *current_stack(void)
 {
-	return (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	return (void *)(current_stack_pointer & ~(THREAD_SIZE - 1));
 }
 
 static inline int
@@ -96,7 +96,7 @@ execute_on_irq_stack(int overflow, struc
 
 	/* Save the next esp at the bottom of the stack */
 	prev_esp = (u32 *)irqstk;
-	*prev_esp = current_stack_pointer();
+	*prev_esp = current_stack_pointer;
 
 	if (unlikely(overflow))
 		call_on_stack(print_stack_overflow, isp);
@@ -149,7 +149,7 @@ void do_softirq_own_stack(void)
 
 	/* Push the previous esp onto the stack */
 	prev_esp = (u32 *)irqstk;
-	*prev_esp = current_stack_pointer();
+	*prev_esp = current_stack_pointer;
 
 	call_on_stack(__do_softirq, isp);
 }
