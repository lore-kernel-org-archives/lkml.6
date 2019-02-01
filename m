Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A170C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7374621916
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfBALB0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:01:26 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53571 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfBALBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:01:25 -0500
X-Originating-IP: 90.88.147.226
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 87EE56000A;
        Fri,  1 Feb 2019 11:01:20 +0000 (UTC)
Date:   Fri, 1 Feb 2019 12:01:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190201120119.752e7ed6@xps13>
In-Reply-To: <20190130194608.GB28098@t480s.localdomain>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
        <20190125095507.29334-2-miquel.raynal@bootlin.com>
        <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
        <20190128152456.212ae5ac@xps13>
        <20190128144417.GG4765@lunn.ch>
        <20190128165749.6abf2dc4@xps13>
        <20190128174246.GD28759@lunn.ch>
        <20190129100117.5ef6774c@xps13>
        <20190129145157.GK4765@lunn.ch>
        <20190129104613.GC20920@t480s.localdomain>
        <20190130104606.31639abb@xps13>
        <20190130194608.GB28098@t480s.localdomain>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivien,

Vivien Didelot <vivien.didelot@gmail.com> wrote on Wed, 30 Jan 2019
19:46:08 -0500:

> Hi Miquèl,
> 
> On Wed, 30 Jan 2019 10:46:06 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > > > > Today, there is no S2RAM support for switches. First, I proposed to add
> > > > > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > > > > crashing the kernel.    
> > > > 
> > > > Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> > > > probably is the first correct step. We don't have suspend support, so
> > > > stop the suspend happening, so preventing the kernel crash.    
> 
> Actually can you show me the crash that is happening?

Sure, here it is: http://code.bulix.org/swwb11-569137

Actually it is a silent crash but the platform never resumes. I am
pretty sure this is due to the kthread_queue_delayed_work() loop which
might access registers before it is allowed to do so. In my proposal I
just canceled it at suspend and restarted it at resume.

Next week I will send a patch to refuse the suspend as you both
suggested and if people want to suspend, they will have to remove the
switch support.


Thanks,
Miquèl
