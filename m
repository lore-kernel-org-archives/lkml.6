Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD48C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872BB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="niYr6EJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872BB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeIJWkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:40:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54458 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeIJWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:40:49 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 82F475C0414;
        Mon, 10 Sep 2018 19:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536601533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZWp9KqgbQjuOfzRPLcdogaqdPH6Fd/f5vgZjN9g17s=;
        b=niYr6EJWOmRdMezY+sIUyxPnftn1R6svpVZ2mH6eO/P8koTkhL548ASOk9VUrpvTvVrQ9O
        iJPNpc4f1IWjZL+4d9KipYfBl3ZJIyft4xe1WDMrqs4pswsWwp1tX7fgtgX8C53zsiqWoA
        THIL3j6lRjSXIAsgesVV9CFIJHWKbQk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Sep 2018 10:45:33 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4 05/13] Compiler Attributes: naked was fixed in gcc 4.6
In-Reply-To: <20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
 <20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com>
Message-ID: <edf2141389d25ecb40d32575d1e31a26@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08.09.2018 14:24, Miguel Ojeda wrote:
> Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
> and noinline on __naked functions") added noinline and noclone
> as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.
> 
> Since now the minimum gcc supported version is 4.6,
> we can clean it up.
> 
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
> and https://godbolt.org/z/h6NMIL
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler-gcc.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 76f4907ef707..4cd5e9264bce 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -77,14 +77,8 @@
>   * to trace naked functions because then mcount is called without
>   * stack and frame pointer being set up and there is no chance to
>   * restore the lr register to the value before mcount was called.

I think this is also no longer required since GCC 4.6 and newer only
have the new mcount interface:

https://lore.kernel.org/lkml/20180826214022.4889-1-stefan@agner.ch/T/#u

That said, I am not sure whether it is a good idea to enable tracing for
naked functions even with the mcount interface.

--
Stefan


> - *
> - * The asm() bodies of naked functions often depend on standard calling
> - * conventions, therefore they must be noinline and noclone.
> - *
> - * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
> - * See GCC PR44290.
>   */
> -#define __naked		__attribute__((__naked__)) noinline __noclone notrace
> +#define __naked		__attribute__((__naked__)) notrace
>  
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
