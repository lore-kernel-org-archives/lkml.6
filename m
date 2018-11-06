Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811BFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3297F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbeKFVr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:47:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387568AbeKFVr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:47:59 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uQbP3KgsmQl0; Tue,  6 Nov 2018 13:23:00 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 202C61EC0758;
        Tue,  6 Nov 2018 13:23:00 +0100 (CET)
Date:   Tue, 6 Nov 2018 13:22:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v10 1/7] x86/boot: Introduce cmdline_find_option_arg()to
 detect if option=arg in cmdline
Message-ID: <20181106122253.GG13712@zn.tnic>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
 <20181022093720.21426-2-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022093720.21426-2-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 05:37:14PM +0800, Chao Fan wrote:
> Now, there are cmdline_find_option() and cmdline_find_option_bool() in
> cmdline.c. Sometimes, when detecting such as whether 'acpi=off' is
> in cmdline, we need to cmdline_find_option() first, then compare
> the argument. Now splite the operation as a independent function.
> Introduce a new function cmdline_find_option_arg() to detect whether
> option is in command line and the value is arg.

For all future commit messages you write:

Use passive tone in your commit message: no "we", etc.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst.

> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/cmdline.c | 15 +++++++++++++++
>  arch/x86/boot/compressed/misc.h    |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
> index af6cda0b7900..61118c69feb8 100644
> --- a/arch/x86/boot/compressed/cmdline.c
> +++ b/arch/x86/boot/compressed/cmdline.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "misc.h"
> +#define STATIC
> +#include <linux/decompress/mm.h>
>  
>  #if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE || CONFIG_X86_5LEVEL
>  
> @@ -30,5 +32,18 @@ int cmdline_find_option_bool(const char *option)
>  {
>  	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
>  }
> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize)
> +{
> +	char *buffer = malloc(argsize+1);
> +	bool find = false;
> +	int ret;
> +
> +	ret = cmdline_find_option(option, buffer, argsize+1);
> +	if (ret == argsize && !strncmp(buffer, arg, argsize))
> +		find = true;
> +
> +	free(buffer);
> +	return find;
> +}

I don't think such wrapper is needed. Simply calling
cmdline_find_option() and then examining the buffer - like other call
sites do - is perfectly fine.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
