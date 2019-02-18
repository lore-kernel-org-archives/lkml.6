Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2A217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550494998;
	bh=zkKxeyDMFpsKYNcJDk8FH6f/zLqo73TgiUZJRhr/mhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fx0G0+znwJ+9okilzQbJLR+sDycOKIx9owN4IHl6qdpJCcPUJU97jgXTZZN8N8458
	 c1ALZZuU7YcBELwwP7E6OocHdateC8KtwvlUZoflEtTV3Cq2S6IY9AD8uqDtwkExVn
	 5im2fvBlqp2M6P65+YTJM0q2AIH7hw0jE0WYqCts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbfBRNDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfBRNDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:03:16 -0500
Received: from localhost (unknown [106.200.226.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2701217F5;
        Mon, 18 Feb 2019 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550494994;
        bh=zkKxeyDMFpsKYNcJDk8FH6f/zLqo73TgiUZJRhr/mhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHweP6dxobzwegXQ4bfSwW4+MAy66gVtPtyQbgrmj6DSE1AQeMmVKzYgAgIz0vKfl
         GDsvqtwqIpOezXFEq2ro1MCT+hW4MMBk7nHwMd2Kri2WcEWxGs6IquXrkTvT60nsmW
         ARklHDxZoipIn4PNib5zHacUaO4vsYPV1gr6VN+8=
Date:   Mon, 18 Feb 2019 18:33:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC] net: dsa: qca8k: implement rgmii-id mode
Message-ID: <20190218130306.GM21884@vkoul-mobl>
References: <0c7428dc-736e-c5c4-13e7-b42052c60cd7@ysoft.com>
 <20190215152356.GP708@lunn.ch>
 <20190218104539.GL21884@vkoul-mobl>
 <40d0e8b0-b16d-85ef-e647-944bc7dbd571@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40d0e8b0-b16d-85ef-e647-944bc7dbd571@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-19, 12:54, Michal Vokáč wrote:
> On 18. 02. 19 11:45, Vinod Koul wrote:
> > On 15-02-19, 16:23, Andrew Lunn wrote:
> > > On Fri, Feb 15, 2019 at 04:01:08PM +0100, Michal Vokáč wrote:
> > > > Hi,
> > > > 
> > > > networking on my boards [1], which are currently in linux-next, suddently
> > > > stopped working. I tracked it down to this commit 5ecdd77c61c8 ("net: dsa:
> > > > qca8k: disable delay for RGMII mode") [2].
> > > > 
> > > > So I think the rgmii-id mode is obviously needed in my case.
> > > > I was able to find a couple drivers that read tx/rx-delay or
> > > > tx/rx-internal-delay from device tree. Namely:
> > > > 
> > > >    drivers/net/ethernet/apm/xgene/xgene_enet_main.c
> > > >    drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > > >    drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> > > >    drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > > >    drivers/net/phy/dp83867.c
> > > > 
> > > > I would appreciate any hints how to add similar function to qca8k driver
> > > > if that is the correct way to go. Can I take some of the above mentioned
> > > > drivers as a good example for that? How should the binding look like?
> > > > 
> > > > I would expect something like this:
> > > > 
> > > > 	switch@0 {
> > > > 		compatible = "qca,qca8334";
> > > > 		reg = <0>;
> > > > 
> > > > 		switch_ports: ports {
> > > > 			#address-cells = <1>;
> > > > 			#size-cells = <0>;
> > > > 
> > > > 			ethphy0: port@0 {
> > > > 				reg = <0>;
> > > > 				label = "cpu";
> > > > 				phy-mode = "rgmii-id";
> > > > 				qca,tx-delay = <3>;
> > > > 				qca,rx-delay = <3>;
> > > > 				ethernet = <&fec>;
> > > > 		};
> > > 
> > > Hi Michal
> > > 
> > > Your submission used:
> > > 
> > > +				ethphy0: port@0 {
> > > +					reg = <0>;
> > > +					label = "cpu";
> > > +					phy-mode = "rgmii";
> > > +					ethernet = <&fec>;
> > > +
> > > +					fixed-link {
> > > +						speed = <1000>;
> > > +						full-duplex;
> > > +					};
> > > +				};
> > > 
> > > This is good. If you have a fixed-link you can pass a phy-mode.
> 
> Yes, I am using fixed-link and the plan was to implement the rgmii-id
> mode.
> 
> > > 
> > > The comment that was removed was:
> > > 
> > > -               /* According to the datasheet, RGMII delay is enabled through
> > > -                * PORT5_PAD_CTRL for all ports, rather than individual port
> > > -                * registers
> > > -                */
> > > 
> > > Is it possible to enable delays per port? Ideally, you want to enable
> > > delays for just selected ports. Add another case for
> > > PHY_INTERFACE_MODE_RGMII_ID to enable the delays.
> 
> I am still trying to collect all the relevant notes and bits from the
> horrible docs to understand how this is done. The problem is different
> parts and different versions of the documentation provide diffrerent
> details.
> 
> For example the QCA8334 model does not have PORT5 and so that registers
> are not documented. Though some application note document says:
> 
>   """
>   The MAC0 timing control is in the Port0 PAD Mode Control Register (offset 0x0004):
> 
>   1. RGMII timing delay for the output path of QCA8337(N) is enabled by 0x8[24].
>      Set 1 to add 2ns delay in 1000 mode for all RGMII interfaces.
> 
>   2. Bit [21:20]: select the delay time for the output path in 10/100 mode.
> 
>   3. Bit 25: enable the timing delay for the input path of QCA8337(N) in 1000 mode.
> 
>   4. Bit [23:22]: select the delay time for the input path in 1000 mode.
>     00: 0.2ns
>     01: 1.2ns
>     10: 2.1ns
>     11: 3.1ns
>   """
> 
> That is in line with the removed comment. The bit 24 at address 0x8 is
> used to enable/disable delays globally. And obviously it is needed on the
> QCA8334 model as well even though it should not have the PORT5.
> 
> > In the hindsight I should not have removed the comment, let me ressurect
> > that as well as add handling of the RGMII modes...
> 
> OK, thanks.

Since it used to work for you before, you need older code in RGMII_ID
mode, I have added that along with the comment

> 
> > Please do test
> 
> Sure, will do. Just let me know when you have something ready.
> Thank you!

Sending it shortly and ccing you as well

Thanks
-- 
~Vinod
