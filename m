Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbeDDXKU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:10:20 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:40795 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeDDXKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:10:19 -0400
X-Google-Smtp-Source: AIpwx4/Lcar/wSvyDOgQ2Kyop0jE+16gjaSFwm1qVgdpj/7BNjqzmW6Dh9ifNlTN+uPb82d5XEKWMA==
Date: Thu, 5 Apr 2018 08:10:14 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
Message-ID: <20180404231014.GA622@jagdpanzerIV>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404085843.16050-3-pmladek@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/04/18 10:58), Petr Mladek wrote:
>
> restricted_pointer() pretends that it prints the address when kptr_restrict
> is set to zero. But it is never called in this situation. Instead,
> pointer() falls back to ptr_to_id() and hashes the pointer.
> 
> This patch removes the potential confusion. klp_restrict is checked only
> in restricted_pointer().
> 
> It should actually fix a small race when the address might get printed
> unhashed:

Early morning, didn't have my coffee yet [like really didn't].

But I don't see how you "fix" a race. "echo 0" might still be called
later than switch().

[..]
> @@ -1426,8 +1427,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  
>  	switch (kptr_restrict) {
>  	case 0:
> -		/* Always print %pK values */
> -		break;
> +		/* Handle as %p, hash and do _not_ leak addresses. */
> +		return ptr_to_id(buf, end, ptr, spec);

>From "Always print pK values" to "Always print hashed values"... Do we need
%pK then? You probably need to update printk-formats.rst as well.

	-ss
