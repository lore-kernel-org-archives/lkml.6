Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E64B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xv6rEUfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732722AbfAKNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:37:48 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40273 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfAKNhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=yDwzKdjG78BFDG+kvb+t3ciYmE0iFcrwnyBkD1+WHXk=;
        b=Xv6rEUfNbHm/vY64ecFMLfPVf8OqUwHToLStx+6rkOLmPcneuuQoyq0EwYFKwmc+/QIuBPtf/I2WE5dFxl8VTLXbhYV1cbZjly1Tc8RWSoy3c6eRSEAMuYfoD/VbFqE2GKGgJrYyyndjrJTJqIrcONBSV1DetlIrzmodCqF5pTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghx06-0000kb-O2; Fri, 11 Jan 2019 14:37:30 +0100
Date:   Fri, 11 Jan 2019 14:37:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Camelia Groza <camelia.groza@nxp.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        oss@buserror.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: guard against accessing a NULL features
 bitmap
Message-ID: <20190111133730.GA1895@lunn.ch>
References: <1547207806-30572-1-git-send-email-camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547207806-30572-1-git-send-email-camelia.groza@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:56:46PM +0200, Camelia Groza wrote:
> Since phy driver features became a link_mode bitmap, phy drivers that
> don't have a list of features configured will cause the kernel to crash
> when probed.

Hi Camelia

A NULL features is a driver bug. So i would prefer to solve this
differently.

Please make phy_driver_register() do a WARN_ON(!new_driver->features)
and return -EINVAL.

Do you know of a specific driver which as a NULL value? We should fix
that as well.

Thank
	Andrew
