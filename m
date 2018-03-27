Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755385AbeC0RLx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:11:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36648 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeC0RLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:11:50 -0400
X-Google-Smtp-Source: AIpwx4/dIFFNf4CeJ/+1Mms5SpUA57NRJvb34Ym3DjDtEJkTGsnKDGhIx1KwOdBJ9Zp6SWqXQyzWxg==
Date: Tue, 27 Mar 2018 18:43:43 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] x86: Force asm-goto
Message-ID: <20180327164343.GA4002@localhost.localdomain>
References: <20180319154124.337947038@infradead.org>
 <20180319154717.652679334@infradead.org>
 <alpine.DEB.2.21.1803192055410.1520@nanos.tec.linutronix.de>
 <20180319201327.GJ4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319201327.GJ4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-19 21:13, Peter Zijlstra wrote:
> On Mon, Mar 19, 2018 at 08:57:48PM +0100, Thomas Gleixner wrote:
> > On Mon, 19 Mar 2018, Peter Zijlstra wrote:
> > 
> > > We want to start using asm-goto to guarantee the absence of dynamic
> > > branches (and thus speculation).
> > > 
> > > A primary prerequisite for this is of course that the compiler
> > > supports asm-goto. This effecively lifts the minimum GCC version to
> > > build an x86 kernel to gcc-4.5.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  Makefile          |   13 +++++++------
> > >  arch/x86/Makefile |    4 ++++
> > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > 
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-ex
> > >  RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
> > >  export RETPOLINE_CFLAGS
> > >  
> > > +# check for 'asm goto'
> > > +ifeq ($(shell $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> > 
> > Why are you not using the shell-cached version which you remove further
> > down?
> 
> Bah, I'm an idiot. I fixed that up at least two times, but clearly I
> forgot to check that again before sending.
> 
> ---
> Subject: x86: Force asm-goto
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Jan 17 11:42:07 CET 2018
> 
> We want to start using asm-goto to guarantee the absence of dynamic
> branches (and thus speculation).
> 
> A primary prerequisite for this is of course that the compiler
> supports asm-goto. This effecively lifts the minimum GCC version to
> build an x86 kernel to gcc-4.5.

With this patch applied I'm not able to do "make kernelversion" without
any toolchain to get the kernel version, I was able to do that before.

Cheers,
Anders

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Makefile          |   13 +++++++------
>  arch/x86/Makefile |    4 ++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -494,6 +494,13 @@ RETPOLINE_CFLAGS_CLANG := -mretpoline-ex
>  RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
>  export RETPOLINE_CFLAGS
>  
> +# check for 'asm goto'
> +ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> +  CC_HAVE_ASM_GOTO := 1
> +  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> +  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
> +endif
> +
>  ifeq ($(config-targets),1)
>  # ===========================================================================
>  # *config targets only - make sure prerequisites are updated, and descend
> @@ -658,12 +665,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -l
>  # Tell gcc to never replace conditional load with a non-conditional one
>  KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
>  
> -# check for 'asm goto'
> -ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> -	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> -	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
> -endif
> -
>  include scripts/Makefile.kcov
>  include scripts/Makefile.gcc-plugins
>  
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -181,6 +181,10 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
>    endif
>  endif
>  
> +ifndef CC_HAVE_ASM_GOTO
> +  $(error Compiler lacks asm-goto support.)
> +endif
> +
>  #
>  # Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent a
>  # GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46226).  There's no way
