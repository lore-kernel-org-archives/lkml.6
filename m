Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeBEQa7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:30:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37061 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbeBEQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:30:50 -0500
X-Google-Smtp-Source: AH8x226xoy2sVFoBJV1wc9LgmfLT4mYnBcv3J2lTogs64Xh1OTYCZq9t30wCLNbtMv0DiaMbkoNZXQ==
Date: Mon, 5 Feb 2018 17:30:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        luto@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180205163046.zeic6bqhkypbsutt@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
 <6CCF65EF-325A-4207-9C5E-2CD2D8E2A7E4@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CCF65EF-325A-4207-9C5E-2CD2D8E2A7E4@amacapital.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> 
> 
> > On Feb 5, 2018, at 3:42 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > 
> > * Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> >> +    /*
> >> +     * Sanitize extra registers of values that a speculation attack
> >> +     * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
> >> +     * the expectation is that %ebp will be clobbered before it
> >> +     * could be used.
> >> +     */
> >> +    .macro CLEAR_EXTRA_REGS_NOSPEC
> >> +    xorq %r15, %r15
> >> +    xorq %r14, %r14
> >> +    xorq %r13, %r13
> >> +    xorq %r12, %r12
> >> +    xorl %ebx, %ebx
> >> +#ifndef CONFIG_FRAME_POINTER
> >> +    xorl %ebp, %ebp
> >> +#endif
> >> +    .endm
> > 
> > Yeah, so this series look pretty good to me, but there's one small detail: I think 
> > RBP should be cleared unconditionally here, even in the CONFIG_FRAME_POINTERS=y 
> > case, because:
> 
> ENCODE_FRAME_POINTER should take care of rbp, though.

AFAICS there's various entry paths where it's not used I think: for example the 
compat system calls in entry_64_compat.S don't seem to encode RBP in such a 
fashion (unless I missed some macro side effect).

Basically I'd iterate these things the following way:

 - where there's justified, demonstrable doubt we should be clearing input values 
   in a simple, robust fashion (as it seems to be in this particular case)

 - then we can micro-optimize again when we are convinced that it's safe

Otherwise I'm worried about the speed with which we converge to Spectre 
correctness.

Thanks,

	Ingo
