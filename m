Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD01C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84902146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84902146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeK3Ppl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:45:41 -0500
Received: from mx.socionext.com ([202.248.49.38]:15436 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeK3Ppl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:45:41 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Nov 2018 13:37:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1AE65180B47;
        Fri, 30 Nov 2018 13:37:40 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 30 Nov 2018 13:37:40 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 9E11B4036D;
        Fri, 30 Nov 2018 13:37:39 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 79DA4120455;
        Fri, 30 Nov 2018 13:37:39 +0900 (JST)
Date:   Fri, 30 Nov 2018 13:37:39 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH net] net: phy: fix the issue that netif always links up after resuming
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d32d2d7e-2c78-425a-4016-0aebbf0828ed@gmail.com>
References: <0499fc01-fce3-26c7-8b42-64788b8bf47b@gmail.com> <d32d2d7e-2c78-425a-4016-0aebbf0828ed@gmail.com>
Message-Id: <20181130133738.813D.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner Florian,

Thank you for your comments.

On Thu, 29 Nov 2018 16:37:48 -0800 <f.fainelli@gmail.com> wrote:

> 
> 
> On 11/29/2018 2:47 PM, Heiner Kallweit wrote:
> > On 29.11.2018 09:12, Kunihiko Hayashi wrote:
> >> Even though the link is down before entering hibernation,
> >> there is an issue that the network interface always links up after resuming
> >> from hibernation.
> >>
> >> The phydev->state is PHY_READY before enabling the network interface, so
> >> the link is down. After resuming from hibernation, the phydev->state is
> >> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> >>
> >> This patch expects to solve the issue by changing phydev->state to PHY_UP
> >> only when the link is up.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>  drivers/net/phy/phy_device.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> >> index ab33d17..d5bba0f 100644
> >> --- a/drivers/net/phy/phy_device.c
> >> +++ b/drivers/net/phy/phy_device.c
> >> @@ -309,8 +309,10 @@ static int mdio_bus_phy_restore(struct device *dev)
> >>  		return ret;
> >>  
> >>  	/* The PHY needs to renegotiate. */
> >> -	phydev->link = 0;
> >> -	phydev->state = PHY_UP;
> >> +	if (phydev->link) {
> >> +		phydev->link = 0;
> >> +		phydev->state = PHY_UP;
> >> +	}
> >>  
> > Thanks for reporting. I agree that it isn't right to unconditionally set
> > PHY_UP, because we don't know whether the PHY was started before
> > hibernation. However I don't think using phydev->link as criteria is
> > right. Example would be: PHY was started before hibernation, but w/o link.
> > In this case we want to set PHY_UP to start an aneg, because a cable may
> > have been plugged in whilst system was sleeping.

Indeed. I didn't consider the case that the PHY was started but a cable was
unplugged before hibernation.

> > So I think, similar to phy_stop_machine, we should use state >= UP and
> > state != HALTED as criteria, and also phy_start_machine() would need to
> > be called only if this criteria is met.
> > 
> > It may make sense to add a helper for checking whether PHY is in a
> > started state (>=UP && !=HALTED), because we need this in more than
> > one place.
> 
> Agreed, that would make sense.

I agree, too.
I'll try this in v2 patch that changes the PHY state to PHY_UP and calls
phy_start_machine(), only when the PHY was started before hibernation.
If I understand correctly, it will be like that:

	phydev->link = 0;
	if (phy_is_started(phydev)) {
		phydev->state = PHY_UP;
		phy_start_machine(phydev);
	}

Thank you,

---
Best Regards,
Kunihiko Hayashi


