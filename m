Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05441C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F1E215E6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tJ13y1Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F1E215E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeJUEX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:23:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39050 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJUEX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=zwE7XsP3qjD5nT3EGIDHGWbVEUmgMzK8gYWW0A9ThJE=;
        b=tJ13y1Mijmp2P1la1G5qr1jvoefomorpeh8j0OJvFF5UA563oPm9LEVqNOcrwgOlnIPw5ysfbbM0z0sMs0owxdJnWvVWTY3yV9+6H0g8lnsXbk3cpg5MXhrE/grKqywiqwGm7T/aZJGVBLYWtl0HR42iZ3kDEDBdNs5ziwtOMOI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gDxbd-0003aJ-3d; Sat, 20 Oct 2018 22:12:17 +0200
Date:   Sat, 20 Oct 2018 22:12:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>, davem@davemloft.net,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181020201217.GB6615@lunn.ch>
References: <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
 <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com>
 <20181018195909.GA11317@Red>
 <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
 <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
 <20181020153922.GC1596@lunn.ch>
 <c8f4f203-b2b6-81ba-2c79-85501a640948@gmail.com>
 <20181020185947.GA6615@lunn.ch>
 <1153d0a5-1c23-1e14-7ebd-459886af957a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153d0a5-1c23-1e14-7ebd-459886af957a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, you are correct.
> > 
> > But it is no longer possible to just do PHY_BASIC_FEATURES |
> > SUPPORTED_Pause because .features is no loner a u32 but a linux
> > bitmap.
> > 
> Ahh, missed that.

Yes, easy to miss, since it is still work in progress. The next
patchset completes the migration, making phydev->advertise and
phydev->supported bitmaps.

> > We need to keep the same idea, allow the PHY driver to indicate it
> > supports a subset of Pause, and if not, enable pause by default.
> > 
> Could the PHY driver define its own bitmap instead of pointing to
> one of the predefined ones?

I'm actually just adding a few more pre-defined ones. I suspect they
will get used by more than one driver. These changed have uncovered a
few bugs with pause, and i would not be surprised to find there are
more still to be found.

     Andrew
