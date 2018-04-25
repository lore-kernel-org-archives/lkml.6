Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeDYPLB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:11:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:1679 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755035AbeDYPK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:10:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="35197348"
Message-ID: <1524669054.21176.566.camel@linux.intel.com>
Subject: Re: [PATCH v5 09/11] vsprintf: Prevent crash when dereferencing
 invalid pointers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 18:10:54 +0300
In-Reply-To: <20180425111251.13246-10-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-10-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> We already prevent crash when dereferencing some obviously broken
> pointers. But the handling is not consistent. Sometimes we print
> "(null)"
> only for pure NULL pointer, sometimes for pointers in the first
> page and sometimes also for pointers in the last page (error codes).
> 
> Note that printk() call this code under logbuf_lock. Any recursive
> printks are redirected to the printk_safe implementation and the
> messages
> are stored into per-CPU buffers. These buffers might be eventually
> flushed
> in printk_safe_flush_on_panic() but it is not guaranteed.
> 
> This patch adds a check using probe_kernel_read(). It is not a full-
> proof
> test. But it should help to see the error message in 99% situations
> where
> the kernel would silently crash otherwise.
> 
> Also it makes the error handling unified for "%s" and the many %p*
> specifiers that need to read the data from a given address. We print:
> 
>    + (null)   when accessing data on pure pure NULL address
>    + (efault) when accessing data on an invalid address
> 
> It does not affect the %p* specifiers that just print the given
> address
> in some form, namely %pF, %pf, %pS, %ps, %pB, %pK, %px, and plain %p.
> 
> Note that we print (efault) from security reasons. In fact, the real
> address can be seen only by %px or eventually %pK.


> +static const char *check_pointer_access(const void *ptr)
> +{
> +	char byte;
> +
> +	if (!ptr)
> +		return "(null)";
> +
> +	if (probe_kernel_address(ptr, byte))
> +		return "(efault)";
> +
> +	return NULL;
> +}
> +
> +static bool valid_pointer_access(char **buf, char *end, const void
> *ptr,
> +				 struct printf_spec spec)
> +{
> +	const char *err_msg;
> +
> +	err_msg = check_pointer_access(ptr);
> +	if (err_msg) {
> +		*buf = valid_string(*buf, end, err_msg, spec);
> +		return false;
> +	}
> +
> +	return true;
> +}

I would preserve similar style of buf pointer handling, i.e.

static char *valid_pointer_access(char **buf, char *end,
				  const void *ptr, struct printf_spec spec)
{
	const char *err_msg;

	err_msg = check_pointer_access(ptr);
	if (err_msg)
		return = valid_string(*buf, end, err_msg, spec);

	return NULL;
}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
