Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E24C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299E4214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeLZPru convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:47:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48739 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeLZPrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 10:47:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A527320A02; Wed, 26 Dec 2018 16:47:48 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7A4FA2070E;
        Wed, 26 Dec 2018 16:47:38 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: dove: fix refcount leak in dove_clk_init()
References: <20181226135013.5580-1-tiny.windzz@gmail.com>
Date:   Wed, 26 Dec 2018 16:47:38 +0100
In-Reply-To: <20181226135013.5580-1-tiny.windzz@gmail.com> (Yangtao Li's
        message of "Wed, 26 Dec 2018 08:50:13 -0500")
Message-ID: <87lg4c9tnp.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,
 
 On mer., déc. 26 2018, Yangtao Li <tiny.windzz@gmail.com> wrote:

> The of_find_compatible_node() returns a node pointer with refcount
> incremented, but there is the lack of use of the of_node_put() when
> done. Add the missing of_node_put() to release the refcount.

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/clk/mvebu/dove.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
> index e0dd99f36bf4..0bd09d33f9cf 100644
> --- a/drivers/clk/mvebu/dove.c
> +++ b/drivers/clk/mvebu/dove.c
> @@ -188,10 +188,14 @@ static void __init dove_clk_init(struct device_node *np)
>  
>  	mvebu_coreclk_setup(np, &dove_coreclks);
>  
> -	if (ddnp)
> +	if (ddnp) {
>  		dove_divider_clk_init(ddnp);
> +		of_node_put(ddnp);
> +	}
>  
> -	if (cgnp)
> +	if (cgnp) {
>  		mvebu_clk_gating_setup(cgnp, dove_gating_desc);
> +		of_node_put(cgnp);
> +	}
>  }
>  CLK_OF_DECLARE(dove_clk, "marvell,dove-core-clock", dove_clk_init);
> -- 
> 2.17.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
