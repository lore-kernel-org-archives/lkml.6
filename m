Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeBEPWr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:22:47 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:48874 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:22:40 -0500
Date: Mon, 5 Feb 2018 16:22:19 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180205152218.hxgozi67zka4hgkf@angband.pl>
References: <20180204174521.21383-1-kilobyte@angband.pl>
 <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
 <20180205100305.GO29988@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180205100305.GO29988@eros>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:03:05PM +1100, Tobin C. Harding wrote:
> On Mon, Feb 05, 2018 at 10:44:38AM +0100, Petr Mladek wrote:
> > On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
> > > Like %pK already does, print "00000000" instead.
> > >
> > > This confused people -- the convention is that "(null)" means you tried to
> > > dereference a null pointer as opposed to printing the address.
> > 
> > By other words, this avoids regressions when people convert
> > %x to %px. Do I get it right, please?

It's a regression in the sense that it confuses people.  %px never could
dereference a pointer so the information provided doesn't change, merely its
presentation.

> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > > index 77ee6ced11b1..d7a708f82559 100644
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> > >  {
> > >  	const int default_width = 2 * sizeof(void *);
> > >  
> > > -	if (!ptr && *fmt != 'K') {
> > > +	if (!ptr && *fmt != 'K' && *fmt != 'x') {
> 
> I don't know if it matters but with this it won't be immediately
> apparent that a null pointer was printed (since zero could hash to
> anything).

My change touches %px only, where your concern doesn't apply.

You're right, though, when it comes to %pK:
    printk("%%pK: %pK, %%px: %px\n", 0, 0);
says
    %pK: 00000000ba8bdc0a, %px: 0000000000000000

So what should we do?  Avoid hashing 0?  Print a special value?


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ The bill with 3 years prison for mentioning Polish concentration
⣾⠁⢰⠒⠀⣿⡁ camps is back.  What about KL Warschau (operating until 1956)?
⢿⡄⠘⠷⠚⠋⠀ Zgoda?  Łambinowice?  Most ex-German KLs?  If those were "soviet
⠈⠳⣄⠀⠀⠀⠀ puppets", Bereza Kartuska?  Sikorski's camps in UK (thanks Brits!)?
