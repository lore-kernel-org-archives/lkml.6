Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D00C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF57220685
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r2erocUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395202AbfBOPYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:24:01 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53902 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfBOPYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zleyHMTUsHgLyhB3FFf3QLLuYWFs+3Wf02MxpRd1cX4=; b=r2erocUcKFFP248L5dweVSJ9JZ
        FpWjC+twNG17LXwS46PRnw0eRjaxsCq7SU10A56x9o7Ep28uGJvs5ocNrzlvdLolnm1SCbFIZt/4h
        v/EY/staDhbSF4lZpvaIqNQjNdA+7kSFm9kmaOCeJHAAKq7BJ7Wm6OoKNXPO/a3BWTDo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gufLI-0006qy-5s; Fri, 15 Feb 2019 16:23:56 +0100
Date:   Fri, 15 Feb 2019 16:23:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC] net: dsa: qca8k: implement rgmii-id mode
Message-ID: <20190215152356.GP708@lunn.ch>
References: <0c7428dc-736e-c5c4-13e7-b42052c60cd7@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c7428dc-736e-c5c4-13e7-b42052c60cd7@ysoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:01:08PM +0100, Michal Vokáč wrote:
> Hi,
> 
> networking on my boards [1], which are currently in linux-next, suddently
> stopped working. I tracked it down to this commit 5ecdd77c61c8 ("net: dsa:
> qca8k: disable delay for RGMII mode") [2].
> 
> So I think the rgmii-id mode is obviously needed in my case.
> I was able to find a couple drivers that read tx/rx-delay or
> tx/rx-internal-delay from device tree. Namely:
> 
>   drivers/net/ethernet/apm/xgene/xgene_enet_main.c
>   drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
>   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>   drivers/net/phy/dp83867.c
> 
> I would appreciate any hints how to add similar function to qca8k driver
> if that is the correct way to go. Can I take some of the above mentioned
> drivers as a good example for that? How should the binding look like?
> 
> I would expect something like this:
> 
> 	switch@0 {
> 		compatible = "qca,qca8334";
> 		reg = <0>;
> 
> 		switch_ports: ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			ethphy0: port@0 {
> 				reg = <0>;
> 				label = "cpu";
> 				phy-mode = "rgmii-id";
> 				qca,tx-delay = <3>;
> 				qca,rx-delay = <3>;
> 				ethernet = <&fec>;
> 		};

Hi Michal

Your submission used:

+				ethphy0: port@0 {
+					reg = <0>;
+					label = "cpu";
+					phy-mode = "rgmii";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};

This is good. If you have a fixed-link you can pass a phy-mode.

The comment that was removed was:

-               /* According to the datasheet, RGMII delay is enabled through
-                * PORT5_PAD_CTRL for all ports, rather than individual port
-                * registers
-                */

Is it possible to enable delays per port? Ideally, you want to enable
delays for just selected ports. Add another case for
PHY_INTERFACE_MODE_RGMII_ID to enable the delays.

    Andrew
