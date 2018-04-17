Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754198AbeDQRBX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:01:23 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36956 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeDQRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:01:21 -0400
Date: Tue, 17 Apr 2018 18:58:43 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417165843.GA14271@light.dominikbrodowski.net>
References: <20180417115440.2145f7f5@gandalf.local.home>
 <20180417161029.GA8733@light.dominikbrodowski.net>
 <20180417123927.4406f990@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417123927.4406f990@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 12:39:27PM -0400, Steven Rostedt wrote:
> > > names, they do not match the default compare algorithm. As this was a
> > > problem for power pc, the algorithm can be overwritten by the architecture.
> > > The solution is to have x86 have its own algorithm to do the compare and
> > > this brings back the system call trace events.  
> > 
> > this lets me wonder *which* syscall "function" should be included in this
> > directory. Is it really the stub (__x64_sys_waitid, for example), or better
> > the sign-extending C function (__se_sys_waitid) which then calls an
> > internal helper (__do_sys_waitid). An additional advantage:
> > __se_sys_waitid would be available on x86 and, AFAICS, on all other archs.
> 
> It should include anything that uses the "SYSCALL_DEFINE#()" macros.

Well, that's not a 1:1, but a 1:several translation... SYSCALL_DEFINEx()
[SYSCALL_DEFINE0() is special] expands to

	__do_sys_waitid     # inlined helper doing actual work
	__se_sys_waitid     # C func calling inlined helper

on all architectures, with most (!= 64-bit x86) also having

	     sys_waitid	    # alias to __se_sys_waitid()

On 64-bit x86, it does not only extend to the two functions mentioned above,
but also to one or two stubs (depending on the configuration), namely

	  __x64_sys_waitid  # x64 64-bit-ptregs -> C stub
	 __ia32_sys_waitid  # ia32 32-bit-ptregs -> C stub

Thanks,
	Dominik
