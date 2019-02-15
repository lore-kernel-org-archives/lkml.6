Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267A021924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZdRP3vkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBOQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:23:49 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54063 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBOQXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=67+IEeFhpK0B2Sc9+tSCEUZ8B30FAu4sX2jWxP6yjGM=; b=ZdRP3vkKhooC31hEVRs25q5t1j
        JxN0LQsxdZ9drXZh11chb0+WPSFMVbnPjQxv1iOz/eTXg4M0xKiLjkxZYTqQcQb+GHMgjRG2VWj11
        L6o1wWel3eJhNVXgHo2aQkKb/xJ/IfL9yviQFzufFPOgWJcWwi3rGlbrzmC4sf1VSaMw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gugHA-0007iX-K6; Fri, 15 Feb 2019 17:23:44 +0100
Date:   Fri, 15 Feb 2019 17:23:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
Message-ID: <20190215162344.GQ708@lunn.ch>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 05:17:08PM +0100, Paul Kocialkowski wrote:
> Some PHY drivers like the generic one do not provide a read_status
> callback on their own but rely on genphy_read_status being called
> directly.
> 
> With the current code, this results in a NULL function pointer call.
> Call genphy_read_status instead when there is no specific callback.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index 74a8782313cf..bd6084e315de 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
>  	u16 val = 0;
>  	int err;
>  
> -	err = priv->phy_drv->read_status(phydev);

Hi Paul

How about using phy_read_status()?

	Andrew
