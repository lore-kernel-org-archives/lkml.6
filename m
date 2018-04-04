Return-Path: <kernel-hardening-return-12856-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48/O2pa20EXNbWobADlEQ3pniZhSYw+xmJdo62vR2OFe8zzllHKEfB+aiqyy42CEz3C/W8N
ARC-Seal: i=1; a=rsa-sha256; t=1522882568; cv=none;
        d=google.com; s=arc-20160816;
        b=rfQNlo3qp5MsGH//IlNeq5oxiPmjWmGxMwI+GGsLFMljdhSEjLMevpbblmfjLnE9z0
         PI4RSAr3+fjP0rvh4m2051XOg9MEoTxfDFaLuKL3lebj6cHOtCk5VdwlbT3UIkYPjAyB
         oD9RNiotOJofLIMJSozxFNvEsvC0pdh9OrcXxhtAT+CuRxWxUqnS8mjkQHLm3Eq3/jQd
         AyUXAwlna/Bgf0WAHLoNtr3Syug7VbQ020rFS7OAs79FxifVQNue0ecTcY5V/mZoucj1
         Q0I075lvlsnEpnhVGaDBdccSVqtzAEgKCKwmza2QDa66oN46YKSInaNuPLkBRmYmGPXb
         12EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=lCzOxw/sX6R7Y4mrUZ+klZg2guFYNIVGTEzPF+d+UKk=;
        b=I/7yYgcHbG3W1UGzvoz8A+4uJa/pXOiEjwkr2k7y4D4YymbecEnHkXqd6eUyQKYXWs
         onsdLpT94cvR2cTbPBxV/mXsBssm0YKnYY/Sn+NUXEY5f/SzNaXMzOk8hMqBViyGf8R+
         p417s0vrsgIeecjWKSLBBSpuXAP2bhymg1oRZW3UBXNdJX5BzE2H3Fcm3Scqd9e4+7yN
         ELVvnEkW9Nof8KsQbG1ShkYNV3WlmPuBzavypcxTFcqZcGVRA4rtCbh8NjcfkBhw2XLs
         ARACejUhJ1eDIKHHAZHAOgXNuhaDDKUpoRkIB1jUCKgDh/ev3dJVhxzA5zAgA52dNAU6
         KyMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WJCYJl0+;
       dkim=pass header.i=@chromium.org header.s=google header.b=DYElsdXJ;
       spf=pass (google.com: domain of kernel-hardening-return-12856-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12856-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WJCYJl0+;
       dkim=pass header.i=@chromium.org header.s=google header.b=DYElsdXJ;
       spf=pass (google.com: domain of kernel-hardening-return-12856-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12856-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1519899591-29761-3-git-send-email-kpark3469@gmail.com>
References: <1519899591-29761-1-git-send-email-kpark3469@gmail.com>
 <1519899591-29761-2-git-send-email-kpark3469@gmail.com> <1519899591-29761-3-git-send-email-kpark3469@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 15:55:50 -0700
X-Google-Sender-Auth: FMJYXgqWEpxVZoYhY4MWluO3Jpg
Message-ID: <CAGXu5jKidijcESX2vguQ=m4Fx1S7eKOKXrLTEb3Of1FN9jQbbg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: usercopy: implement arch_within_stack_frames
To: Keun-O Park <kpark3469@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, keun-o.park@darkmatter.ae,
	Sodagudi Prasad <psodagud@codeaurora.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593731050789508476?=
X-GMAIL-MSGID: =?utf-8?q?1596858112566468378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 2:19 AM,  <kpark3469@gmail.com> wrote:
> From: James Morse <james.morse@arm.com>
>
> This implements arch_within_stack_frames() for arm64 that should
> validate if a given object is contained by a kernel stack frame.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sahara <keun-o.park@darkmatter.ae>

Looks good to me. Does this end up passing the LKDTM
USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/kernel/stacktrace.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5361287..b6c3b52 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -127,6 +127,7 @@ config ARM64
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_KPROBES
>         select HAVE_KRETPROBES
> +       select HAVE_ARCH_WITHIN_STACK_FRAMES
>         select IOMMU_DMA if IOMMU_SUPPORT
>         select IRQ_DOMAIN
>         select IRQ_FORCED_THREADING
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index fbc366d..6d37fad 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -26,6 +26,11 @@
>  #include <asm/irq.h>
>  #include <asm/stack_pointer.h>
>
> +#define FAKE_FRAME(frame, my_func) do {                                \
> +       frame.fp = (unsigned long)__builtin_frame_address(0);   \
> +       frame.pc = (unsigned long)my_func;                      \
> +} while (0)
> +
>  /*
>   * AArch64 PCS assigns the frame pointer to x29.
>   *
> @@ -94,6 +99,77 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>         }
>  }
>
> +struct check_frame_arg {
> +       unsigned long obj_start;
> +       unsigned long obj_end;
> +       unsigned long frame_start;
> +       int discard_frames;
> +       int err;
> +};
> +
> +static int check_frame(struct stackframe *frame, void *d)
> +{
> +       struct check_frame_arg *arg = d;
> +       unsigned long frame_end = frame->fp;
> +
> +       /* object overlaps multiple frames */
> +       if (arg->obj_start < frame->fp && frame->fp < arg->obj_end) {
> +               arg->err = BAD_STACK;
> +               return 1;
> +       }
> +
> +       /*
> +        * Discard frames and check object is in a frame written early
> +        * enough.
> +        */
> +       if (arg->discard_frames)
> +               arg->discard_frames--;
> +       else if ((arg->frame_start <= arg->obj_start &&
> +                       arg->obj_start < frame_end) &&
> +               (arg->frame_start < arg->obj_end && arg->obj_end <= frame_end))
> +               return 1;
> +
> +       /* object exists in a previous frame */
> +       if (arg->obj_end < arg->frame_start) {
> +               arg->err = BAD_STACK;
> +               return 1;
> +       }
> +
> +       arg->frame_start = frame_end + 0x10;
> +
> +       return 0;
> +}
> +
> +/* Check obj doesn't overlap a stack frame record */
> +int arch_within_stack_frames(const void *stack,
> +                            const void *stack_end,
> +                            const void *obj, unsigned long obj_len)
> +{
> +       struct stackframe frame;
> +       struct check_frame_arg arg;
> +
> +       if (!IS_ENABLED(CONFIG_FRAME_POINTER))
> +               return NOT_STACK;
> +
> +       arg.err = GOOD_FRAME;
> +       arg.obj_start = (unsigned long)obj;
> +       arg.obj_end = arg.obj_start + obj_len;
> +
> +       FAKE_FRAME(frame, arch_within_stack_frames);
> +       arg.frame_start = frame.fp;
> +
> +       /*
> +        * Skip 4 non-inlined frames: <fake frame>,
> +        * arch_within_stack_frames(), check_stack_object() and
> +        * __check_object_size().
> +        */
> +       arg.discard_frames = 4;
> +
> +       walk_stackframe(current, &frame, check_frame, &arg);
> +
> +       return arg.err;
> +}
> +
>  #ifdef CONFIG_STACKTRACE
>  struct stack_trace_data {
>         struct stack_trace *trace;
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
