Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758072AbeD0MrY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:47:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39237 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757241AbeD0MrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:47:23 -0400
Date: Fri, 27 Apr 2018 14:47:21 +0200
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
Subject: Re: [PATCH v5 09/11] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20180427124721.z2vrsrlohxzyv6vh@pathway.suse.cz>
References: <20180425111251.13246-1-pmladek@suse.com>
 <20180425111251.13246-10-pmladek@suse.com>
 <1524669054.21176.566.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524669054.21176.566.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-04-25 18:10:54, Andy Shevchenko wrote:
> On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> > We already prevent crash when dereferencing some obviously broken
> > pointers. But the handling is not consistent. Sometimes we print
> > "(null)"
> > only for pure NULL pointer, sometimes for pointers in the first
> > page and sometimes also for pointers in the last page (error codes).
> > 
> > Note that printk() call this code under logbuf_lock. Any recursive
> > printks are redirected to the printk_safe implementation and the
> > messages
> > are stored into per-CPU buffers. These buffers might be eventually
> > flushed
> > in printk_safe_flush_on_panic() but it is not guaranteed.
> 
> > +static const char *check_pointer_access(const void *ptr)
> > +{
> > +	char byte;
> > +
> > +	if (!ptr)
> > +		return "(null)";
> > +
> > +	if (probe_kernel_address(ptr, byte))
> > +		return "(efault)";
> > +
> > +	return NULL;
> > +}
> > +
> > +static bool valid_pointer_access(char **buf, char *end, const void
> > *ptr,
> > +				 struct printf_spec spec)
> > +{
> > +	const char *err_msg;
> > +
> > +	err_msg = check_pointer_access(ptr);
> > +	if (err_msg) {
> > +		*buf = valid_string(*buf, end, err_msg, spec);
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> I would preserve similar style of buf pointer handling, i.e.
> 
> static char *valid_pointer_access(char **buf, char *end,
> 				  const void *ptr, struct printf_spec spec)
> {
> 	const char *err_msg;
> 
> 	err_msg = check_pointer_access(ptr);
> 	if (err_msg)
> 		return = valid_string(*buf, end, err_msg, spec);
> 
> 	return NULL;
> }

Heh, I actually started with exactly this code. But it caused confusion.
The name suggests that it should return true on success and NULL
is false:

	if (!valid_pointer_access())
		return err;

Any better naming/code is welcome.

Best Reagrds,
Petr
