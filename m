Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeBELnD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:43:03 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46013 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeBELmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:42:55 -0500
X-Google-Smtp-Source: AH8x224tr/JNMD9+uk2PPXS8m+yycPxIhQ8VM+wzvXo0SyTMqVPX7J8mZA9CNlvfC6z8lI2OmjixXw==
Date: Mon, 5 Feb 2018 12:42:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> +	/*
> +	 * Sanitize extra registers of values that a speculation attack
> +	 * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
> +	 * the expectation is that %ebp will be clobbered before it
> +	 * could be used.
> +	 */
> +	.macro CLEAR_EXTRA_REGS_NOSPEC
> +	xorq %r15, %r15
> +	xorq %r14, %r14
> +	xorq %r13, %r13
> +	xorq %r12, %r12
> +	xorl %ebx, %ebx
> +#ifndef CONFIG_FRAME_POINTER
> +	xorl %ebp, %ebp
> +#endif
> +	.endm

Yeah, so this series look pretty good to me, but there's one small detail: I think 
RBP should be cleared unconditionally here, even in the CONFIG_FRAME_POINTERS=y 
case, because:

 - It's much easier to think about the validity of this code if we _know_ that
   these particular registers are cleared, so they cannot be used for deep 
   speculation. While typically on frame-pointer kernels most regular C function
   entry sequences will set RBP, there's exceptions:

     - There's various conditional pieces of entry code that run before any 
       RBP-clobbering C function is called. While none of them has an exploitable 
       Spectre 'gadget' at the moment, we'd have to consider this for every future
       change.

     - There's various compiler instrumentation that might run before RBP 
       clobbering of the typical C function prologue: -mfentry is one such case 
       (used by all distro kernels) compiler plugins might be another case. The 
       instrumentation is often hand written in assembly - which would thus have 
       to be 'RBP safe' as well.

     - Sanitizing RBP is not a hard requirement on the compiler: there's versions 
       of GCC where it won't set RBP, such as leaf functions - and other 
       compilers might have different defaults. This fact makes it harder to 
       ascertain that various C functions from low level assembly that we are 
       verifying for 'RBP safety' do indeed sanitize RBP under all circumstances.

   I.e. we cannot universally rely on RBP being sanitized. In _practice_ it will 
   be sanitized, but we don't know for sure without expending quite some effort to 
   think through all the cases.

 - CONFIG_FRAME_POINTERS=y is a non-default debug option with a significant 
   runtime cost that will get less and less testing as time goes forward. So 
   we are complicating the code path and are micro-optimizing an already 
   significantly slower debug build of the kernel.

So all things considered removing the #ifndef would make this angle easier to 
think about: let's just clear all the extra registers.

If you agree then there's no need to resend the series for this reason alone, I'll 
remove the #ifndef when applying the patches.

Thanks,

	Ingo
