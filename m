Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F5E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfBTKy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:54:28 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50755 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:54:28 -0500
X-Originating-IP: 90.88.23.190
Received: from bootlin.com (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2F59B4001E;
        Wed, 20 Feb 2019 10:54:22 +0000 (UTC)
Date:   Wed, 20 Feb 2019 11:54:21 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Message-ID: <20190220115421.588aa5d9@bootlin.com>
In-Reply-To: <20190207234824.dhynfaglfxllxhei@shell.armlinux.org.uk>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
        <20190207094939.27369-8-maxime.chevallier@bootlin.com>
        <20190207234824.dhynfaglfxllxhei@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Thu, 7 Feb 2019 23:48:24 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Thu, Feb 07, 2019 at 10:49:36AM +0100, Maxime Chevallier wrote:
>> The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
>> as defined in the 802.3bz specification.
>> 
>> When the link partner requests a 2.5GBASET link, the PHY will
>> reconfigure it's MII interface to 2500BASEX.
>> 
>> At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
>> mode isn't supported by any MAC for now.
>> 
>> This was tested with :
>>  - The 88X3310, which is on the MacchiatoBin  
>
>Hi Maxime,
>
>Looking deeper at this, I think we actually need an additional patch at
>the beginning of your series.
>
>The default AN advertisement in 7.32 is 0x1181 - which includes the
>2.5G and 5G modes.  We need to clear these bits, so that when the 10G
>mode disabled via ethtool, we do not switch to 2.5G or 5G speed (both
>of which are not currently reported as supported.)  Such a patch needs
>backporting to stable kernels.

Good catch. The issue seems fixed by Andrew's patch :
3de97f3c6308 ("net: phy: marvell10g: use genphy_c45_an_config_aneg")

However, the fix should indeed be backported to the -stable trees, I've
been able to repdocude this on 4.20. I'll take care of sending a patch
to -net for that.

Thanks for reporting this,

Maxime

