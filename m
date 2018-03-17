Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeCQRVb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:21:31 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:35192 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeCQRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:21:13 -0400
Date: Sat, 17 Mar 2018 17:39:37 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/36] mm: use do_futex() instead of sys_futex() in
 mm_release()
Message-ID: <20180317163937.GA1619@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-4-linux@dominikbrodowski.net>
 <20180316184348.GA20184@localhost.localdomain>
 <CALCETrUQzPGjzGrO_J5DmG4Tp+11O+1jB3KY8XX2GTYsZ3-VTw@mail.gmail.com>
 <20180316214454.GB20184@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316214454.GB20184@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 02:44:54PM -0700, Darren Hart wrote:
> On Fri, Mar 16, 2018 at 07:03:53PM +0000, Andy Lutomirski wrote:
> > On Fri, Mar 16, 2018 at 6:43 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > On Thu, Mar 15, 2018 at 08:04:56PM +0100, Dominik Brodowski wrote:
> > >> sys_futex() is a wrapper to do_futex() which does not modify any
> > >> values here:
> > >>
> > >> - uaddr, val and val3 are kept the same
> > >>
> > >> - op is masked with FUTEX_CMD_MASK, but is always set to FUTEX_WAKE.
> > >>   Therefore, val2 is always 0.
> > >>
> > >> - as utime is set to NULL, *timeout is NULL
> > >>
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Ingo Molnar <mingo@redhat.com>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: Darren Hart <dvhart@infradead.org>
> > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > >
> > > Hi Dominik,
> > >
> > > I'm missing the "why" part here. What is it you are trying to address?
> > >
> > > do_futex is not currently in use outside of the futex implementation,
> > > while sys_futex is. This decouples the interface from the
> > > implementation. While this is perhaps less critical within the
> > > kernel, I don't see a compelling reason to increase the coupling
> > > between the mm and futex implementations.
> > >
> > > Without a compelling WHY, Nack from me.
> > >
> > 
> > We want to make some changes to the way that the syscall entry code
> > invokes syscalls, and these changes will make it impossible to call
> > sys_xyz() functions from the kernel.  So we can make sys_futex() be a
> > trivial wrapper around a new ksys_futex(), or we can do a patch like
> > this.
> 
> I dug up the cover letter and got the motivation and withdraw my
> objection. I understand the motivation to put the motivation in the
> cover letter in a large series, but I think there should have been
> something indicating the need for this change in the individual patches,
> even just a single line like Andy's first sentence above.

It's two lines, but I added

	This patch is part of a series which tries to remove in-kernel calls to
	syscalls. On this basis, the syscall entry path can be streamlined.

to all commits in these series which remove in-kernel calls to syscalls.

Thanks,
	Dominik
