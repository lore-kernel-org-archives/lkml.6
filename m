Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46865C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065F2217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 06:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeLRG6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:58:43 -0500
Received: from mx.socionext.com ([202.248.49.38]:3648 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeLRG6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 01:58:42 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Dec 2018 15:58:40 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9DDCD60085;
        Tue, 18 Dec 2018 15:58:40 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 18 Dec 2018 15:58:40 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 374394087F;
        Tue, 18 Dec 2018 15:58:40 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 14771120605;
        Tue, 18 Dec 2018 15:58:40 +0900 (JST)
Date:   Tue, 18 Dec 2018 15:58:39 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH net v3] net: phy: Fix the issue that netif always links up after resuming
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <fcfb1597-e8f4-27c6-ae8c-646fd43c846d@gmail.com>
References: <20181218152507.F2C6.4A936039@socionext.com> <fcfb1597-e8f4-27c6-ae8c-646fd43c846d@gmail.com>
Message-Id: <20181218155839.F2CA.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Tue, 18 Dec 2018 07:44:33 +0100 <hkallweit1@gmail.com> wrote:

> On 18.12.2018 07:25, Kunihiko Hayashi wrote:
> > Hi Heiner,
> > 
> > On Mon, 17 Dec 2018 19:43:31 +0100 <hkallweit1@gmail.com> wrote:
> > 
> >> On 17.12.2018 19:41, Heiner Kallweit wrote:
> >>> On 17.12.2018 07:41, Kunihiko Hayashi wrote:
> >>>> Hi,
> >>>>
> >>>> Gentle ping...
> >>>> Are there any comments about changes since v2?
> >>>>
> >>>> v2: https://www.spinics.net/lists/netdev/msg536926.html
> >>>>
> >>>> Thank you,
> >>>>
> >>>> On Mon, 3 Dec 2018 17:22:29 +0900 <hayashi.kunihiko@socionext.com> wrote:
> >>>>
> >>>>> Even though the link is down before entering hibernation,
> >>>>> there is an issue that the network interface always links up after resuming
> >>>>> from hibernation.
> >>>>>
> >>>>> The phydev->state is PHY_READY before enabling the network interface, so
> >>>>> the link is down. After resuming from hibernation, the phydev->state is
> >>>>> forcibly set to PHY_UP in mdio_bus_phy_restore(), and the link becomes up.
> >>>>>
> >>>>> This patch adds a new convenient function to check whether the PHY is in
> >>>>> a started state, and expects to solve the issue by changing phydev->state
> >>>>> to PHY_UP and calling phy_start_machine() only when the PHY is started.
> >>>>>
> >>> This convenience function and the related change to phy_stop() are part of
> >>> the following already and don't need to be part of your patch.
> >>> https://patchwork.ozlabs.org/patch/1014171/
> > 
> > I see. I'll follow your patch when necessary.
> > 
> >>>>> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>>> ---
> >>>>>
> >>>>> Changes since v2:
> >>>>>  - add mutex lock/unlock for changing phydev->state
> >>>>>  - check whether the mutex is locked in phy_is_started()
> >>>>>  
> >>>>> Changes since v1:
> >>>>>  - introduce a new helper function phy_is_started() and use it instead of
> >>>>>    checking link status
> >>>>>  - replace checking phydev->state with phy_is_started() in
> >>>>>    phy_stop_machine()
> >>>>>
> >>>>> drivers/net/phy/phy.c        |  2 +-
> >>>>>  drivers/net/phy/phy_device.c | 12 +++++++++---
> >>>>>  include/linux/phy.h          | 13 +++++++++++++
> >>>>>  3 files changed, 23 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> >>>>> index 1d73ac3..f484d03 100644
> >>>>> --- a/drivers/net/phy/phy.c
> >>>>> +++ b/drivers/net/phy/phy.c
> >>>>> @@ -670,7 +670,7 @@ void phy_stop_machine(struct phy_device *phydev)
> >>>>>  	cancel_delayed_work_sync(&phydev->state_queue);
> >>>>>  
> >>>>>  	mutex_lock(&phydev->lock);
> >>>>> -	if (phydev->state > PHY_UP && phydev->state != PHY_HALTED)
> >>>>> +	if (phy_is_started(phydev))
> >>>>>  		phydev->state = PHY_UP;
> >>>
> >>> I'm wondering whether we need to do this. If the PHY is attached,
> >>> then mdio_bus_phy_suspend() calls phy_stop_machine() which does
> >>> exactly the same. If the PHY is not attached, then we don't have
> >>> to do anything. Therefore I think we just have to do the same as
> >>> in mdio_bus_phy_resume():
> >>>
> >>> if (phydev->attached_dev && phydev->adjust_link)
> >>> 	phy_start_machine(phydev);
> > 
> > Agreed.
> > 
> > Although the original code changed phydev->state,
> > it seems that it's only enough to
> > - call phy_stop_machine() in mdio_bus_phy_suspend()
> > - call phy_start_machine() in mdio_bus_phy_resume() and mdio_bus_phy_restore()
> > if the PHY is attached.
> > 
> >>> Can you test this?
> > 
> > I tested your code instead of applying my entire patch, and I confirmed
> > that the code solved the issue in my environment.
> > 
> > Do you make new patch instead of my patch?
> > (and I can add Reported-by: for the issue and Tested-by:)
> > 
> Up to you. It's fine with me if you submit the patch, but I can also do it
> and mention you in Reported-by and Tested-by. Just let me know.

