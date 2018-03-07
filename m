Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbeCGJJV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:09:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:55486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeCGJJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:09:19 -0500
Date: Wed, 7 Mar 2018 10:09:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180307090917.2xqifk2wpk5ty36j@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV>
 <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, there was a mid-air collision. Arnd already answered most of my
questions and even more.

On Wed 2018-03-07 09:46:27, Arnd Bergmann wrote:
> On Wed, Mar 7, 2018 at 3:21 AM, Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> > On (03/06/18 14:27), Arnd Bergmann wrote:
> >> Weak symbols are generally discouraged in the kernel. We have
> >> them in a couple of places, but I find them rather confusing as they
> >> make it harder to figure out what is actually going on.
> >
> > Honestly, I kind of find __weak less confusing than EXPORT_SYMBOL(dump_stack)
> > in 3 different places. __weak hints that the symbol likely will be overridden
> > somewhere, while EXPORT_SYMBOL() does not (at least not to me). Dunno.
> 
> It's not either/or, they are both wrong ;-)
> 
> The EXPORT_SYMBOL() is not the thing that makes it work. The duplicate
> declaration today only works because lib/dump_stack.o is listed as lib-y
> in the Makefile instead of obj-y. On blackfin and nds32, this causes the entire
> file to just not be included in the final vmlinux, because there are no
> references to it.
> 
> With your patch, I would actually expect the lib/dump_stack.o file
> to still not be picked up, so now you have a missing EXPORT_SYMBOL()
> on the two unusual architectures until the point when you add another
> (referenced) symbol to it.

Great catch! We should change it from lib-y to obj-y. Of course,
the best solution would be if nds32 uses the generic implementation
and we could avoid adding __weak.

Best Regards,
Petr
