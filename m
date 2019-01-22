Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070BAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfAVKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:09:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfAVKJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:09:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 79ECB2078C; Tue, 22 Jan 2019 11:09:02 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F50A206A7;
        Tue, 22 Jan 2019 11:08:52 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:08:51 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 4/7] net: phy: marvell10g: Add support for
 2.5GBASET and 5GBASET
Message-ID: <20190122110851.35c316d1@bootlin.com>
In-Reply-To: <20190121201715.GA20277@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
        <20190118152352.26417-5-maxime.chevallier@bootlin.com>
        <20190121201715.GA20277@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, Russell,

On Mon, 21 Jan 2019 21:17:15 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> @@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	linkmode_and(phydev->advertising, phydev->advertising,
>> -		     phydev->supported);
>> +	/* Make sure we advertise all the supported modes, and not just the
>> +	 * default one specified in the driver's .features.
>> +	 */
>> +	linkmode_copy(phydev->advertising, phydev->supported);  
>
>So by doing a copy of supported into advertising, you can stomping
>over any restrictions applied via of_set_phy_supported(),
>of_set_phy_eee_broken(phydev), and any pause control settings which
>might of happened.

Thanks for the explanations, this is indeed clearly not a good solution.

>What might make sense here is that a PHY driver can replace its
>.features member at run time, in its config_init() call. The core then
>needs to perform these evaluations. So i'm guessing we need to split
>this code out of probe() and move it into phy_init_hw()?

So the .features won't be read-only anymore ? We could also simply make
a helper that would add a mode to both the supported and advertising
modes list, that would be used in the 'genphy_c45_pma_read_abilities'
and config_init ?

I lack the big picture of the PHY init sequence, there seems to be a
lot of quirks and complex cases that we need to take into account, so
I'll let you decide :)

>Heiner, you know this code better than anybody. What do you think?
>
>	Andrew

Thanks for the feedback,

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
