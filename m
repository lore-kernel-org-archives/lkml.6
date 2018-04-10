Return-Path: <kernel-hardening-return-12948-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/0F1OmYMJFgcGmf/2phB0qfYd3xz7wkfTxAkwiXk5V2wW823L6GthErnsTxEBv+ag9A9Km
ARC-Seal: i=1; a=rsa-sha256; t=1523345503; cv=none;
        d=google.com; s=arc-20160816;
        b=gPSvhqCgDqnNWdhZMUyqEhy+0qnP5Nf5dDU2q7OuQSdShU/89EPAWiHnBNPAvoukmO
         fb6q4Q5W97CeS60p+q4NAiVFGL1qV/0Kd3nSReNr6zvLxvT2xVbJSNgEXBR+6+MFp+j2
         zwiBUhbB4CRyO7S/X1Sb4eU/uwG0lcQaDprf54sXCuRYsgUNIjIvN3PVr4FDeQ3eXgrv
         pnmA4CESuylOW2TGc80vNWnOBP85sfmlXMxsOJo78rb8FlKZ5VZ6STjJuPFUP64qr1Ku
         41vJV8OLrjiQiYSoFyLdpF/2L++mEZckJKRZ+sbOp6y6FU1mo5Su3EW1GgkoLZlxBpeD
         afvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QVdUNFQEP2PBzgiizGMptMiMFI80vvYZP7iNFdF67Sg=;
        b=IYPzzXSdhM9Sy0geB7Gq0aUnUlvosRP5oXWdbkBG7xc49b/mel5HyDsCpQSELiWrYk
         qI6raTsoJobmyam5FJdLgqhToxqyr2Ske25FC7RyZJK9qKZ3tOxNyi5Ilqc4R17cnoHk
         ErQYC4jRrX8T080WEnEnwlRuCIHRWm83Bze+tke2NPdgXdkWYosyUHWUU5IL37e1jKe1
         +Ic9Hl2dtkQHifioAr/2P7ky2dJ8H+ZkVs0r2GNhgHWQv4U8VOdXr2krsDB5vfnf9xOj
         oxYIcp98FnrpM5VvUy5dKSY93o+XIDmazLnIlC/l2n0LWzy4Wupw2jI6AvN4pFUf4PkT
         ciIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=beBpv6g8;
       spf=pass (google.com: domain of kernel-hardening-return-12948-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12948-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=beBpv6g8;
       spf=pass (google.com: domain of kernel-hardening-return-12948-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12948-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: kpark3469@gmail.com
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com,
	keescook@chromium.org,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	james.morse@arm.com,
	panand@redhat.com,
	keun-o.park@darkmatter.ae,
	psodagud@codeaurora.org,
	jpoimboe@redhat.com,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] stacktrace: move arch_within_stack_frames from thread_info.h
Date: Tue, 10 Apr 2018 11:30:45 +0400
Message-Id: <1523345447-10725-2-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523345447-10725-1-git-send-email-kpark3469@gmail.com>
References: <1523345447-10725-1-git-send-email-kpark3469@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597343534429179630?=
X-GMAIL-MSGID: =?utf-8?q?1597343534429179630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sahara <keun-o.park@darkmatter.ae>

Since the inlined arch_within_stack_frames function was placed within
asm/thread_info.h, using stacktrace functions to unwind stack was
restricted. Now in order to have this function use more abundant apis,
it is moved to architecture's stacktrace.c. And, it is changed from
inline to noinline function to clearly have three depth calls like:

do_usercopy_stack()
  copy_[to|from]_user() : inline
    check_copy_size() : inline
      __check_object_size()
        check_stack_object()
          arch_within_stack_frames()

With this change, the x86's implementation was slightly changed also.

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/thread_info.h | 51 +-------------------------------------
 arch/x86/kernel/Makefile           |  2 +-
 arch/x86/kernel/stacktrace.c       | 49 ++++++++++++++++++++++++++++++++++++
 include/linux/stacktrace.h         | 24 ++++++++++++++++++
 include/linux/thread_info.h        | 21 ----------------
 mm/usercopy.c                      |  2 +-
 6 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a5d9521..e25d70a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -156,59 +156,10 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#ifndef __ASSEMBLY__
-
-/*
- * Walks up the stack frames to make sure that the specified object is
- * entirely contained by a single stack frame.
- *
- * Returns:
- *	GOOD_FRAME	if within a frame
- *	BAD_STACK	if placed across a frame boundary (or outside stack)
- *	NOT_STACK	unable to determine (no frame pointers, etc)
- */
-static inline int arch_within_stack_frames(const void * const stack,
-					   const void * const stackend,
-					   const void *obj, unsigned long len)
-{
-#if defined(CONFIG_FRAME_POINTER)
-	const void *frame = NULL;
-	const void *oldframe;
-
-	oldframe = __builtin_frame_address(1);
-	if (oldframe)
-		frame = __builtin_frame_address(2);
-	/*
-	 * low ----------------------------------------------> high
-	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
-	 *                     ^----------------^
-	 *               allow copies only within here
-	 */
-	while (stack <= frame && frame < stackend) {
-		/*
-		 * If obj + len extends past the last frame, this
-		 * check won't pass and the next frame will be 0,
-		 * causing us to bail out and correctly report
-		 * the copy as invalid.
-		 */
-		if (obj + len <= frame)
-			return obj >= oldframe + 2 * sizeof(void *) ?
-				GOOD_FRAME : BAD_STACK;
-		oldframe = frame;
-		frame = *(const void * const *)frame;
-	}
-	return BAD_STACK;
-#else
-	return NOT_STACK;
-#endif
-}
-
-#else /* !__ASSEMBLY__ */
-
+#ifdef __ASSEMBLY__
 #ifdef CONFIG_X86_64
 # define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)
 #endif
-
 #endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5c..3b8afd5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
-obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-y				+= stacktrace.o
 obj-y				+= cpu/
 obj-y				+= acpi/
 obj-y				+= reboot.o
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 093f2ea..ff178a0 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -12,6 +12,54 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
+
+/*
+ * Walks up the stack frames to make sure that the specified object is
+ * entirely contained by a single stack frame.
+ *
+ * Returns:
+ *	GOOD_FRAME	if within a frame
+ *	BAD_STACK	if placed across a frame boundary (or outside stack)
+ *	NOT_STACK	unable to determine (no frame pointers, etc)
+ */
+int arch_within_stack_frames(const void * const stack,
+			     const void * const stackend,
+			     const void *obj, unsigned long len)
+{
+#if defined(CONFIG_FRAME_POINTER)
+	const void *frame = NULL;
+	const void *oldframe;
+
+	oldframe = __builtin_frame_address(2);
+	if (oldframe)
+		frame = __builtin_frame_address(3);
+	/*
+	 * low ----------------------------------------------> high
+	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
+	 *                     ^----------------^
+	 *               allow copies only within here
+	 */
+	while (stack <= frame && frame < stackend) {
+		/*
+		 * If obj + len extends past the last frame, this
+		 * check won't pass and the next frame will be 0,
+		 * causing us to bail out and correctly report
+		 * the copy as invalid.
+		 */
+		if (obj + len <= frame)
+			return obj >= oldframe + 2 * sizeof(void *) ?
+				GOOD_FRAME : BAD_STACK;
+		oldframe = frame;
+		frame = *(const void * const *)frame;
+	}
+	return BAD_STACK;
+#else
+	return NOT_STACK;
+#endif
+}
+
+#ifdef CONFIG_STACKTRACE
+
 static int save_stack_address(struct stack_trace *trace, unsigned long addr,
 			      bool nosched)
 {
@@ -241,3 +289,4 @@ void save_stack_trace_user(struct stack_trace *trace)
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
+#endif /* CONFIG_STACKTRACE */
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index ba29a06..60bb988 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -7,6 +7,30 @@
 struct task_struct;
 struct pt_regs;
 
+/*
+ * For per-arch arch_within_stack_frames() implementations, defined in
+ * kernel/stacktrace.c.
+ */
+enum {
+	BAD_STACK = -1,
+	NOT_STACK = 0,
+	GOOD_FRAME,
+	GOOD_STACK,
+};
+
+#ifdef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
+extern int arch_within_stack_frames(const void * const stack,
+				    const void * const stackend,
+				    const void *obj, unsigned long len);
+#else
+static inline int arch_within_stack_frames(const void * const stack,
+					   const void * const stackend,
+					   const void *obj, unsigned long len)
+{
+	return NOT_STACK;
+}
+#endif
+
 #ifdef CONFIG_STACKTRACE
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 34f053a..5403851 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -23,18 +23,6 @@
 #endif
 
 #include <linux/bitops.h>
-
-/*
- * For per-arch arch_within_stack_frames() implementations, defined in
- * asm/thread_info.h.
- */
-enum {
-	BAD_STACK = -1,
-	NOT_STACK = 0,
-	GOOD_FRAME,
-	GOOD_STACK,
-};
-
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
@@ -92,15 +80,6 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
-#ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
-static inline int arch_within_stack_frames(const void * const stack,
-					   const void * const stackend,
-					   const void *obj, unsigned long len)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_HARDENED_USERCOPY
 extern void __check_object_size(const void *ptr, unsigned long n,
 					bool to_user);
diff --git a/mm/usercopy.c b/mm/usercopy.c
index e9e9325..6a74776 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -19,7 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
-#include <linux/thread_info.h>
+#include <linux/stacktrace.h>
 #include <asm/sections.h>
 
 /*
-- 
2.7.4
