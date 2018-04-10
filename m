Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDJN1C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:27:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752859AbeDJN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:27:00 -0400
Date: Tue, 10 Apr 2018 15:26:57 +0200
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
Message-ID: <20180410132657.xr73vrkq3qtncg35@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-9-pmladek@suse.com>
 <f5fd81ea-99ab-29ac-a176-87ca8c4a754d@rasmusvillemoes.dk>
 <20180406122635.7ow2e2dgo6lqjopp@pathway.suse.cz>
 <0a4f396f-1963-c723-7e4a-618b456210b6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4f396f-1963-c723-7e4a-618b456210b6@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 15:12:03, Rasmus Villemoes wrote:
> On 2018-04-06 14:26, Petr Mladek wrote:
> > On Thu 2018-04-05 16:46:23, Rasmus Villemoes wrote:
> >> On 2018-04-04 10:58, Petr Mladek wrote:
> >>
> >>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> >>> index 3551b7957d9e..1a080a75a825 100644
> >>> --- a/lib/vsprintf.c
> >>> +++ b/lib/vsprintf.c
> >>> @@ -599,12 +599,46 @@ char *__string(char *buf, char *end, const char *s, struct printf_spec spec)
> >>>  	return widen_string(buf, len, end, spec);
> >>>  }
> >>>  
> >>> + /*
> >>> +  * This is not a fool-proof test. 99% of the time that this will fault is
> >>> +  * due to a bad pointer, not one that crosses into bad memory. Just test
> >>> +  * the address to make sure it doesn't fault due to a poorly added printk
> >>> +  * during debugging.
> >>> +  */
> >>> +static const char *check_pointer_access(const void *ptr)
> >>> +{
> >>> +	char byte;
> >>> +
> >>> +	if (!ptr)
> >>> +		return "(null)";
> >>> +
> >>> +	if (probe_kernel_address(ptr, byte))
> >>> +		return "(efault)";
> >>> +
> >>> +	return NULL;
> >>> +}
> >>
> >> So while I think the WARNings are mostly pointless for the bad format
> >> specifiers, I'm wondering why an averted crash is not worth a
> >> WARN_ONCE?
> > 
> > It is used to match the error with the code. It was more explained in
> > the other mail.
> 
> Yes, I agree that _if_ we want to trigger some action rather than just
> gracefully handling a bogus %pXYZ by printing nothing, it must include a
> backtrace to be useful, and not just some pr_warn. I'm just doubting
> whether it is worth the code size increase - especially if we'd want to
> be _consistent_ and then also warn about %phq and %pISaa and %pbm and
> all the other cases where we do not check the trailing letters for
> making sense. So maybe a WARN for a 'toplevel' %p* makes sense, but I'd
> rather rely on static analysis for the rest and remove WARN_ONCE in
> flags_string than introducing a myriad new WARN_ONCEs.

Static analyze is fine if you are cleaning existing code. But it
does not work well when the behavior depends on CONFIG setting.
Also it is not much helpful when you write new code and it does
not work as expected.

The increase of the code is minimal. It either replaced existing
handling or it was added into newly created functions.

I needed to create the functions because I wanted to add
the access check. I would need to handle the error anyway.
In fact, the refactoring helped to fix a possible information leak, see
https://lkml.kernel.org/r/20180404085843.16050-8-pmladek@suse.com

IMHO, we do not need to solve this on all levels. There is mostly
reasonable fallback.

We could do nothing and just eat the invalid format specifier.
But whom will it help? Are these WARN_ONCE()s really so useless and
even harmful? I would understand this fear if they started complicating
the code or if we started to print many of them at runtime regularly.
But this is not the case.



> >> This means there's an actual bug somewhere, probably even exploitable,
> >> but we're just silently producing some innocent string...
> > 
> > Good point! It would make sense in many situations, especially when
> > we "silently" crashed so far.
> > 
> > I just wonder if some code already relies on the fact that passing
> > NULL is rather innocent, for example, in some timer- or networking-
> > related debug output. This change might make it hard to read.
> 
> Yeah, I would also just WARN in the case where we get to
> probe_kernel_address and fails that. That's why it should be in
> check_pointer_access where we can distinguish, and not in its caller.

Yes.


> But I think string() still needs to allow not just NULL but the full
> first page (mapping that to "(null)" as it used to), so that doesn't
> change the need for string to special-case that before calling
> valid_pointer_access.

Well, the special handling for %s is weird. In fact, writing (null) for
the entire first page is strange. On the other hand, we have written
(null) and did not warn for all the affected %p formats so far.

Therefore I suggest to WARN() only when probe_kernel_address()
fails and not for NULL. Also I suggest to do it consistently.
It will get some testing in linux-next and RCs. We could change
this if people scream. But passing invalid pointer to %s looks
like a bug. I believe that there are not many of them.


> >> Also, I'd still prefer to insist on ptr being a kernel pointer. Sure,
> >> for %ph userspace gets to print their own memory, but for a lot of the
> >> others, we're chasing pointers another level, so if an attacker can feed
> >> a user pointer to one of those, there's a trivial arbitrary read gadget.
> >> We have lots of printks in untested error paths, and I find it quite
> >> likely that one of those uses a garbage pointer.
> >>
> >> I know you're mostly phrasing this in terms of preventing a crash, but
> >> it seems silly not to close that when it only costs a pointer comparison.
> > 
> > I thought that it was good idea but Steven was against, see
> > https://lkml.kernel.org/r/20180315130612.4b4cd091@vmware.local.home
> 
> I know. If he has veto power, so be it.

Steven is very experienced and wrote amazing amount of kernel code.
I just take his opinion seriously. Of course, it does not mean that
he is right.

Anyway, adding the check would change the existing behavior. Steven
suggest that it might be an obstacle. People want from printk()
to give information and do not make unnecessary obstructions.
The question is when the check might help and when it might
be annoying. I do not have time to go more deeply into this
and argue about it at the moment. But feel to do so...


> >> You're also missing the %pD (struct file*) case, which is one of those
> >> double-pointer chasing cases.
> > 
> > I wanted to keep the initial code simple. Well, %pD is pretty
> > straightforward, I could move the check to the cycle in v5.
> > 
> > I just want to avoid a monster patchset that would add the check
> > for every read byte. I am not persuaded that it is worth it.
> 
> No, we most definitely do not want to read every byte with
> probe_kernel_read, vsnprintf() is used far too widely for that. I think
> checking that the initial pointer points to valid memory is a fine
> heuristic. I'm just saying that that is then precisely what we should
> do, and %pD does a dereference before we get to dentry_name. (And ok, if
> we then end up doing another check due to reuse of the %pd code, fine).

OK, I'll extend the check in %pD.

Best Regards,
Petr
