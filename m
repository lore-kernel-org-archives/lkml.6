Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeBGT2h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:28:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37924 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbeBGT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:28:36 -0500
Date: Wed, 7 Feb 2018 20:28:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207192816.GA19536@pd.tnic>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
 <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207191451.GC25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 08:14:51PM +0100, Peter Zijlstra wrote:
> Then someone went and wrecked it.

Yeah, note says UD0 didn't eat a ModRM byte on old CPUs. But then that
changed too. Fun stuff changing insn encoding underway.

So if we opt for adding a ModRM byte, could a 0x90 NOP work so that it
doesn't shit itself on those old CPUs?

/me goes and checks

Well, no:

  b3:   0f ff eb                ud0    %ebx,%ebp

decoded with latest objdump turns into:

  b3:   0f                      .byte 0xf
  b4:   ff                      .byte 0xff
  b5:   90                      nop

because 0x90, when used as a ModRM means, AFAICT, register-indirect
addressing with a 32-bit offset which would need more bytes. :-\

/me adds more bytes...

Yap, yuck, that works:

  b3:   0f ff 90 90 90 90 90    ud0    -0x6f6f6f70(%rax),%edx

I guess we need to experiment a bit to find a suitable byte to add...

Nasty.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
