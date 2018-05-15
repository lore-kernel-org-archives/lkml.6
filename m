Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEOKCB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:02:01 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:37044 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeEOKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:02:00 -0400
Date: Tue, 15 May 2018 12:01:58 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/18] arm64: convert raw syscall invocation to C
Message-ID: <20180515100158.GC14007@isilmar-4.linta.de>
References: <20180514125351.GK7753@e103592.cambridge.arm.com>
 <20180514114104.oubxdf526hf2m6t5@lakrids.cambridge.arm.com>
 <20180514202445.GA26773@light.dominikbrodowski.net>
 <20180515082222.rcoyf6dsf2s2edgq@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515082222.rcoyf6dsf2s2edgq@salmiak>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:22:23AM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 10:24:45PM +0200, Dominik Brodowski wrote:
> > On Mon, May 14, 2018 at 12:41:10PM +0100, Mark Rutland wrote:
> > > I agree it would be nicer if it had a wrapper that took a pt_regs, even
> > > if it does nothing with it.
> > > 
> > > We can't use SYSCALL_DEFINE0() due to the fault injection muck, we'd
> > > need a ksys_ni_syscall() for our traps.c logic, and adding this
> > > uniformly would involve some arch-specific rework for x86, too, so I
> > > decided it was not worth the effort.
> > 
> > Couldn't you just open-code the "return -ENOSYS;" in traps.c?
> 
> I guess so. I was just worried that debug logic might be added to the generic
> ni_syscall() in future, and wanted to avoid potential divergence.
> 
> > Error injection has no reasonable stable ABI/API expectations, so that's not
> > a show-stopper either.
> 
> If people are happy with using SYSCALL_DEFINE0() for ni_syscall, I'm happy to
> do that -- it's just that we'll need a fixup for x86 as that will change the
> symbol name.

For me, it's less about using SYSCALL_DEFINE0() for ni_syscall, but more
about keeping the syscall invokation easy. Therefore, we do pass a pointer
struct pt_regs to sys_ni_syscall() on x86, even though it does not expect
it.

	/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
	extern asmlinkage long sys_ni_syscall(const struct pt_regs *);

Thanks,
	Dominik
