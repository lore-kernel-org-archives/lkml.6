Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB3FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43920867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OoQAjYRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIZBMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:12:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36199 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeIZBMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:12:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so12235416pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SyTK1BoMxBxv+BqLKB7rn0i/6v7po3PI/AAlrgqFWUE=;
        b=OoQAjYRJEQc+wDXThrOgSgmmoiY/U2ikybunt+it1FcaN9uTRdPhkiEUk0G/bxJw/E
         Tllcg+gsnWtpE9zCJMlnSHLmXplhIX+dpEYuIhZhnkSpdETyjD05k3jsoR/e1TD8cCv9
         5sguE1CFPoQh1e49Lo+kyuUVbvnvhjALlVfv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SyTK1BoMxBxv+BqLKB7rn0i/6v7po3PI/AAlrgqFWUE=;
        b=iPwntTblAKilACI5/2fLHIOfhK0eaq16vDcy33s+1haXzPNIvqEtz9S6u0cxNrCd4m
         X8lk41OGTbLbbOp33L7rwivjIHxqcg1dFFAn7cea7mB+1vvqU4MoAC5x0JfFTekvsuOo
         TJ68sm0ROUSu3W5KPB71wVmVxA7yhZdWEB/3nvAVppbGSxGs7FSufKKKMrn5+TfV554q
         g2nn5LAD6+9LEw2Eo1QN+ufLw29MHPETObNmiCXvt6t1fzj9Nb30crurfpjaoHT10kQX
         slCaFa32uG7e4nlwsCWqsXdHFOwnGQTecLlqx/lLZB/9+KjrzEJg++oQ1k/6jVF5oNG3
         grrg==
X-Gm-Message-State: ABuFfoiWlVovOurvvC1RMtpntrnVHdgRHHichR7e+ieI2GNwKDHwyHrM
        Yxftt1BEHCCPBJUsVJCZR8dIAA==
X-Google-Smtp-Source: ACcGV62IhquDyRFx4Z37+dTQdsDYzFDbKer3PxQ1a7RYYNkYC5MQQOEIMmJ1CLsUXo6v3sf3HQzoDA==
X-Received: by 2002:a63:4281:: with SMTP id p123-v6mr2231119pga.91.1537902230396;
        Tue, 25 Sep 2018 12:03:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a15-v6sm4697625pfe.32.2018.09.25.12.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:03:49 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:03:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Compiler Attributes: naked can be shared
Message-ID: <20180925190349.GB22824@google.com>
References: <20180925185339.80701-1-mka@chromium.org>
 <20180925185339.80701-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925185339.80701-2-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this series got messed up. Apparently the branch was still
rebasing when I ran 'git send-email' :/

On Tue, Sep 25, 2018 at 11:53:38AM -0700, Matthias Kaehlcke wrote:
> From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
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
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
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
> Tested-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
