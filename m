Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeBGPDf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:03:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:52157 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754138AbeBGPDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:03:34 -0500
Date: Wed, 7 Feb 2018 16:03:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Kees Cook <keescook@chromium.org>, "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180207150328.nuk7f76nutq2trcg@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros>
 <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
 <20180205205817.72dy7e7xzjcnwmhs@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205205817.72dy7e7xzjcnwmhs@angband.pl>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-02-05 21:58:17, Adam Borowski wrote:
> On Tue, Feb 06, 2018 at 07:32:32AM +1100, Kees Cook wrote:
> > On Tue, Feb 6, 2018 at 7:15 AM, Tobin C. Harding <me@tobin.cc> wrote:
> > > On Tue, Feb 06, 2018 at 05:57:17AM +1100, Kees Cook wrote:
> > >> On Mon, Feb 5, 2018 at 8:44 PM, Petr Mladek <pmladek@suse.com> wrote:
> > >> > On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
> > >> >> Like %pK already does, print "00000000" instead.
> > >> >>
> > >> >> This confused people -- the convention is that "(null)" means you tried to
> > >> >> dereference a null pointer as opposed to printing the address.
> > >
> > > Leaving aside what is converting to %px.  If we consider that using %px
> > > is meant to convey to us that we _really_ want the address, in hex hence
> > > the 'x', then it is not surprising that we will get "00000000"'s for a
> > > null pointer, right?  Yes it is different to before but since we are
> > > changing the specifier does this not imply that there may be some
> > > change?
> > 
> > I personally prefer 0000s, but if we're going to change this, we need
> > to be aware of the difference.
> 
> It's easy to paint this bikeshed any color you guys want to: there's an "if"
> already.  My preference is also 0000; NULL would be good, too -- I just
> don't want (null) as that has a special meaning in usual userspace
> implementations; (null) also fits well most other modes of %p as they show
> some object the argument points to.  Confusion = wasted debugging time.

> Let's recap:
> 
> Currently:
>               not-null              null
> %pponies      object's description  (null)
> %px           address               (null)
> %pK           hash                  hash
> 
> I'd propose:
>               not-null              null
> %pponies      object's description  (null)
> %px           address               00000000
> %pK           hash                  00000000

It makes sense to me[*], so

Reviewed-by: Petr Mladek <pmladek@suse.com>

It seems that all people agree with this change. But there was also some
confusion. I am going to give it few more days before I push it to
Linus. It means waiting for 4.16-rc3 because I will be without
reliable internet next week. Anyone, feel free to push it faster.


[*] I made some archaeology:

The "(null)" string was added by the commit d97106ab53f812910
("Make %p print '(null)' for NULL pointers").

It was a generic solution to prevent eventual crashes, see
https://lkml.kernel.org/r/1230979341-23029-1-git-send-email-xyzzy@speakeasy.org

>From this point, printing 00000000 for %px looks perfectly fine because
it does not crash.

In fact, it would have made perfect sense to print 00000000 for pure
%p because it did not crash. But nobody has cared about the eventual
confusion yet.

I am not sure if it makes sense to change the pure %p handling
now. Note that printing "(null)" has the advantage that we
get this string instead of the hash ;-)

Best Regards,
Petr