I see. I'll make and submit the patch as a fix for the issue.

Thank you,

> 
> > Thank you,
> > 
> > 
> >>>
> >> Sorry for the confusion, this comment is related to the next part
> >> of your patch.
> >>
> >>>>>  	mutex_unlock(&phydev->lock);
> >>>>>  }
> >>>>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> >>>>> index ab33d17..4897d24 100644
> >>>>> --- a/drivers/net/phy/phy_device.c
> >>>>> +++ b/drivers/net/phy/phy_device.c
> >>>>> @@ -309,10 +309,16 @@ static int mdio_bus_phy_restore(struct device *dev)
> >>>>>  		return ret;
> >>>>>  
> >>>>>  	/* The PHY needs to renegotiate. */
> >>>>> -	phydev->link = 0;
> >>>>> -	phydev->state = PHY_UP;
> >>>>> +	mutex_lock(&phydev->lock);
> >>>>> +	if (phy_is_started(phydev)) {
> >>>>> +		phydev->state = PHY_UP;
> >>>>> +		mutex_unlock(&phydev->lock);
> >>>>> +		phydev->link = 0;
> >>>>> +		phy_start_machine(phydev);
> >>>>> +	} else {
> >>>>> +		mutex_unlock(&phydev->lock);
> >>>>> +	}
> >>>>>  
> >>>>> -	phy_start_machine(phydev);
> >>>>>  
> >>>>>  	return 0;
> >>>>>  }
> >>>>> diff --git a/include/linux/phy.h b/include/linux/phy.h
> >>>>> index 3ea87f7..dd21537 100644
> >>>>> --- a/include/linux/phy.h
> >>>>> +++ b/include/linux/phy.h
> >>>>> @@ -898,6 +898,19 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
> >>>>>  }
> >>>>>  
> >>>>>  /**
> >>>>> + * phy_is_started - Convenience function for testing whether a PHY is in
> >>>>> + * a started state
> >>>>> + * @phydev: the phy_device struct
> >>>>> + *
> >>>>> + * The caller must have taken the phy_device mutex lock.
> >>>>> + */
> >>>>> +static inline bool phy_is_started(struct phy_device *phydev)
> >>>>> +{
> >>>>> +	WARN_ON(!mutex_is_locked(&phydev->lock));
> >>>>> +	return phydev->state >= PHY_UP && phydev->state != PHY_HALTED;
> >>>>> +}
> >>>>> +
> >>>>> +/**
> >>>>>   * phy_write_mmd - Convenience function for writing a register
> >>>>>   * on an MMD on a given PHY.
> >>>>>   * @phydev: The phy_device struct
> >>>>> -- 
> >>>>> 2.7.4
> >>>>
> >>>> ---
> >>>> Best Regards,
> >>>> Kunihiko Hayashi
> >>>>
> >>>>
> >>>>
> >>>
> > 
> > ---
> > Best Regards,
> > Kunihiko Hayashi
> > 
> > 
> > 

---
Best Regards,
Kunihiko Hayashi


