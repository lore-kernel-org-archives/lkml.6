Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824EAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DC4218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfAaJbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:31:03 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:59714 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:31:03 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 86B233A919E;
        Thu, 31 Jan 2019 10:26:07 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 49D6320000F;
        Thu, 31 Jan 2019 09:26:04 +0000 (UTC)
Date:   Thu, 31 Jan 2019 10:26:03 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, andrew@lunn.ch, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
Message-ID: <20190131092603.GD9744@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-7-antoine.tenart@bootlin.com>
 <6ebf0541-0830-3df9-121f-ac560822bf1c@gmail.com>
 <20190124092349.GE3662@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124092349.GE3662@kwain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 24, 2019 at 10:23:49AM +0100, Antoine Tenart wrote:
> On Wed, Jan 23, 2019 at 12:16:08PM -0800, Florian Fainelli wrote:
> > On 1/23/19 7:56 AM, Antoine Tenart wrote:
> > > @@ -1441,6 +1445,10 @@ struct net_device_ops {
> > >  						u32 flags);
> > >  	int			(*ndo_xsk_async_xmit)(struct net_device *dev,
> > >  						      u32 queue_id);
> > > +#ifdef CONFIG_MACSEC
> > > +	int			(*ndo_macsec)(struct net_device *dev,
> > > +					      struct netdev_macsec *macsec);
> > 
> > You would really want to define an API which is more oriented towards
> > configuring/deconfiguring a MACsec association here, e.g.: similar to
> > what the IPsec offload ndos offer.
> 
> This means mostly moving from a single function using a command field to
> multiple specialized functions to add/remove each element of MACsec
> configuration.
> 
> I don't have strong opinion on the single helper vs a structure
> containing pointers to specialized ones, but out of curiosity what's the
> benefit of such a move? Future additions and maintainability?
> 
> > It is not clear to me whether after your patch series we still need to
> > create a macsec virtual device, and that gets offloaded onto its real
> > device/PHY device, or if we don't need that all?
> 
> After this series, we will still need the virtual MACsec interface. When
> using hardware offloading this interface isn't doing much, but it's the
> interface used to configure all the MACsec connexions.
> 
> This is because, and that's specific to MACsec (vs IPsec), a software
> implementation is already supported and it's using a virtual interface
> to perform all the MACsec related operations (vs hooks in the Rx/Tx
> paths). I really wanted to avoid having two interfaces and ways of
> configuring MACsec depending on if the offloading is used.
> 
> This should also allow in the future to disable at run-time the
> offloading on a given interface, and to still have MACsec working in
> software (or the opposite, with extra work). For this to work, the
> virtual interface still has to provide an Rx and a Tx functions so that
> programs can bind onto the same interface, regardless of if the
> offloading is enabled.

Do you need extra information and explanations about this? I believe
this point is very important as the design choices were influenced a lot
by reusing the s/w implementation logic and API.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
