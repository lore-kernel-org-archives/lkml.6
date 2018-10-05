Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222AFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8023208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="no6ZApMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8023208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeJEPpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:45:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47244 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeJEPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:45:12 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2EB219E6;
        Fri,  5 Oct 2018 10:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538729246;
        bh=5cISgKifriNSupDXNiNaXhwWI5lXVEU7L5mY6MwTcro=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=no6ZApMX5HlYoJwZ4jxOaHpScWnaCa2wj4JB9M7MkHuEMwaug6MEASTtl6oi1ByU+
         MeMPWZlBJqkaXR2mMVixks4rcRQxXy+FE5xVJscR26uQ2ALoJdTSNGw1dHaA2pGWTo
         c2wbjuw8zhWu+zGGip6GUJh5tzinCSRkzCGaiWdQ=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] kbuild: fix kernel/bounds.c 'W=1' warning
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        yamada.masahiro@socionext.com
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20181005083313.2088252-1-arnd@arndb.de>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <ae573dd3-8a2a-bad6-0132-815d1688a8ae@ideasonboard.com>
Date:   Fri, 5 Oct 2018 09:47:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005083313.2088252-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 05/10/18 09:33, Arnd Bergmann wrote:
> Building any configuration with 'make W=1' produces a warning:
> 
> kernel/bounds.c:16:6: warnign: no previous prototype for 'foo' [-Wmissing-prototypes]
> 

s/warnign/warning/ but I don't think that's too important :D

> When also passing -Werror, this prevents us from building any
> other files. Nobody ever calls the function, but we can't make
> it 'static' either since we want the compiler output.
> 
> Calling it 'main' instead however avoids the warning, because gcc
> does not insist on having a declaration for main.

Aha - even better! (and annoyingly fairly obvious, from the
Why-didn't-I-think-of-that department).

> Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> I have run into this problem several times before, and thought I had
> sent a fix at some point. Looking in the archives, I came across
> the suggested fix from Kieran, so I'm following up on that here.
> ---
>  kernel/bounds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index c373e887c066..9795d75b09b2 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -13,7 +13,7 @@
>  #include <linux/log2.h>
>  #include <linux/spinlock_types.h>
>  
> -void foo(void)
> +int main(void)
>  {
>  	/* The enum constants to put into include/generated/bounds.h */
>  	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
> @@ -23,4 +23,6 @@ void foo(void)
>  #endif
>  	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
>  	/* End of constants */
> +
> +	return 0;
>  }
> 

