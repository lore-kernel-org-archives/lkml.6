Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB2BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5362089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5362089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeGIPb3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:31:29 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:33562 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933298AbeGIPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:31:27 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id A74A127A64E;
        Mon,  9 Jul 2018 17:31:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 72E761A7929;
        Mon,  9 Jul 2018 17:31:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RXwySRVDCtJN; Mon,  9 Jul 2018 17:31:24 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.92])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id A096B1A7928;
        Mon,  9 Jul 2018 17:31:24 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: aspeed: fix compile testing warning
Date:   Mon, 09 Jul 2018 17:31:24 +0200
Message-ID: <3652696.6JvIze6Ubc@ws-140106>
In-Reply-To: <20180709145612.4166409-1-arnd@arndb.de>
References: <20180709145612.4166409-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 9, 2018, 4:56:03 PM CEST Arnd Bergmann wrote:
> Gcc cannot always see that BUG_ON(1) is guaranteed to not
> return, so we get a warning message in some configurations:
> 
> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void
> function [-Werror=return-type]
> 
> Using a plain BUG() is easier here and avoids the problem.
> 
> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 1e00f4045f9d..2342e154029b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio
> *gpio, case reg_cmdsrc1:
>  		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
>  	}
> -	BUG_ON(1);
> +	BUG();
>  }
> 
>  #define GPIO_BANK(x)	((x) >> 5)

Is the semantic of BUG() (and BUG_ON as well) to never return? If so, then 
just an idea: Is it possible to add some macro magic in BUG_ON(x) to fail 
compiling if x is compile-constant? Giving a hint the passed condition always 
fails, which indicates a problem, at least to me.
From a short search I found this in drivers/gpu/vga/vgaarb.c L630-633:
>	if (vgadev_find(pdev) != NULL) {
>		BUG_ON(1);
>		goto fail;
>	}
You can't fail with a BUG_ON(1) and try to do some error handling after that.

Best regards,
Alexander



