Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D5FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3621480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mIKq3Uwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD3621480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeIYNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:31:45 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35661 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeIYNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:31:45 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9F7AF25B749;
        Tue, 25 Sep 2018 17:25:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537860331; bh=0cTJg+ekm0gQss3gSH8RZxHjQ2NBj2/OD5aq57NKo0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIKq3UwyLNh+SanjnF0OCcvgjmCRq77P1O9g/EWtcj8rlr1YoNS86rkmJjYASoSrX
         2654QjSVx9g8JSIfrxYuNxjUuQ0KBwEzMVCfJPxywdp7EijKrvmzKU61P15iaugN+l
         q1wj/Prdtkbb8sWWLM7Lacwl2Ry7+e0EWslZX9jo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AD016940453; Tue, 25 Sep 2018 09:25:29 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:25:29 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/8] phy: renesas: rcar-gen3-usb2: Check a property to
 use otg pins
Message-ID: <20180925072528.zginn24mkg5ggvxh@verge.net.au>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:53:20PM +0900, Yoshihiro Shimoda wrote:
> Since All R-Car Gen3 SoCs have dedicated otg pins actually but
> some boards don't use the otg pins (e.g. R-Car D3 Draak and R-Car E3
> Ebisu), the driver should not choose SoC model base by using
> rcar_gen3_phy_usb2_match_table's data. So, this patch checks a
> "renesas,no-otg-pins" property to set the "uses_otg_pins".
> 
> Note that since r8a77995-draak.dts and r8a77990-ebisu.dts don't have
> 'dr_mode = "otg";' for now, if we apply this patch, no behavior
> changes (the value of "uses_otg_pins" is false).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index d69317e..856056e 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -78,8 +78,6 @@
>  #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
>  #define USB2_ADPCTRL_DRVVBUS		BIT(4)
>  
> -#define RCAR_GEN3_PHY_HAS_DEDICATED_PINS	1
> -
>  struct rcar_gen3_chan {
>  	void __iomem *base;
>  	struct extcon_dev *extcon;
> @@ -385,21 +383,10 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
>  }
>  
>  static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
> -	{
> -		.compatible = "renesas,usb2-phy-r8a7795",
> -		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
> -	},
> -	{
> -		.compatible = "renesas,usb2-phy-r8a7796",
> -		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
> -	},
> -	{
> -		.compatible = "renesas,usb2-phy-r8a77965",
> -		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
> -	},
> -	{
> -		.compatible = "renesas,rcar-gen3-usb2-phy",
> -	},
> +	{ .compatible = "renesas,usb2-phy-r8a7795" },
> +	{ .compatible = "renesas,usb2-phy-r8a7796" },
> +	{ .compatible = "renesas,usb2-phy-r8a77965" },
> +	{ .compatible = "renesas,rcar-gen3-usb2-phy" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen3_phy_usb2_match_table);
> @@ -445,7 +432,8 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  	if (of_usb_get_dr_mode_by_phy(dev->of_node, 0) == USB_DR_MODE_OTG) {
>  		int ret;
>  
> -		channel->uses_otg_pins = (uintptr_t)of_device_get_match_data(dev);
> +		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
> +							"renesas,no-otg-pins");
>  		channel->extcon = devm_extcon_dev_allocate(dev,
>  							rcar_gen3_phy_cable);
>  		if (IS_ERR(channel->extcon))
> -- 
> 1.9.1
> 
