Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeEaWrF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:47:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54755 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750985AbeEaWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:47:04 -0400
X-ME-Proxy: <xmx:Z3sQW1lk68rDg9YUrzBdtG5N_okjFZG0bHpELQI6mjQMdM24fuiPdQ>
X-ME-Proxy: <xmx:Z3sQW85gbI8FJ3FWojnpXsanQTpkrrlodmC7P61YbMP-av1fsZGZMQ>
X-ME-Proxy: <xmx:Z3sQW29BdauuwsumbBe7NEELzz-Ww8bSLhCtV-8vEa-MClqX1pt21g>
X-ME-Proxy: <xmx:Z3sQW0jzdvJToeGdnGi3_kc5FYRJpwX9ctATRGkCQr5wigZywzxPgw>
X-ME-Proxy: <xmx:Z3sQW87EevKgY9Hyg1LpVuoC8a3E7324RDHvNX-xruTYjjko-hkS4g>
X-ME-Proxy: <xmx:Z3sQWxepo3MKd5h3--BxOnO9DoS2GYaAFuPVuNxzDskTu19JdpH8kw>
X-ME-Sender: <xms:Z3sQW4P1B6xBf-n92RKCXB-TVgAOK5S6PlLepImTgnspIYwtnzZ3lw>
Date: Fri, 1 Jun 2018 08:46:59 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] vsprintf: Add command line option
 debug_boot_weak_hash
Message-ID: <20180531224659.GA1682@eros>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
 <1527472002-11571-5-git-send-email-me@tobin.cc>
 <20180531173515.0252d579@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531173515.0252d579@vmware.local.home>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 05:35:15PM -0400, Steven Rostedt wrote:
> On Mon, 28 May 2018 11:46:42 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Currently printing [hashed] pointers requires enough entropy to be
> > available.  Early in the boot sequence this may not be the case
> > resulting in a dummy string '(____ptrval____)' being printed.  This
> > makes debugging the early boot sequence difficult.  We can relax the
> > requirement to use cryptographically secure hashing during debugging.
> > This enables debugging while keeping development/production kernel
> > behaviour the same.
> > 
> > If new command line option debug_boot_weak_hash is enabled use
> > cryptographically insecure hashing and hash pointer value immediately.
> > 
> 
> I was able to play with this. It did start showing real pointers after
> the early parameters are parsed. Hopefully we don't need anything
> before that. But that is still much earlier than what we had before.

Cool, thanks for testing.

> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  lib/vsprintf.c                                  | 20 ++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2040d46f095..8a86d895343e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -753,6 +753,15 @@
> >  
> >  	debug		[KNL] Enable kernel debugging (events log level).
> >  
> > +	debug_boot_weak_hash
> > +			[KNL] Enable printing pointers early in the boot
> > +			sequence.  If enabled, we use a weak hash instead of
> > +			siphash to hash pointers.  Use this option if you need
> > +			to see pointer values during early boot (i.e you are
> > +			seeing instances of '(___ptrval___)').
> > +			Cryptographically insecure, please do not use on
> > +			production kernels.
> > +
> >  	debug_locks_verbose=
> >  			[KNL] verbose self-tests
> >  			Format=<0|1>
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 1545a8aa26a9..369623205e2c 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1670,6 +1670,20 @@ char *pointer_string(char *buf, char *end, const void *ptr,
> >  }
> >  
> >  static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
> > +
> > +/* Make pointers available for printing early in the boot sequence. */
> > +static int debug_boot_weak_hash __ro_after_init;
> > +EXPORT_SYMBOL(debug_boot_weak_hash);
> > +
> > +static int __init debug_boot_weak_hash_enable(char *str)
> > +{
> > +	debug_boot_weak_hash = 1;
> > +	pr_info("debug_boot_weak_hash enabled\n");
> > +	return 0;
> > +}
> > +early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> > +
> > +static bool have_filled_random_ptr_key __read_mostly;
> >  static siphash_key_t ptr_key __read_mostly;
> >  
> >  static void enable_ptr_key_workfn(struct work_struct *work)
> > @@ -1721,6 +1735,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
> >  	unsigned long hashval;
> >  	const int default_width = 2 * sizeof(ptr);
> >  
> > +	/* When debugging early boot use non-cryptographically secure hash */
> > +	if (unlikely(debug_boot_weak_hash)) {
> 
> Perhaps we should make the debug_boot_weak_hash into a static key too.
> That way, it's constant jump instead of a compare.

Happy to do it but isn't that a bit of an over optimization, is printing
ever that performance critical?

Of course, if on second thoughts you still think it's worth doing I'll
code it up.

thanks,
Tobin.
