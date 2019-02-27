Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A83FC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C248218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfB0IZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:25:21 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:53017 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfB0IZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:25:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,418,1544482800"; 
   d="scan'208";a="371074940"
Received: from think-julia.rsr.lip6.fr ([132.227.76.14])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:25:19 +0100
Date:   Wed, 27 Feb 2019 09:25:19 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error
 paths
In-Reply-To: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Message-ID: <alpine.DEB.2.21.1902270920300.2671@hadrien>
References: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:

> This patch fixes memory leak at error paths of the probe function.
> In for_each_child_of_node, if the loop returns, the driver should
> call of_put_node() before returns.
>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
> index 72eeb06..570b4e4 100644
> --- a/drivers/phy/renesas/phy-rcar-gen2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen2.c
> @@ -285,6 +285,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
>  		error = of_property_read_u32(np, "reg", &channel_num);
>  		if (error || channel_num > 2) {
>  			dev_err(dev, "Invalid \"reg\" property\n");
> +			of_node_put(np);
>  			return error;
>  		}
>  		channel->select_mask = select_mask[channel_num];
> @@ -300,6 +301,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
>  						   &rcar_gen2_phy_ops);
>  			if (IS_ERR(phy->phy)) {
>  				dev_err(dev, "Failed to create PHY\n");
> +				of_node_put(np);
>  				return PTR_ERR(phy->phy);
>  			}
>  			phy_set_drvdata(phy->phy, phy);

Hello,

I was concerned about the assignment channel->of_node = np;.  Because
channels is allocated with a devm function, it will get freed on an error
return, so this pointer doesn't matter.  But don't you need an of_node_get
on this assignment?  Does the fact that you haven't seen a problem with
this in testing mean that the field is actually never accessed?

julia
