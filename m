Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeCTTkC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:40:02 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37482 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeCTTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:39:59 -0400
X-Google-Smtp-Source: AG47ELt13Er7PmLn0eFD9AVELoU+GMwaaLFREBfQ3oBeZdse8SK4to+71Z9+BWc4bEl1pRD46XHvZw==
Date: Tue, 20 Mar 2018 12:39:57 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] x86/unwind: Make CONFIG_UNWINDER_ORC=y the default
 in kconfig for 64-bit
Message-ID: <20180320193957.GG37438@google.com>
References: <20171013052544.euk7yawni47lhmdq@gmail.com>
 <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
 <20180319185732.GD37438@google.com>
 <20180319192910.wfbi656bxkrlurgf@treble>
 <20180319203130.GE37438@google.com>
 <20180319212053.e77dc3vmemfazt3b@treble>
 <20180319232255.GF37438@google.com>
 <20180320022803.i46ixerodrhzzewd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180320022803.i46ixerodrhzzewd@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, Mar 19, 2018 at 09:28:03PM -0500 Josh Poimboeuf ha dit:

> On Mon, Mar 19, 2018 at 04:22:55PM -0700, Matthias Kaehlcke wrote:
> > > Here's a (surprisingly easy) fix for this particular issue, though I'd
> > > be shocked if there weren't a bunch more issues lurking elsewhere.  Let
> > > me know how it goes.
> > 
> > Thanks for having a look, this fixes the vast majority of warnings in
> > a defconfig build!
> 
> Wow.  Consider me shocked :-)
> 
> > The remaining warnings are:
> > 
> > arch/x86/mm/pti.o: warning: objtool: pti_init() falls through to next
> > function pti_user_pagetable_walk_pmd()
> > s/debugfs/file.o: warning: objtool: full_proxy_llseek() falls through to next function full_proxy_read()
> > fs/debugfs/file.o: warning: objtool: full_proxy_read() falls through to next function full_proxy_write()
> > fs/debugfs/file.o: warning: objtool: full_proxy_write() falls through to next function full_proxy_poll()
> > fs/debugfs/file.o: warning: objtool: full_proxy_poll() falls through to next function full_proxy_unlocked_ioctl()
> > fs/debugfs/file.o: warning: objtool: full_proxy_unlocked_ioctl() falls through to next function fops_u8_open()
> 
> These all seem to be related to some weirdness with the UD2 instruction,
> not necessarily an objtool issue per se.
> 
> Any chance this fixes some of the warnings?  If not, I can try to build
> with clang and look a little deeper.
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index ab4711c63601..315a8757b565 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -124,7 +124,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  # define ASM_UNREACHABLE
>  #endif
>  #ifndef unreachable
> -# define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
> +#define unreachable() \
> +	do {					\
> +		annotate_unreachable();		\
> +		barrier_before_unreachable();	\
> +		__builtin_unreachable();	\
> +	} while (0)
>  #endif

Thanks, unfortunately negative on this one, all the warnings are still
generated.
