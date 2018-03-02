Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428284AbeCBNpJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:45:09 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35569 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424655AbeCBNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:45:07 -0500
X-Google-Smtp-Source: AG47ELsuq23Pxmmh1wyYS31SXTROPa229KBSFIb3qJzSUtmd6P76RY+/1f8YYQ96HOwuLr3sP/uqXg==
Date: Fri, 2 Mar 2018 14:44:53 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kbuild@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/kconfig: replace single character strcat()
 appends
Message-ID: <20180302134453.mtd4uepeiviicyef@huvuddator>
References: <20180302074424.2myh3zhxnbpaohjq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302074424.2myh3zhxnbpaohjq@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 09:44:24PM -1000, Joey Pabalinas wrote:
> Convert strcat() calls which only append single characters
> to the end of res into simpler (and most likely cheaper)
> single assignment statements.
> 
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> 
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index cca9663be5ddd91870..67600f48660f2ac142 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -910,8 +910,7 @@ char *sym_expand_string_value(const char *in)
>  	 * freed, so make sure to always allocate a new string
>  	 */
>  	reslen = strlen(in) + 1;
> -	res = xmalloc(reslen);
> -	res[0] = '\0';
> +	res = xcalloc(1, reslen);

Not sure this is an improvement. Zeroing the bytes after the initial
null terminator is redundant, and the explicit '\0' makes it clearer to
me what's going on.

>  
>  	while ((src = strchr(in, '$'))) {
>  		char *p, name[SYMBOL_MAXLENGTH];
> @@ -951,7 +950,7 @@ const char *sym_escape_string_value(const char *in)
>  {
>  	const char *p;
>  	size_t reslen;
> -	char *res;
> +	char *res, *end;
>  	size_t l;
>  
>  	reslen = strlen(in) + strlen("\"\"") + 1;
> @@ -968,25 +967,25 @@ const char *sym_escape_string_value(const char *in)
>  		p++;
>  	}
>  
> -	res = xmalloc(reslen);
> -	res[0] = '\0';
> -
> -	strcat(res, "\"");
> +	res = xcalloc(1, reslen);
> +	end = res;
> +	*end++ = '\"';

Could make this xmalloc() instead and write the null terminator via
'end' -- see below.

>  
>  	p = in;
>  	for (;;) {
>  		l = strcspn(p, "\"\\");
>  		strncat(res, p, l);

Could replace this with memcpy(end, p, l).

At that point, all the writing would be done via 'end', and 'res' would
just be a way to remember the starting address of the result.

>  		p += l;
> +		end += l;
>  
>  		if (p[0] == '\0')

Unrelated, but *p is clearer than p[0] to me when doing pointers rather
than indices.

>  			break;
>  
> -		strcat(res, "\\");
> -		strncat(res, p++, 1);
> +		*end++ = '\\';
> +		*end++ = *p++;
>  	}
> +	*end = '\"';

With all the writing done via 'end', the null terminator could be
written here.

>  
> -	strcat(res, "\"");
>  	return res;
>  }
>  
> -- 
> 2.16.2
> 
> Sorry about the double send, clipboards are very fickle beasts :(

I like the approach, but I wonder if we can take it a bit further.
Here's what I'd do:

	1. Rename the 'in' parameter to 's'.
	2. Rename 'p' to 'in'.
	3. Rename 'end' to 'out'

At that point, you're reading from 'in' and writing to 'out', which
seems pretty nice and readable.

This code is pretty cold by the way, so it wouldn't matter for
performance. GCC knows how functions like strcat() work too, and uses
that to optimize (see
https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html).

I'm all for trying to make Kconfig's code neater though.


Tip: If you want to run Valgrind, you can do it with a command like

  $ ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` valgrind scripts/kconfig/mconf Kconfig

That works the same as

  $ make menuconfig

Cheers,
Ulf
