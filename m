Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE448C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714D0206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fHrvrXnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeLNQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:38:56 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38068 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbeLNQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnvV3IJV6CWDRBtPZPhv4SRluXbQaZ52dhNgJJRtUoI=; b=fHrvrXnlrBT6gUxtyYf48XzkL
        bNPkFEwYpyRbT+S/8jbgA6heoJ+S2ySD5DW4wL/zo/s54poitvRjkf7stWb+0PVpk70N7lbNcAMbS
        J7Pdwa10ASul1UkhCKuRe4s0yKhlmI2gGijpC9xDUD9aHTSjhGR0IRO4bxlOg5cqAm4Kw=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39467)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gXqUC-0000qB-AS; Fri, 14 Dec 2018 16:38:48 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gXqU8-0005qs-TK; Fri, 14 Dec 2018 16:38:44 +0000
Date:   Fri, 14 Dec 2018 16:38:43 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH net v2] net: mvpp2: 10G modes aren't supported on all
 ports
Message-ID: <20181214163843.GF26090@n2100.armlinux.org.uk>
References: <20181214093451.26314-1-antoine.tenart@bootlin.com>
 <20181214160249.GD26090@n2100.armlinux.org.uk>
 <20181214160944.GE20364@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214160944.GE20364@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 05:09:44PM +0100, Antoine Tenart wrote:
> Hi Russell,
> 
> On Fri, Dec 14, 2018 at 04:02:50PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Dec 14, 2018 at 10:34:51AM +0100, Antoine Tenart wrote:
> > > The mvpp2_phylink_validate() function sets all modes that are
> > > supported by a given PPv2 port. A recent change made all ports to
> > > advertise they support 10G modes in certain cases. This is not true,
> > > as only the port #0 can do so. This patch fixes it.
> > > 
> > > Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
> > > Cc: Baruch Siach <baruch@tkos.co.il>
> > > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > 
> > Looking at net-next, I think there's more to be fixed here:
> > 
> >         case PHY_INTERFACE_MODE_RGMII:
> >         case PHY_INTERFACE_MODE_RGMII_ID:
> >         case PHY_INTERFACE_MODE_RGMII_RXID:
> >         case PHY_INTERFACE_MODE_RGMII_TXID:
> >         case PHY_INTERFACE_MODE_SGMII:
> > ...
> > 		phylink_set(mask, 10000baseT_Full);
> > 
> > Is that really true?
> 
> Good catch. Will you send a fix or do you want me to do it?

I'm not planning to given that I don't know what other changes are
in the pipeline - I had assumed you'd wrap it up into a v3.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
