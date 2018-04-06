Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeDFJPr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeDFJPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:15:45 -0400
Date: Fri, 6 Apr 2018 11:15:43 +0200
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
Subject: Re: [PATCH v4 3/9] vsprintf: Do not check address of well-known
 strings
Message-ID: <20180406091543.sh6efp24kflluxco@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-4-pmladek@suse.com>
 <0ff89c4e-e20d-467e-de36-61e3a5557c7d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff89c4e-e20d-467e-de36-61e3a5557c7d@rasmusvillemoes.dk>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 15:30:51, Rasmus Villemoes wrote:
> On 2018-04-04 10:58, Petr Mladek wrote:
> > We are going to check the address using probe_kernel_address(). It will
> > be more expensive and it does not make sense for well known address.
> > 
> > This patch splits the string() function. The variant without the check
> > is then used on locations that handle string constants or strings defined
> > as local variables.
> > 
> > This patch does not change the existing behavior.
> 
> Please leave string() alone, except for moving the < PAGE_SIZE check to
> a new helper checked_string (feel free to find a better name), and use
> checked_string for handling %s and possibly the few other cases where
> we're passing a user-supplied pointer. That avoids cluttering the entire
> file with double-underscore calls, and e.g. in the %pO case, it's easier
> to understand why one uses two different *string() helpers if the name
> of one somehow conveys how it is different from the other.

I understand your reasoning. I thought about exactly this as well.
My problem is that string() will then be unsafe. It might be dangerous
when porting patches.

This is why I wanted a different name for the variant without the
check. But I was not able to come up with anything short and clear
at the same time.

Is _string() really that bad? I think that it is a rather common
practice to use _func() for functions that are less safe than func()
variants. People should use _func() variants with care and this is
what we want here.

In addition, it is an internal API. IMHO, only few people do changes
there. They will get used to it quickly. Which is not true for people
that might need to port patches.

Best Regards,
Petr
