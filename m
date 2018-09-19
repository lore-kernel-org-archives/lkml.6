Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120FCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76396214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HmR3SaQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76396214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeISPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:44:36 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46578 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeISPof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LO5F9+2AsIhu9S2QOgyzS04AwmGCS0QfpMurMfnCpRQ=; b=HmR3SaQ8SN3nS+yCFPvOVTAtp
        glXwdLCJTZDxtKDfV1c/754FT6PXyZ6rt5+IoQuTcqw9zjAz4SzPDBEhK9nkk5JEgNvtd6qUkvIpR
        0aHHGuJOBSF7XgB2ctzojmf53VgFWmGfDYGUukjAFaxTytBHQMRIYDnz5iHCfa3R/GbMA=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60815)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g2ZO5-0003XZ-Rm; Wed, 19 Sep 2018 11:07:14 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g2ZNy-0004dS-LD; Wed, 19 Sep 2018 11:07:06 +0100
Date:   Wed, 19 Sep 2018 11:07:01 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/3] net: phy: phylink: ensure the carrier is
 off when starting phylink
Message-ID: <20180919100701.GI30658@n2100.armlinux.org.uk>
References: <20180919093933.24411-1-antoine.tenart@bootlin.com>
 <20180919093933.24411-2-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919093933.24411-2-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:39:31AM +0200, Antoine Tenart wrote:
> Phylink made an assumption about the carrier state being down when
> calling phylink_start(). If this assumption isn't satisfied, the
> internal phylink state could misbehave and a net device could end up not
> being functional.
> 
> This patch fixes this by explicitly calling netif_carrier_off() in
> phylink_start().
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 3ba5cf2a8a5f..1d01e0c625a5 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -901,6 +901,9 @@ void phylink_start(struct phylink *pl)
>  		    phylink_an_mode_str(pl->link_an_mode),
>  		    phy_modes(pl->link_config.interface));
>  
> +	/* Always set the carrier off */
> +	netif_carrier_off(pl->netdev);
> +
>  	/* Apply the link configuration to the MAC when starting. This allows
>  	 * a fixed-link to start with the correct parameters, and also
>  	 * ensures that we set the appropriate advertisement for Serdes links.
> -- 
> 2.17.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
