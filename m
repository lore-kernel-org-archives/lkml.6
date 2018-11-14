Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B08223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B08223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeKOFUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:20:23 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:36228 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKOFUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:20:23 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d16 with ME
        id zvFs1y00E0nnJME03vFtRt; Wed, 14 Nov 2018 20:15:54 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 14 Nov 2018 20:15:54 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning
References: <20181114173107.1229717-1-lkundrak@v3.sk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 14 Nov 2018 20:15:52 +0100
In-Reply-To: <20181114173107.1229717-1-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Wed, 14 Nov 2018 18:31:07 +0100")
Message-ID: <87lg5vjwrb.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> A careless oversight. Sorry.
>
> Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/spi/spi-pxa2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 29e6025f104c..7194070e4009 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1555,7 +1555,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>  	}
>  #endif
>  
> -#if CONFIG_OF
> +#ifdef CONFIG_OF
>  	if (of_id) {
>  		pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
>  								"spi-slave");
While at it, why not simply remove the "#if CONFIG_OF", the if (of_id), and
write simply this, without any ifs ? :
	pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
						"spi-slave");

If CONFIG_OF=n, of_property_read_bool() is guaranteed to return false. If the
device is not found through devicetree, of_node == NULL and a false will
still be returned. And the last case is your bool read case (ie. when devicetree
probed the device).

Cheers.

-- 
Robert
