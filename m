Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5679C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D11B20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LSGwhsTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfBAOIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:08:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35650 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfBAOIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wo/3ynjeKPe+PUKzsHVU42Pd3zDHoDnLV3rlIJivieE=; b=LSGwhsTykHib6z4vxRBV2Rq0hx
        iDA3A+jDPPBft16PP3z/1dFqk9yuABVDAA6G55ularCzM9hCFxT+ZmvDXwhObMRPNYyAIizROqOEA
        17wqLEWLshuIz+hYZiweeADaT/SzYiPfC1KMI9TBPMPZo0SSPZ8FhVZvE/NesovqRPCw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gpZUd-0008LQ-NX; Fri, 01 Feb 2019 15:08:31 +0100
Date:   Fri, 1 Feb 2019 15:08:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Message-ID: <20190201140831.GE30908@lunn.ch>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201120119.752e7ed6@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:01:19PM +0100, Miquel Raynal wrote:
> Hi Vivien,
> 
> Vivien Didelot <vivien.didelot@gmail.com> wrote on Wed, 30 Jan 2019
> 19:46:08 -0500:
> 
> > Hi Miquèl,
> > 
> > On Wed, 30 Jan 2019 10:46:06 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > 
> > > > > > Today, there is no S2RAM support for switches. First, I proposed to add
> > > > > > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > > > > > crashing the kernel.    
> > > > > 
> > > > > Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> > > > > probably is the first correct step. We don't have suspend support, so
> > > > > stop the suspend happening, so preventing the kernel crash.    
> > 
> > Actually can you show me the crash that is happening?
> 
> Sure, here it is: http://code.bulix.org/swwb11-569137
> 
> Actually it is a silent crash but the platform never resumes. I am
> pretty sure this is due to the kthread_queue_delayed_work() loop which
> might access registers before it is allowed to do so.

Hi Miquel

That sounds like it is an MDIO driver problem, or at least, a resume
ordering problem. You need to ensure that the MDIO bus driver is
resumed before the switch driver. Also, that the switch is suspended
before the MDIO bus driver is suspended.

       Andrew
