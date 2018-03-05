Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCEPQj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:16:39 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42060 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:16:38 -0500
X-Google-Smtp-Source: AG47ELvKqiTppalKAYVFtSJEe+CmTRHeppor0vy4U/G2wXudV7vkm3RfYCnvz5YIP1dES1GvKZHhniCrD5At0LjJop8=
MIME-Version: 1.0
In-Reply-To: <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz> <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz> <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz> <20180302125359.szbin2kznxvoq7sc@pathway.suse.cz>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Mon, 5 Mar 2018 16:16:37 +0100
Message-ID: <CAKwiHFgTbFof34oc59OU3M1=-PTzstv0uxSmoiRc8TJPJPMHVw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Make "null" pointer dereference more robust
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 March 2018 at 13:53, Petr Mladek <pmladek@suse.com> wrote:
> %p has many modifiers where the pointer is dereferenced. An invalid
> pointer might cause kernel to crash silently.
>
> Note that printk() formats the string under logbuf_lock. Any recursive
> printks are redirected to the printk_safe implementation and the messages
> are stored into per-CPU buffers. These buffers might be eventually flushed
> in printk_safe_flush_on_panic() but it is not guaranteed.

Yeah, it's annoying that we can't reliably WARN for bogus vsprintf() uses.

> In general, we should do our best to get useful message from printk().
> All pointers to the first memory page must be invalid. Let's prevent
> the dereference and print "(null)" in this case. This is already done
> in many other situations, including "%s" format handling and many
> page fault handlers.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index d7a708f82559..5c2d1f44218a 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  {
>         const int default_width = 2 * sizeof(void *);
>
> -       if (!ptr && *fmt != 'K' && *fmt != 'x') {
> +       if ((unsigned long)ptr < PAGE_SIZE && *fmt != 'K' && *fmt != 'x') {

ISTM that accidentally passing an ERR_PTR would be just as likely as
passing a NULL pointer (or some small offset from one), so if we do
this, shouldn't the test also cover IS_ERR values?

Rasmus
