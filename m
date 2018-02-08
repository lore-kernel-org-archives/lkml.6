Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBHJrO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:47:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeBHJrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:47:12 -0500
Date: Thu, 8 Feb 2018 10:46:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208094651.GA7964@pd.tnic>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208091302.GD25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 10:13:02AM +0100, Peter Zijlstra wrote:
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index 34d99af43994..f0d5b4a1512d 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -12,16 +12,21 @@
>   * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
>   *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
>   *  with various things like the Intel SDM instruction encoding rules)
> + *
> + * And now someone went and taught binutils about UD0 as taking a ModR/M too
> + * and it generates crap when disassembling the kernel. Stick a pointless 0xD6
> + * ModR/M on, which the old binutils decodes as (bad) and the new binutils sees
> + * as a valid single byte ModR/M.
>   */
>  
> -#define ASM_UD0		".byte 0x0f, 0xff"
> +#define ASM_UD0		".byte 0x0f, 0xff, 0xd6"

Yeah, we probably should say that it was SALC:

http://ref.x86asm.net/geek.html#xD6

but undefined after P4.

Not that it matters a whole lot after an UD0. And it still won't matter
if it gets redefined to some new fancy prefix.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
