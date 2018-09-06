Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497F20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tezSezxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D497F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIFVBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:01:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54787 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeIFVBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=86ZO1VOgKjDMaOlKxCyLMygUxVimyqELMwSAZ6biafM=;
        b=tezSezxP7TtBm0dTiBR85ZJmysV3uYyremy9dqUE84lhVELBcwkLkhGDQmQchp+STYyTpLtgtgUtZ3EqmA0RLRCrS4Oa2G/93+bVB7QWxcZ+QRyvMUMhDXA5lmVvaq9u8vMXNbH6JLjiO7bqCpTOp3yeLfddwmQIhuAqRvpfVlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxx5O-0007C6-Hg; Thu, 06 Sep 2018 18:24:50 +0200
Date:   Thu, 6 Sep 2018 18:24:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 02/10] phy: Add configuration interface
Message-ID: <20180906162450.GA26997@lunn.ch>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <a739a2d623c3e60373a73e1ec206c2aa35c4a742.1536138624.git-series.maxime.ripard@bootlin.com>
 <8397722.XVQDA25ZU6@avalon>
 <20180906144807.pn753tgfyovvheil@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906144807.pn753tgfyovvheil@flea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +int phy_configure(struct phy *phy, enum phy_mode mode,
> > > +		  union phy_configure_opts *opts)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!phy)
> > > +		return -EINVAL;
> > > +
> > > +	if (!phy->ops->configure)
> > > +		return 0;
> > 
> > Shouldn't you report an error to the caller ? If a caller expects the PHY to 
> > be configurable, I would assume that silently ignoring the requested 
> > configuration won't work great.
> 
> I'm not sure. I also expect a device having to interact with multiple
> PHYs, some of them needing some configuration while some other do
> not. In that scenario, returning 0 seems to be the right thing to do.

You could return -EOPNOTSUPP. That is common in the network stack. The
caller then has the information to decide if it should keep going, or
return an error.

       Andrew
