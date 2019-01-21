Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21341C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BC520663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfAUKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:35:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46396 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfAUKfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:35:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8CA62209EF; Mon, 21 Jan 2019 11:35:41 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C312207B2;
        Mon, 21 Jan 2019 11:35:31 +0100 (CET)
Date:   Mon, 21 Jan 2019 11:35:31 +0100
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
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190121113531.7a8b5b51@bootlin.com>
In-Reply-To: <20190120190809.GB19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
        <20190118152352.26417-6-maxime.chevallier@bootlin.com>
        <20190120190809.GB19714@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Sun, 20 Jan 2019 20:08:09 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
>> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
>> whether or not we should read register (1.21) "2.52/5G PMA Extended
>> Abilities", which contains information on the support of 2.5GBASET and
>> 5GBASET.
>> 
>> After testing on several variants of PHYS of this family, it appears
>> that bit 14 in (1.11) isn't always set when it should be.
>> 
>> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
>> but don't have 1.11.14 set. Their register 1.21 is filled with the
>> correct values, indicating 2.5G and 5G support.
>> 
>> PHYs 88X2110 do have their 1.11.14 bit set, as it should.  
>
>Hi Maxime
>
>Is there anything about this in any Errata?

I haven't seen any Errata on that unfortunately.

I also thought about reading (1.4) "PMA/PMD Speed Ability", but the
2.5G and 5G speeds are also reported as not being supported on the
88X3310.

>We potentially have an issue if Marvell have any PHYs in this family
>which don't support 2.5G/5G. Maybe this workaround needs to check the
>IDs and only enable it on device we know are broken.

I agree with you, this might be a better way to handle that issue. For
now, I've only seen that issue on the 3310 and 2010, with PHY IDs
respectively 002b09aa and 002b09ab.

I 'll add a test for ids '002b09aX', hopefully there won't be any PHYs
with these IDs that don't support 2.5/5G.

In that case, there's no need for a separate mv2110_config_init in
patch 7.

Thanks,

Maxime.

>    Andrew



-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
