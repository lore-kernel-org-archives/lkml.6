Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98537C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A02F208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qobM4pVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A02F208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeH1BUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:20:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44488 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH1BUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=r7JHg32UWvWzdM3nVc6NWAgzu+uBIUmBURlkbGUatD0=;
        b=qobM4pVdjOWRMM7rE5+LNEMAU0akzqjy+2UWYpns8BaO7bCcTf07DG0Af8n3ltMtYdki0Fggn7L7y5+8GJwROAeZjZ3w5qHy+1XnLQviguolxxrJcghRAm4oBzve22e3rY/bjOXd8V/hvWzGwnrDzAJDaoB06hcVcyjzCX+kamM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fuP73-0006sm-7A; Mon, 27 Aug 2018 23:31:53 +0200
Date:   Mon, 27 Aug 2018 23:31:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
Message-ID: <20180827213153.GQ27483@lunn.ch>
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827203500.GN27483@lunn.ch>
 <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
 <20180827210916.GP27483@lunn.ch>
 <cd82f8a8-ddd2-dda9-95ad-38265fa406c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd82f8a8-ddd2-dda9-95ad-38265fa406c9@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Florian
> > 
> > I didn't need anything like this for the mv88e6xxx. I had patches
> > merged in -rc1 to make SFF work connected to the mv88e6390. The DT
> > change was not merged, but it is here:
> > 
> > https://patchwork.ozlabs.org/patch/955635/
> > 
> > +					port@9 {
> > +						reg = <9>;
> > +						label = "sff2";
> > +						phy-mode = "sgmii";
> > +						managed = "in-band-status";
> 
> 						^=====
> 
> Yes that is what I was missing, thanks Andrew! Still not 100% sure why
> having a "sfp" phandle is not enough, but I suppose there are
> problematic cases like the ZII Devel Rev. B where we have a SFF and we
> are not able to auto-negotiate the fiber connection.

ZII Devel Rev. B is actually broken, should not work, but does
somehow. The SFF 3 and 4 are connected to switch ports which cannot do
1000Base-X. They are using something like SGMII. So the link partner
needs to be very forgiving. But it happens that the link partners i'm
testing against are forgiving. SFF 1 and 2 are generally not
populated. If they are, i think you need to remove a resistor, to make
them work. But they are then connected to a switch port which does use
1000Base-X.

Now, since ZII devel B is technically broken, i would not be too
unhappy if "sfp" phandle implies managed = "in-band-status" by
default, so long as we can still use fixed-link somehow.

	 Andrew
