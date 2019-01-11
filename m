Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF342183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbfAKTA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:00:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:42384 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388253AbfAKTA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:00:56 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi234-0006jc-Cz; Fri, 11 Jan 2019 22:00:54 +0300
Subject: Re: [PATCH] lib/ubsan: default UBSAN_ALIGNMENT to not set
To:     Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20181217150326.30933-1-anders.roxell@linaro.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <8bc73bbf-6c12-7fd1-3253-676731bf5ae5@virtuozzo.com>
Date:   Fri, 11 Jan 2019 22:01:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181217150326.30933-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/18 6:03 PM, Anders Roxell wrote:
> When booting an allmodconfig kernel, there are a lot of false-positives.
> With a message like this 'UBSAN: Undefined behaviour in...' with a call
> trace that follows.
> 
> Reworked so that when building a allmodconfig kernel that turns
> everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>


>  lib/Kconfig.ubsan | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 98fa559ebd80..a2ae4a8e4fa6 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -27,15 +27,19 @@ config UBSAN_SANITIZE_ALL
>  	  Enabling this option will get kernel image size increased
>  	  significantly.
>  
> -config UBSAN_ALIGNMENT
> -	bool "Enable checking of pointers alignment"
> +config UBSAN_NO_ALIGNMENT
> +	bool "Disable checking of pointers alignment"
>  	depends on UBSAN
> -	default y if !HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	default y if HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	help
> -	  This option enables detection of unaligned memory accesses.
> -	  Enabling this option on architectures that support unaligned
> +	  This option disables the check of unaligned memory accesses.
> +	  This option should be used when building allmodconfig.
> +	  Disabling this option on architectures that support unaligned
>  	  accesses may produce a lot of false positives.
>  
> +config UBSAN_ALIGNMENT
> +	def_bool !UBSAN_NO_ALIGNMENT
> +
>  config TEST_UBSAN
>  	tristate "Module for testing for undefined behavior detection"
>  	depends on m && UBSAN
> 
