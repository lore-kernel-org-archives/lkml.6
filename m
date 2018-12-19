Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E9621871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeLSB7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:59:04 -0500
Received: from mx.socionext.com ([202.248.49.38]:13794 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeLSB7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:59:03 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Dec 2018 10:59:01 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id DB312180092;
        Wed, 19 Dec 2018 10:59:01 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 19 Dec 2018 10:59:01 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 94C3540376;
        Wed, 19 Dec 2018 10:59:01 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6E197120605;
        Wed, 19 Dec 2018 10:59:01 +0900 (JST)
Date:   Wed, 19 Dec 2018 10:59:01 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net] net: phy: Fix the issue that netif always links up after resuming
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e8312559-2b67-eb3b-3f61-0503db90fa69@gmail.com>
References: <1545119824-30380-1-git-send-email-hayashi.kunihiko@socionext.com> <e8312559-2b67-eb3b-3f61-0503db90fa69@gmail.com>
Message-Id: <20181219105900.E219.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Tue, 18 Dec 2018 19:15:39 +0100 <hkallweit1@gmail.com> wrote:

> On 18.12.2018 08:57, Kunihiko Hayashi wrote:
> > Even though the link is down before entering hibernation,
> > there is an issue that the network interface always links up after resuming
> > from hibernation.
> > 
> > If the link is still down before enabling the network interface,
> > and after resuming from hibernation, the phydev->state is forcibly set
> > to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> > 
> > In suspend sequence, only if the PHY is attached, mdio_bus_phy_suspend()
> > calls phy_stop_machine(), and mdio_bus_phy_resume() calls
> > phy_start_machine().
> > In resume sequence, it's enough to do the same as mdio_bus_phy_resume()
> > because the state has been preserved.
> > 
> > This patch fixes the issue by calling phy_start_machine() in
> > mdio_bus_phy_restore() in the same way as mdio_bus_phy_resume().
> > 
> The patch itself is fine and also that you tagged it as "net".
> What's missing is a "Fixes:" line (before the Suggested-by:).
> I think it should be:
> 
> Fixes: bc87922ff59d ("phy: Move PHY PM operations into phy_device")
> 
> This commit didn't actually introduce the issue, but moved it to today's
> place.

Thanks for pointing out.
I was concerned about that and which commit would be fixed if added.

Thank you,

> 
> > Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/net/phy/phy_device.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > This patch is based on the RFC patch discussion [1].
> > [1] https://www.spinics.net/lists/netdev/msg537326.html
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 7d5d698..3685be4 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -315,11 +315,8 @@ static int mdio_bus_phy_restore(struct device *dev)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	/* The PHY needs to renegotiate. */
> > -	phydev->link = 0;
> > -	phydev->state = PHY_UP;
> > -
> > -	phy_start_machine(phydev);
> > +	if (phydev->attached_dev && phydev->adjust_link)
> > +		phy_start_machine(phydev);
> >  
> >  	return 0;
> >  }
> > 

---
Best Regards,
Kunihiko Hayashi


