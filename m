Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeDFL0D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeDFLZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:25:09 -0400
Date: Fri, 6 Apr 2018 13:25:06 +0200
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
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180406112506.bzg3c4tqvvmmvkf2@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 16:25:41, Rasmus Villemoes wrote:
> On 2018-04-04 10:58, Petr Mladek wrote:
> > There are few printk formats that make sense only with two or more
> > specifiers. Also some specifiers make sense only when a kernel feature
> > is enabled.
> > 
> > The handling of unknown specifiers is strange, inconsistent, and
> > even leaking the address. For example, netdev_bits() prints the
> > non-hashed pointer value or clock() prints "(null)".
> > 
> > The best solution seems to be in flags_string(). It does not print any
> > misleading value. Instead it calls WARN_ONCE() describing the unknown
> > specifier. Therefore it clearly shows the problem and helps to find it.
> >
> I'm not sure it's actually worth WARNing about the unknown variants
> since

I agree that WARN() looks like an overkill for this type of error.
On the other hand, I am not sure how to make it lightweight and useful
at the same time.

We could not be much talkative in the passed buffer because we do not
know how big it is. We could call printk but it might be hard to match
the line with the caller without the backtrace.

The extra printk() message would end up in the per-CPU printk_safe
buffer when the broken vsprintf() comes from printk(). It might be
pushed to the main log buffer "much" later. On the other hand,
the original string would not end in the log buffer at all
when vsprintf() is not called from printk().


> we have static analysis (at least checkpatch and smatch) that
> should catch that.

Yes but not everybody uses it. Also there are things that depends
on CONFIG setting.

Anyway, I think that triggering the WARN() is rather a corner case.
So I would not be much concerned about using WARN().


> Even just git grep -1 -E '%p"$' finds %pt and %po
> which should get fixed before somebody claims those extensions.

I do not understand this much. git grep -1 -E '%p"$' does not find
lines with %pt and %po. Also it seems that %pt and %po are not
part of any format passed to vsprintf.



> But, I don't disagree with trying to fix up the inconsistency, and
> certainly not with fixing netdev_bits(), but it seems you've missed that
> e.g. the "case: 'g'" is completely compiled out for !CONFIG_BLOCK.
> There's also %pOF which is effectively disabled for !CONFIG_OF (which
> obviously makes sense), but with yet a different fallback behaviour.

You are accurate ;-) I was a bit lazy to change them. %pg was "nicely"
compiled out. %pOF was nicely minimalist solution but not usable in
general. I could do it in v5 or in a separate patchset.


> Hm. I think we should somehow distinguish between the cases of "%po" and
> "%pNX", i.e. specifiers/variants that are always bogus, and the cases of
> a %pOF or %pC that somehow happens even though nobody should have a
> struct device_node* or struct clk* to pass.

I think that the existing formulation is fine for the always bogus
specifiers, for example:

  "Unsupported pointer format specifier: %pGa"

What about the following for the other case:

  "Format specifier %%pC supported only with CONFIG_HAVE_CLK\n"

Best Regards,
Petr
