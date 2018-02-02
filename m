Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeBBO4F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeBBOz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:55:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406392178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 2 Feb 2018 11:55:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Matthew Whitehead <tedheadster@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/perf : Add check for CPUID instruction before using
Message-ID: <20180202145556.GE26905@kernel.org>
References: <1517581851-6600-1-git-send-email-tedheadster@gmail.com>
 <20180202143731.ohtpa4kh4twtj7yo@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202143731.ohtpa4kh4twtj7yo@pd.tnic>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 02, 2018 at 03:37:31PM +0100, Borislav Petkov escreveu:
> On Fri, Feb 02, 2018 at 09:30:51AM -0500, Matthew Whitehead wrote:
> > We still officially support the ancient i486 cpu. First generation
> > versions of this processor do not have the CPUID instruction, though
> > later versions do. Therefore you must check that the cpu supports
> > it before using it. At present it fails with an "Illegal Instruction"
> > signal on the early processors.
> > 
> > This code was based on similar code in the gcc package.
> > 
> > Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> > ---
> >  tools/perf/arch/x86/util/header.c | 51 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/header.h          |  2 ++
> >  2 files changed, 53 insertions(+)
> > 
> > diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> > index fb0d71afee8b..d4d12894c64d 100644
> > --- a/tools/perf/arch/x86/util/header.c
> > +++ b/tools/perf/arch/x86/util/header.c
> > @@ -7,6 +7,54 @@
> >  
> >  #include "../../util/header.h"
> >  
> > +/* This code based on gcc cpuid.h __get_cpuid_max() */
> > +unsigned int have_cpuid(void)
> 
> You could've copied have_cpuid_p() from arch/x86/kernel/cpu/common.c
> 
> > +{
> > +	unsigned int __eax, __ebx;
> > +
> > +#ifndef __x86_64__
> > +/* See if we can use cpuid.  On AMD64 we always can.  */
> > +#if __GNUC__ >= 3
> > +	__asm__ ("pushf{l|d}\n\t"
> > +		"pushf{l|d}\n\t"
> > +		"pop{l}\t%0\n\t"
> > +		"mov{l}\t{%0, %1|%1, %0}\n\t"
> > +		"xor{l}\t{%2, %0|%0, %2}\n\t"
> > +		"push{l}\t%0\n\t"
> > +		"popf{l|d}\n\t"
> > +		"pushf{l|d}\n\t"
> > +		"pop{l}\t%0\n\t"
> > +		"popf{l|d}\n\t"
> > +		: "=&r" (__eax), "=&r" (__ebx)
> > +		: "i" (0x00200000));
> > +#else
> > +/* Host GCCs older than 3.0 weren't supporting Intel asm syntax
> > + * nor alternatives in i386 code.
> 
> We don't support gcc < 3
> 
> #if GCC_VERSION < 30200
> # error Sorry, your compiler is too old - please upgrade it.
> #endif
> 
> There's even talk currently to raise the minimum version to 4.9 or so.

But this is for the kernel build process, right? If we don't have a
strict reason to forbid archeology... 8-)

- Arnaldo
