Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3990DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1104D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBAOna convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:43:30 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52455 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfBAOn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:43:29 -0500
X-Originating-IP: 90.88.147.226
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3ABB56000D;
        Fri,  1 Feb 2019 14:43:25 +0000 (UTC)
Date:   Fri, 1 Feb 2019 15:43:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190201154324.72680940@xps13>
In-Reply-To: <20190201140831.GE30908@lunn.ch>
References: <20190128152456.212ae5ac@xps13>
        <20190128144417.GG4765@lunn.ch>
        <20190128165749.6abf2dc4@xps13>
        <20190128174246.GD28759@lunn.ch>
        <20190129100117.5ef6774c@xps13>
        <20190129145157.GK4765@lunn.ch>
        <20190129104613.GC20920@t480s.localdomain>
        <20190130104606.31639abb@xps13>
        <20190130194608.GB28098@t480s.localdomain>
        <20190201120119.752e7ed6@xps13>
        <20190201140831.GE30908@lunn.ch>
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

Andrew Lunn <andrew@lunn.ch> wrote on Fri, 1 Feb 2019 15:08:31 +0100:

> On Fri, Feb 01, 2019 at 12:01:19PM +0100, Miquel Raynal wrote:
> > Hi Vivien,
> > 
> > Vivien Didelot <vivien.didelot@gmail.com> wrote on Wed, 30 Jan 2019
> > 19:46:08 -0500:
> >   
> > > Hi Miquèl,
> > > 
> > > On Wed, 30 Jan 2019 10:46:06 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >   
> > > > > > > Today, there is no S2RAM support for switches. First, I proposed to add
> > > > > > > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > > > > > > crashing the kernel.      
> > > > > > 
> > > > > > Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> > > > > > probably is the first correct step. We don't have suspend support, so
> > > > > > stop the suspend happening, so preventing the kernel crash.      
> > > 
> > > Actually can you show me the crash that is happening?  
> > 
> > Sure, here it is: http://code.bulix.org/swwb11-569137
> > 
> > Actually it is a silent crash but the platform never resumes. I am
> > pretty sure this is due to the kthread_queue_delayed_work() loop which
> > might access registers before it is allowed to do so.  
> 
> Hi Miquel
> 
> That sounds like it is an MDIO driver problem, or at least, a resume
> ordering problem. You need to ensure that the MDIO bus driver is
> resumed before the switch driver. Also, that the switch is suspended
> before the MDIO bus driver is suspended.

I don't think there is an ordering problem. The MDIO bus is suspended
after the switch and resumed before. But if there is no cancellation of
the work thread (which is always automatically restarted) in the suspend
path, soon or later this work will run at a time when the MDIO bus is
still not accessible and will freeze the platform entirely.


Thanks,
Miquèl
