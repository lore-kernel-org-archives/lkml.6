Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDYMnf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:43:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52133 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDYMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:43:34 -0400
X-Google-Smtp-Source: AIpwx4/6qH/qL559LUfmer3WQRBHMR6UHLM1+pFrTfgrY/kJwBNAyfgT8m9Mqi+gSCRSQMdIgNUMOQ==
Subject: Re: [PATCH v5 10/11] vsprintf: WARN() on invalid pointer access
To: Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180425111251.13246-1-pmladek@suse.com>
 <20180425111251.13246-11-pmladek@suse.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f01f7010-f757-c2d2-ff31-eba2b12974e3@rasmusvillemoes.dk>
Date: Wed, 25 Apr 2018 14:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425111251.13246-11-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-25 13:12, Petr Mladek wrote:

>  
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 45c33143fb4a..74dff6c44ec6 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -285,12 +285,19 @@ null_pointer(void)
>  
>  #define PTR_INVALID ((void *)0x000000ab)
>  
> +extern int test_printf_pointer_access;
> +
>  static void __init
>  invalid_pointer(void)
>  {
> +	/* Avoid calling WARN() */
> +	test_printf_pointer_access = 1;
> +
>  	plain(PTR_INVALID);
>  	test(ZEROS "000000ab", "%px", PTR_INVALID);
>  	test("(efault)", "%pE", PTR_INVALID);
> +
> +	test_printf_pointer_access = 0;
>  }
>  
>  static void __init
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 5dfdc7e11d05..46e3e7c71229 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -610,6 +610,9 @@ static char *valid_string(char *buf, char *end, const char *s,
>  	return widen_string(buf, len, end, spec);
>  }
>  
> +int test_printf_pointer_access;
> +EXPORT_SYMBOL_GPL(test_printf_pointer_access);
> +

I understand that the printf test module needs this hook, and I
considered adding similar things for other tests when I originally wrote
the printf test module. But can we please make that

#if IS_ENABLED(CONFIG_TEST_PRINTF)
int test_printf_pointer_access;
EXPORT_SYMBOL_GPL(test_printf_pointer_access);
#else
#define test_printf_pointer_access 0
#endif

and maybe also wrap the EXPORT_SYMBOL_GPL in another #if
IS_MODULE(CONFIG_TEST_PRINTF). It's not something random modules should
play with, and I'd hate adding ~100 bytes (or whatever the export
metadata uses these days) to vmlinux for the sake of a module that is
most likely not built at all.

Rasmus
