Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8260C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8DA20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j6JyqrLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8DA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeGZUro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:47:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47705 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbeGZUro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FquRfStKJoc5qkcJpPqwZ2p010g1xohB/4nG2X7LxN0=;
        b=j6JyqrLE5reXKWSJDqjqVYy2NKqHXAYQrwTxMM9jlRFYaRkOe/V4Tdhi5Xb3i3Cc+JkXcTCxnRggdz1hoGsi7gd8J0D6unFZ8UZXL5q9ENirkTQpJVSQngCe7pSA0fe3y/yNEGtEDGMFod/1IhrkSWUvh8va7RdYIg/VZ2NigZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1filwx-0005bZ-8T; Thu, 26 Jul 2018 21:29:23 +0200
Date:   Thu, 26 Jul 2018 21:29:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20180726192923.GL10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
 <20180726190636.GG10686@lunn.ch>
 <6188441f-670d-7644-361b-7a5e8e06c9c2@broadcom.com>
 <eeaf777f-e0ea-fb41-5a5e-4ab42a35e10f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeaf777f-e0ea-fb41-5a5e-4ab42a35e10f@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:25:24PM -0700, Ray Jui wrote:
> 
> 
> On 7/26/2018 12:16 PM, Arun Parameswaran wrote:
> >
> >
> >On 18-07-26 12:06 PM, Andrew Lunn wrote:
> >>On Thu, Jul 26, 2018 at 11:36:19AM -0700, Arun Parameswaran wrote:
> >>>Modify the register offsets in the Broadcom iProc mdio mux to start
> >>>from the top of the register address space.
> >>>
> >>>Earlier the base address specified was from the middle of the block's
> >>>register space. The base address will now point to the start of the
> >>>mdio's address space. The offsets have been fixed to match this.
> >>
> >>Hi Arun
> >>
> >>Did you consider a change something like:
> >That looks good. I will make this change to the patch.
> >
> >Thanks
> >Arun
> 
> To make it backward compatible, then length of the resource also needs to be
> adjusted from 0x14 to 0x250 in the driver?
> 
> Otherwise you will end up accessing areas out of 0x14 defined in old DT that
> is not mapped?

struct resource {
       resource_size_t start;
       resource_size_t end;
       const char *name;
       unsigned long flags;
       unsigned long desc;
       struct resource *parent, *sibling, *child;
};

"end" suggests an address, not a length. But it would be good to look
deeper into the code to be sure.

       Andrew
