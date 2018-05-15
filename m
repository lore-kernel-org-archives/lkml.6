Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeEOXpP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:45:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34333 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEOXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:45:14 -0400
Date: Wed, 16 May 2018 01:45:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: Introduce 'no5lvl' kernel parameter
In-Reply-To: <20180514215057.yodhn3nk37fnsxui@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1805152305270.1605@nanos.tec.linutronix.de>
References: <20180511120859.26375-1-kirill.shutemov@linux.intel.com> <20180511120859.26375-3-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1805132339240.1582@nanos.tec.linutronix.de> <20180514215057.yodhn3nk37fnsxui@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Kirill A. Shutemov wrote:

> On Sun, May 13, 2018 at 09:55:00PM +0000, Thomas Gleixner wrote:
> > On Fri, 11 May 2018, Kirill A. Shutemov wrote:
> > > --- a/arch/x86/kernel/cpu/common.c
> > > +++ b/arch/x86/kernel/cpu/common.c
> > > @@ -1008,6 +1008,12 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
> > >  	 */
> > >  	setup_clear_cpu_cap(X86_FEATURE_PCID);
> > >  #endif
> > > +
> > > +#ifdef CONFIG_X86_5LEVEL
> > > +	/* Clear the 5-level paging feature if user asked for 'no5lvl' */
> > 
> > no5lvl is only one reason why 5 level paging is not available.
> 
> The 5-level paging may not be available for few reasons:
>  - CONFIG_X86_5LEVEL=n
>  - Machine doesn't support X86_FEATURE_LA57 -- clearing is nop;
>  - User asked for 'no5lvl'.
> 
> To me the one-line comment reflects the situation reasonably well.
> Do you want more verbose comment here?

The question is what of that set __pgtable_l5_enabled to 0? Is it only the
no5lvl command line option? If not, then the comment is misleading.

> > > +	if (!__pgtable_l5_enabled)
> > > +		setup_clear_cpu_cap(X86_FEATURE_LA57);
> > > +#endif
> > 
> > And that #ifdeffery can be avoided by simply doing:
> > 
> > 	if (IS_ENABLED(CONFIG_X86_5LEVEL) && !pgtable_l5_enabled)
> > 		setup_clear_cpu_cap(X86_FEATURE_LA57);
> > 
> > Hmm?
> 
> Unfortunately, no.
> 
> pgtable_l5_enabled is defined as cpu_feature_enabled(X86_FEATURE_LA57).
> So with such change we would only clear the feature bit if it's already
> clear.

Bah. I really hate stuff which looks like a variable but in fact is a
function. The whole pgtable_l5_enabled vs. __pgtable_l5_enabled stuff is
pretty horrid to be honest.

arch/x86/kernel/head64.c:

#ifdef CONFIG_X86_5LEVEL
#undef pgtable_l5_enabled
#define pgtable_l5_enabled __pgtable_l5_enabled
#endif

arch/x86/mm/kasan_init_64.c

#ifdef CONFIG_X86_5LEVEL
/* Too early to use cpu_feature_enabled() */
#define pgtable_l5_enabled __pgtable_l5_enabled
#endif

The same hack is in arch/x86/boot/compressed/misc.h:

#ifdef CONFIG_X86_5LEVEL
/* Too early to use cpu_feature_enabled() */
#define pgtable_l5_enabled __pgtable_l5_enabled
#endif

while arch/x86/boot/compressed/kaslr.c has:

#ifdef CONFIG_X86_5LEVEl
unsigned int pgtable_l5_enabled __ro_after_init;

_AFTER_ including mish.h 

Groan. That's just 'Yay, the compiler does not barf' programming, It's the
macro substitution magic which makes it compile

#define WTF wtf
#define USE_WTF WTF

int WTF;

int fun()
{
	return USE_WTF;
}

actually compiles and returns the content of the variable WTF because the
first define makes the compiler to substitute all instances of WTF with the
lower case 'wtf'.

Its clever to abuse that, but it's mind boggling enough if you look at it
in a single file, but when it's all over the place it just becomes
incomprehensible.

Can we pretty please clean all of this up and make it in a way that a
simple grep is sufficient to grok all the magic behind that?

The issues with the boot/compressed code can be avoided by having a define
in the relevant files before including the pgtable headers, or any
header. boot/compressed undefines already CONFIG_ symbols and defines other
stuff for similar reasons.

So either have a define in misc.h or add something like this in the
boot/compressed/Makefile

KBUILD_CFLAGS	+= -DBUILD_COMPRESSED

The same applies to all the other files where you have to rely on the same
macro substitution stuff or even undefine it and the #ifndef
pgtable_l5_enabled guard in pgtable_64_types.h.

You can just have something like

#define USE_EARLY_PGTABLE_L5

before including any header file and the whole mess becomes a single place
in include/asm/pgtable.h

#ifndef CONFIG_X86_5LEVEL
static inline bool pgtable_l5_enabled(void)
{
	return false;
}
#elif defined(BUILD_COMPRESSED)
static inline bool pgtable_l5_enabled(void)
{
	return boot_pgtable_l5_enabled;
}
#elif defined(USE_EARLY_PGTABLE_L5)
static inline bool pgtable_l5_enabled(void)
{
	return __pgtable_l5_enabled;
}
#else
static inline bool pgtable_l5_enabled(void)
{
	return cpu_feature_enabled(X86_FEATURE_LA57);
}
#endif

And that makes every use case immidiately obvious and clear. No nested
layers of macro susbstitutions, not ambigousities. No need for the same
#ifdef blocks and no #ifndef pgtable_l5_enabled guards either. Not SIX
places which define pgtable_l5_enabled. The same thing for 32 and 64 bit.

The fast path case which needs cpu_feature_enabled() might not work with
the inline due to include dependency hell, but it still can be made a macro
which looks like a function,

One other thing:

__pgtable_l5_enabled is defined in head64.c

#ifdef CONFIG_X86_5LEVEL
unsigned int __pgtable_l5_enabled __ro_after_init;
EXPORT_SYMBOL(__pgtable_l5_enabled);

First of all this should be __init_data because after init nothing needs
that anymore. Plus the export is completely pointless.

Thanks,

	tglx
