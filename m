Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE71C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A692085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfAUM36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:29:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51578 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbfAUM36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:29:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 485FF20898; Mon, 21 Jan 2019 13:29:55 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id D2F2B2077B;
        Mon, 21 Jan 2019 13:29:44 +0100 (CET)
Date:   Mon, 21 Jan 2019 13:29:45 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121132945.6e6dee23@bootlin.com>
In-Reply-To: <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
        <20190118152352.26417-6-maxime.chevallier@bootlin.com>
        <20190120190809.GB19714@lunn.ch>
        <20190121113531.7a8b5b51@bootlin.com>
        <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Mon, 21 Jan 2019 10:52:06 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Mon, Jan 21, 2019 at 11:35:31AM +0100, Maxime Chevallier wrote:
>> Hello Andrew,
>> 
>> On Sun, 20 Jan 2019 20:08:09 +0100
>> Andrew Lunn <andrew@lunn.ch> wrote:
>>   
>> >On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:  
>> >> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
>> >> whether or not we should read register (1.21) "2.52/5G PMA Extended
>> >> Abilities", which contains information on the support of 2.5GBASET and
>> >> 5GBASET.
>> >> 
>> >> After testing on several variants of PHYS of this family, it appears
>> >> that bit 14 in (1.11) isn't always set when it should be.
>> >> 
>> >> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
>> >> but don't have 1.11.14 set. Their register 1.21 is filled with the
>> >> correct values, indicating 2.5G and 5G support.
>> >> 
>> >> PHYs 88X2110 do have their 1.11.14 bit set, as it should.    
>> >
>> >Hi Maxime
>> >
>> >Is there anything about this in any Errata?  
>> 
>> I haven't seen any Errata on that unfortunately.
>> 
>> I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
>> 2.5G and 5G speeds are also reported as not being supported on the
>> 88X3310.  
>
>It's entirely possible that the 3310 switches to different hardware
>blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
>is not sufficient.

I agree with you but in that particular case, I think we are reading
from the correct device. The datasheet itself says that we should be
reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
registers are read-only, and the datasheet's values aren't what we
actually read).

>The 88x3310 is multiple PHY devices in one package, with a CPU that
>manages the routing between each individual device.

I also just checked register 3.4 "PCS Speed Ability", and 3.8 "PCS
Status 2" which also contains informations on 2.5G/5G abilities, but
there's the same issue here.

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
