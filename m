Return-Path: <kernel-hardening-return-12949-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4901m8YbK7ALjciMPXCVYJg0ohu1ULcfI6umrQ0RoPn5gaBsSonoxLVLxU9UcmAQMiEiejo
ARC-Seal: i=1; a=rsa-sha256; t=1523345512; cv=none;
        d=google.com; s=arc-20160816;
        b=otUS6if13017suB9+fZHSGhYqc4r42jWECDtjnj5EIneH0Le92i0kIuOT2ebM152F6
         Q7u4+8NqXKSiV7RCtROSPnzeGMGbJEOm8YoySUtmWOSs+Paqcea9oDLR6kxd/l70EUNQ
         9yrbAZdBAN80F7uYnhnRzp/npYWEPI5gha8I+cbUJ/yiYBaFZXGRzA27P84nIrGBQlGY
         RUnHye24gtxbRXe21GCBn2r19aORHAx4G4aNVJVFa1qRwwZQUnHQV6FKEFOU1pxfvRp5
         92uzAwQSInMc+xIu4xTfkNhw+9KMiUHvKty1X7sh7ncwRVdP1AgdA05623+n8lnSbPN7
         gXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=NzoZuc+DdjRY93JGvBryC2MtxBtRt5tGrF7yypD1BLw=;
        b=a8BBoqS38eQgFGgR+fENowj+/6dexBbwEQnw9op5RV4PhOi9se5g7ElcFjTqyGb9K9
         sAVQkCl29qQYpgj9gsuO/05ny8Wf1DK+fdzMzIfmYku1wg4EpxFM8fXT4wJEpqJCSz6y
         6+BSoyXoWOQ+CBFwEvi4lxbrY05PMvg2xa6oA7Xb3v7JBW6o3XmQx31PRIQ45FE64Mh9
         vgKY3pi5PhMFSgDMfAkCpmVWCBrnpjEmzPPD7oL6hPZwPuvvT9lftb2fhsZPGuFTpqKJ
         d6qAggr34bDkYEI5YlNxeIb7bVJ5TTt8YpgZNSdii/m0cRqFKc/vBid3zIqN2nYKLRoG
         C9Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhfAR9aU;
       spf=pass (google.com: domain of kernel-hardening-return-12949-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12949-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZhfAR9aU;
       spf=pass (google.com: domain of kernel-hardening-return-12949-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12949-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v4 2/3] arm64: usercopy: implement arch_within_stack_frames
Date: Tue, 10 Apr 2018 11:30:46 +0400
Message-Id: <1523345447-10725-3-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523345447-10725-2-git-send-email-kpark3469@gmail.com>
References: <1523345447-10725-1-git-send-email-kpark3469@gmail.com>
 <1523345447-10725-2-git-send-email-kpark3469@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597343543964107629?=
X-GMAIL-MSGID: =?utf-8?q?1597343543964107629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

This implements arch_within_stack_frames() for arm64 that should
validate if a given object is contained by a kernel stack frame.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Sahara <keun-o.park@darkmatter.ae>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/stacktrace.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..4498ff4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,6 +128,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_ARCH_WITHIN_STACK_FRAMES
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d5718a0..5eb3784 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -27,6 +27,11 @@
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
+#define FAKE_FRAME(frame, my_func) do {				\
+	frame.fp = (unsigned long)__builtin_frame_address(0);	\
+	frame.pc = (unsigned long)my_func;			\
+} while (0)
+
 /*
  * AArch64 PCS assigns the frame pointer to x29.
  *
@@ -100,6 +105,77 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 	}
 }
 
+struct check_frame_arg {
+	unsigned long obj_start;
+	unsigned long obj_end;
+	unsigned long frame_start;
+	int discard_frames;
+	int err;
+};
+
+static int check_frame(struct stackframe *frame, void *d)
+{
+	struct check_frame_arg *arg = d;
+	unsigned long frame_end = frame->fp;
+
+	/* object overlaps multiple frames */
+	if (arg->obj_start < frame->fp && frame->fp < arg->obj_end) {
+		arg->err = BAD_STACK;
+		return 1;
+	}
+
+	/*
+	 * Discard frames and check object is in a frame written early
+	 * enough.
+	 */
+	if (arg->discard_frames)
+		arg->discard_frames--;
+	else if ((arg->frame_start <= arg->obj_start &&
+			arg->obj_start < frame_end) &&
+		(arg->frame_start < arg->obj_end && arg->obj_end <= frame_end))
+		return 1;
+
+	/* object exists in a previous frame */
+	if (arg->obj_end < arg->frame_start) {
+		arg->err = BAD_STACK;
+		return 1;
+	}
+
+	arg->frame_start = frame_end + 0x10;
+
+	return 0;
+}
+
+/* Check obj doesn't overlap a stack frame record */
+int arch_within_stack_frames(const void *stack,
+			     const void *stack_end,
+			     const void *obj, unsigned long obj_len)
+{
+	struct stackframe frame;
+	struct check_frame_arg arg;
+
+	if (!IS_ENABLED(CONFIG_FRAME_POINTER))
+		return NOT_STACK;
+
+	arg.err = GOOD_FRAME;
+	arg.obj_start = (unsigned long)obj;
+	arg.obj_end = arg.obj_start + obj_len;
+
+	FAKE_FRAME(frame, arch_within_stack_frames);
+	arg.frame_start = frame.fp;
+
+	/*
+	 * Skip 4 non-inlined frames: <fake frame>,
+	 * arch_within_stack_frames(), check_stack_object() and
+	 * __check_object_size().
+	 */
+	arg.discard_frames = 4;
+
+	walk_stackframe(current, &frame, check_frame, &arg);
+
+	return arg.err;
+}
+
 #ifdef CONFIG_STACKTRACE
 struct stack_trace_data {
 	struct stack_trace *trace;
-- 
2.7.4
