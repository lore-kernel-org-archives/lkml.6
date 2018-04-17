Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeDQPAr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:00:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750741AbeDQPAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:00:45 -0400
Subject: Re: [PATCH] x86/entry/64/compat: Preserve r8-r11 in int $0x80
To: Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <cd1a4b8c-dd8e-d88d-c154-fcf02aca5d74@redhat.com>
Date: Tue, 17 Apr 2018 17:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 04:36 PM, Andy Lutomirski wrote:
> 32-bit user code that uses int $80 doesn't care about r8-r11.  There is,
> however, some 64-bit user code that intentionally uses int $0x80 to
> invoke 32-bit system calls.  From what I've seen, basically all such
> code assumes that r8-r15 are all preserved, but the kernel clobbers
> r8-r11.  Since I doubt that there's any code that depends on int $0x80
> zeroing r8-r11, change the kernel to preserve them.
> 
> I suspect that very little user code is broken by the old clobber,
> since r8-r11 are only rarely allocated by gcc, and they're clobbered
> by function calls, so they only way we'd see a problem is if the
> same function that invokes int $0x80 also spills something important
> to one of these registers.
> 
> The current behavior seems to date back to the historical commit
> "[PATCH] x86-64 merge for 2.6.4".  Before that, all regs were
> preserved.  I can't find any explanation of why this change was made.

This means that the new behavior is there for some 8 years already.
Whoever was impacted by it, probably already switched to the new ABI.

Current ABI is "weaker", it allows kernel to save fewer registers.

Which is generally a good thing, since saving/restoring things cost
cycles, and sometimes painful on entry paths where you may desperately
need a scratch register or two. (Recall this one? -
...
         movq    %rsp, PER_CPU_VAR(rsp_scratch)
         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
         /* Construct struct pt_regs on stack */
         pushq   $__USER_DS                      /* pt_regs->ss */
         pushq   PER_CPU_VAR(rsp_scratch)        /* pt_regs->sp */
...
wouldn't it be _great_ if one of GPRs would be available here
to hold userspace %rsp?
)

If userspace needs some registers saved, it's trivial for it to have:

	push reg1
	push reg2
	int  0x80
	pop  reg2
	pop  reg1

OTOH if userspace _does not_ need some registers saved,
but they are defined as saved by the entrypoint ABI, then save/restore work
is done every time, even when not needed.

Thus, I propose to retain the current behavior.
