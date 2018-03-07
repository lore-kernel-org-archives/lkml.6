Return-Path: <kernel-hardening-return-12218-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsmtyE66swlvA4s7e56g9I0j/zhw92DB0x0E9Pe23qW7IJsh7Aa18jOzyS+tA0HxfRBDvTg
ARC-Seal: i=1; a=rsa-sha256; t=1520466041; cv=none;
        d=google.com; s=arc-20160816;
        b=0/GUJHibE0/DqUn82ep12tmRSU2jiUHI+Lw0sdtUNnOVoMuzTY13s4PGRpCHw7egPs
         lS/5q5cHCiSmMH/mRBBBgB2ndlKfa8NsEdSpXdI3KTg9TGhboeNmRwSaj8MGhEj3KkU7
         H/PBWKoF0Z33rkNtse09+pulkUOq/gntgQXUtVI2glvm877Dda172MplsEU+qXLesdT2
         K/Fg8gFNanPn5NbtfG0KXx0V5IlKJSg2pUeLK9sNXBfc71fO9vt8SR0lc9tsbkqTyuAg
         4TYqogitlQwT8sQabel/IIZmFuKx2sabYNWAnbh0Y78iOc4726koaY4mNAjcn6ioxdOK
         jhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=uu1Nf8/D17wtAZdvU2ccquIhiuPohcg95qy7rX/YeXk=;
        b=UMvfkjGSsj8KbDOAdR0Lne9xWvCRz4ECOYuCcGr+6zbjNJiQNXlHGpAUiSyts54Ld/
         1fnd0jkMzDPzhMDoFMtBm9GTM0CaSwCW4r3nzYknjgv3Tt1buvCVyuv1r6Dl9tA5kj6b
         d+mvZ+qcVgYKWCHy270C4yydBIELVrHjDvvtU5riK5RANxjnjrvhS0FJ1uf3ucTACvRi
         2CA/OGfGlf1GU6e+jy2A+gZKzBuEp5dbuHHMcrwQeQl1dooerFxtt8ATpKgDfMVxrqcO
         as5KecbcXrG/sRYKoozvpTOI5Hj8SDlO5QJ/vSLsvTgoiYEfockLg6zEJR5MOAvBm+sB
         xLaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12218-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12218-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12218-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12218-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 15:40:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
Message-Id: <20180307154019.e39890b5f8aa98cf25532cf1@linux-foundation.org>
In-Reply-To: <20180307230714.GA20797@beast>
References: <20180307230714.GA20797@beast>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594324199850026312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018 15:07:14 -0800 Kees Cook <keescook@chromium.org> wrote:

> The "sym" calculation is actually a fixed size, but since the max()
> macro uses some extensive tricks for safety, it ends up looking like a
> variable size. This replaces max() with a simple max macro which is
> sufficient for the calculation of the array size.
> 
> Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> ...
>
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
>  #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
>  #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
>  #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
> -	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
> -		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
> +#define SIMPLE_MAX(x, y)	((x) > (y) ? (x) : (y))
> +	char sym[SIMPLE_MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
> +			    2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
>  
>  	char *p = sym, *pend = sym + sizeof(sym);
>  	int decode = (fmt[0] == 'R') ? 1 : 0;

A year from now I'll be receiving an email titled

	[patch] lib/vsprintf.c: use standard max() macro

won't I?

--- a/lib/vsprintf.c~vsprintf-remove-accidental-vla-usage-fix
+++ a/lib/vsprintf.c
@@ -754,6 +754,7 @@ char *resource_string(char *buf, char *e
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
+/* regular max() tricks gcc into creating a variable length array */
 #define SIMPLE_MAX(x, y)	((x) > (y) ? (x) : (y))
 	char sym[SIMPLE_MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 			    2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
_
