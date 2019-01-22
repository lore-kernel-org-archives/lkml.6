Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD23C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666B820844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfAVKEh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:04:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVKEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:04:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 724FB2078C; Tue, 22 Jan 2019 11:04:35 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C36B206A7;
        Tue, 22 Jan 2019 11:04:35 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:04:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
Message-ID: <20190122110435.5eaab82a@xps13>
In-Reply-To: <b804e77a-5eb5-6d18-cb79-f8176e370775@gmail.com>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
        <20190116155651.GC29244@lunn.ch>
        <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
        <20190116222329.GP29244@lunn.ch>
        <20190117104641.GD13242@t480s.localdomain>
        <20190117165052.6d1f1a58@xps13>
        <b804e77a-5eb5-6d18-cb79-f8176e370775@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> wrote on Thu, 17 Jan 2019
10:00:46 -0800:

> On 1/17/19 7:50 AM, Miquel Raynal wrote:
> > Hi Andrew, Vivien,
> > 
> > Vivien Didelot <vivien.didelot@gmail.com> wrote on Thu, 17 Jan 2019
> > 10:46:41 -0500:
> >   
> >> Hi,
> >>
> >> On Wed, 16 Jan 2019 23:23:29 +0100, Andrew Lunn <andrew@lunn.ch> wrote:  
> >>> Hi Florian
> >>>     
> >>>> A possible approach could be to call the port_disable, port_enable
> >>>> callbacks from dsa_slave_suspend() and dsa_slave_resume(), I might have
> >>>> some patches doing that already somewhere.    
> >>>
> >>> I expect it is also on Viviens TODO list, since this really could be
> >>> in the core.    
> >>
> >> Indeed that is!  
> > 
> > So, shall I wait for Vivien's patches (adding port_disable/enable()
> > in dsa_slave_suspend/resume()) and keep the driver as-is or do you want
> > me to manually call port_disable/enable() from the mv88e6xxx driver?  
> 
> Up to you guys, the only thing that I an tell you is that my platform
> loses its register contents during suspend/resume, therefore you must
> make sure the driver re-applies the entire switch configuration,
> identical to how it was prior to suspend. If you need me to test
> something, please holler.

I am not sure to understand what is lost. On my setup ethtool shows
that everything is fine after resume but maybe I fall into a "default"
working case.

When I compare with the two drivers pointed out by Andrew:
* qca8k resume callback:
	* enable ports,
	* call dsa_switch_resume().
* bcm_sf2 resume callback:
	* call dsa_switch_resume(),
	* reset the switch,
	* refresh rules (Not applicable?),
	* enable the PHYs,
	* setup the ports,
	* configure vlan (Not applicable?),
* mv88e6xxx resume callback:
	* reset the switch,
	* enable the PHYs,
	* setup the ports,
	* enable IRQs,
	* call dsa_switch_resume().

This looks pretty similar. Maybe the ports setup are set to default
values while I should save some parameters at suspend? I changed a
few parameters (like the MTU or the queue length) but they seem to be
correct across suspend cycles. Can you show a diff of what part of the
configuration is lost?

Anyway, I have little background working with switches, so I might miss
something big.


Thanks,
Miquèl
