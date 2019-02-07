Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF5FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FF42190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBGOtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:49:16 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40707 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:49:15 -0500
X-Originating-IP: 90.88.22.177
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6EB971BF20A;
        Thu,  7 Feb 2019 14:49:11 +0000 (UTC)
Date:   Thu, 7 Feb 2019 15:49:10 +0100
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
Subject: Re: [PATCH net-next v2 04/10] net: phy: Automatically fill the
 generic TP, FIBRE and Backplane modes
Message-ID: <20190207154910.697a8761@bootlin.com>
In-Reply-To: <20190207140939.GI32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
        <20190207094939.27369-5-maxime.chevallier@bootlin.com>
        <20190207140939.GI32483@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Thu, 7 Feb 2019 15:09:39 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Thu, Feb 07, 2019 at 10:49:33AM +0100, Maxime Chevallier wrote:
>> PHY advertised and supported linkmodes contain both specific modes such
>> as 1000BASET Half/Full and generic ones such as TP that represent a
>> class of modes.
>> 
>> Since some modes such as Fibre, TP or Backplane match a wide range of
>> specific modes, we can automatically set these bits if one of the
>> specific modes it corresponds to is present in the list.
>> 
>> The 'TP' bit is set whenever there's a BaseT linkmode in
>> phydev->supported.
>> 
>> The 'FIBRE' bit is set for BaseL, BaseS and BaseE linkmodes.
>> 
>> Finally, the 'Backplane' is set whenever a BaseK mode is supported.  
>
>Hi Maxime
>
>Interesting idea.
>
>But what exactly are we supposed to be representing here?  That PHY
>can do these modes, or that the port exists on the device? The
>marvell10g can do fibre, but do all boards have an SFP/SFF, or do some
>only have an RJ-45 for TP? Are there boards without TP and just
>SFP/SFF?

My understanding is that this would represent what the PHY is capable
of, at least when set in the supported field, but I agree that this
doesn't reflect what's on the device.

I extrapolated this logic from the ability detection in marvell10g,
that would set these bits according to the abilities reported by the
PHY. This was done based on the PHY register values, instead of the
linkmodes in the 'supported' field.

>Is there documentation in ethtool which gives a clue as to what is
>expected?

Not really, at least to my knowledge. I think this would be used by
"ethtool -s ethX port tp|fibre|aui|etc". Maybe this could be useful if
we decide to implement port selection with ethtool on the MCBin, but I'm
getting a bit ahead of myself.

Thanks,

Maxime
