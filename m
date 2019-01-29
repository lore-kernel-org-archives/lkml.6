Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22520989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y0x0B7fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfA2OwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:52:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59327 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2OwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9DB3ZDb/nJp8Hcwu9bGPl0wkx9GvtWbJvb2euo1hYdQ=; b=Y0x0B7fnxz75xC2BXY84s35s9c
        QyIn33HffiUMZT7dKsj/aZ6kDUBJRhfsqpgSGoWN3wHBcDPMLiKXTrcmMgx3tu54OzmfUQAWZkMqY
        ebAbAXXH4Wq7Hbw8fk739dgit2GdpIZ3o54scKG2r8ACPjjDORIjHW8OnTxNYw6hZpbU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1goUk1-0001OW-FN; Tue, 29 Jan 2019 15:51:57 +0100
Date:   Tue, 29 Jan 2019 15:51:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190129145157.GK4765@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
 <20190128152456.212ae5ac@xps13>
 <20190128144417.GG4765@lunn.ch>
 <20190128165749.6abf2dc4@xps13>
 <20190128174246.GD28759@lunn.ch>
 <20190129100117.5ef6774c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129100117.5ef6774c@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:01:17AM +0100, Miquel Raynal wrote:
> Hi Andrew,
> 
> Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 18:42:46 +0100:
> 
> > On Mon, Jan 28, 2019 at 04:57:49PM +0100, Miquel Raynal wrote:
> > > Hi Andrew,
> > > 
> > > Thanks for helping!
> > > 
> > > Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 15:44:17 +0100:
> > >   
> > > > > I don't see where VLAN and bridge information are cached, can you point
> > > > > me to the relevant locations?    
> > > > 
> > > > Miquèl
> > > > 
> > > > The bridge should have all that information. You need to ask it to
> > > > enumerate the current configuration and replay it to the switch.
> > > > 
> > > > There might be something in the Mellanox driver you can copy? But i've
> > > > not looked, i'm just guessing.  
> > > 
> > > I am still searching but so far I did not find a mechanism reading the
> > > configuration of the bridge out of a 'net' object. Indeed there are
> > > multiple lists with the configuration but they are all 'mellanox'
> > > objects, they do not belong to the core.  
> > 
> > Hi Miquèl
> > 
> > Look at how iproute2 works. How does the bridge command enumerate the
> > fdb and mdb's? How does bridge vlan show work? bridge link show? See
> > if you can use this infrastructure within the kernel.
> 
> Thanks!
> 
> > 
> > > > We also need to think about how we are going to test this. There is a
> > > > lot of state information in a switch. So we are going to need some
> > > > pretty good tests to show we have recreated all of it.  
> > > 
> > > My understanding of all this is rather short, until know I used what
> > > you proposed in the v1 of this series but I am all ears if I need to
> > > add anything to my test list.  
> > 
> > What you probably need is a generic DSA test suite, with a number of
> > hardware devices, with different generations of mv88e6xxx devices, and
> > ideally different sf2, kzs, etc switches. Setup a configuration and
> > test is works correctly. Suspend, resume, and test is still works. And
> > you probably need to go through a number of cycles of suspend/resume.
> > And you are going to need to maintain that for a number of years,
> > testing every release, to see what breaks as we add new features and
> > new devices.
> 
> I am very sorry but I kind of disagree with the above proposal. Usually
> contributors try to write the best solution with the help of the
> community, test on the hardware they have in hand and propose the
> changes. I cannot bond on a 10-years involvement in testing several
> switches over the releases.

Hi Miquèl

I was trying to point out this is a very hard subject to tackle. And
to do it right is not going to be a few patches. It needs a lot of
work, and a lot of testing, and it needs ongoing work because the
mv88e6xxx driver is not complete, there are more features to add,
which are going to need suspend/resume support adding.

> Today, there is no S2RAM support for switches. First, I proposed to add
> suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> crashing the kernel.

Then i would suggest the mv88e6xxx refuses the suspend. Actually that
probably is the first correct step. We don't have suspend support, so
stop the suspend happening, so preventing the kernel crash.

Having to maintain the mv88e6xxx, i don't want a suspend which might
work in the simplest configuration, but fails badly for more complex
configurations. Before accepting any patches, i want a good feeling it
works correctly. I would be willing to accept support and testing on
one Marvell family of switches, but again, i want to know it is well
tested. And i want to know somebody is going to stay around and look
after the support as the switch driver develops new features, which
are going to need suspend/resume support.

If you are only willing to consider a limited number of features, you
need to track if the switch is still within those limited set of
features, and refuse the suspend if not.

> > There also needs to be some though put into what happens when the
> > network changes while the switch is suspended. A port looses its link,
> > a port comes up, an SFP module is ejected, and SFP module is
> > inserted. The PTP grand master moves, etc. I hope the usual mechanisms
> > just work, but it all needs testing.
> 
> Is this really specific to switches? I know it is an issue and I
> understand you would prefer not to support S2RAM at all rather than
> addressing part of it, but isn't it better to support the simplest
> situation first, than supporting nothing at all?

Worst case scenario, you induce a loop in your network, and a
broadcast storm takes down the whole network. It is unlikely, but it
is very disruptive if it does happen. It is also the sort of situation
which is probably not going to get tested, making it more likely to
actually happen. And this is specific to switches. A single network
card cannot do this, you need two ports to form a loop.

     Andrew

