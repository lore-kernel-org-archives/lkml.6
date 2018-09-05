Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6088C43143
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB420857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rQnD/GAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABB420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIERBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:01:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53290 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbeIERBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=p5qBI66sU/PlIlrGvwVtJXuuRtG8YSAoOgnqo8Ja9vE=;
        b=rQnD/GAQ+SWbliFQWkqN18Q/2hDUZ5QfWhRNl9CQOPbOvx4lJhsEMbfD66Vi2zGGZM72t7Bhg/CuFBhVfNnLFl7cKexR6AsXUSIPULxSNx7xTSkj0TShTmdaQKgnb9Rui1akhuU1bEUOatyVIT4x+FsyF/b/wyDjIzvZFBiVOZs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxWxZ-00072O-7n; Wed, 05 Sep 2018 14:31:01 +0200
Date:   Wed, 5 Sep 2018 14:31:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williams <alex.williams@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
Message-ID: <20180905123101.GA26739@lunn.ch>
References: <20180905001535.19168-1-mdf@kernel.org>
 <fa4fca9c-5950-8ec1-5746-91e51085cecf@gmail.com>
 <CAAtXAHdZxgvb7=DG0B2irB4wJ+taJaOYbxhGjNtjWvaAQP8_nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAtXAHdZxgvb7=DG0B2irB4wJ+taJaOYbxhGjNtjWvaAQP8_nA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me check, it seems there is a register that indicates whether the MAC can
> do either 1G or 10G. I might be able to use that for some of the above, but
> there is not really much in terms of writable registers there.

Can the MAC do 10 or 100? At the moment, you don't have anything
stopping the PHY anto-neg'ing 10Half. If the MAC does not fully
implement standard Ethernet, you need to tell the PHY driver about
this. That is what the validate call is about. phylink and phylib
knows what the PHY supports. It passes that list to the validate
call. You need to then remove all the modes the MAC does not support.

> It's like a DMA engine with a bit of MDIO on the side. Let me see if
> I can make it look less weird with that. If not I'll go with a
> comment explaining that there isn't much to do for the MLO_AN_PHY
> case and the MLO_FIXED cases?

You again need to configure the MAC to the selected speed, duplex,
etc. If the link is down, you want to disable the MAC. You need this
for both MLO_AN_PHY and MLO_FIXED, because both specify speeds,
duplex, etc.

	Andrew
