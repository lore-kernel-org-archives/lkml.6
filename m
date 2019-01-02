Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600AEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885E21907
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vTYj5zRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfABNRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:17:12 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60294 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfABNRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=CY1R7rVxOq1U5N7TLLqJmd8ody7iz3skUxcSMA/sf4c=;
        b=vTYj5zRIHBA2S4UzAPuS/948gS5WewFtoIcNsuu2CVIXtKAUbrWrgVo6zq+dD8OGTPESgDYLImO+wEl1yhXHuzOWqmlpPqCq1QItaux3Zj8R6cnD28bGIc1+0kJau5NCDlxaul4qM3liMwc4K6fQxQ4o1MO7CBKVw1SStpz3h2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gegOH-0008BP-89; Wed, 02 Jan 2019 14:16:57 +0100
Date:   Wed, 2 Jan 2019 14:16:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Murali Krishna Policharla <murali.policharla@broadcom.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, davem@davemloft.net,
        amritha.nambiar@intel.com, ecree@solarflare.com,
        ktkhai@virtuozzo.com, alexander.h.duyck@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Message-ID: <20190102131657.GE22737@lunn.ch>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <20190101083450.GA17613@lunn.ch>
 <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
 <20190101232443.GA22737@lunn.ch>
 <b6ff97415cd415614393e35793972ccc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ff97415cd415614393e35793972ccc@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew/Heiner
> 
>                                        Thanks for the feedback. This patch
> fixes a case where ndo_change_mtu function is provided but the callback
> function is not storing mtu to netdevice structure.

Hi Murali

At the moment, any driver which implements ndo_change_mtu MUST set
ndev->mtu. It is a nice clean definition, easy for any driver write to
understand.

What you are proposing is that the core will set ndev->mtu. That is
fine, but again we need a nice clean definition. The drivers MUST NOT
set ndev->mtu.

If you plan to make this core change, please also change all the
drivers as well, so we have very clear semantics of what is expected.

It would also be good to extend the comment in include/linux/netdevice.h:

 * int (*ndo_change_mtu)(struct net_device *dev, int new_mtu);
 *      Called when a user wants to change the Maximum Transfer Unit
 *      of a device.

Adding something like: Should only program the hardware with the new MTU.

To give the hint that the core is doing all the validation and
modifying ndev->mtu.

I had one other thought. Please also take a look at how stacked
devices work. I've not looked, but i expect there are cases where a
lower device calls into an upper device to inform it the MTU has
changed. When does this call happen? Does the MTU of the lower device
need to of already changed before this call is made? Are there similar
cases of an upper device calling down to the lower device? You need to
be careful here, you are changing exactly when the ndev->mtu value
changes, and so could be introducing bugs if you don't do a proper
code review.

	  Andrew
