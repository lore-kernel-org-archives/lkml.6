Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA04E208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AlcayZtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA04E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeKOGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:51:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34871 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOGvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8CF1b9uJ2LZtLg9OyJaWX8whrOCy5l8Cp4Uigi0mGNw=;
        b=AlcayZtJnvaSDqjpF+D3dUwZbWZYxO2mRlqxcG/sXoifUrFX3bZaaSEbrRpbcHt3tjklUycUHILYLz9kqBsWduPIPbOjj2tghjF58r30ztq2neLT84AnBueq8BxIh5TZGXM/rMIp3ydF5NZV3+TVzoXYFKFAJO4Ch9/p+u/JIzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gN23q-0008Ty-2T; Wed, 14 Nov 2018 21:46:54 +0100
Date:   Wed, 14 Nov 2018 21:46:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, davem@davemloft.net
Subject: Re: [PATCH v2] net: phy: mdio-gpio: fix access that may sleep
Message-ID: <20181114204654.GB32305@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114063703.13379-1-ms@dev.tdt.de>
 <20181114070528.GD17052@lunn.ch>
 <248deac95f412b925b0de44ead2ffec6@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248deac95f412b925b0de44ead2ffec6@dev.tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 08:43:49AM +0100, Martin Schiller wrote:
> On 2018-11-14 08:05, Andrew Lunn wrote:
> >On Wed, Nov 14, 2018 at 07:37:03AM +0100, Martin Schiller wrote:
> >>This commit re-enables support for slow GPIO pins. It was initially
> >>introduced by commit
> >>	2d6c9091ab7630dfcf34417c6683ce4764d7d40a
> >>and got lost by commit
> >>	7e5fbd1e0700f1bdb94508f84ec2aeb01eed7b12
> >
> >Hi Martin
> >
> >Was it really lost? It looks like _cansleep() just adds an extra check
> >might_sleep_if(extra_checks), but it does not change any
> >functionality.
> 
> Well, you are right, the functionality itself is not broken, but using
> the NON _cansleep() functions on GPIOs that have the cansleep flag set,
> this leads to a lot of kernel warnings/backtraces which makes the system
> in fact useless.
> 
> Thats the WARN_ON() here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v4.20-rc2#n2992
> 
> and here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v4.20-rc2#n3304

Hi Martin

Right, this is really what you are fixing. So the commit message
should talk about these WARN_ON being hit.

> >
> >So the change itself is O.K, i'm just not too sure about the commit
> >message.
> >
> >	Andrew
> 
> Hmm, ok. What would you suggest for a better commit message?

Up until commit XXX, the _cansleep variants of the gpio_ API was
used. After that commit and the change to gpiod_ API, the _cansleep()
was dropped. This then results in WARN_ON() when used with GPIO
devices which do sleep. Add back the _cansleep() to avoid this.

This is something which is useful in stable. So please base this fix
on DaveM net tree, not net-next, and include a Fixes: tag for the
patch which broke it.

      Thanks
	Andrew
