Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6EC208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="jTLEtd7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6EC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeIYNad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:30:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35648 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeIYNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:30:32 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9C77C25B749;
        Tue, 25 Sep 2018 17:24:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1537860258; bh=Qwfk0O42Hv/8wqMdAJmsVrNdneVZ4hyq1in7PUrtZlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTLEtd7bVyqFPpfodtwZwLugfPkJC7RBwU16DuFFXyAT84f2z8jQr/x4VEUL3A5Yx
         ypjLJyNhKMm4mTEbdNdJOo02p9WCPe7DN6JktRuNVsX8gM+j6Zjq+LpToG+6XnhZZ4
         dtxkT3um7OqTLiYe9KawGy4Tm5swLXRKhyQulif4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8F396940453; Tue, 25 Sep 2018 09:24:16 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:24:16 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/8] phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
Message-ID: <20180925072415.apfl6s5e7l5rwmxa@verge.net.au>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1537530804-19399-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537530804-19399-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:53:21PM +0900, Yoshihiro Shimoda wrote:
> This patch unifies the OBINTEN handling to clean-up the code.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The nit below notwithstanding.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index 856056e..e7eaed9 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -142,6 +142,18 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_gen3_chan *ch, int vbus)
>  	writel(val, usb2_base + USB2_ADPCTRL);
>  }
>  
> +static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
> +{

nit: Perhaps bool would be a better type for the enable parameter.

> +	void __iomem *usb2_base = ch->base;
> +	u32 val = readl(usb2_base + USB2_OBINTEN);
> +
> +	if (enable)
> +		val |= USB2_OBINT_BITS;
> +	else
> +		val &= ~USB2_OBINT_BITS;
> +	writel(val, usb2_base + USB2_OBINTEN);
> +}
> +
>  static void rcar_gen3_init_for_host(struct rcar_gen3_chan *ch)
>  {
>  	rcar_gen3_set_linectrl(ch, 1, 1);
> @@ -187,16 +199,12 @@ static void rcar_gen3_init_for_a_peri(struct rcar_gen3_chan *ch)
>  
>  static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
>  {
> -	void __iomem *usb2_base = ch->base;
> -	u32 val;
> -
> -	val = readl(usb2_base + USB2_OBINTEN);
> -	writel(val & ~USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> +	rcar_gen3_control_otg_irq(ch, 0);
>  
>  	rcar_gen3_enable_vbus_ctrl(ch, 1);
>  	rcar_gen3_init_for_host(ch);
>  
> -	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> +	rcar_gen3_control_otg_irq(ch, 1);
>  }
>  
>  static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
> @@ -286,8 +294,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
>  	val = readl(usb2_base + USB2_VBCTRL);
>  	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
>  	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> -	val = readl(usb2_base + USB2_OBINTEN);
> -	writel(val | USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
> +	rcar_gen3_control_otg_irq(ch, 1);
>  	val = readl(usb2_base + USB2_ADPCTRL);
>  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
>  	val = readl(usb2_base + USB2_LINECTRL1);
> -- 
> 1.9.1
> 
