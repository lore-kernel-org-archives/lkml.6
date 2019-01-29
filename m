Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3274EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A921473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfA2JBX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:01:23 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39597 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfA2JBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:01:22 -0500
X-Greylist: delayed 66980 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 04:01:21 EST
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 57EC4100006;
        Tue, 29 Jan 2019 09:01:18 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:01:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20190129100117.5ef6774c@xps13>
In-Reply-To: <20190128174246.GD28759@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
        <20190125095507.29334-2-miquel.raynal@bootlin.com>
        <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
        <20190128152456.212ae5ac@xps13>
        <20190128144417.GG4765@lunn.ch>
        <20190128165749.6abf2dc4@xps13>
        <20190128174246.GD28759@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 18:42:46 +0100:

> On Mon, Jan 28, 2019 at 04:57:49PM +0100, Miquel Raynal wrote:
> > Hi Andrew,
> > 
> > Thanks for helping!
> > 
> > Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 15:44:17 +0100:
> >   
> > > > I don't see where VLAN and bridge information are cached, can you point
> > > > me to the relevant locations?    
> > > 
> > > Miquèl
> > > 
> > > The bridge should have all that information. You need to ask it to
> > > enumerate the current configuration and replay it to the switch.
> > > 
> > > There might be something in the Mellanox driver you can copy? But i've
> > > not looked, i'm just guessing.  
> > 
> > I am still searching but so far I did not find a mechanism reading the
> > configuration of the bridge out of a 'net' object. Indeed there are
> > multiple lists with the configuration but they are all 'mellanox'
> > objects, they do not belong to the core.  
> 
> Hi Miquèl
> 
> Look at how iproute2 works. How does the bridge command enumerate the
> fdb and mdb's? How does bridge vlan show work? bridge link show? See
> if you can use this infrastructure within the kernel.

Thanks!

> 
> > > We also need to think about how we are going to test this. There is a
> > > lot of state information in a switch. So we are going to need some
> > > pretty good tests to show we have recreated all of it.  
> > 
> > My understanding of all this is rather short, until know I used what
> > you proposed in the v1 of this series but I am all ears if I need to
> > add anything to my test list.  
> 
> What you probably need is a generic DSA test suite, with a number of
> hardware devices, with different generations of mv88e6xxx devices, and
> ideally different sf2, kzs, etc switches. Setup a configuration and
> test is works correctly. Suspend, resume, and test is still works. And
> you probably need to go through a number of cycles of suspend/resume.
> And you are going to need to maintain that for a number of years,
> testing every release, to see what breaks as we add new features and
> new devices.

I am very sorry but I kind of disagree with the above proposal. Usually
contributors try to write the best solution with the help of the
community, test on the hardware they have in hand and propose the
changes. I cannot bond on a 10-years involvement in testing several
switches over the releases.

Today, there is no S2RAM support for switches. First, I proposed to add
suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
crashing the kernel. It was reported that the configuration was lost so
I wrote a rule-saving mechanism to replay the rules at resume. I was
told that this mechanism would best fit in the DSA core directly. I am
open to do that, I don't think it is that much work. But it is also
required that I use as less memory as possible. This is going to take
more time but I think I can do it as well. At least for a minimal set of
configuration.

Then, why not let other people improve things as they need? IIUC Switch
S2RAM does not work at all, I may try to improve the situation but I
do not have the abilities nor the time to do it exhaustively for every
piece of hardware and every situation.

> 
> There also needs to be some though put into what happens when the
> network changes while the switch is suspended. A port looses its link,
> a port comes up, an SFP module is ejected, and SFP module is
> inserted. The PTP grand master moves, etc. I hope the usual mechanisms
> just work, but it all needs testing.

Is this really specific to switches? I know it is an issue and I
understand you would prefer not to support S2RAM at all rather than
addressing part of it, but isn't it better to support the simplest
situation first, than supporting nothing at all?


Thanks Andrew for your guidance and help anyway,
Miquèl
