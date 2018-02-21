Return-Path: <kernel-hardening-return-11860-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226U5jAhO3w9heR8bSOEMA56iaWaj+zgfRt3Pa9HVbnjvScq8uDdyUnX7D/Hot7/m4ABWCs+
ARC-Seal: i=1; a=rsa-sha256; t=1519227561; cv=none;
        d=google.com; s=arc-20160816;
        b=Pjw2uFUV0slr90aycd5uAWvYhNxn8Ubopqd3kvSafnLV1qqEP5d+LXH6Tt3RIBn0fv
         mOOwQ9lqK8rJ7Sj9vImEeF6pqYGCOXl7QG8kHUNzUl9DqN+Tz+Lv03t2+x7Us0a4qUsW
         TYtJsMWejN7Ncsn03Ti5seFVKDa1Tain7X99Y7tLnqLoK101FF+oe/i732Wt1iq69kQ+
         VLr+MLmqJDYfa+MO3LGiSdKh4ZRueNnVclxBHvUWPLFg3GHG5B1DkfAmmhx7zEhNGX46
         091J6aLbKwoxQqqMP/0XWDC4iOD7gozYoua1ahRJCqV0Aun5JQrNv/qJ1BT2O4cNq1Lb
         M7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FksaBsgauULptsajEQ/36336sUB2iNvu7aKDkQaajfQ=;
        b=Dd8XZgdBAVH8YhSmWtACMDwx6YP24qmzpnxxyCXi2144pzoKf8QLOVI4pkD8MBPAzn
         8P1YQgE+rr7XruUUg4yzzAG0I6gTICIcXeUKETmBDaxL7rmqJwQLYU6PNydx8Sv2LDsb
         q+a/MwvpEfNKZ2gabEQNIHBlMH26MT44P+el/W3Bp6wR+1zEj+crjx7YW+go40Y1iDBG
         muXoWlBzqx0RTnJ3VnI6jTPndy4Vri76ej19EU/Ou0XlMHoEayJTCGu132HgqVzY8bMk
         VsiWfHn9QTcpQybpWuxoFA73mdBfIZ3yQPH0jDnLkvinmNWgG4Sol2fxyK6KTVhYW5cw
         kVIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11860-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11860-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11860-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11860-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 21 Feb 2018 15:38:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Alexander Popov <alex.popov@linux.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	kernel-hardening@lists.openwall.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: Clear the stack
Message-ID: <20180221153850.ywpzsigfnz3etoun@salmiak>
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-3-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221011303.20392-3-labbott@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971106986303834?=
X-GMAIL-MSGID: =?utf-8?q?1593025559383563821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

On Tue, Feb 20, 2018 at 05:13:03PM -0800, Laura Abbott wrote:
> Implementation of stackleak based heavily on the x86 version

Neat!

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ec2ee720e33e..b909b436293a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -401,6 +401,11 @@ tsk	.req	x28		// current thread_info
>  
>  	.text
>  
> +	.macro	erase_kstack
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	bl	__erase_kstack
> +#endif
> +	.endm
>  /*
>   * Exception vectors.
>   */
> @@ -901,6 +906,7 @@ work_pending:
>   */
>  ret_to_user:
>  	disable_daif
> +	erase_kstack

I *think* this should happen in finish_ret_to_user a few lines down, since we
can call C code if we branch to work_pending, dirtying the stack.

