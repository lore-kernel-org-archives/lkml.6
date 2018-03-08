Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935794AbeCHOS3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:18:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55653 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933418AbeCHOS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:18:27 -0500
Date: Thu, 8 Mar 2018 15:18:24 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180308141824.bfk2pr6wmjh4ytdi@pathway.suse.cz>
References: <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
 <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
 <1520330185.10722.401.camel@linux.intel.com>
 <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
 <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxr5eg_fWjyhcYFU4CSOoVP_GeB79cYa=8mUk7J1cUG7A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-03-07 10:34:17, Linus Torvalds wrote:
> On Wed, Mar 7, 2018 at 7:52 AM, Petr Mladek <pmladek@suse.com> wrote:
> > If we are changing things, let's do it properly. The range
> > (-PAGE_SIZE,+PAGE_SIZE) is just a small subset of invalid pointers.
> > Let's try to catch more of them by reading one byte using
> > probe_kernel_read(). It would return -FAULT if we are not able
> > to read the address but it would not crash.
> >
> > Then we clearly need a new message when dereferencing invalid
> > poitners that are not pure NULL. I propose (efault).
> 
> "probe_kernel_read()" is really complicated. It takes a *fault* for chrissake!
> 
> Guess what happens now to any crash report if it uses %p and there is
> anything wrong with the VM?

This patch does _not_ affect plain %p, %px, and %pK!

It affects %s and %p* modifiers that need to read data from the
given address.


> Yes, yes, it disables page faults, but that only means that we won't
> go all the way into the generic VM. We'll still take the fauly, still
> do vmalloc fault filling, still do a *lot* of potentially really
> complicated things.

But the faulty way would happen anyway when vsnprintf() tried to
access the data at the given address.


> Guys, stop this idiocy. printk() needs to be *simple* and *reliable*, not fancy.

This patch is primary about printk() reliability. We want a message
instead of a silent crash.

I am open for better ideas how to get the fault-related messages out
when logbug_lock is taken. At the moment we have them in printk_safe
per-CPU buffer. The only chance to see them is crashdump or
printk_safe_flush_on_panic() called in single CPU mode.


> Plus, you just made %p be an excellent leak of some very sensitive
> information, like "where is the kernel mapped" etc.

We might call panic() after lockbuf_lock is released. This would help
to see the message and prevent crash-free hunting for kernel location.

Best Regards,
Petr
