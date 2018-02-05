Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBEU6q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:58:46 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:34890 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeBEU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:58:41 -0500
Date: Mon, 5 Feb 2018 21:58:17 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20180205205817.72dy7e7xzjcnwmhs@angband.pl>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <CAGXu5j+rWhT7_DH5Z96_7naPou96-6736x4mjq0r_8EG4iiQ_g@mail.gmail.com>
 <20180205201555.GQ29988@eros>
 <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5j+KSm3rOK46xiYPx8SRaO9T5LaeaXxOA3PSktJv4F__dg@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 07:32:32AM +1100, Kees Cook wrote:
> On Tue, Feb 6, 2018 at 7:15 AM, Tobin C. Harding <me@tobin.cc> wrote:
> > On Tue, Feb 06, 2018 at 05:57:17AM +1100, Kees Cook wrote:
> >> On Mon, Feb 5, 2018 at 8:44 PM, Petr Mladek <pmladek@suse.com> wrote:
> >> > On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
> >> >> Like %pK already does, print "00000000" instead.
> >> >>
> >> >> This confused people -- the convention is that "(null)" means you tried to
> >> >> dereference a null pointer as opposed to printing the address.
> >
> > Leaving aside what is converting to %px.  If we consider that using %px
> > is meant to convey to us that we _really_ want the address, in hex hence
> > the 'x', then it is not surprising that we will get "00000000"'s for a
> > null pointer, right?  Yes it is different to before but since we are
> > changing the specifier does this not imply that there may be some
> > change?
> 
> I personally prefer 0000s, but if we're going to change this, we need
> to be aware of the difference.

It's easy to paint this bikeshed any color you guys want to: there's an "if"
already.  My preference is also 0000; NULL would be good, too -- I just
don't want (null) as that has a special meaning in usual userspace
implementations; (null) also fits well most other modes of %p as they show
some object the argument points to.  Confusion = wasted debugging time.

This is consistent with what we had before, with %pK special-cased.

> > In what is now to be expected fashion for %p the discussion appears to
> > have split into two different things - what to do with %px and what to
> > do with %pK :)
> 
> I say leave %pK alone. :)

As in, printing some random (hashed) value?


Let's recap:

Currently:
              not-null              null
%pponies      object's description  (null)
%px           address               (null)
%pK           hash                  hash

I'd propose:
              not-null              null
%pponies      object's description  (null)
%px           address               00000000
%pK           hash                  00000000

The initial patch in this thread changes printk("%px",0) from (null) to
00000000; what Tobin complained about is that printk("%pK",0) prints a
random value.               


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ The bill with 3 years prison for mentioning Polish concentration
⣾⠁⢰⠒⠀⣿⡁ camps is back.  What about KL Warschau (operating until 1956)?
⢿⡄⠘⠷⠚⠋⠀ Zgoda?  Łambinowice?  Most ex-German KLs?  If those were "soviet
⠈⠳⣄⠀⠀⠀⠀ puppets", Bereza Kartuska?  Sikorski's camps in UK (thanks Brits!)?
