Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9012145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyncKu55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9012145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeKPPYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:24:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45743 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeKPPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:24:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id d135so35612104qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=B2EdM+72quGJ7vFvERTQ17aISz/apRKrBzgbhXypf8U=;
        b=CyncKu55LvCbEg3hVAvQBQZlSQWGOzh9qf7t2PO3PT4aAtPIb1s0cth2282OVtH+Un
         Dzzi981XLkFjRlVvtuS/olzlESPmImw2ilkCtIYpyy34BT2Gi8k9Rh4yNThwGoYcHWUS
         yAku7xbutYsPZlJizfB7q8B7xElV1U7Fiv4dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=B2EdM+72quGJ7vFvERTQ17aISz/apRKrBzgbhXypf8U=;
        b=VoRZ5F9wlgbDL1ujgUqjyApCZtT2etRMmRFol6D96Q6cynLWSNHfSZX5MOUoJXkwri
         Sg/0EDZ8dxMV9xpkxADbFFlouNb/xFP5FhmmCnV64VG18BgauJXuUKOH3w1i3F9OaELT
         KCC8CtEO5iNcW4bTrq0kr/ejuZ9D72najBGjNSrYtAJDBYCcso9K5EpKH3eXqCvbyj2g
         kRaPMWWmgShiNqJtxSKJ+WTrIyoRscUMozb141jcbdEpSYfzd2VjpErjetK9GHgAPaBi
         f8qchjfpHdHlieghdkTIO1b1bU3NGxXFMftSq/RwP+1LgO81y6mIPYFkDA6B1wUj21Cn
         tzgg==
X-Gm-Message-State: AGRZ1gL+eSWH7promNELwTt5KyVhgGi21nF+0jYZT9EphrD8SogWaCWS
        nYMxTsDWj/9F08XcuKuEx1S1SA==
X-Google-Smtp-Source: AJdET5eAXnsH0UtwD8cVCwMNc+Ma+sERYi5Ax63QzViGMXwNNDNSKiSj2htDBj0bTZ0Mv3dHCjvrZw==
X-Received: by 2002:a37:b405:: with SMTP id d5mr8693275qkf.162.1542345194620;
        Thu, 15 Nov 2018 21:13:14 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id z20sm4259182qkb.41.2018.11.15.21.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 21:13:13 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:13:10 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 4/8] kbuild: simplify dependency generation for
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1811152346510.1993@knanqh.ubzr>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com> <1542270435-11181-5-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Masahiro Yamada wrote:

> My main motivation of this commit is to clean up scripts/Kbuild.include
> and scripts/Makefile.build.
> 
> Currently, CONFIG_TRIM_UNUSED_KSYMS works with a tricky gimmick;
> possibly exported symbols are detected by letting $(CPP) replace
> EXPORT_SYMBOL* with a special string '=== __KSYM_*===', which is
> post-processed by sed, and passed to fixdep. The extra preprocessing
> is costly, and hacking cmd_and_fixdep is ugly.
> 
> I came up with a new way to find exported symbols; insert a dummy
> symbol __ksym_marker_* to each potentially exported symbol. Those
> dummy symbols are picked up by $(NM), post-processed by sed, then
> appended to .*.cmd files. I collected the post-process part to a
> new shell script scripts/gen_ksymdeps.sh for readability. The dummy
> symbols are put into the .discard.* section so that the linker
> script rips them off the final vmlinux or modules.

Brilliant!  I really like it.

Minor comments below.

> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 4d73e6e..294d6ae 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -59,16 +59,19 @@ __kcrctab_\name:
>  .endm
>  #undef __put
>  
> -#if defined(__KSYM_DEPS__)
> -
> -#define __EXPORT_SYMBOL(sym, val, sec)	=== __KSYM_##sym ===
> -
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +#if defined(CONFIG_TRIM_UNUSED_KSYMS)
>  
>  #include <linux/kconfig.h>
>  #include <generated/autoksyms.h>
>  
> +.macro __ksym_marker sym
> +	.section ".discard.ksym","a"
> +__ksym_marker_\sym:
> +	 .previous

Does this work as intended? I have vague memories about having problems 
with sections being discarded when they don't allocate any space.

> +.endm
> +
>  #define __EXPORT_SYMBOL(sym, val, sec)				\
> +	__ksym_marker sym;					\
>  	__cond_export_sym(sym, val, sec, __is_defined(__KSYM_##sym))
>  #define __cond_export_sym(sym, val, sec, conf)			\
>  	___cond_export_sym(sym, val, sec, conf)
> diff --git a/include/linux/export.h b/include/linux/export.h
> index ce764a5..0413a3d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -92,22 +92,22 @@ struct kernel_symbol {
>   */
>  #define __EXPORT_SYMBOL(sym, sec)
>  
> -#elif defined(__KSYM_DEPS__)
> +#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> +
> +#include <generated/autoksyms.h>
>  
>  /*
>   * For fine grained build dependencies, we want to tell the build system
>   * about each possible exported symbol even if they're not actually exported.
> - * We use a string pattern that is unlikely to be valid code that the build
> - * system filters out from the preprocessor output (see ksym_dep_filter
> - * in scripts/Kbuild.include).
> + * We use a symbol pattern __ksym_marker_<symbol> that the build system filters
> + * from the $(NM) output (see scripts/gen_ksymdep.sh). These symbols are
> + * discarded in the final link stage.
>   */
> -#define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
> -
> -#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
> -
> -#include <generated/autoksyms.h>
> +#define __ksym_marker(sym)	\
> +	static int __ksym_marker_##sym[0] __section(".discard.ksym") __used

Even if this is discarded during the final link, maybe this could save 
a tiny amount of disk space by using a char instead?

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 7f3ca6e..e5ba9b1 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -254,9 +254,18 @@ objtool_dep = $(objtool_obj)					\
>  	      $(wildcard include/config/orc/unwinder.h		\
>  			 include/config/stack/validation.h)
>  
> +ifdef CONFIG_TRIM_UNUSED_KSYMS
> +cmd_gen_ksymdeps = \
> +	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ > $(dot-target).tmp; \
> +	cat $(dot-target).tmp >> $(dot-target).cmd; \
> +	rm -f $(dot-target).tmp;

Why don't you append to $(dot-target).cmd directly?


Nicolas
