Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDGO0q (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 10:26:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:21191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeDGO0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 10:26:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="31786887"
Message-ID: <1523111200.21176.416.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 17:26:40 +0300
In-Reply-To: <20180404085843.16050-5-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> There are few printk formats that make sense only with two or more
> specifiers. Also some specifiers make sense only when a kernel feature
> is enabled.
> 
> The handling of unknown specifiers is strange, inconsistent, and
> even leaking the address. For example, netdev_bits() prints the
> non-hashed pointer value or clock() prints "(null)".
> 
> The best solution seems to be in flags_string(). It does not print any
> misleading value. Instead it calls WARN_ONCE() describing the unknown
> specifier. Therefore it clearly shows the problem and helps to find
> it.
> 
> Note that WARN_ONCE() used to cause recursive printk(). But it is safe
> now because vscnprintf() is called in printk_safe context from
> vprintk_emit().
> 

> -	if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> +	if (!IS_ENABLED(CONFIG_HAVE_CLK)) {
> +		WARN_ONCE(1, "Unsupported pointer format specifier:
> %%pC\n");
> +		return buf;
> +	}
> +
> +	if (!clk)
>  		return string(buf, end, NULL, spec);

This change collides with my patch series. Can you elaborate what your
thoughts are about my patches? Are you going incorporate them to your
series? Should I send them independently?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
