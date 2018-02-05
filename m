Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBEJoy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:44:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBEJos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:44:48 -0500
Date: Mon, 5 Feb 2018 10:44:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: avoid misleading "(null)" for %px
Message-ID: <20180205094438.pfd7ffymlvklpxe7@pathway.suse.cz>
References: <20180204174521.21383-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204174521.21383-1-kilobyte@angband.pl>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I add people who actively commented on adding %px modifier,
see the thread starting at
https://lkml.kernel.org/r/1511921105-3647-5-git-send-email-me@tobin.cc

Just for reference. It seems to be related to the commit 9f36e2c448007b54
("printk: use %pK for /proc/kallsyms and /proc/modules").


On Sun 2018-02-04 18:45:21, Adam Borowski wrote:
> Like %pK already does, print "00000000" instead.
>
> This confused people -- the convention is that "(null)" means you tried to
> dereference a null pointer as opposed to printing the address.

By other words, this avoids regressions when people convert
%x to %px. Do I get it right, please?

> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 77ee6ced11b1..d7a708f82559 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1849,7 +1849,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  {
>  	const int default_width = 2 * sizeof(void *);
>  
> -	if (!ptr && *fmt != 'K') {
> +	if (!ptr && *fmt != 'K' && *fmt != 'x') {
>  		/*
>  		 * Print (null) with the same width as a pointer so it makes
>  		 * tabular output look nice.
> -- 
> 2.15.1
> 
