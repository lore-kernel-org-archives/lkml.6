Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934931AbeD0OLC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52451 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:00 -0400
Date: Fri, 27 Apr 2018 16:10:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] vsprintf: Prevent silent crashes and
 consolidate error handling
Message-ID: <20180427141057.bzyw4qsnm7qfqqdd@pathway.suse.cz>
References: <20180425111251.13246-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-25 13:12:40, Petr Mladek wrote:
> Crash in vsprintf() might be silent when it happens under logbuf_lock
> in vprintk_emit(). This patch set prevents most of the crashes by probing
> the address. The check is done only by %s and some %p* specifiers that need
> to dereference the address.
> 
> Only the first byte of the address is checked to keep it simple. It should
> be enough to catch most problems.
> 
> The check is explicitly done in each function that does the dereference.
> It helps to avoid the questionable strchr() of affected specifiers. This
> change motivated me to do some preparation patches that consolidated
> the error handling and cleaned the code a bit.
> 
> I did my best to address the feedback. Note that there is still the
> (efault) error message. But it is accompanied with WARN() when
> panic_on_warn is not enabled. I hope that it makes it more acceptable.
> 
> 
> Changes against v4:
> 
> 	+ rebased on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-4.18
> 	+ Added missing conts into ptr_to_ind() in a separate patch
> 	+ Renamed __string to valid_string()
> 	+ Avoid WARN() for invalid poimter specifiers
> 	+ Removed noinline_for_stack where it was not really useful
> 	+ WARN() when accessing invalid non-NULL address

Thanks a lot everyone for feedback. I'll incorporate it into v6. It
might take some time.

BTW: I also got report from 0day robot about that the size of vmlinux
increased by 545 bytes in i386-tinyconfig. I guess that it is mainly
because all the copies of

	if (!valid_pointer_access(&buf, end, bdev, spec))
		return buf;

got inlined. I guess that I would need to address it somehow
as well.

Best Regards,
Petr
