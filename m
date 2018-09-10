Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA1220870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="DPTaHtfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA1220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIJWp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:45:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54536 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:45:57 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E13435C19B2;
        Mon, 10 Sep 2018 19:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536601840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEqyCQBeGFMuM69LrkARWUdBfgxnLdJ+yuLUFggzxuY=;
        b=DPTaHtfgkHsVlnHRG913TfUw92pZnmasvyJs82fMyFjbDJWpEJe73DZcWM3YSA4mLxp4oy
        9z3soxUofy27lOjWHWZ28V+EXKFb49Kv+0A0iO3rDu5Oixezh79twcokhdKovWo9VIBAgI
        x8hC4yw/RBt0LCPd0cqUamMoMONsqzo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Sep 2018 10:50:40 -0700
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4 06/13] Compiler Attributes: naked can be shared
In-Reply-To: <20180908212459.19736-7-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
 <20180908212459.19736-7-miguel.ojeda.sandonis@gmail.com>
Message-ID: <9daffa34182b7163c2bfdbbe5b688189@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2018 14:24, Miguel Ojeda wrote:
> The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> and icc >= 13. See https://godbolt.org/z/350Dyc
> 
> Therefore, move it out of compiler-gcc.h so that the definition
> is shared by all compilers.
> 

This actually fixes Clang support for ARM32, it fixes: 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

So this should go in v4.19. Is this patch set (patches 5/6 in
particular) planned for v4.19? If not, we probably have to split out
this fix...

--
Stefan

> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler-gcc.h   | 8 --------
>  include/linux/compiler_types.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 4cd5e9264bce..3b32bbfa5a49 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -72,14 +72,6 @@
>  #define __noretpoline __attribute__((__indirect_branch__("keep")))
>  #endif
>  
> -/*
> - * it doesn't make sense on ARM (currently the only user of __naked)
> - * to trace naked functions because then mcount is called without
> - * stack and frame pointer being set up and there is no chance to
> - * restore the lr register to the value before mcount was called.
> - */
> -#define __naked		__attribute__((__naked__)) notrace
> -
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 83475515bc39..5ff9cda893f4 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -224,6 +224,14 @@ struct ftrace_likely_data {
>  #define notrace			__attribute__((__no_instrument_function__))
>  #endif
>  
> +/*
> + * it doesn't make sense on ARM (currently the only user of __naked)
> + * to trace naked functions because then mcount is called without
> + * stack and frame pointer being set up and there is no chance to
> + * restore the lr register to the value before mcount was called.
> + */
> +#define __naked			__attribute__((__naked__)) notrace
> +
>  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
>  
>  /*
