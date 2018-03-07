Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeCGSSO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:18:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:22769 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbeCGSSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:18:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="23735622"
Message-ID: <1520446689.10722.493.camel@linux.intel.com>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 07 Mar 2018 20:18:09 +0200
In-Reply-To: <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
References: <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
         <1519814544.10722.266.camel@linux.intel.com>
         <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
         <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
         <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
         <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <1520330185.10722.401.camel@linux.intel.com>
         <20180307155244.b45c3fb5vcxb4q2l@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 16:52 +0100, Petr Mladek wrote:
> On Tue 2018-03-06 11:56:25, Andy Shevchenko wrote:

> Anyway, I have discussed this with my colleagues. Different people had
> different opinions. But I liked the following.

I discussed as well, and...

> We already prevent crash when derefencing some obviously broken
> pointers. The handling is not consistent. Sometimes we print "(null)"
> only for pure NULL pointer, sometimes for pointers in the first
> page and sometimes also for pointers in the last page (error codes).

> In general, we should do our best to get useful message from printk().
> This patch tries to find a wide range of invalid strings using
> probe_kernel_read(). Also it makes the handling unified. We print:

...they are considering not crashing is a bad idea from debugging point
of view.

So, what is can be done is to:
 - print "(null)" only for null pointers
 - print error codes for IS_ERR() part
 - crash on everything else

which partially what does my patch 1.

> Note that we could not print the exact pointer value from security
> reasons.

If it's invalid we need to fix the code, not to hide a problem, right?

> Developers need print the pointer using %px to get the real value.

But how developer will know (w/o traceback) where to look for?

> +	if (probe_kernel_read(&byte, ptr, 1))
> +		return "(efault)";

There is couple of flaws here:

 - If we asked to print 0 bytes of the value of pointer or something
from extension (%*ph, %*pE, etc), we don't know if pointer valid or not,
because we are going to print nothing. So, for now there is a
ZERO_OR_NULL_PTR() check for them, but in reality I wouldn't know what
the best to do in such case. So, the question is what we would like to
know more: the pointer is invalid, or the spec.width is 0 and caller
doesn't care in this case?

 - For IS_ERR() case it might be better to print an actual value of err,
(4 chars + parens + 2 chars left, like (e:dddd) or similar.
Unfortunately it doesn't scale good (ffff is a last error value we may
print). So, perhaps printing as %p in this case is a good enough and
scalable.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
