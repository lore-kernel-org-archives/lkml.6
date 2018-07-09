Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4458020849
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4458020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbeGJAco (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:32:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:41875 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932847AbeGJAch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:32:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w69NrOR3025026;
        Mon, 9 Jul 2018 18:53:26 -0500
Message-ID: <34126dddef64a7669946c354d4dd9e2adfb3344f.camel@kernel.crashing.org>
Subject: Re: [PATCH] gpio: aspeed: fix compile testing warning
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 09:53:24 +1000
In-Reply-To: <20180709145612.4166409-1-arnd@arndb.de>
References: <20180709145612.4166409-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 16:56 +0200, Arnd Bergmann wrote:
> Gcc cannot always see that BUG_ON(1) is guaranteed to not
> return, so we get a warning message in some configurations:
> 
> drivers/gpio/gpio-aspeed.c: In function 'bank_reg':
> drivers/gpio/gpio-aspeed.c:244:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> Using a plain BUG() is easier here and avoids the problem.
> 
> Fixes: 44ddf559d579 ("gpio: aspeed: Rework register type accessors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Linus, can you plonk that on top of the patches in that topic branch
you created ?

> ---
>  drivers/gpio/gpio-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 1e00f4045f9d..2342e154029b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -240,7 +240,7 @@ static inline void __iomem *bank_reg(struct aspeed_gpio *gpio,
>  	case reg_cmdsrc1:
>  		return gpio->base + bank->cmdsrc_regs + GPIO_CMDSRC_1;
>  	}
> -	BUG_ON(1);
> +	BUG();
>  }
>  
>  #define GPIO_BANK(x)	((x) >> 5)


