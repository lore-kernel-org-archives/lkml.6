Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E15FC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B18821726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PbFy3Dl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfAWAyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:54:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2sCNN41CsolrZP+fJntEHUF7cg9yTvuWZBcL6XC/85k=; b=PbFy3Dl3HN+LB4Ak96nok/qXCb
        36GwBlHyDN/vaFPQg6a9Zb+xTxvFqFau+LsNcerlFkE3zB4zcNmO66GHo2YSdZheoVTknWjZbRSwF
        NNEkTcHuZwlX5qY3DHUusMKf6V4fk+16RAi9vXSlf4f7Euheni8jrYHHQ/IYafL7Shw0GbF/Lz/lh
        IHp1kvhHUuqW0u+igpSYM3AI2ESzj19hzHmdEzUmDRrIVGxPPCD3eFVkZ44r1kbndqAcxEk6QN01o
        Hem6U+0mRbHH0eJH3QR24kmcS4o0Rvb4gjQV+GalNvhUPJI4qoodfVJ3/vaJwF2yDUzLrfGJdffbQ
        3FEgkzIA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gm6nq-0008Cb-Pp; Wed, 23 Jan 2019 00:54:02 +0000
Subject: Re: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, paul.gortmaker@windriver.com
References: <20190123003345.13750-1-f.fainelli@gmail.com>
 <20190123003345.13750-3-f.fainelli@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c64196a-b23c-efae-b449-a62981d44a26@infradead.org>
Date:   Tue, 22 Jan 2019 16:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190123003345.13750-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 4:33 PM, Florian Fainelli wrote:
> On 32-bit architectures defining resource_size_t as 64-bit (because of
> PAE), we can run into a linker failure because of the modulo and the
> division against resource_size(), replace the two problematic operations
> with an alignment check on the register resource (instead of modulo),
> and the division with DIV_ROUND_CLOSEST_ULL().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/reset-brcmstb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> index 01ab1f71518b..c4cab8b5052d 100644
> --- a/drivers/reset/reset-brcmstb.c
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) % SW_INIT_BANK_SIZE) {
> +	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
> +	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
>  		dev_err(kdev, "incorrect register range\n");
>  		return -EINVAL;
>  	}
> @@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  	dev_set_drvdata(kdev, priv);
>  
>  	priv->rcdev.owner = THIS_MODULE;
> -	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
> +						      SW_INIT_BANK_SIZE) * 32;
>  	priv->rcdev.ops = &brcmstb_reset_ops;
>  	priv->rcdev.of_node = kdev->of_node;
>  	/* Use defaults: 1 cell and simple xlate function */
> 

Hi Florian,

This gives me:

  CC      drivers/reset/reset-brcmstb.o
../drivers/reset/reset-brcmstb.c: In function ‘brcmstb_reset_probe’:
../drivers/reset/reset-brcmstb.c:95:6: error: implicit declaration of function ‘IS_AGLINED’ [-Werror=implicit-function-declaration]
      !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
      ^


but if the typo is fixed, it is fine :) then you can added:

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
