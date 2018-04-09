Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDIMTj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:19:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbeDIMTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:19:37 -0400
Date: Mon, 9 Apr 2018 14:19:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] vsprintf: Do not check address of well-known
 strings
Message-ID: <20180409121933.ftvmhhr37fmngfu3@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-4-pmladek@suse.com>
 <0ff89c4e-e20d-467e-de36-61e3a5557c7d@rasmusvillemoes.dk>
 <20180406091543.sh6efp24kflluxco@pathway.suse.cz>
 <1523110355.21176.412.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523110355.21176.412.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-04-07 17:12:35, Andy Shevchenko wrote:
> On Fri, 2018-04-06 at 11:15 +0200, Petr Mladek wrote:
> > On Thu 2018-04-05 15:30:51, Rasmus Villemoes wrote:
> > > On 2018-04-04 10:58, Petr Mladek wrote:
> > > > We are going to check the address using probe_kernel_address(). It
> > > > will
> > > > be more expensive and it does not make sense for well known
> > > > address.
> > > > 
> > > > This patch splits the string() function. The variant without the
> > > > check
> > > > is then used on locations that handle string constants or strings
> > > > defined
> > > > as local variables.
> > > > 
> > > > This patch does not change the existing behavior.
> > > 
> > > Please leave string() alone, except for moving the < PAGE_SIZE check
> > > to
> > > a new helper checked_string (feel free to find a better name), and
> > > use
> > > checked_string for handling %s and possibly the few other cases
> > > where
> > > we're passing a user-supplied pointer. That avoids cluttering the
> > > entire
> > > file with double-underscore calls, and e.g. in the %pO case, it's
> > > easier
> > > to understand why one uses two different *string() helpers if the
> > > name
> > > of one somehow conveys how it is different from the other.
> > 
> > I understand your reasoning. I thought about exactly this as well.
> > My problem is that string() will then be unsafe. It might be dangerous
> > when porting patches.
> 
> I agree with Rasmus, and your argument here from my point of view kinda
> weak. Are we really going to backport this patches? Why? We lived w/o
> them for a long time. What's changed now?

Someone might have out-of-tree patch that adds yet another format
specifier. It might call string() that checks for (null) now but
it it won't if we rename it as you suggest. People used to safe
string() might miss this when the patch is send upstream for
inclusion, ...


> > Is _string() really that bad? 
> 
> I would think so.

OK, I am going to use valid_string() instead of _string().
Feel free to suggest anything better. Just please no bike-shedding.

Best Regards,
Petr
