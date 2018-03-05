Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeCELBt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:01:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48164 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932891AbeCELBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:01:48 -0500
Date: Mon, 5 Mar 2018 11:01:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64/debug: Fix registers on sleeping tasks
Message-ID: <20180305110143.nfffbftqplrba7wu@lakrids.cambridge.arm.com>
References: <20180301193803.129195-1-dianders@chromium.org>
 <20180302180131.GA20579@arm.com>
 <20180302181636.a2nqgm4ezrbcdxkc@lakrids.cambridge.arm.com>
 <CAD=FV=U5QFqn3PU_H1rU0KMJBD9yt1FCLJd=E0afGVPg19wgWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U5QFqn3PU_H1rU0KMJBD9yt1FCLJd=E0afGVPg19wgWA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 10:45:25AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Mar 2, 2018 at 10:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Mar 02, 2018 at 06:01:31PM +0000, Will Deacon wrote:
> >> On Thu, Mar 01, 2018 at 11:38:03AM -0800, Douglas Anderson wrote:

> >> >     /* Initialize to zero */
> >> >     memset((char *)gdb_regs, 0, NUMREGBYTES);
> >> > -   thread_regs = task_pt_regs(task);
> >> > -   memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
> >> > -   /* Special case for PSTATE (check comments in asm/kgdb.h for details) */
> >> > -   dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
> >> > +
> >> > +   gdb_regs[19] = cpu_context->x19;
> >> > +   gdb_regs[20] = cpu_context->x20;
> >> > +   gdb_regs[21] = cpu_context->x21;
> >> > +   gdb_regs[22] = cpu_context->x22;
> >> > +   gdb_regs[23] = cpu_context->x23;
> >> > +   gdb_regs[24] = cpu_context->x24;
> >> > +   gdb_regs[25] = cpu_context->x25;
> >> > +   gdb_regs[26] = cpu_context->x26;
> >> > +   gdb_regs[27] = cpu_context->x27;
> >> > +   gdb_regs[28] = cpu_context->x28;
> >> > +   gdb_regs[29] = cpu_context->fp;
> >> > +
> >> > +   gdb_regs[31] = cpu_context->sp;
> >> > +   gdb_regs[32] = cpu_context->pc;
> >
> > Are the other reg fields initialised elsewhere?
> >
> > We might want to zero them here.
> 
> Isn't that covered by the the "/* Initialize to zero */" comment and
> and "memset((char *)gdb_regs, 0, NUMREGBYTES);"

I'd misread the patch and thought that was part of the deleted lines.

That looks fine, then.

Mark.
