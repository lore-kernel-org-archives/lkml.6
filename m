Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDB420857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBAEYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:24:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46140 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBAEYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:24:23 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gpQN9-0007Kv-U1; Fri, 01 Feb 2019 04:24:12 +0000
Date:   Fri, 1 Feb 2019 04:24:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mdio_bus: Fix PTR_ERR() usage after
 initialization to constant
Message-ID: <20190201042411.GM2217@ZenIV.linux.org.uk>
References: <20190128132409.17736-1-yuehaibing@huawei.com>
 <20190128143634.GF4765@lunn.ch>
 <eeb532d5-45a7-648f-f835-82448465762a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb532d5-45a7-648f-f835-82448465762a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:30:27AM +0800, YueHaibing wrote:
> >>  		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
> >>  					       "reset-gpios", 0, GPIOD_OUT_LOW,
> >>  					       "PHY reset");
> >> -	if (PTR_ERR(gpiod) == -ENOENT ||
> >> -	    PTR_ERR(gpiod) == -ENOSYS)
> >> -		gpiod = NULL;
> >> -	else if (IS_ERR(gpiod))
> >> -		return PTR_ERR(gpiod);
> >> +	if (IS_ERR(gpiod)) {
> >> +		ret = PTR_ERR(gpiod);
> >> +		if (ret == -ENOENT || ret == -ENOSYS)
> >> +			gpiod = NULL;
> >> +		else
> >> +			return ret;
> >> +	}

Rule of the thumb: PTR_ERR(p) == -E... is almost always better off
as p == ERR_PTR(-E...)
