Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38724C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D2620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XNt6PGm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfA1Rmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:42:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58004 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfA1Rmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sMoY8eqIpeQH7z9JcjiW2zAEfvXKU9XUzHdDLpiU4Cc=; b=XNt6PGm0z4bKgpElM8gs0kTsi1
        Cj+t1JcKsfKirT+hr5ih4kHPbCqrhF/XUDXl+mMKhoophGArumJ0p6qXZq7IsgjpsfCjVRcp2hbp4
        sD/CGL2Xg5jNiujaXMcZfkPygjEgAiltNkcm5uXrw5XOFGW1YkoP6iOJ5pu3dJuXTitY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1goAvm-000142-0X; Mon, 28 Jan 2019 18:42:46 +0100
Date:   Mon, 28 Jan 2019 18:42:46 +0100
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
Message-ID: <20190128174246.GD28759@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
 <20190128152456.212ae5ac@xps13>
 <20190128144417.GG4765@lunn.ch>
 <20190128165749.6abf2dc4@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128165749.6abf2dc4@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:57:49PM +0100, Miquel Raynal wrote:
> Hi Andrew,
> 
> Thanks for helping!
> 
> Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 15:44:17 +0100:
> 
> > > I don't see where VLAN and bridge information are cached, can you point
> > > me to the relevant locations?  
> > 
> > Miquèl
> > 
> > The bridge should have all that information. You need to ask it to
> > enumerate the current configuration and replay it to the switch.
> > 
> > There might be something in the Mellanox driver you can copy? But i've
> > not looked, i'm just guessing.
> 
> I am still searching but so far I did not find a mechanism reading the
> configuration of the bridge out of a 'net' object. Indeed there are
> multiple lists with the configuration but they are all 'mellanox'
> objects, they do not belong to the core.

Hi Miquèl

Look at how iproute2 works. How does the bridge command enumerate the
fdb and mdb's? How does bridge vlan show work? bridge link show? See
if you can use this infrastructure within the kernel.

> > We also need to think about how we are going to test this. There is a
> > lot of state information in a switch. So we are going to need some
> > pretty good tests to show we have recreated all of it.
> 
> My understanding of all this is rather short, until know I used what
> you proposed in the v1 of this series but I am all ears if I need to
> add anything to my test list.

What you probably need is a generic DSA test suite, with a number of
hardware devices, with different generations of mv88e6xxx devices, and
ideally different sf2, kzs, etc switches. Setup a configuration and
test is works correctly. Suspend, resume, and test is still works. And
you probably need to go through a number of cycles of suspend/resume.
And you are going to need to maintain that for a number of years,
testing every release, to see what breaks as we add new features and
new devices.

There also needs to be some though put into what happens when the
network changes while the switch is suspended. A port looses its link,
a port comes up, an SFP module is ejected, and SFP module is
inserted. The PTP grand master moves, etc. I hope the usual mechanisms
just work, but it all needs testing.

S2RAM is hard for a device like this. It is not something i personally
would want to do :-(

      Andrew
