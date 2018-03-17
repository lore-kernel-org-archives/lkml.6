Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeCQXAY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:00:24 -0400
Received: from one.firstfloor.org ([193.170.194.197]:54514 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeCQXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:00:23 -0400
Date: Sat, 17 Mar 2018 16:00:21 -0700
From: Andi Kleen <andi@firstfloor.org>
To: jason.vas.dias@gmail.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, andi@firstfloor.org
Subject: Re: [PATCH v4.16-rc5 2/2] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
Message-ID: <20180317230020.ensccrtuajqgxsxa@two.firstfloor.org>
References: <1521296974-12142-1-git-send-email-jason.vas.dias@gmail.com>
 <1521296974-12142-3-git-send-email-jason.vas.dias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521296974-12142-3-git-send-email-jason.vas.dias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 02:29:34PM +0000, jason.vas.dias@gmail.com wrote:
>          This patch allows compilation to succeed with compilers that support -DRETPOLINE -
>          it was kindly contributed by H.J. Liu in GCC Bugzilla: 84908 :
>             https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84908
> 
>          Apparently the GCC retpoline implementation has a limitation that it cannot
>          handle switch statements with more than 5 clauses, which vclock_gettime.c's
>          __vdso_clock_gettime function now conts.

That's quite a mischaracterization of the issue. gcc works as intended,
but the kernel did not correctly supply a indirect call retpoline thunk
to the vdso, and it just happened to work by accident with the old
vdso.

> 
>          The automated test builds should now succeed with this patch.

How about just adding the thunk function to the vdso object instead of
this cheap hack? 

The other option would be to build vdso with inline thunks.

But just disabling is completely the wrong action.

-Andi


> 
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 1943aeb..cb64e10 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -76,7 +76,7 @@ CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
>         -fno-omit-frame-pointer -foptimize-sibling-calls \
>         -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
>  
> -$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
> +$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS) -DRETPOLINE,$(KBUILD_CFLAGS)) $(CFL)
>  
>  #
>  # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
> @@ -143,6 +143,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
> +KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS) -DRETPOLINE,$(KBUILD_CFLAGS_32))
>  KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
>  KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
>  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
> 
