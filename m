Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248B208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BUntQFgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C248B208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeHAXnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:43:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53300 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeHAXnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nf/mCcPTi0/XUChceHGx+w0nUYFXpCPhILE5ZqcyqU4=;
        b=BUntQFgbd+5rbIIXCraCn1kqoHJusBpKHa2dkfB4yy6VCrNpSgTbzcOlnsyt9RJkxFRr4RbVjN+AALXp1RhVR7UQcNptYSfySBTvvTBuyIppG/iG7Wtu428gOpqIb81XxrEBCXvzaW3H5iwDNEl9fJr25siWKdZVxJAiu29KrPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkz5L-000763-43; Wed, 01 Aug 2018 23:55:11 +0200
Date:   Wed, 1 Aug 2018 23:55:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
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
Message-ID: <20180801215511.GG19257@lunn.ch>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
 <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> md->core_clk = devm_clk_get(&pdev->dev, NULL);
> if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
> 	/* clock is optional, without it the default
> 	 * rate divider register values will be used
> 	 */
> 	md->core_clk = NULL;
> } else if (IS_ERR(md->core_clk)) {
> 	return PTR_ERR(md->core_clk);
> } else {
> 	rc = clk_prepare_enable(md->core_clk);
> 	...
> }

As Florian pointed out, the clk_ API is happy to take a NULL pointer
for a clock. So you don't need this last else.

    Andrew
