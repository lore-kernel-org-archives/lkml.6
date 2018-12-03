Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF27C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14165208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b1UCvsoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14165208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLCAgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:36:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37252 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeLCAgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wVfAIRMk0An1olHgawVbczOreBOhhpzXovqg+meDD3c=; b=b1UCvsoDWz4pvhahahsaCskoG
        Ey3U6Ie3CF6L3Gq3jXWbwOMPkWn2kd2I8Rs99N5WSSfzp7NeKCc3nnhu0bTtKAGB4jHpFpufODzmv
        05x2ttdmGnFSTEvKNlUcBY8JiYHvUe6ghUC0Ms/qa5ADV0glDZ55v2kxx3Y7/ihXjHLpA=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:42398)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gTcDu-0005GD-D8; Mon, 03 Dec 2018 00:36:33 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gTcDp-0007rI-Pl; Mon, 03 Dec 2018 00:36:25 +0000
Date:   Mon, 3 Dec 2018 00:36:23 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] phy: mvebu-cp110-comphy: fix port check in
 ->xlate()
Message-ID: <20181203003623.GJ30658@n2100.armlinux.org.uk>
References: <20181130144743.675-1-miquel.raynal@bootlin.com>
 <20181130144743.675-3-miquel.raynal@bootlin.com>
 <20181130190031.GH30658@n2100.armlinux.org.uk>
 <20181202203509.21b067c4@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202203509.21b067c4@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:35:09PM +0100, Miquel Raynal wrote:
> Hi Russell,
> 
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote on Fri, 30 Nov
> 2018 19:00:31 +0000:
> 
> > On Fri, Nov 30, 2018 at 03:47:37PM +0100, Miquel Raynal wrote:
> > > So far the PHY ->xlate() callback was checking if the port was
> > > "invalid" before continuing, meaning that the port has not been used
> > > yet. This check is not correct as there is no opposite call to  
> > > ->xlate() once the PHY is released by the user and the port will  
> > > remain "valid" after the first phy_get()/phy_put() calls. Hence, if
> > > this driver is built as a module, inserted, removed and inserted
> > > again, the PHY will appear busy and the second probe will fail.
> > > 
> > > To fix this, just drop the faulty check and instead verify that the
> > > port number is valid (ie. in the possible range).
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > > index 31b9a1c18345..a40b876ff214 100644
> > > --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > > +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> > > @@ -567,9 +567,9 @@ static struct phy *mvebu_comphy_xlate(struct device *dev,
> > >  		return phy;
> > >  
> > >  	lane = phy_get_drvdata(phy);
> > > -	if (lane->port >= 0)
> > > -		return ERR_PTR(-EBUSY);
> > >  	lane->port = args->args[0];
> > > +	if (lane->port >= MVEBU_COMPHY_PORTS)
> > > +		return ERR_PTR(-EINVAL);  
> > 
> > Shouldn't we validate args->args[0] before doing anything?
> > 
> 
> I don't understand your point, there is a check on args->args[0] as
> we check its value (through lane->port) right after. What do you
> have in mind?

Right, there is already a check on args->args[0] for it being greater
than MVEBU_COMPHY_PORTS and returning an error (and in fact warning
if that is the case).  So in that case, what is the use of the above
additional test you are proposing to add?  The resulting code ends up
looking like this:

	if (WARN_ON(args->args[0] >= MVEBU_COMPHY_PORTS))
		return ERR_PTR(-EINVAL);
...
	lane->port = args->args[0];
+	if (lane->port >= MVEBU_COMPHY_PORTS)
+		return ERR_PTR(-EINVAL);  

which is just silly - the second test can never be evaluated as true,
and therefore is redundant.

In any case, my point was that in your patch, where you assign
lane->port and then validate the lane->port value, this is in
principle the wrong order - the order should always be: validate
first, then make use.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
