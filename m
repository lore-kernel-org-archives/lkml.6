Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B8BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48FB20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Uf1Tyzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbfBFN2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:28:24 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41018 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfBFN2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0IQq8nAN/yaD43ODriP1tQxqVU1MuznPRDL4cxmwbIg=; b=5Uf1TyztlwzuvulrDMfurqLq9N
        Cj+1B49xyTgoTo5IlH+6u/nrr692SrfBsei9Q/CSXITHZkrkjRaU4dEd5dTZs65H4kEIHFWJc5ohd
        Em22svB4qZ/yiAE0MfMnE1s6VoamBig2VgVwC/EObJyzheoa47pZNFL3uKbxTqhVKf1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grNFQ-0005p6-UP; Wed, 06 Feb 2019 14:28:16 +0100
Date:   Wed, 6 Feb 2019 14:28:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] r8169: Avoid pointer aliasing
Message-ID: <20190206132816.GD20405@lunn.ch>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
 <20190206123018.24802-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206123018.24802-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:30:18PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Read MAC address 32-bit at a time and manually extract the individual
> bytes. This avoids pointer aliasing and gives the compiler a better
> chance of optimizing the operation.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Applies to net-next.
> 
> I tested this on a Jetson TX2 with an add-in Realtek ethernet card that
> has a properly programmed OTP to verify that I got the endianess right.
> Seems like everything works and the device behaves the same with or
> without this patch.
> 
> Changes in v3:
> - align MAC address to u16 for is_valid_ether_addr()

Hi Thierry

The point of this patch was to try to avoid the pointer aliasing,
which is what leads to the alignment requirements. But if you are
forced to align it because of is_valid_ether_addr() i would just drop
this patch. Aliasing is going to happen whatever.

But if you want to keep it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
