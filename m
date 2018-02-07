Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeBGSgE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:36:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35218 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbeBGSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:36:03 -0500
Date: Wed, 7 Feb 2018 19:35:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kbuild test robot <fengguang.wu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207183543.GA8897@pd.tnic>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:13:35AM -0800, Linus Torvalds wrote:
> Adding more people for this funky warning from the kbuild robot.
> 
> Something is confused. UD0 is 0f ff, the bytes after that shouldn't
> matter. But I guess they can be interpreted as modrm bytes, and
> somebody started doing that.
> 
> That said, intel only _documents_ UD2 (0f 0b).

They documented UD0 and UD1 a year ago or so:

0F FF /r UD0¹  r32, r/m32 RM Valid Valid Raise invalid opcode exception
0F B9 /r UD1 r32, r/m32 RM Valid Valid Raise invalid opcode exception.

and the footnote says

"1. Some older processors decode the UD0 instruction without a ModR/M
byte. As a result, those processors would deliver an invalid- opcode
exception instead of a fault on instruction fetch when the instruction
with a ModR/M byte (and any implied bytes) would cross a page or segment
boundary."

So those two take a ModRM byte.

And we chose UD0 for WARN, see arch/x86/include/asm/bug.h for the
reasoning.

Except objdump can't handle that insn because it doesn't have it in its
insn tables. Thus it says:

  b3:   0f ff                   (bad)
  b5:   eb                      .byte 0xeb

> Maybe we should avoid using UD0/UD1 entirely.

Or that test should ignore UD0.

Or we should add UD0 only *decoding* support to binutils - not
generating.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
