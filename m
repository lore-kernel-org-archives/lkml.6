Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472742176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfBRKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:50:32 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52423 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfBRKuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:50:32 -0500
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F28BF4001B;
        Mon, 18 Feb 2019 10:50:27 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:50:27 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while
 reconfiguring the serdes lanes
Message-ID: <20190218105027.GC3784@kwain>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
 <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
 <20190218102630.GA3784@kwain>
 <20190218104302.bp6ccmpkt26dflyx@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218104302.bp6ccmpkt26dflyx@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Mon, Feb 18, 2019 at 10:43:02AM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 18, 2019 at 11:26:30AM +0100, Antoine Tenart wrote:
> > On Fri, Feb 15, 2019 at 05:12:24PM +0000, Russell King - ARM Linux admin wrote:
> > > On Fri, Feb 15, 2019 at 04:32:38PM +0100, Antoine Tenart wrote:
> > > > The documentation advises to set the XPCS in reset while reconfiguring
> > > > the serdes lanes. This seems to be a good thing to do, but the PPv2
> > > > driver wasn't doing it. This patch fixes it.
> > > 
> > > Hmm.  That statment seems to have some ambiguity in it - we do two
> > > "reconfigurations" - one may be upon initialisation, where the lane
> > > is already configured for 10Gbase-KR, and we're re-initialising it
> > > for the same mode.  The other case is when we're switching between
> > > 10Gbase-KR and SGMII, or as will be the case with 2.5G support for
> > > the Alaska PHYs, 2500base-X.
> > 
> > The configuration at the lane at boot time is dependent to the
> > firmware or bootloader configuration. On the mcbin, the lane may be
> > configured in 10Gbase-KR, but it could be configured in SGMII as well.
> > The configuration upon initialization and the re-configuration are quite
> > similar then, as we might change mode as well at boot time.
> > 
> > You're right in that we might be re-configuring the lane for the same
> > exact mode at boot time, if it was already configured in the same mode.
> > 
> > > Does this apply to reconfiguration of the serdes lane between
> > > 10Gbase-KR and slower modes?
> > 
> > This applies only when configuring a line in a 10G mode,
> > mvpp22_gop_init_10gkr isn't called otherwise.
> > 
> > When switching to an non-10G mode we might want to put the XPCS in reset
> > though, which is not done today with this patch.
> 
> I'm merely pointing out the discrepency between the commit message and
> what is actually being done.  I'm not particularly concerned about what
> happens at boot.
> 
> We have four different transitions a port can go through, all of which
> reconfigure the serdes lanes:
> 
> 1. 10gkr -> 10gkr
> 2. 10gkr -> non-10gkr
> 3. non-10gkr -> non-10gkr
> 4. non-10gkr -> 10gkr
> 
> With this patch, XPCS is only placed into reset during the
> reconfiguration for cases 1 and 4.  Case 3 doesn't matter (the XPCS
> should already be in reset right?)  Case 2 isn't covered, and this
> leaves a rather big hole.
> 
> It seems to me that if the documentation states that the XPCS needs to
> be placed in reset while the serdes is reconfigured, then what should
> be happening is:
> 
> - at boot, place the XPCS into reset.
> - when we configure for 10gkr, release the reset once we've finished
>   configuring the serdes.
> - when we configure away from 10gkr, place the XPCS back into reset
>   before configuring the serdes.
> 
> Merely placing the XPCS into reset while we configure the serdes for
> 10gkr doesn't seem to be "fixing" the driver to conform to your commit
> message opening statement.

That's right, we should put the XPCS in reset when booting and when
switching away from a 10G mode. I'll fix that in v2.

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
