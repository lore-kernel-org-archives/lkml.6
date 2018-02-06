Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517949140; cv=none;
        d=google.com; s=arc-20160816;
        b=E5rMSq6bfA1p9xE2LzS2WcZdSxf9eUj4EhRCVVXUvSXW0FH/Xh31BmBjdCyTXwEio6
         e7whp7uQv4CwpKPVrFB/0lcmaprFl6ChxUI21AMgVdsWMLzAFB2ksiyqwdZQIC+qdu1f
         ni+FMhguMRdwgWRCNfsreYXues5OCLNEeQBnOOnK9N7e/abhftjSalNPrC4QwTsIyyZQ
         TjSK5N++0xwLcAcB1qOMJctl8jIAanVO8ZmMcWcwJqpBW6A5+bs1JTd6w4zRyzCqgt1x
         WmdeXGRZWQPqLaFXB1i/Rd8NOoeGuGQbsrJk/VFNELWxZ3S93KMmAa3++Iu+1IJlH9oj
         EUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=6YV63gH0ZqPoAQsDYWCs7HH5NDcIvRgWkKmHv5HsQdM=;
        b=Unmars9tO58pFEPP4tfl28+t4qFTGOL0dqq2tVr5uqifJeZN+XzV1e9s3GLGi7wO+t
         i+9uN9FmfDbGwuH40wVQpjUb4ZuwX/xoEg8nn6VVqsP72KMpMNy6Tu7j/moHXdMaPui4
         4UyVTIDoasFt5qshDiULR783R+F/MelJDaX70Ci2vnkq1xDY5+okjI7RnhL+skGNFDoY
         u9WiUn2Mm9qY5/ou37WZXn/hXk/FZRpDazh6v7GHm70zPR/6zE1BDy2j2b2vtYA/zwNj
         VseaUxkC6etmY0Seirv2kqne0w+yj9pWHsjuduc3EcqM/t1mfs8rTmCqqhIay4o1V1lh
         /Hbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VfAh91MV;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VfAh91MV;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x225Je2zPc4eMYXyMrCeSC6yBBDa0HfzDOJXiWODwby0/HQ6nGmUGAN1NBY7vGob+2kUJrw4uqg==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Feb 2018 12:32:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
	gnomes@lxorguk.ukuu.org.uk, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, thomas.lendacky@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>
Subject: Re: [RFC] x86/retpoline: Add clang support for 64-bit builds
Message-ID: <20180206203218.GA11026@roeck-us.net>
References: <1517614240-31269-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517614240-31269-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591333873946801262?=
X-GMAIL-MSGID: =?utf-8?q?1591685038434769651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 03:30:40PM -0800, Guenter Roeck wrote:
> clang has its own set of compiler options for retpoline support.
> Also, the thunks required by C code have their own function names.
> 
> For 64-bit builds, there is only a single thunk, which is easy
> to support. Support for 32-bit builds is more complicated - in
> addition to various register thunks, there is also a thunk
> named __llvm_external_retpoline_push which is more challenging.
> Play it safe and only support 64-bit clang builds for now.
> 
Feedback, anyone ?

I understand that there is no love for the ABI differences between clang
and gcc, but that doesn't help me. Even if the patch is unacceptable
as-is, I would like to have some feedback to get an idea if I am on the
right track, and what I would have to change to at least move into the
right direction.

Thanks,
Guenter

> Link: https://github.com/llvm-mirror/clang/commit/0d816739a82da29748caf88570affb9715e18b69
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: gnomes@lxorguk.ukuu.org.uk
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: thomas.lendacky@amd.com
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
> Cc: Paul Turner <pjt@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Sent as RFC because I am not sure if the 64-bit only solution
> is acceptable.
> 
>  arch/x86/Makefile        |  5 ++++-
>  arch/x86/lib/retpoline.S | 24 ++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index fad55160dcb9..536dd6775988 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -232,7 +232,10 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  
>  # Avoid indirect branches in kernel to deal with Spectre
>  ifdef CONFIG_RETPOLINE
> -    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> +    RETPOLINE_CFLAGS = $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
> +    ifeq ($(RETPOLINE_CFLAGS)$(CONFIG_X86_32),)
> +	RETPOLINE_CFLAGS = $(call cc-option,-mretpoline -mretpoline-external-thunk)
> +    endif
>      ifneq ($(RETPOLINE_CFLAGS),)
>          KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
>      endif
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 480edc3a5e03..f77738b13481 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -9,14 +9,22 @@
>  #include <asm/nospec-branch.h>
>  #include <asm/bitsperlong.h>
>  
> -.macro THUNK reg
> +.macro _THUNK prefix, reg
>  	.section .text.__x86.indirect_thunk
>  
> -ENTRY(__x86_indirect_thunk_\reg)
> +ENTRY(\prefix\reg)
>  	CFI_STARTPROC
>  	JMP_NOSPEC %\reg
>  	CFI_ENDPROC
> -ENDPROC(__x86_indirect_thunk_\reg)
> +ENDPROC(\prefix\reg)
> +.endm
> +
> +.macro THUNK reg
> +_THUNK __x86_indirect_thunk_ \reg
> +.endm
> +
> +.macro CLANG_THUNK reg
> +_THUNK __llvm_external_retpoline_ \reg
>  .endm
>  
>  /*
> @@ -27,8 +35,11 @@ ENDPROC(__x86_indirect_thunk_\reg)
>   * the simple and nasty way...
>   */
>  #define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
> -#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
> +#define _EXPORT_THUNK(thunk, reg) __EXPORT_THUNK(thunk ## reg)
> +#define EXPORT_THUNK(reg) _EXPORT_THUNK(__x86_indirect_thunk_, reg)
>  #define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)
> +#define EXPORT_CLANG_THUNK(reg) _EXPORT_THUNK(__llvm_external_retpoline_, reg)
> +#define GENERATE_CLANG_THUNK(reg) CLANG_THUNK reg ; EXPORT_CLANG_THUNK(reg)
>  
>  GENERATE_THUNK(_ASM_AX)
>  GENERATE_THUNK(_ASM_BX)
> @@ -46,6 +57,11 @@ GENERATE_THUNK(r12)
>  GENERATE_THUNK(r13)
>  GENERATE_THUNK(r14)
>  GENERATE_THUNK(r15)
> +
> +#ifdef __clang__
> +GENERATE_CLANG_THUNK(r11)
> +#endif
> +
>  #endif
>  
>  /*
> -- 
> 2.7.4
> 
