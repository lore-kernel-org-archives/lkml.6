Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA12C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32462206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BnZytbQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32462206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeGZUy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:54:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47721 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbeGZUy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=wqkcscTK0ZfKs2jflZa196FfuF0rmKH2ABWeYrqfnP4=;
        b=BnZytbQDAPCCceHmre2I1NXEHsT4OBhA4uE+rSkdYxYAv10WL0DXovt5xDEkW9zAQl6daoij4RU1EHslD7Ix9K1qhS5dqMXh7HN5WYvvu0p4DVFZS+la/xY3jTbb/Hg4NGNBAnGDMhOMDOR8oAsaznZEr6iNqKpGYOhOYSfb0CA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fim3u-0005jE-Qc; Thu, 26 Jul 2018 21:36:34 +0200
Date:   Thu, 26 Jul 2018 21:36:34 +0200
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
Subject: Re: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to
 bcm mdio mux
Message-ID: <20180726193634.GM10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
 <20180726192050.GJ10686@lunn.ch>
 <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170a4731-b091-aef4-2d66-2950114e41fc@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:33:05PM -0700, Arun Parameswaran wrote:
> 
> 
> On 18-07-26 12:20 PM, Andrew Lunn wrote:
> > On Thu, Jul 26, 2018 at 11:36:24AM -0700, Arun Parameswaran wrote:
> >> Add support for saving and restoring the 'scan control' register
> >> in the Broadcom iProc mdio mux driver.
> > 
> > Hi Arun
> > 
> > I don't see anything setting this register. So why is it necessary to
> > save it over suspend/resume?
> > 
> >      Andrew
> > 
> Hi Andrew
> In the Omega SoC (only), this register was defaulted incorrectly (to use
> a test mode) by the hardware. So we added the setup of the register to
> the early bootloader (ATF).
> 
> We still need to restore this register while resuming from sleep.

Hi Arun

It is better to not rely on the bootloader and have the driver do it.
That makes it easier for people to swap to alternative bootloaders.

     Andrew
