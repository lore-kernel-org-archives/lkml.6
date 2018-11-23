Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4F620664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jx9Ud2pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4F620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504718AbeKXBow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:44:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47001 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeKXBow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=MUsftLhn/cjZIn29ixUEodK5xcPaZ84SqpdHj2128d4=;
        b=jx9Ud2pYDEqj7botqn9lGJpb1xOnRlh8snIKbIZ/M7TLh4snarWnAkUUK19hCtF5icaIjPJPHWM6qDr5VkrBY+Fzg2XjLY1Kt+hBIpFBAUzNiE1S6e57Wm7mnp+Var6ZRWGuMSWaPzfYRGsFrSpchJ0xutA7/dIeq37JH92ubro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gQCwM-00085Q-Af; Fri, 23 Nov 2018 16:00:18 +0100
Date:   Fri, 23 Nov 2018 16:00:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net] phy: Micrel KSZ8061: link failure after cable
 connect
Message-ID: <20181123150018.GA30913@lunn.ch>
References: <1542965762-26822-1-git-send-email-alexander.onnasch@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542965762-26822-1-git-send-email-alexander.onnasch@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:36:11AM +0000, Onnasch, Alexander (EXT) wrote:
> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
> 
> DESCRIPTION
> Link-up may not occur properly when the Ethernet cable is initially
> connected. This issue occurs more commonly when the cable is connected
> slowly, but it may occur any time a cable is connected. This issue occurs
> in the auto-negotiation circuit, and will not occur if auto-negotiation
> is disabled (which requires that the two link partners be set to the
> same speed and duplex).
> 
> END USER IMPLICATIONS
> When this issue occurs, link is not established. Subsequent cable
> plug/unplug cycles will not correct the issue.
> 
> WORK AROUND
> There are four approaches to work around this issue:
> 1.  This issue can be prevented by setting bit 15 in MMD device address 1,
>     register 2, prior to connecting the  cable or prior to setting the
>     Restart Auto-Negotiation bit in register 0h.The MMD registers are
>     accessed via the indirect access registers Dh and Eh, or via the Micrel
>     EthUtil utility as shown here:
>     •  If using the EthUtil utility (usually with a Micrel KSZ8061
>        Evaluation Board), type the following commands:
>        > address 1
>        > mmd 1
>        > iw 2 b61a
>     •  Alternatively, write the following registers to write to the
>        indirect MMD register:
>        Write register Dh, data 0001h
>        Write register Eh, data 0002h
>        Write register Dh, data 4001h
>        Write register Eh, data B61Ah
> 2.  The issue can be avoided by disabling auto-negotiation in the KSZ8061,
>     either by the strapping option, or by clearing bit 12 in register 0h.
>     Care must be taken to ensure that the KSZ8061 and the link partner
>     will link with the same speed and duplex. Note that the KSZ8061
>     defaults to full-duplex when auto-negotiation is off, but other
>     devices may default to half-duplex in the event of failed
>     auto-negotiation.
> 3.  The issue can be avoided by connecting the cable prior to powering-up
>     or resetting the KSZ8061, and leaving it plugged in thereafter.
> 4.  If the above measures are not taken and the problem occurs, link can
>     be recovered by setting the Restart Auto-Negotiation bit in
>     register 0h, or by resetting or power cycling the device. Reset may
>     be either hardware reset or software reset (register 0h, bit 15).
> 
> PLAN
> This errata will not be corrected in a future revision.
> 
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Hi Alexander

Thanks for correctly formatting the commit message, etc.

Fixes: 7ab59dc15e2f ("drivers/net/phy/micrel_phy: Add support for new PHYs")

       Andrew
