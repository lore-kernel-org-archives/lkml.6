Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013B7C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9CA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yKB1reus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAYTHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:07:22 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:56033 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SLCY49f44O40vBlW5iLYi8dQuN31A4lVjgyHOMHXJfQ=; b=yKB1reusBEMpfgeDRTOYNk/F5P
        /iDS2Z/kanqeslz34D2L9Sun9SXyAMSlM17JNahEszbeoFiSB2FDQkdT/1Z4bF59fdDvAqJpS3pNh
        xqnOJCUBzJeMzdeQMuqhKiD9T3ghA/+1UZPMPAoXxUY1OaLg7t/xjNf9rIqG7LpXPYE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gn6ot-0006pC-Gt; Fri, 25 Jan 2019 20:07:15 +0100
Date:   Fri, 25 Jan 2019 20:07:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: Load MAC address from device tree if present
Message-ID: <20190125190715.GG22211@lunn.ch>
References: <20190125101814.6262-1-thierry.reding@gmail.com>
 <20190125145711.GF12962@lunn.ch>
 <42d32783-c433-b859-6ba4-f2864f034871@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d32783-c433-b859-6ba4-f2864f034871@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew, for my understanding: What do you think is wrong with the 
> alignment requirement? It was introduced because we do a 32 bit access
> to the start address of the array and want to avoid an unaligned access.

Hi Heiner

Because you are doing pointer aliasing, the compiler will by default
generate bad code, doing unaligned access. Adding the attribute works
around this. But it is just a work around. Since this is very slow
path code, i would just avoid the pointer aliasing, write a bit more C
code as Thierry suggested, and the optimiser will probably figure out
what is going on and produce reasonable code.

Also, in general, by avoiding pointer aliasing, you allow static code
checkers to work better. They are more likely to discover buffer
overruns, etc.

    Andrew
