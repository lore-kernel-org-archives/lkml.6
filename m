Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E5DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDF020671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIpvERgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeGZUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:44:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZUo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PiZeAUHsj7tW6dYvJbze5h7e3H2oEqgoRu7sxIN5s9E=; b=LIpvERgVmOL9ogumzFBBkSOEv
        6qhJqinX1INfSfb2pfdLlVYGzYb8bwlkvLwAFUm7wVMQ1K2XtVj0RObc4J+DaudjV+fCo6sYtqcNM
        bcC7SmsCIhhp2lwfmtNEF+i5zHLc/l9Kzk7OYLtr8/xknhH8aaKSKZrmW/heVw4zljMdtKxuUZul+
        KX0u35KpsW6FWYpz8YdChlirSxG/G6OicIczDCLBuHIS4G6Gsv/AV+DJPU70HXoCMC/k/kDBqHWFf
        9Yxg48jaVvfTYkuZSBEYs8kswpXq5AuJ+X4m/c7HB3SWN18JIkUp+ONHtwj41ncUaoPv1HScPj7/I
        Sb3WP6I6g==;
Received: from [179.95.19.99] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1filtq-00086H-Vk; Thu, 26 Jul 2018 19:26:11 +0000
Date:   Thu, 26 Jul 2018 16:26:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Ivan Bornyakov <brnkv.i1@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: stv090x: fix if-else order
Message-ID: <20180726162607.2de43b84@coco.lan>
In-Reply-To: <20180601161221.24807-1-brnkv.i1@gmail.com>
References: <20180601161221.24807-1-brnkv.i1@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri,  1 Jun 2018 19:12:21 +0300
Ivan Bornyakov <brnkv.i1@gmail.com> escreveu:

> There is this code:
> 
> 	if (v >= 0x20) {
> 		...
> 	} else if (v < 0x20) {
> 		...
> 	} else if (v > 0x30) {
> 		/* this branch is impossible */
> 	}
> 
> It would be sensibly for last branch to be on the top.

Have you tested it and check at the datasheets if dev_ver > 0x30 makes
sense?

If not, I would prefer, instead, to remove the dead code, as this
patch may cause regressions (adding a FIXME comment about this
special case).

> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  drivers/media/dvb-frontends/stv090x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/stv090x.c b/drivers/media/dvb-frontends/stv090x.c
> index 9133f65d4623..d70eb311ebaf 100644
> --- a/drivers/media/dvb-frontends/stv090x.c
> +++ b/drivers/media/dvb-frontends/stv090x.c
> @@ -4841,7 +4841,11 @@ static int stv090x_setup(struct dvb_frontend *fe)
>  	}
>  
>  	state->internal->dev_ver = stv090x_read_reg(state, STV090x_MID);
> -	if (state->internal->dev_ver >= 0x20) {
> +	if (state->internal->dev_ver > 0x30) {
> +		/* we shouldn't bail out from here */
> +		dprintk(FE_ERROR, 1, "INFO: Cut: 0x%02x probably incomplete support!",
> +			state->internal->dev_ver);
> +	} else if (state->internal->dev_ver >= 0x20) {
>  		if (stv090x_write_reg(state, STV090x_TSGENERAL, 0x0c) < 0)
>  			goto err;
>  
> @@ -4857,10 +4861,6 @@ static int stv090x_setup(struct dvb_frontend *fe)
>  			state->internal->dev_ver);
>  
>  		goto err;
> -	} else if (state->internal->dev_ver > 0x30) {
> -		/* we shouldn't bail out from here */
> -		dprintk(FE_ERROR, 1, "INFO: Cut: 0x%02x probably incomplete support!",
> -			state->internal->dev_ver);
>  	}
>  
>  	/* ADC1 range */



Thanks,
Mauro
