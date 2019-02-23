Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B75C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D55A20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I+3oNNYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfBWPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:23:11 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36125 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBWPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 10:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=agxcWecpNsZNc4QFWlQWRLQid46UtUb6vNwhjzc4Y80=; b=I+3oNNYcutdbIHseBsl8EARH5b
        7fvOfDvZUXvSawv7t5gMySkGsEQGYZPfdDTt6IqsIgpVxmAcY3e9s81NWb3827M+nZgFNupQDwHiU
        l1NHG9Hqg7rXC3TikYiiYJlpkbgLYyZcoHZqDfsr9lgDeQvA1GVUw01HnKu7Hkkhdsvg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxZ8q-0003Jt-CC; Sat, 23 Feb 2019 16:23:04 +0100
Date:   Sat, 23 Feb 2019 16:23:04 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Piotr Sroka <piotrs@cadence.com>, Jan Kotas <jank@cadence.com>
Subject: Re: [PATCH 2/3] net: ethernet: add c45 PHY support in MDIO
 read/write functions.
Message-ID: <20190223152304.GD10693@lunn.ch>
References: <20190222201242.GA20889@lvlogina.cadence.com>
 <20190222214140.GO5894@lunn.ch>
 <CO2PR07MB2469D90FD13642D668F8D281C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR07MB2469D90FD13642D668F8D281C1780@CO2PR07MB2469.namprd07.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Fri, Feb 22, 2019 at 08:12:42PM +0000, Parshuram Thombare wrote:
> >> This patch modify MDIO read/write functions to support communication
> >> with C45 PHY in Cadence ethernet controller driver.
> >
> >Hi Parshuram
> >
> >Are all versions of the MDIO controller capable of doing C45?
> >
> >    Andrew
> Now driver support c22 and c45 PHY. 
> Are you suggesting to add check for C45 PHY using is_c45 in phydev ?

You are unconditionally supporting C45. Are there versions of the
hardware which don't actually support C45? You have this endless loop:

+       /* wait for end of transfer */
+       while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+               cpu_relax();

If there is hardware which does not support C45, will this loop
forever?

	Andrew