>  	ldr	x1, [tsk, #TSK_TI_FLAGS]
>  	and	x2, x1, #_TIF_WORK_MASK
>  	cbnz	x2, work_pending
> @@ -1337,3 +1343,105 @@ alternative_else_nop_endif
>  ENDPROC(__sdei_asm_handler)
>  NOKPROBE(__sdei_asm_handler)
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
> +
> +/*
> + * This is what the stack looks like
> + *
> + * +---+ <- task_stack_page(p) + THREAD_SIZE
> + * |   |
> + * +---+ <- task_stack_page(p) + THREAD_START_SP
> + * |   |
> + * |   |
> + * +---+ <- task_pt_regs(p)

THREAD_START_SP got killed off in commit 34be98f4944f9907 as part of the
VMAP_STACK rework, so this can be:

      +---+ <- task_stack_page(p) + THREAD_SIZE
      |   |
      |   |
      +---+ <- task_pt_regs(p)
       ...

> + * |   |
> + * |   |
> + * |   | <- current_sp
> + * ~~~~~
> + *
> + * ~~~~~
> + * |   | <- lowest_stack
> + * |   |
> + * |   |
> + * +---+ <- task_stack_page(p)
> + *
> + * This function is desgned to poison the memory between the lowest_stack
> + * and the current stack pointer. After clearing the stack, the lowest
> + * stack is reset.
> + */
> +
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +ENTRY(__erase_kstack)
> +	mov	x10, x0	// save x0 for the fast path

AFAICT, we only call this from ret_to_user, where x0 doesn't need to be
preserved.

Is that for ret_fast_syscall? In some cases, ret_fast_syscall can bypass
ret_to_user and calls kernel_exit directly, so we might need a call there.

> +
> +	get_thread_info	x0
> +	ldr	x1, [x0, #TSK_TI_LOWEST_STACK]
> +
> +	/* get the number of bytes to check for lowest stack */
> +	mov	x3, x1
> +	and	x3, x3, #THREAD_SIZE - 1
> +	lsr	x3, x3, #3
> +
> +	/* generate addresses from the bottom of the stack */
> +	mov	x4, sp
> +	movn	x2, #THREAD_SIZE - 1
> +	and	x1, x4, x2

Can we replace the MOVN;AND with a single instruction to clear the low bits?
e.g.

	mov	x4, sp
	bic	x1, x4, #THREAD_SIZE - 1

... IIUC BIC is an alias for the bitfield instructions, though I can't recall
exactly which one(s).

> +
> +	mov	x2, #STACKLEAK_POISON
> +
> +	mov	x5, #0
> +1:
> +	/*
> +	 * As borrowed from the x86 logic, start from the lowest_stack
> +	 * and go to the bottom to find the poison value.
> +	 * The check of 16 is to hopefully avoid false positives.
> +	 */
> +	cbz	x3, 4f
> +	ldr	x4, [x1, x3, lsl #3]
> +	cmp	x4, x2
> +	csinc	x5, xzr, x5, ne
> +	tbnz	x5, #STACKLEAK_POISON_CHECK_DEPTH/4, 4f	// found 16 poisons?
> +	sub	x3, x3, #1
> +	b	1b
> +
> +4:
> +	/* total number of bytes to poison */
> +	add     x5, x1, x3, lsl #3
> +	mov	x4, sp
> +	sub     x8, x4, x5
> +
> +	cmp     x8, #THREAD_SIZE // sanity check the range
> +	b.lo    5f
> +	ASM_BUG()
> +
> +5:
> +	/*
> +	 * We may have hit a path where the stack did not get used,
> +	 * no need to do anything here
> +	 */
> +	cbz	x8, 7f
> +
> +	sub	x8, x8, #1 // don't poison the current stack pointer
> +
> +	lsr     x8, x8, #3
> +	add     x3, x3, x8
> +
> +	/*
> +	 * The logic of this loop ensures the last stack word isn't
> +	 * ovewritten.
> +	 */

Is that to ensure that we don't clobber the word at the current sp value?

> +6:
> +	cbz     x8, 7f
> +	str     x2, [x1, x3, lsl #3]
> +	sub     x3, x3, #1
> +	sub     x8, x8, #1
> +	b	6b
> +
> +	/* Reset the lowest stack to the top of the stack */
> +7:
> +	mov	x1, sp
> +	str	x1, [x0, #TSK_TI_LOWEST_STACK]
> +
> +	mov	x0, x10
> +	ret
> +ENDPROC(__erase_kstack)
> +#endif

[...]

> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 7b3ba40f0745..35ebbc1b17ff 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
>  KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -D__NO_FORTIFY \
>  				   $(call cc-option,-ffreestanding) \
> -				   $(call cc-option,-fno-stack-protector)
> +				   $(call cc-option,-fno-stack-protector) \
> +				   $(DISABLE_STACKLEAK_PLUGIN)

I believe the KVM hyp code will also need to opt-out of this.

Thanks,
Mark.
