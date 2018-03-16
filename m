Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeCPT1Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:27:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeCPT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:27:14 -0400
Date: Fri, 16 Mar 2018 15:27:12 -0400 (EDT)
Message-Id: <20180316.152712.1584177628223195375.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: heiko@sntech.de, branislav@radocaj.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
From: David Miller <davem@davemloft.net>
In-Reply-To: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 14 Mar 2018 22:09:34 +0100

> diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
> index 16f9bee992fe..8ee9dfd0e363 100644
> --- a/drivers/net/ethernet/arc/emac_rockchip.c
> +++ b/drivers/net/ethernet/arc/emac_rockchip.c
> @@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
>  	/* Optional regulator for PHY */
>  	priv->regulator = devm_regulator_get_optional(dev, "phy");
>  	if (IS_ERR(priv->regulator)) {
> -		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
> +			ret = -EPROBE_DEFER;
> +			goto out_clk_disable;
> +		}

Please build test your changes.

There is no 'ret' variable in this function, perhaps you meant 'err'.
