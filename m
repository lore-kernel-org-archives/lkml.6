Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C67217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfB0Uz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:55:58 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33840 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfB0Uz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:55:57 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544482800"; 
   d="scan'208";a="371210492"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 21:55:52 +0100
Date:   Wed, 27 Feb 2019 21:55:52 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
cc:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error
 paths
In-Reply-To:   <TY2PR01MB4812FABCB851C22F4295B9D4D8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1902272154140.2561@hadrien>
References: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <alpine.DEB.2.21.1902270920300.2671@hadrien>   <TY2PR01MB4812FABCB851C22F4295B9D4D8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:

> Hello,
>
> > From: Julia Lawall, Sent: Wednesday, February 27, 2019 5:25 PM
> >
> > On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:
> >
> > > This patch fixes memory leak at error paths of the probe function.
> > > In for_each_child_of_node, if the loop returns, the driver should
> > > call of_put_node() before returns.
> > >
> > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
> > > index 72eeb06..570b4e4 100644
> > > --- a/drivers/phy/renesas/phy-rcar-gen2.c
> > > +++ b/drivers/phy/renesas/phy-rcar-gen2.c
> > > @@ -285,6 +285,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
> > >  		error = of_property_read_u32(np, "reg", &channel_num);
> > >  		if (error || channel_num > 2) {
> > >  			dev_err(dev, "Invalid \"reg\" property\n");
> > > +			of_node_put(np);
> > >  			return error;
> > >  		}
> > >  		channel->select_mask = select_mask[channel_num];
> > > @@ -300,6 +301,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
> > >  						   &rcar_gen2_phy_ops);
> > >  			if (IS_ERR(phy->phy)) {
> > >  				dev_err(dev, "Failed to create PHY\n");
> > > +				of_node_put(np);
> > >  				return PTR_ERR(phy->phy);
> > >  			}
> > >  			phy_set_drvdata(phy->phy, phy);
> >
> > Hello,
> >
> > I was concerned about the assignment channel->of_node = np;.  Because
> > channels is allocated with a devm function, it will get freed on an error
> > return, so this pointer doesn't matter.  But don't you need an of_node_get
> > on this assignment?  Does the fact that you haven't seen a problem with
> > this in testing mean that the field is actually never accessed?
>
> The channel->of_node will be used in the rcar_gen2_phy_xlate() as drv->channels[i].of_node.
> The assignment is not used for any device tree APIs, just comparing the pointer.
> So, I don't think this driver needs an of_node_get() on this assignment.
> Is my understanding incorrect?

I see that the value is only used for comparison.  Thanks for pointing
that out.  If you are sure that the pointers are the same when the
function is called as when the pointer to the possibly now freed device
node was stored in the channels structure, then everything should be ok.

julia


>
> ---
> static struct phy *rcar_gen2_phy_xlate(struct device *dev,
> 				       struct of_phandle_args *args)
> {
> 	struct rcar_gen2_phy_driver *drv;
> 	struct device_node *np = args->np;
> 	int i;
>
> 	drv = dev_get_drvdata(dev);
> 	if (!drv)
> 		return ERR_PTR(-EINVAL);
>
> 	for (i = 0; i < drv->num_channels; i++) {
> 		if (np == drv->channels[i].of_node)	// <--- here only
> 			break;
> 	}
>
> 	if (i >= drv->num_channels || args->args[0] >= 2)
> 		return ERR_PTR(-ENODEV);
>
> 	return drv->channels[i].phys[args->args[0]].phy;
> }
> ---
>
> Best regards,
> Yoshihiro Shimoda
>
> > julia
>
