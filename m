Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C755C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF11214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeLZPmv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:42:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48684 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeLZPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 10:42:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8753D20A02; Wed, 26 Dec 2018 16:42:49 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5D8EB2070E;
        Wed, 26 Dec 2018 16:42:39 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: armada-370: fix refcount leak in a370_clk_init()
References: <20181226133658.5095-1-tiny.windzz@gmail.com>
Date:   Wed, 26 Dec 2018 16:42:39 +0100
In-Reply-To: <20181226133658.5095-1-tiny.windzz@gmail.com> (Yangtao Li's
        message of "Wed, 26 Dec 2018 08:36:58 -0500")
Message-ID: <8736qkb8gg.fsf@bootlin.com>
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
>  drivers/clk/mvebu/armada-370.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
> index 7dedfaa6e152..5c6bbee396b3 100644
> --- a/drivers/clk/mvebu/armada-370.c
> +++ b/drivers/clk/mvebu/armada-370.c
> @@ -175,8 +175,10 @@ static void __init a370_clk_init(struct device_node *np)
>  
>  	mvebu_coreclk_setup(np, &a370_coreclks);
>  
> -	if (cgnp)
> +	if (cgnp) {
>  		mvebu_clk_gating_setup(cgnp, a370_gating_desc);
> +		of_node_put(cgnp);
> +	}
>  }
>  CLK_OF_DECLARE(a370_clk, "marvell,armada-370-core-clock", a370_clk_init);
>  
> -- 
> 2.17.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
