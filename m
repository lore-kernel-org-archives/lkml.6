Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B908C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9D20647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kSO8i2NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC9D20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeGZUYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:24:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47612 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbeGZUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0DrjUQjLf2SxXXO29WiJ6a2V6Aux3THgLgFK+vnmabM=;
        b=kSO8i2NB1YC2282S7C2fHJ/UfsoRi50veZxOm/nrWtJz41VkM4mGnqAtq3kG0dHWmEJcVCCizAgC9o9MyD3gAbbXIST4ZVlCxeYu260uOIyc3ypF8ohthmTqWIjb4Lxvf1WjwQW0aug047IlN1j7zn8qwCx2UL4OaT/sepTT9nM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1filau-00055N-8A; Thu, 26 Jul 2018 21:06:36 +0200
Date:   Thu, 26 Jul 2018 21:06:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc
 mdio mux driver
Message-ID: <20180726190636.GG10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:36:19AM -0700, Arun Parameswaran wrote:
> Modify the register offsets in the Broadcom iProc mdio mux to start
> from the top of the register address space.
> 
> Earlier the base address specified was from the middle of the block's
> register space. The base address will now point to the start of the
> mdio's address space. The offsets have been fixed to match this.

Hi Arun

Did you consider a change something like:

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b7142df7..2d53e609498c 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -169,6 +169,12 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
        md->dev = &pdev->dev;
 
        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+       if (res->start & 0xfff != 0) {
+               dev_info(&pdev->dev, "Please upgrade your device tree blob.\n");
+               res->start &= ~0xfff;
+       }
+
        md->base = devm_ioremap_resource(&pdev->dev, res);
        if (IS_ERR(md->base)) {
                dev_err(&pdev->dev, "failed to ioremap register\n");


	Andrew
