Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeFEOVT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbeFEOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:21:14 -0400
Date: Tue, 5 Jun 2018 16:20:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180605142051.GB12925@kroah.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605120021.GH12258@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:00:22PM +0200, Peter Zijlstra wrote:
> On Tue, May 29, 2018 at 07:07:40PM +0100, Mark Rutland wrote:
> > In ldsem_cmpxchg a pointer to unsigned long is passed to
> > atomic_long_cmpxchg(), which expects a pointer to atomic_long_t.
> 
> > -	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
> > +	long tmp = atomic_long_cmpxchg((atomic_long_t *)&sem->count, *old, new);
> 
> Needing to cast anything to atomic types is dodgy at best, so I had me a
> look at this code.
> 
> Would not the following patch be much better?
> 
> ---
>  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
>  include/linux/tty_ldisc.h |  4 +--
>  2 files changed, 37 insertions(+), 49 deletions(-)

At first glance, yes, this does look a lot better, it's less lines at
the least :)

I think Peter Hurley was just trying to hid the atomic mess behind
function calls, which is why he didn't open-code it like you did here.
But this makes it a bit more obvious as to what "magic" is happening, so
I like it.

Care to turn it into a real patch so I can queue it up after 4.18-rc1 is
out?  Or do you want me to do that?

thanks,

greg k-h
