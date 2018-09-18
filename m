Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F111ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2C4214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="nQUA1jLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2C4214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeIRIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:50:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33668 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbeIRIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:50:24 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F04FB5C045D;
        Tue, 18 Sep 2018 05:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537240790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uiuhlr1l8MDh5zBNRPOZgn8LuQ3SVloDu3CsAIWYp+E=;
        b=nQUA1jLKVlH5t7Ily9NVxu1LBMKZCnDx7Y7Spwrr3LptwoOpif7477ujT/oowXsaJddzZb
        rrAhH1xg/WCfmshz1a8aMM1PgGI3UXamji80e2DbcPFXbD8GZVNEtlrYKi0xRqrNEaQwCR
        ctPJAI8qvVjOkknocJZ59w/rNsp8hfg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 20:19:50 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, arnd@arndb.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/2] Compiler Attributes: naked can be shared
In-Reply-To: <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com>
Message-ID: <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 16:59, Miguel Ojeda wrote:
> The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> and icc >= 13. See https://godbolt.org/z/350Dyc
> 
> Therefore, move it out of compiler-gcc.h so that the definition
> is shared by all compilers.
> 
> This also fixes Clang support for ARM32 --- 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

Ideally this two patches should go into v4.19. Not sure which path the patch should take, MAINTAINERS is not quite clear about that. This fixes 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive") for ARM32, which has been merged directly by
Linus, afaict...

--
Stefan

> ---
>  include/linux/compiler-gcc.h   | 8 --------
>  include/linux/compiler_types.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 25d3dd6b2702..4d36b27214fd 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -79,14 +79,6 @@
>  #define __noretpoline __attribute__((indirect_branch("keep")))
>  #endif
>  
> -/*
> - * it doesn't make sense on ARM (currently the only user of __naked)
> - * to trace naked functions because then mcount is called without
> - * stack and frame pointer being set up and there is no chance to
> - * restore the lr register to the value before mcount was called.
> - */
> -#define __naked		__attribute__((naked)) notrace
> -
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  #define __optimize(level)	__attribute__((__optimize__(level)))
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3525c179698c..db192becfec4 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -226,6 +226,14 @@ struct ftrace_likely_data {
>  #define notrace			__attribute__((no_instrument_function))
>  #endif
>  
> +/*
> + * it doesn't make sense on ARM (currently the only user of __naked)
> + * to trace naked functions because then mcount is called without
> + * stack and frame pointer being set up and there is no chance to
> + * restore the lr register to the value before mcount was called.
> + */
> +#define __naked			__attribute__((naked)) notrace
> +
>  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
>  
>  /*
