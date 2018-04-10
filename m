Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeDJMih (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:38:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:46689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDJMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:38:34 -0400
Message-ID: <1523363877.4942.2.camel@gmx.de>
Subject: Re: x86-tip.today (4cdf573)  early instaboot
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 10 Apr 2018 14:37:57 +0200
In-Reply-To: <20180410085917.bo526ueprf7zfare@gmail.com>
References: <1523347959.4724.2.camel@gmx.de>
         <20180410085917.bo526ueprf7zfare@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/BRZYU1/d+t+xUbdt218l12Dye9DeYZe7slrgtH3EGK9FNlBNhB
 0rJYiOwpiVXXc/HyMoBpX2Z/VgNjYJtr6MM+GM+KxUiwSTdcHrcjWRhXWGFJSOSVVbR65jA
 3XloBKRBkOpUUZe3WiXJoaDLgb0LB4rbmEIh4VU+3cSLIZKy3p11/Li8P6vZ3qMVkVmhVxs
 QuteG9cJA9BlTJBZEzKWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YUoKsin8dXg=:HdxKGo5bkCbUrqnttRjOAo
 kd4jQ11/BvWbtZFKR9BNEhJV9uzrG5De72OOACwHfnbCEJcKITW6r5bz6DSAho23F8lHd4tx5
 IGyBlO74w9khW+M3AF4erdMdHCZl45gdmZ+e4/zG4/3jnQHjO5YXSb+5BQhqBh860UM1gtGiO
 1o4Kn+y9m8yLn6cFWxf1s54h6o1Vdu0Eh01PjiOhHru/rlEOCQ4hgR2h1IfPUaOY06G30HF/t
 jHS0oR0Z3L1pPkhHnKiFniggafdzWF4VRN7zxQCnXzHSExSCtyuvqmVBoQpO9aeSH2UfHo+5t
 JbxRK+8BHaj8UGRx7GhUQd/dqxoN728QHmD8WsdnsdZMaqqOSfPo5WAaKso/sgb4o8nZ6mYxL
 Uy5AkwydtpEJJEI6Tb4B/SrPRt9MeuAvaxY0b0zne8Y/bT/0VGvFHsdZp1SR8mH0hjhLA0RhB
 Y/2zOWtBEXmG24Gx2++fAQc9KS3iHI/SakYtDnpvdTePBbX+mTnYOKDJ7d1+JImU0oVvlEpPx
 lmsawnuCDwmhPuCfa0Su4URoqc8qk15ktSdMP/C//syt3jFlrtYdyO3kG0ywmvTI/u5ptEHiE
 sXgoZeMECWz/zvysuoxDTzLuZkAOQKp5md4SRqezRWnwKU+yolUG9/fFxcNhfrLCcIA6jlSxj
 DdqMLm1uMwwxFUFJUB2b2pAG/HLMv8PrDbYd/watQVzJCRyX1bg8c6guAqEi8A8NnmSrK/5Vf
 bUQRP2UkZSX8rT5JtPMxc896iHnV+NaITL+KL+OaWBFumdgFWw1XrIQMNJQdaDcp4B9gm6x6f
 jrplRtrXNkEvF/TMzFHUfvEE0Tjqn4b5ONY6LqTnKKsnSGUNng=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 10:59 +0200, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > Hi Ingo,
> > 
> > FYI, my i4790 box reboots immediately.. or close enough to it that you
> > see nothing at all before again meeting the bios splash.  Master with
> > the ~same config works fine.  I haven't poked around yet (work).
> 
> Hm, so there's been a few 'dangerous' pieces of work merged yesterday-ish.
> 
> Prime suspects would be:
> 
>  triton:~/tip> gll linus..x86/pti
> 
>  0564258fb2cf: x86/pti: Leave kernel text global for !PCID
>  a5df4f1f0d78: x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image
>  e0bb456e3250: x86/pti: Enable global pages for shared areas
>  efad2b415152: x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init
>  4ddee6efdcd0: x86/mm: Comment _PAGE_GLOBAL mystery
>  e71e836f463d: x86/mm: Remove extra filtering in pageattr code
>  64c80759408f: x86/mm: Do not auto-massage page protections  <== WOOF
>  6baf4bec02db: x86/espfix: Document use of _PAGE_GLOBAL
>  8a57f4849f4f: x86/mm: Introduce "default" kernel PTE mask
>  606c7193d5fb: x86/mm: Undo double _PAGE_PSE clearing
>  d1440b23c922: x86/mm: Factor out pageattr _PAGE_GLOBAL setting
>  ee1400dda318: Merge branch 'linus' into x86/pti to pick up upstream changes
>  071ccc966ba5: x86/entry/64: Drop idtentry's manual stack switch for user entries
>  9820e1c3376c: x86/uapi: Fix asm/bootparam.h userspace compilation errors
> 
> ... which you could test via 0564258fb2cf: if that insta-reboots too then 
> 9820e1c3376c^1 is expected to work and 4 bisection steps should pinpoint the 
> guilty commit ...

Thanks.  I already had a full bisect running, so ended up doing more
than 4 steps, but ended up at the above.

	-Mike
