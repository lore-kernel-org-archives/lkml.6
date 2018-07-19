Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A1720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PNRrc6zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A1720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbeGSPcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:32:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40120 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeGSPcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=01b7YBsoQCdF1sT77NYz72yUWqWJ3uYRg7Gqf9cf4Gs=;
        b=PNRrc6zCiIFE2zTHkDhbgV2abHscFUHKtWBhvkJ18BSLNJl+u5EeiXoIrN+DwKGgTBXBKYwtlPlR65hvRttNFiQ3h+k1TrLmeRxIKAZ+14+l7mHnAEXh4wBwSWOIj3KsH8hIfMVbPfCcSLK/gitf702OG0oDpb9fP16BWF4ombk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fgAF2-0002Z2-CA; Thu, 19 Jul 2018 16:49:16 +0200
Date:   Thu, 19 Jul 2018 16:49:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Camelia Alexandra Groza <camelia.groza@nxp.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
Message-ID: <20180719144916.GB9119@lunn.ch>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
 <20180718143919.GA10856@lunn.ch>
 <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
 <20180719125635.GK17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719125635.GK17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 01:56:35PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 19, 2018 at 12:47:18PM +0000, Camelia Alexandra Groza wrote:
> > > -----Original Message-----
> > > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > > Sent: Wednesday, July 18, 2018 17:39
> > > To: Camelia Alexandra Groza <camelia.groza@nxp.com>
> > > Cc: f.fainelli@gmail.com; davem@davemloft.net; netdev@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation done
> > > 
> > > On Wed, Jul 18, 2018 at 04:12:15PM +0300, Camelia Groza wrote:
> > > > Only Clause 22 PHYs can use genphy_aneg_done(). Use
> > > > genphy_c45_aneg_done() for PHYs that implement Clause 45 without the
> > > > Clause 22 register set.
> > > >
> > > > This change follows the model of phy_restart_aneg() which
> > > > differentiates between the two implementations in a similar way.
> > > 
> > > Hi Camelia
> > > 
> > > What about phy_config_aneg()? I would assume any sort of auto-neg action
> > > needs to check for c45 without c22, before calling a genphy_ function. Do you
> > > think it is possible to write a genphy_c45_config_aneg()? If not, we might
> > > want to return -EOPNOTSUPP.
> > 
> > Hi Andrew,
> > 
> > Adding Russell to the thread as well, since he wrote the c45 helpers.
> > 
> > Sure, I'll send a v2 with an additional generic phy_config_aneg(). I'll
> > stick to returning -EOPNOTSUPP for c22-less PHYs for now.
> 
> Be aware that there are no generic registers for configuring (eg) 1G
> speeds in C45 phys - that is vendor specific.

So returning -EOPNOTSUPP sounds like the right thing to do, making it
clear the PHY driver needs to implement it.

Thanks
      Andrew
