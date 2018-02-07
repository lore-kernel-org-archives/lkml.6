Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeBGStn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:49:43 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:54533 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754007AbeBGStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:49:41 -0500
Date: Wed, 7 Feb 2018 19:49:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180207184933.GA25201@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180207183543.GA8897@pd.tnic>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 07:35:43PM +0100, Borislav Petkov wrote:
> On Wed, Feb 07, 2018 at 10:13:35AM -0800, Linus Torvalds wrote:
> > Adding more people for this funky warning from the kbuild robot.
> > 
> > Something is confused. UD0 is 0f ff, the bytes after that shouldn't
> > matter. But I guess they can be interpreted as modrm bytes, and
> > somebody started doing that.
> > 
> > That said, intel only _documents_ UD2 (0f 0b).
> 
> They documented UD0 and UD1 a year ago or so:
> 
> 0F FF /r UD0¹  r32, r/m32 RM Valid Valid Raise invalid opcode exception
> 0F B9 /r UD1 r32, r/m32 RM Valid Valid Raise invalid opcode exception.
> 
> and the footnote says
> 
> "1. Some older processors decode the UD0 instruction without a ModR/M
> byte. As a result, those processors would deliver an invalid- opcode
> exception instead of a fault on instruction fetch when the instruction
> with a ModR/M byte (and any implied bytes) would cross a page or segment
> boundary."
> 
> So those two take a ModRM byte.

Argh. So the SDM I'm looking at (March 2017) doesn't list UD0 as having
a ModR/M byte, it doesn't have that footnote.

> And we chose UD0 for WARN, see arch/x86/include/asm/bug.h for the
> reasoning.

Right, we picked UD0 because we _thought_ everybody agreed it being 2
bytes, just like UD2. This is now not true anymore?
