Return-Path: <kernel-hardening-return-12950-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+3FRzP6pCQvxSG6lTeEfQOkq3pVz0peF/nmVR91dnOZyvVcho3cpzphTUViA6qSjqhBeqf
ARC-Seal: i=1; a=rsa-sha256; t=1523345522; cv=none;
        d=google.com; s=arc-20160816;
        b=kB3clgTiJIpSkhC8S0QbALYFqpW3Qn999xypg/9ZF/HBeelNDC0fkXqvhJr12YXXWG
         73Rf8J1rsSuceOQbXMPwbkTCAuJgTE7KqMjUFz+uu0+XnYb0/t9Q+Q4RPKncHvdCNbTT
         jTCqYB2vJsHNxnTYdp3ZnX134Zx1l3zeNeL1uy3K2JY7dkS+OUiMZTa9ACcGsqbH3rgw
         AYVyYjWvXWP8RaZEVH0lqvZzs4B1pMQuIodaeOtGhdhX0DK0aaVZixhGjlq10U6aoyak
         6XMwzvNcpJYDnatKkM5n5bCTmWNfW5P3TgHMwvje6uIQbu3Jj51eBn6kcDWzrPwwpai/
         KaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=KkoAn0XKI3SIyBj98Z9iP8iiibOgEVzCiE0UvoSvhKw=;
        b=cayxEeaOOPN3a/b3Q/wzKrWdvYi5/lVmjTJ+gbFdvgydoPSLbi0ypf85RMKXKKo58D
         4JfZlnoY/GFD1LEooAKtS8p8vgRdDYtDGwx4Z/+/wytfRqOTvAbxMq5eEgheISdL63e4
         8341J1skaU5tUkp1rwCZ2+XKTzbPvO20PQvblkYU1O2vJzC+pIkJl/22z7iMli3E9KtU
         tLB17RVAoS8GZMwRIcPwEfYUrFjaTAPYLJjQBubxP1HXmUpNcWSyd4OxvczEeK4d7jSu
         TR6V88PLWSCVR1ygKLHdOGr7n82SI2SIZDTUb4Fhyf8Mg7rJZBZe5wqVGGMeXzvDM0Tx
         2YRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pr7wp6oi;
       spf=pass (google.com: domain of kernel-hardening-return-12950-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12950-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pr7wp6oi;
       spf=pass (google.com: domain of kernel-hardening-return-12950-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12950-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v4 3/3] x86: usercopy: reimplement arch_within_stack_frames with unwinder
Date: Tue, 10 Apr 2018 11:30:47 +0400
Message-Id: <1523345447-10725-4-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523345447-10725-3-git-send-email-kpark3469@gmail.com>
References: <1523345447-10725-1-git-send-email-kpark3469@gmail.com>
 <1523345447-10725-2-git-send-email-kpark3469@gmail.com>
 <1523345447-10725-3-git-send-email-kpark3469@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597343554456540478?=
X-GMAIL-MSGID: =?utf-8?q?1597343554456540478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sahara <keun-o.park@darkmatter.ae>

The old arch_within_stack_frames which used the frame pointer is
now reimplemented to use frame pointer unwinder apis. So the main
functionality is same as before.

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
---
 arch/x86/include/asm/unwind.h  |  5 ++++
 arch/x86/kernel/stacktrace.c   | 64 +++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/unwind_frame.c |  4 +--
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 1f86e1b..6f04906f 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -87,6 +87,11 @@ void unwind_init(void);
 void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
 			void *orc, size_t orc_size);
 #else
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+#define FRAME_HEADER_SIZE (sizeof(long) * 2)
+size_t regs_size(struct pt_regs *regs);
+#endif
+
 static inline void unwind_init(void) {}
 static inline
 void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index ff178a0..3de1105 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -13,6 +13,33 @@
 #include <asm/unwind.h>
 
 
+static inline void *get_cur_frame(struct unwind_state *state)
+{
+	void *frame = NULL;
+
+#if defined(CONFIG_UNWINDER_FRAME_POINTER)
+	if (state->regs)
+		frame = (void *)state->regs;
+	else
+		frame = (void *)state->bp;
+#endif
+	return frame;
+}
+
+static inline void *get_frame_end(struct unwind_state *state)
+{
+	void *frame_end = NULL;
+
+#if defined(CONFIG_UNWINDER_FRAME_POINTER)
+	if (state->regs) {
+		frame_end = (void *)state->regs + regs_size(state->regs);
+	} else {
+		frame_end = (void *)state->bp + FRAME_HEADER_SIZE;
+	}
+#endif
+	return frame_end;
+}
+
 /*
  * Walks up the stack frames to make sure that the specified object is
  * entirely contained by a single stack frame.
@@ -26,31 +53,42 @@ int arch_within_stack_frames(const void * const stack,
 			     const void * const stackend,
 			     const void *obj, unsigned long len)
 {
-#if defined(CONFIG_FRAME_POINTER)
-	const void *frame = NULL;
-	const void *oldframe;
-
-	oldframe = __builtin_frame_address(2);
-	if (oldframe)
-		frame = __builtin_frame_address(3);
+#if defined(CONFIG_UNWINDER_FRAME_POINTER)
+	struct unwind_state state;
+	void *prev_frame_end = NULL;
 	/*
 	 * low ----------------------------------------------> high
 	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
 	 *                     ^----------------^
 	 *               allow copies only within here
+	 *
+	 * Skip 3 non-inlined frames: arch_within_stack_frames(),
+	 * check_stack_object() and __check_object_size().
+	 *
 	 */
-	while (stack <= frame && frame < stackend) {
+	unsigned int discard_frames = 3;
+
+	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
 		/*
 		 * If obj + len extends past the last frame, this
 		 * check won't pass and the next frame will be 0,
 		 * causing us to bail out and correctly report
 		 * the copy as invalid.
 		 */
-		if (obj + len <= frame)
-			return obj >= oldframe + 2 * sizeof(void *) ?
-				GOOD_FRAME : BAD_STACK;
-		oldframe = frame;
-		frame = *(const void * const *)frame;
+		if (discard_frames) {
+			discard_frames--;
+		} else {
+			void *frame = get_cur_frame(&state);
+
+			if (!frame || !prev_frame_end)
+				return NOT_STACK;
+			if (obj + len <= frame)
+				return obj >= prev_frame_end ?
+						GOOD_FRAME : BAD_STACK;
+		}
+		/* save current frame end before move to next frame */
+		prev_frame_end = get_frame_end(&state);
 	}
 	return BAD_STACK;
 #else
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 3dc26f9..c8bfa5c 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -8,8 +8,6 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-#define FRAME_HEADER_SIZE (sizeof(long) * 2)
-
 unsigned long unwind_get_return_address(struct unwind_state *state)
 {
 	if (unwind_done(state))
@@ -69,7 +67,7 @@ static void unwind_dump(struct unwind_state *state)
 	}
 }
 
-static size_t regs_size(struct pt_regs *regs)
+size_t regs_size(struct pt_regs *regs)
 {
 	/* x86_32 regs from kernel mode are two words shorter: */
 	if (IS_ENABLED(CONFIG_X86_32) && !user_mode(regs))
-- 
2.7.4
