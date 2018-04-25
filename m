Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbeDYO6r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:58:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:54104 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754400AbeDYO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="36967668"
Message-ID: <1524668321.21176.560.camel@linux.intel.com>
Subject: Re: [PATCH v5 03/11] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
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
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date: Wed, 25 Apr 2018 17:58:41 +0300
In-Reply-To: <20180425111251.13246-4-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
         <20180425111251.13246-4-pmladek@suse.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:12 +0200, Petr Mladek wrote:
> restricted_pointer() pretends that it prints the address when
> kptr_restrict
> is set to zero. But it is never called in this situation. Instead,
> pointer() falls back to ptr_to_id() and hashes the pointer.
> 
> This patch removes the potential confusion. klp_restrict is checked
> only
> in restricted_pointer().
> 
> It actually fixes a small race when the address might get printed
> unhashed:
> 
> CPU0                            CPU1
> 
> pointer()
>   if (!kptr_restrict)
>      /* for example set to 2 */
>   restricted_pointer()
> 				/* echo 0
> >/proc/sys/kernel/kptr_restrict */
> 				proc_dointvec_minmax_sysadmin()
> 				  klpr_restrict = 0;
>     switch(kptr_restrict)
>       case 0:
> 	break:
> 
>     number()
> 

FWIW, 
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use
> 'restricted_pointer()' when not restricting")
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tobin Harding <me@tobin.cc>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index eef9f725e9ff..2678dfe61d73 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -694,8 +694,8 @@ char *restricted_pointer(char *buf, char *end,
> const void *ptr,
>  {
>  	switch (kptr_restrict) {
>  	case 0:
> -		/* Always print %pK values */
> -		break;
> +		/* Handle as %p, hash and do _not_ leak addresses. */
> +		return ptr_to_id(buf, end, ptr, spec);
>  	case 1: {
>  		const struct cred *cred;
>  
> @@ -1915,8 +1915,6 @@ char *pointer(const char *fmt, char *buf, char
> *end, void *ptr,
>  			return buf;
>  		}
>  	case 'K':
> -		if (!kptr_restrict)
> -			break;
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':
>  		return netdev_bits(buf, end, ptr, fmt);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
