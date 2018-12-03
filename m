Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C920CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BC20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5BC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbeLCEfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:35:18 -0500
Received: from mx.socionext.com ([202.248.49.38]:45835 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLCEfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:35:18 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Dec 2018 13:35:14 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 504E918005E;
        Mon,  3 Dec 2018 13:35:14 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 3 Dec 2018 13:35:14 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B365D40304;
        Mon,  3 Dec 2018 13:35:13 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 904C0120455;
        Mon,  3 Dec 2018 13:35:13 +0900 (JST)
Date:   Mon, 03 Dec 2018 13:35:13 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH net v2] net: phy: Fix the issue that netif always links up after resuming
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <47b5606c-564c-2fe8-0683-65288dafe028@gmail.com>
References: <26e04d2e-16e5-ac0b-daab-931b8f5a0103@gmail.com> <47b5606c-564c-2fe8-0683-65288dafe028@gmail.com>
Message-Id: <20181203133512.57D3.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian Heiner,

On Fri, 30 Nov 2018 19:47:37 +0100 <hkallweit1@gmail.com> wrote:

> On 30.11.2018 18:46, Florian Fainelli wrote:
> > 
> > 
> > On 11/30/2018 1:25 AM, Kunihiko Hayashi wrote:
> >> Even though the link is down before entering hibernation,
> >> there is an issue that the network interface always links up after resuming
> >> from hibernation.
> >>
> >> The phydev->state is PHY_READY before enabling the network interface, so
> >> the link is down. After resuming from hibernation, the phydev->state is
> >> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> >>
> >> This patch adds a new convenient function to check whether the PHY is in
> >> a started state, and expects to solve the issue by changing phydev->state
> >> to PHY_UP and calling phy_start_machine() only when the PHY is started.
> >>
> >> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>  drivers/net/phy/phy.c        |  2 +-
> >>  drivers/net/phy/phy_device.c |  9 +++++----
> >>  include/linux/phy.h          | 10 ++++++++++
> >>  3 files changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> >> index 1d73ac3..f484d03 100644
> >> --- a/drivers/net/phy/phy.c
> >> +++ b/drivers/net/phy/phy.c
> >> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
> >>  	cancel_delayed_work_sync(&phydev->state_queue);
> >>  
> >>  	mutex_lock(&phydev->lock);
> >> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
> >> +	if (phy_is_started(phydev))
> >>  		phydev->state = PHY_UP;
> >>  	mutex_unlock(&phydev->lock);
> >>  }
> >> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> >> index ab33d17..2c39717 100644
> >> --- a/drivers/net/phy/phy_device.c
> >> +++ b/drivers/net/phy/phy_device.c
> >> @@ -309,10 +309,11 @@ static int mdio_bus_phy_restore(struct device *dev)
> >>  		return ret;
> >>  
> >>  	/* The PHY needs to renegotiate. */
> >> -	phydev->link = 0;
> >> -	phydev->state = PHY_UP;
> >> -
> >> -	phy_start_machine(phydev);
> >> +	if (phy_is_started(phydev)) {
> >> +		phydev->link = 0;
> >> +		phydev->state = PHY_UP;
> >> +		phy_start_machine(phydev);
> >> +	}
> > 
> > Don't you need some of these steps to be performed under phydev->lock
> > being held? See comment below.
> > 
> Yes, locking should be done. The old code sets phydev->state
> w/o holding the lock, I'd says this was wrong.

Indeed. The phydev->state should be set with locking the mutex even here.

And it seems that setting phydev->link and calling phy_start_machine() don't
need to hold the lock. Is it correct?

> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/include/linux/phy.h b/include/linux/phy.h
> >> index 3ea87f7..c194b45 100644
> >> --- a/include/linux/phy.h
> >> +++ b/include/linux/phy.h
> >> @@ -898,6 +898,16 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
> >>  }
> >>  
> >>  /**
> >> + * phy_is_started - Convenience function for testing whether a PHY is in
> >> + * a started state
> >> + * @phydev: the phy_device struct
> >> + */
> >> +static inline bool phy_is_started(struct phy_device *phydev)
> >> +{
> > 
> > An assert with the phydev->lock mutex being held here would greatly
> > help, because otherwise this is possibly racy.
> > 
> Have a look at __phy_resume() to see what is meant with this comment.

I see. I found that there was a lock detection in this function.
The phy_is_started() should have the same detection, shouldn't it?

Thank you,

> >> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
> >> +}
> >> +
> >> +/**
> >>   * phy_write_mmd - Convenience function for writing a register
> >>   * on an MMD on a given PHY.
> >>   * @phydev: The phy_device struct
> >>
> > 

---
Best Regards,
Kunihiko Hayashi


