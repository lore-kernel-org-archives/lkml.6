Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E1C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527B320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527B320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKIXpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:44 -0500
Received: from hermes.aosc.io ([199.195.250.187]:42205 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbeKIXpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:43 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7D83A15D7A2;
        Fri,  9 Nov 2018 14:04:54 +0000 (UTC)
Message-ID: <95bd076d865d046b6ba6a929eb7a5ade50c05417.camel@aosc.io>
Subject: Re: [PATCH v4 03/10] phy: sun4i-usb: add support for H6 USB2 PHY
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 09 Nov 2018 22:04:47 +0800
In-Reply-To: <bf2ec3ca-b823-4861-2d40-04227db61e49@ti.com>
References: <20181004122855.22981-1-icenowy@aosc.io>
         <20181004122855.22981-4-icenowy@aosc.io>
         <9cca3453d646f38793df411c4471d062769b4f72.camel@aosc.io>
         <bf2ec3ca-b823-4861-2d40-04227db61e49@ti.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-11-02五的 14:13 +0530，Kishon Vijay Abraham I写道：
> 
> On 02/11/18 2:11 PM, Icenowy Zheng wrote:
> > 在 2018-10-04四的 20:28 +0800，Icenowy Zheng写道：
> > > The USB 2.0 PHY on Allwinner H6 SoC is similar to older Allwinner
> > > SoCs,
> > > with some USB0 quirk like A83T and PHY index 1/2 missing.
> > > 
> > > Add support for it.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > 
> > Excuse me.
> > 
> > Kishon, could you check PATCH 1~3 and queue them?
> > 
> > Even if USB3 support is pending, USB2 support will still be useful,
> > and
> > they're independent.
> 
> I'll queue once -rc1 is tagged.

Ping.

4.20-rc1 is out now.

> 
> Thanks
> Kishon
> 
> > > ---
> > > No changes in v4.
> > > 
> > > Changes in v3:
> > > - Added Chen-Yu's Review tag.
> > > 
> > >  drivers/phy/allwinner/phy-sun4i-usb.c | 19 +++++++++++++++++--
> > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > b/drivers/phy/allwinner/phy-sun4i-usb.c
> > > index 881078ff73f6..ae16854a770a 100644
> > > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > > @@ -115,6 +115,7 @@ enum sun4i_usb_phy_type {
> > >  	sun8i_r40_phy,
> > >  	sun8i_v3s_phy,
> > >  	sun50i_a64_phy,
> > > +	sun50i_h6_phy,
> > >  };
> > >  
> > >  struct sun4i_usb_phy_cfg {
> > > @@ -295,7 +296,8 @@ static int sun4i_usb_phy_init(struct phy
> > > *_phy)
> > >  		return ret;
> > >  	}
> > >  
> > > -	if (data->cfg->type == sun8i_a83t_phy) {
> > > +	if (data->cfg->type == sun8i_a83t_phy ||
> > > +	    data->cfg->type == sun50i_h6_phy) {
> > >  		if (phy->index == 0) {
> > >  			val = readl(data->base + data->cfg-
> > > > phyctl_offset);
> > >  			val |= PHY_CTL_VBUSVLDEXT;
> > > @@ -344,7 +346,8 @@ static int sun4i_usb_phy_exit(struct phy
> > > *_phy)
> > >  	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> > >  
> > >  	if (phy->index == 0) {
> > > -		if (data->cfg->type == sun8i_a83t_phy) {
> > > +		if (data->cfg->type == sun8i_a83t_phy ||
> > > +		    data->cfg->type == sun50i_h6_phy) {
> > >  			void __iomem *phyctl = data->base +
> > >  				data->cfg->phyctl_offset;
> > >  
> > > @@ -959,6 +962,17 @@ static const struct sun4i_usb_phy_cfg
> > > sun50i_a64_cfg = {
> > >  	.phy0_dual_route = true,
> > >  };
> > >  
> > > +static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
> > > +	.num_phys = 4,
> > > +	.type = sun50i_h6_phy,
> > > +	.disc_thresh = 3,
> > > +	.phyctl_offset = REG_PHYCTL_A33,
> > > +	.dedicated_clocks = true,
> > > +	.enable_pmu_unk1 = true,
> > > +	.phy0_dual_route = true,
> > > +	.missing_phys = BIT(1) | BIT(2),
> > > +};
> > > +
> > >  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> > >  	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data =
> > > &sun4i_a10_cfg },
> > >  	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data =
> > > &sun5i_a13_cfg },
> > > @@ -972,6 +986,7 @@ static const struct of_device_id
> > > sun4i_usb_phy_of_match[] = {
> > >  	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data =
> > > &sun8i_v3s_cfg },
> > >  	{ .compatible = "allwinner,sun50i-a64-usb-phy",
> > >  	  .data = &sun50i_a64_cfg},
> > > +	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data =
> > > &sun50i_h6_cfg },
> > >  	{ },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

