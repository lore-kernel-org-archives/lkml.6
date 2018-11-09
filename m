Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1413CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DB820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mzM6KqGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKJGUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:20:41 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57310 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeKJGUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=05kXeXu8jFwshPR2g52hptUQePPDd7DXcDC+N1lf2/c=;
        b=mzM6KqGA0qbWTljqsqYzSkFHogquEqBj5pbklXuztn2/+khlTdtFp1cfDQzKd12oGk9Zl6+9K+2rZCAXGTh8CDqh0lmshDVSjra+AFhcrq688C5FZM5hu8QCAIzcPKsO1qfdMXKgD8mxER5JaFkfT/JwjJ1eD7OiNavABig4KNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gLDXr-0003Lr-1Z; Fri, 09 Nov 2018 21:38:23 +0100
Date:   Fri, 9 Nov 2018 21:38:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with
 a check for config_intr and ack_interrupt
Message-ID: <20181109203823.GY5259@lunn.ch>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
 <20181109201307.GV5259@lunn.ch>
 <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b503b8-9f2a-50ac-c4c9-d25258d98ef5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 09:22:55PM +0100, Heiner Kallweit wrote:
> On 09.11.2018 21:13, Andrew Lunn wrote:
> > Hi Heiner
> > 
> >> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> >> +{
> >> +	return phydrv->config_intr || phydrv->ack_interrupt;
> >> +}
> > 
> > Should this be && not || ? I thought both needed to be provided for
> > interrupts to work. 
> > 
> > 	   Andrew
> > 
> I've seen at least one driver which configures interrupts in
> config_init and doesn't define a config_intr callback
> (ack_interrupt callback is there)

> Intention of this check is not to ensure that the driver defines
> everything to make interrupts work. All it states:
> If at least one of the irq-related callbacks is defined, then
> we interpret this as indicator that the PHY supports interrupts.

I'm just wondering if that driver is broken if it enables interrupts
in config_init()? phylib deliberately enable/disable interrupts. If we
cannot do that, can we get an interrupt when we don't expect it? Can
we miss a state transition which would be reported when interrupts
would be re-enabled immediately triggering an interrupt?

Well, the current code does not seem to care if one is missing. So i
doubt this is making it more broken.

So,

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


