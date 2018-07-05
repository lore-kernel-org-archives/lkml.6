Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21F924053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BPI0tBDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21F924053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeGENyG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:54:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52726 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753353AbeGENyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=T+CTeh2NpfQWmENfc31lR/VGSlcbF61Mjm4eRoQGM5Y=;
        b=BPI0tBDOC2AJ3TODLufvvIFhA/SqNqAb7hHK5bPD8Hus0OwATxONU+gSPh1+aJ3vBc8rTzzq7PRn8pvqEucuqjVZrGkqIupuOZdS3EGhDSdd6/113AQZbGTdbioRVC/LBTvClhWuTcJk0Dqy2FjSM65lqTPr40tNjxMwxrXJKOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fb4hs-0001ma-RD; Thu, 05 Jul 2018 15:54:00 +0200
Date:   Thu, 5 Jul 2018 15:54:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun: remove redundant variables adv and
 lpa
Message-ID: <20180705135400.GG23469@lunn.ch>
References: <20180705093732.21650-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705093732.21650-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:37:32AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables adv and lpa are being assigned but are never used hence they
> are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'lpa' set but not used [-Wunused-but-set-variable]
> warning: variable 'adv' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/sun/niu.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index 88c12474a0c3..2d6b62c6d9ab 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -1225,17 +1225,13 @@ static int link_status_1g_rgmii(struct niu *np, int *link_up_p)
>  
>  	bmsr = err;
>  	if (bmsr & BMSR_LSTATUS) {
> -		u16 adv, lpa;
> -
>  		err = mii_read(np, np->phy_addr, MII_ADVERTISE);
>  		if (err < 0)
>  			goto out;
> -		adv = err;
>  
>  		err = mii_read(np, np->phy_addr, MII_LPA);
>  		if (err < 0)
>  			goto out;
> -		lpa = err;
>  
>  		err = mii_read(np, np->phy_addr, MII_ESTATUS);
>  		if (err < 0)

What should really happen is something like:

                common_adv = lpa & adv;

                lp->active_speed = SPEED_10;
                lp->active_duplex = DUPLEX_HALF;

                if (common_adv_gb & (LPA_1000FULL | LPA_1000HALF)) {
                        lp->active_speed = SPEED_1000;

                        if (common_adv_gb & LPA_1000FULL)
                                lp->active_duplex = DUPLEX_FULL;
                } else if (common_adv & (LPA_100FULL | LPA_100HALF)) {
                        lp->active_speed = SPEED_100;

                        if (common_adv & LPA_100FULL)
                                lp->active_duplex = DUPLEX_FULL;
                } else
                        if (common_adv & LPA_10FULL)
                                lp->active_duplex = DUPLEX_FULL;

i.e. making use of the results of the autoneg to determine the link
speed and duplex, rather than just assuming it is 1G.

If i turn this into a real patch, does anybody have the hardware to
test it?

      Andrew
