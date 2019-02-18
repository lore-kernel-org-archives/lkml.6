Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550486752;
	bh=GFZVWA3DUAPaviHEMyhsZNaqoPwYPRa4vK8mDF19qPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LGOeYeg6bbMxHMLrwIfgfTN2blHTG8WOkxfX+kMSadYh56sb5IckECpet8kAn8jku
	 Kv+5t5p6zDqm1pCGQuVFFWItw+uXjt4eeUwc1PM27uNm27OTO1Ir4AlrvRtz1BQRpi
	 6/OJPWawbXUB5L+bA1f/SFHLYrGf7abQPh1ShcmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfBRKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbfBRKps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:45:48 -0500
Received: from localhost (unknown [106.200.226.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA912147A;
        Mon, 18 Feb 2019 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550486748;
        bh=GFZVWA3DUAPaviHEMyhsZNaqoPwYPRa4vK8mDF19qPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIoLm4bBWbpwl98mlyU+HV8t1ZxqCG+2/6h1Ue2028EOJNUu0B9Wu5ox841rvXxpp
         A4emtnTvJXVz/AC/Lu7tgufLZWYpbF2vOF5XOFwVIR9G+JAmfbKo5a5BQDxEUjiVmi
         aNYPReDdYgEbVqbzqJmcjb/j6J59t89OcmDClFRQ=
Date:   Mon, 18 Feb 2019 16:15:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC] net: dsa: qca8k: implement rgmii-id mode
Message-ID: <20190218104539.GL21884@vkoul-mobl>
References: <0c7428dc-736e-c5c4-13e7-b42052c60cd7@ysoft.com>
 <20190215152356.GP708@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190215152356.GP708@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-19, 16:23, Andrew Lunn wrote:
> On Fri, Feb 15, 2019 at 04:01:08PM +0100, Michal Vokáč wrote:
> > Hi,
> > 
> > networking on my boards [1], which are currently in linux-next, suddently
> > stopped working. I tracked it down to this commit 5ecdd77c61c8 ("net: dsa:
> > qca8k: disable delay for RGMII mode") [2].
> > 
> > So I think the rgmii-id mode is obviously needed in my case.
> > I was able to find a couple drivers that read tx/rx-delay or
> > tx/rx-internal-delay from device tree. Namely:
> > 
> >   drivers/net/ethernet/apm/xgene/xgene_enet_main.c
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> >   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >   drivers/net/phy/dp83867.c
> > 
> > I would appreciate any hints how to add similar function to qca8k driver
> > if that is the correct way to go. Can I take some of the above mentioned
> > drivers as a good example for that? How should the binding look like?
> > 
> > I would expect something like this:
> > 
> > 	switch@0 {
> > 		compatible = "qca,qca8334";
> > 		reg = <0>;
> > 
> > 		switch_ports: ports {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 
> > 			ethphy0: port@0 {
> > 				reg = <0>;
> > 				label = "cpu";
> > 				phy-mode = "rgmii-id";
> > 				qca,tx-delay = <3>;
> > 				qca,rx-delay = <3>;
> > 				ethernet = <&fec>;
> > 		};
> 
> Hi Michal
> 
> Your submission used:
> 
> +				ethphy0: port@0 {
> +					reg = <0>;
> +					label = "cpu";
> +					phy-mode = "rgmii";
> +					ethernet = <&fec>;
> +
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +					};
> +				};
> 
> This is good. If you have a fixed-link you can pass a phy-mode.
> 
> The comment that was removed was:
> 
> -               /* According to the datasheet, RGMII delay is enabled through
> -                * PORT5_PAD_CTRL for all ports, rather than individual port
> -                * registers
> -                */
> 
> Is it possible to enable delays per port? Ideally, you want to enable
> delays for just selected ports. Add another case for
> PHY_INTERFACE_MODE_RGMII_ID to enable the delays.

In the hindsight I should not have removed the comment, let me ressurect
that as well as add handling of the RGMII modes...

Please do test

Thanks
-- 
~Vinod
