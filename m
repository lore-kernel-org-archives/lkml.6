Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBFOLY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:11:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbeBFOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:11:15 -0500
Date: Tue, 6 Feb 2018 14:11:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20180206141118.GC22740@arm.com>
References: <20180206114048.6c8ced1c@canb.auug.org.au>
 <750091485.16756.1517921554396.JavaMail.zimbra@efficios.com>
 <20180206135512.GB22740@arm.com>
 <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1815310787.16844.1517926010063.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 02:06:50PM +0000, Mathieu Desnoyers wrote:
> ----- On Feb 6, 2018, at 8:55 AM, Will Deacon will.deacon@arm.com wrote:
> > On Tue, Feb 06, 2018 at 12:52:34PM +0000, Mathieu Desnoyers wrote:
> >> One approach I would consider for this is to duplicate this
> >> comment and add it just above the "eret" instruction within the
> >> macro:
> >> 
> >> 	/*
> >> 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
> >> 	 * when returning from IPI handler, and when returning to user-space.
> >> 	 */
> >> 
> >> Or perhaps Will has something else in mind ?
> > 
> > To be honest with you, I'd just drop the comment entirely. entry.S is
> > terrifying these days and nobody should have to go in there to understand
> > why we select ARCH_HAS_MEMBARRIER_SYNC_CORE. If you really feel a justification
> > is needed, I'd be happy with a line in the Kconfig file.
> 
> My concern is that someone wanting to optimize away a few cycles by changing
> eret to something else in the future will not be looking at Kconfig: that
> person will be staring at entry.S.

That person will probably also be me, or somebody who sits within punching
distance. I really wouldn't worry about it. There a bunch of other
things that will break if we don't use ERET here and, if it's a real
concern, we're making the *huge* assumption that developers actually
read and pay attention to comments.

> One alternative presented by PeterZ on irc is to do like ppc: define a
> macro for eret, and stick all appropriate comments near the macro. This
> way, it won't hurt when reading the code, but at least it keeps the
> comments near the instruction being discussed.

For the sake of avoiding the conflict, can we just drop it for now, please?
Having an "eret" macro isn't obvious, because people won't realise that it's
a macro. Having "exception_return" is cryptic as hell to people familiar
with the ISA.

Will
