Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeECL4M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:56:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:22597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeECLz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:55:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="196422783"
Message-ID: <1525348553.21176.645.camel@linux.intel.com>
Subject: Re: [PATCH v5 09/11] vsprintf: Prevent crash when dereferencing
 invalid pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 03 May 2018 14:55:53 +0300
In-Reply-To: <20180427124721.z2vrsrlohxzyv6vh@pathway.suse.cz>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-10-pmladek@suse.com>
         <1524669054.21176.566.camel@linux.intel.com>
         <20180427124721.z2vrsrlohxzyv6vh@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-27 at 14:47 +0200, Petr Mladek wrote:
> On Wed 2018-04-25 18:10:54, Andy Shevchenko wrote:
> > On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> > > We already prevent crash when dereferencing some obviously broken
> > > pointers. But the handling is not consistent. Sometimes we print
> > > "(null)"
> > > only for pure NULL pointer, sometimes for pointers in the first
> > > page and sometimes also for pointers in the last page (error
> > > codes).
> > > 
> > > Note that printk() call this code under logbuf_lock. Any recursive
> > > printks are redirected to the printk_safe implementation and the
> > > messages
> > > are stored into per-CPU buffers. These buffers might be eventually
> > > flushed
> > > in printk_safe_flush_on_panic() but it is not guaranteed.
> > > +static const char *check_pointer_access(const void *ptr)
> > > +{
> > > +	char byte;
> > > +
> > > +	if (!ptr)
> > > +		return "(null)";
> > > +
> > > +	if (probe_kernel_address(ptr, byte))
> > > +		return "(efault)";
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static bool valid_pointer_access(char **buf, char *end, const
> > > void
> > > *ptr,
> > > +				 struct printf_spec spec)
> > > +{
> > > +	const char *err_msg;
> > > +
> > > +	err_msg = check_pointer_access(ptr);
> > > +	if (err_msg) {
> > > +		*buf = valid_string(*buf, end, err_msg, spec);
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > 
> > I would preserve similar style of buf pointer handling, i.e.
> > 
> > static char *valid_pointer_access(char **buf, char *end,
> > 				  const void *ptr, struct printf_spec
> > spec)
> > {
> > 	const char *err_msg;
> > 
> > 	err_msg = check_pointer_access(ptr);
> > 	if (err_msg)
> > 		return = valid_string(*buf, end, err_msg, spec);
> > 
> > 	return NULL;
> > }
> 
> Heh, I actually started with exactly this code. But it caused
> confusion.
> The name suggests that it should return true on success and NULL
> is false:
> 
> 	if (!valid_pointer_access())
> 		return err;

Confusion is already created by valid_string() to return char *.

> Any better naming/code is welcome.

Have nothing in my mind currently.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
