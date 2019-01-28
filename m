Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A59B2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfA1O0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:26:32 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38701 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1O0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:26:32 -0500
X-Originating-IP: 77.201.116.149
Received: from bootlin.com (149.116.201.77.rev.sfr.net [77.201.116.149])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DFD811C0023;
        Mon, 28 Jan 2019 14:26:23 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:26:21 +0100
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
Message-ID: <20190128152621.2aec96c1@bootlin.com>
In-Reply-To: <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
        <20190118152352.26417-6-maxime.chevallier@bootlin.com>
        <20190120190809.GB19714@lunn.ch>
        <20190121113531.7a8b5b51@bootlin.com>
        <20190121105206.mxxxosytk5qiysc2@e5254000004ec.dyn.armlinux.org.uk>
        <20190121132945.6e6dee23@bootlin.com>
        <20190121130030.i5kkjb55gwttobvq@e5254000004ec.dyn.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Mon, 21 Jan 2019 13:00:30 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>On Mon, Jan 21, 2019 at 01:29:45PM +0100, Maxime Chevallier wrote:
>> Hello Russell,
>> 
>> On Mon, 21 Jan 2019 10:52:06 +0000
>> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:  
>> >It's entirely possible that the 3310 switches to different hardware
>> >blocks for 2.5G and 5G speeds, and reading _just_ the 1.4 register
>> >is not sufficient.  
>> 
>> I agree with you but in that particular case, I think we are reading
>> from the correct device. The datasheet itself says that we should be
>> reading 1.4 and 1.11 as we expect, with 2.5G/5G support being set (these
>> registers are read-only, and the datasheet's values aren't what we
>> actually read).  
>
>No, you missed what I was saying.
>
>The 88x3310 is a hybrid device.  It contains multiple instances of
>each individual device at different offsets in each MMD address space.

Ah I see, I indeed thought you refered to the MMDs. 

[...]

>The exception seems to be the PMA/PMD MMD which I've only discovered
>a single instance.

Yes there only seems to be one. There are some other registers in the
1.0xCxxx range, but those who are documented don't help a lot with
determing wether or not these modes are supported.

I wonder if these values are correctly reported in newer PHY firmware
revisions.

I've checked other PCS instances, but it seems the one at 3.0x0xxx is
the one used in 2.5/5GBASET.

I've tested with other PHYs from this family, it looks like they are
derivatives of the 33x0 design, with the addition/removal of internal
IPs. Since the 2110 returns the correct values and has a similar
design, with the PMA returning the correct abilities, I think we are
reading from the correct instance.

Thanks,

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
