Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeBGLSA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:18:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43524 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbeBGLR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:17:59 -0500
Date: Wed, 7 Feb 2018 12:17:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
Subject: Re: [RFC PATCH 3/4] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180207111739.GA8698@pd.tnic>
References: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
 <1517961794-14972-4-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517961794-14972-4-git-send-email-dwmw@amazon.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some random thoughts:

On Wed, Feb 07, 2018 at 12:03:13AM +0000, David Woodhouse wrote:
> +#define alternative_msr_write(_msr, _val, _feature)		\
> +	asm volatile(ALTERNATIVE("",				\
> +				 "movl %[msr], %%ecx\n\t"	\
> +				 "movl %[val], %%eax\n\t"	\
> +				 "movl $0, %%edx\n\t"		\

We'll never write anything except 0 in %edx?

> +				 "wrmsr",			\
> +				 _feature)			\
> +		     : : [msr] "i" (_msr), [val] "i" (_val)	\
> +		     : "eax", "ecx", "edx", "memory")

So I'm not crazy about making it a separate macro because TBH it doesn't
look too generic to do that but then again what do I know, considering
recent history. :-)

	 [ Maybe I need to not look at the spectral meltdown for a
	   couple of weeks and simply take a break. ]

I guess it is fine if it is in nospec-branch.h and not prefix it with
alternative_ so that it doesn't give people ideas.

Oh and firmware_restrict_branch_speculation_start/end() is just too long
a name.

All IMHO, of course.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
