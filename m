Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC2PNM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:13:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59809 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeC2PNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:13:11 -0400
Date: Thu, 29 Mar 2018 17:13:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
Message-ID: <20180329151309.omdoxcdku5xoshgx@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
 <1520000254.10722.389.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520000254.10722.389.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-02 16:17:34, Andy Shevchenko wrote:
> On Fri, 2018-03-02 at 13:53 +0100, Petr Mladek wrote:
> > %p has many modifiers where the pointer is dereferenced. An invalid
> > pointer might cause kernel to crash silently.
> > 
> > Note that printk() formats the string under logbuf_lock. Any recursive
> > printks are redirected to the printk_safe implementation and the
> > messages
> > are stored into per-CPU buffers. These buffers might be eventually
> > flushed
> > in printk_safe_flush_on_panic() but it is not guaranteed.
> > 
> > In general, we should do our best to get useful message from printk().
> > All pointers to the first memory page must be invalid. Let's prevent
> > the dereference and print "(null)" in this case. This is already done
> > in many other situations, including "%s" format handling and many
> > page fault handlers.
> > 
> 
> 
> With such explanation it makes at least clear for the reader why it's
> done.
> 
> Thanks!
> 
> Would you be okay if I take this one as a first in my series and
> resubmit the series based on it?

The original simple patch grew into something bigger. I have it
almost ready. It looks the following way at the moment:

  vsprintf: Shuffle ptr_to_id() code
  vsprintf: Consistent %pK handling for kptr_restrict == 0
  vsprintf: Do not check address of well-known strings
  vsprintf: Consolidate handling of unknown pointer specifiers
  vsprintf: Factor out %p[iI] handler as ip_addr_string()
  vsprintf: Factor out %pV handler as va_format()
  vsprintf: Factor out %pO handler as kobject_string()
  vsprintf: Prevent crash when dereferencing invalid pointers
  vsprintf: Avoid confusion between invalid address and value

 Documentation/core-api/printk-formats.rst |   8 +
 lib/test_printf.c                         |  37 ++-
 lib/vsprintf.c                            | 445 ++++++++++++++++++------------
 3 files changed, 307 insertions(+), 183 deletions(-)

I still would like to do some final review and check with a fresh
head after Easter holidays.


Now, I am unsure how to merge it with your patchset. Most of your
patches are independent and should be applied. But there will be
some merge conflicts.

On possibility would be that I take your still valid changes via
printk.git. Then you would even need not send anything. I could
resolve the conflicts when applying the patches.

Or would you prefer to resend your patchset without the controversal
check removal? And wait for my patchset?

Best Regards,
Petr
