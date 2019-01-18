Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCC720883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfARQ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:27:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfARQ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:27:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B655BEBD;
        Fri, 18 Jan 2019 08:27:38 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C48DF3F557;
        Fri, 18 Jan 2019 08:27:36 -0800 (PST)
Subject: Re: [PATCH 1/3] kconfig.h: abstract empty functions with STUB_UNLESS
 macro
To:     Andrew Murray <andrew.murray@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     rjw@rjwysocki.net, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Grant Likely <Grant.Likely@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <1547827230-55132-2-git-send-email-andrew.murray@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <830dafb3-7e93-e655-464f-8cb821de8dd5@arm.com>
Date:   Fri, 18 Jan 2019 16:27:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547827230-55132-2-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 16:00, Andrew Murray wrote:
> A common pattern found in header files is a function declaration dependent
> on a CONFIG_ option being enabled, followed by an empty function for when
> that option isn't enabled. This can often take up a lot of space and impact
> code readability.
> 
> Let's introduce the following STUB_UNLESS macro:
> 
> STUB_UNLESS(CONFIG_FOO, [body], prototype)
> 
> This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
> to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
> inline' followed by an empty function body. Where optional argument 'body'
> then 'body' will be used as the function body, intended to allow for simple
> return statements.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Seems like it should remove a lot of boilerplate code, so looks good to me.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  include/linux/kconfig.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index cc8fa10..216a27f 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -12,6 +12,7 @@
>  
>  #define __ARG_PLACEHOLDER_1 0,
>  #define __take_second_arg(__ignored, val, ...) val
> +#define __take_fourth_arg(__ignored, __ignored2, __ignored3, val, ...) val
>  
>  /*
>   * The use of "&&" / "||" is limited in certain expressions.
> @@ -70,4 +71,34 @@
>   */
>  #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>  
> +
> +
> +/*
> + * Allow for __stub to be overloaded by making the second argument optional
> + */
> +#define __stub_overload(...)		__take_fourth_arg(__VA_ARGS__, \
> +					__stub_body, __stub_void)(__VA_ARGS__)
> +#define __stub_body(option, body, ptype) __stub(option, body, ptype)
> +#define __stub_void(option, ptype)	__stub(option, , ptype)
> +
> +/*
> + * Using the same trick as __defined we use the config option to conditionally
> + * expand to an extern function declaration or a static stub function.
> + */
> +#define __stub(option, body, ptype)	___stub( \
> +					__ARG_PLACEHOLDER_##option, body, ptype)
> +#define ___stub(arg1_or_junk, body, ptype) __take_second_arg( \
> +		arg1_or_junk __extern_ptype(ptype), __static_ptype(body, ptype))
> +#define __static_ptype(body, ptype)	static inline ptype { body; }
> +#define __extern_ptype(ptype)		extern ptype
> +
> +/*
> + * STUB_UNLESS(CONFIG_FOO, [body], prototype) evaluates to 'prototype' prepended
> + * with 'extern' if CONFIG_FOO is set to 'y'. Otherwise it will evaluate to
> + * 'prototype' prepended with 'static inline' followed by an empty function
> + * body. Where optional argument 'body' is present then 'body' will be used
> + * as the function body, intended to allow for simple return statements.
> + */
> +#define STUB_UNLESS(...) __stub_overload(__VA_ARGS__)
> +
>  #endif /* __LINUX_KCONFIG_H */
> 

