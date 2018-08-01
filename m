Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tEY43cNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeHAW03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:26:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53228 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbeHAW03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=wVt/njjw90u5LI5OVyTjIogIfG2pqiT7QONbf8S7fQM=;
        b=tEY43cNAW3vTSOIij66g4Ac/8hNcWkqg0RcUFt+L7pdMulTUJlrmyzPhnquFltKeLk6TpYASmKgxOc54AXRUqzDH+Ms3zXXQqDe5/5wlH9P0hl2f07NgOB+E5CX0HZTEE1ur2y+IZfwlr+K5rMwfw8+4wtCYe21KBgRLij7kLN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkxtO-0006jY-DJ; Wed, 01 Aug 2018 22:38:46 +0200
Date:   Wed, 1 Aug 2018 22:38:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
Message-ID: <20180801203846.GE19257@lunn.ch>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801202313.GH30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:23:14PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 01, 2018 at 10:07:12PM +0200, Andrew Lunn wrote:
> > You might want to consider adding clk_optional_get() and
> > devm_clk_optional_get().
> 
> I think there's attempts to add such APIs but I don't think it's
> trivial - it seems to require a _lot_ of discussion.
> 
> I think part of that is because of the quirky use of error codes.
> If you look at clk_get(), it calls __of_clk_get_by_name() which
> returns:
> 
>  -ENOENT if DT is disabled
>  -ENOENT if the device has no DT node
>  -EPROBE_DEFER if the lookup in DT succeeds but there's no registered
>    clock
>  -EINVAL if the device has a DT node but the lookup of the name
>    failed (in otherwords, the optional clock was omitted)
>  -ENOENT if the clocks = property has not enough clocks for the
>     clock-names property
>  -ENOMEM if we fail to allocate the clk
>  -ENOENT if __clk_get() fails

That makes it hard. I added phy_optional_get() early on, when the
error cases were simple. Hopefully they remain simple...

      Andrew
