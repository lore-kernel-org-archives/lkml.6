Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeDFM0i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752129AbeDFM0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:26:37 -0400
Date: Fri, 6 Apr 2018 14:26:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20180406122635.7ow2e2dgo6lqjopp@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-9-pmladek@suse.com>
 <f5fd81ea-99ab-29ac-a176-87ca8c4a754d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5fd81ea-99ab-29ac-a176-87ca8c4a754d@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 16:46:23, Rasmus Villemoes wrote:
> On 2018-04-04 10:58, Petr Mladek wrote:
> 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 3551b7957d9e..1a080a75a825 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -599,12 +599,46 @@ char *__string(char *buf, char *end, const char *s, struct printf_spec spec)
> >  	return widen_string(buf, len, end, spec);
> >  }
> >  
> > + /*
> > +  * This is not a fool-proof test. 99% of the time that this will fault is
> > +  * due to a bad pointer, not one that crosses into bad memory. Just test
> > +  * the address to make sure it doesn't fault due to a poorly added printk
> > +  * during debugging.
> > +  */
> > +static const char *check_pointer_access(const void *ptr)
> > +{
> > +	char byte;
> > +
> > +	if (!ptr)
> > +		return "(null)";
> > +
> > +	if (probe_kernel_address(ptr, byte))
> > +		return "(efault)";
> > +
> > +	return NULL;
> > +}
> 
> So while I think the WARNings are mostly pointless for the bad format
> specifiers, I'm wondering why an averted crash is not worth a
> WARN_ONCE?

It is used to match the error with the code. It was more explained in
the other mail.


> This means there's an actual bug somewhere, probably even exploitable,
> but we're just silently producing some innocent string...

Good point! It would make sense in many situations, especially when
we "silently" crashed so far.

I just wonder if some code already relies on the fact that passing
NULL is rather innocent, for example, in some timer- or networking-
related debug output. This change might make it hard to read.

Anyway, I still thing that it makes sense. But I would do it as
a separate patch so that it can be reverted easily. In each case,
it should spend some time in linux-next.


> Also, I'd still prefer to insist on ptr being a kernel pointer. Sure,
> for %ph userspace gets to print their own memory, but for a lot of the
> others, we're chasing pointers another level, so if an attacker can feed
> a user pointer to one of those, there's a trivial arbitrary read gadget.
> We have lots of printks in untested error paths, and I find it quite
> likely that one of those uses a garbage pointer.
> 
> I know you're mostly phrasing this in terms of preventing a crash, but
> it seems silly not to close that when it only costs a pointer comparison.

I thought that it was good idea but Steven was against, see
https://lkml.kernel.org/r/20180315130612.4b4cd091@vmware.local.home


> You're also missing the %pD (struct file*) case, which is one of those
> double-pointer chasing cases.

I wanted to keep the initial code simple. Well, %pD is pretty
straightforward, I could move the check to the cycle in v5.

I just want to avoid a monster patchset that would add the check
for every read byte. I am not persuaded that it is worth it.

Best Regards,
Petr
