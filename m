Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeCPUQN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:16:13 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52542 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeCPUQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:16:12 -0400
Date: Fri, 16 Mar 2018 20:39:48 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next 00/22] remove in-kernel syscall invocations (part 2
 == netdev)
Message-ID: <20180316193948.GA12435@light.dominikbrodowski.net>
References: <20180316170614.5392-1-linux@dominikbrodowski.net>
 <20180316.143021.1158193720540239477.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316.143021.1158193720540239477.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 02:30:21PM -0400, David Miller wrote:
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Fri, 16 Mar 2018 18:05:52 +0100
> 
> > The rationale of this change is described in patch 1 of part 1[*] as follows:
> > 
> > 	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> > 	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> > 	through kernel entry points, but not from the kernel itself. This
> > 	will allow cleanups and optimizations to the entry paths *and* to
> > 	the parts of the kernel code which currently need to pretend to be
> > 	userspace in order to make use of syscalls.
> > 
> > At present, these patches are based on v4.16-rc5; there is one trivial
> > conflict against net-next. Dave, I presume that you prefer to take them
> > through net-next? If you want to, I can re-base them against net-next.
> > If you prefer otherwise, though, I can route them as part of my whole
> > syscall series.
> 
> So the transformations themeselves are relatively trivial, so on that
> aspect I don't have any problems with these changes.

Thank you for your fast feedback.

> But overall I have to wonder.
> 
> I imagine one of the things you'd like to do is declare that syscall
> entries use a different (better) argument passing scheme.  For
> example, passing values in registers instead of on the stack.

Well, sort of. Currently, x86-64 decodes all six registers unconditionally:

		regs->ax = sys_call_table[nr](
			regs->di, regs->si, regs->dx,
			regs->r10, regs->r8, regs->r9);

so that in do_syscall_64(), we have to get six parameters from the
stack:

	mov    0x38(%rbx),%rcx
	mov    0x60(%rbx),%rdx
	mov    0x68(%rbx),%rsi
	mov    0x70(%rbx),%rdi
	mov    0x40(%rbx),%r9
	mov    0x48(%rbx),%r8

Instead, the aim is to do

	regs->ax = sys_call_table[nr](regs)

... which results in just a register rename operation:

	mov    %rbp,%rdi

> But in situations where you split out the system call function
> completely into one of these "helpers", the compiler is going
> to have two choices:
> 
> 1) Expand the helper into the syscall function inline, thus we end up
>    with two copies of the function.

That's only sensible for very short stubs, which just call another function
(e.g. __compat_sys_sendmsg()).

> 2) Call the helper from the syscall function.  Well, then the compiler
>    will need to pop the syscal obtained arguments from the registers
>    onto the stack.
> 
> So this doesn't seem like such a total win to me.
> 
> Maybe you can explain things better to ease my concerns.

For example, for sys_recv() and sys_recvfrom(), if all is complete, this
results in:

sys_x86_64_recv:
	callq <__fentry__>
	/* decode struct pt_regs for exactly those parameters
	 * we care about
	 */
	mov    0x38(%rdi),%rcx
	xor    %r9d,%r9d
	xor    %r8d,%r8d
	mov    0x60(%rdi),%rdx
	mov    0x68(%rdi),%rsi
	mov    0x70(%rdi),%rdi

	/* call __sys_recvfrom */
	callq  <__sys_recvfrom>

	/* cleanup and return */
	cltq
	retq

That's only obtaining four entries from the stack, and two register clearing
operations; sys_x86_64_recvfrom is similar (6 movs from stack, one register
rename mov, no xor).

__sys_recvfrom() then does the actual work, starting with pushing some
register contect out of the way and moving registers around, more or less
what SyS_recvfrom() does today.

So the result is nothing spectacular or unusual, but pretty equivalent and
possibly even shorter compared to current codepath.

Thanks,
	Dominik
