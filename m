Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB215C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9753205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6uvh3es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAQBRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:17:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46087 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfAQBRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ec9bbF8OL5VY7UwciWCsOzol94m4fzB9Wgbp8k+25c8=;
        b=M6uvh3esomrz1fZgWOgwkOBV9danA9pHxvDErnZu4+OswQiPOzR3zPZ135/WMYJ3ByGzwViFTM0MUpZ9PnCZrW+W3GVZAz5B3PrTzCergKNeaLDK2ZBpEPGSflWKwsAAZXuLTpyzg4gAMlJbSU1nF5d8YGT2gwaGufgzaRJ1P1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjwIw-00049I-5a; Thu, 17 Jan 2019 02:17:10 +0100
Date:   Thu, 17 Jan 2019 02:17:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Message-ID: <20190117011710.GI24870@lunn.ch>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
 <20190115230613.28334-2-f.fainelli@gmail.com>
 <20190116222937.GR29244@lunn.ch>
 <6f593b8b-5bb7-f884-d1d6-d509fd794419@gmail.com>
 <1a738e85-6a35-5cb3-3069-8d876724b716@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a738e85-6a35-5cb3-3069-8d876724b716@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:50:44PM -0800, Florian Fainelli wrote:
> On 1/16/19 3:06 PM, Florian Fainelli wrote:
> > On 1/16/19 2:29 PM, Andrew Lunn wrote:
> >>> diff --git a/include/net/dsa.h b/include/net/dsa.h
> >>> index b3eefe8e18fd..6178b648d08a 100644
> >>> --- a/include/net/dsa.h
> >>> +++ b/include/net/dsa.h
> >>> @@ -21,6 +21,7 @@
> >>>  #include <linux/ethtool.h>
> >>>  #include <linux/net_tstamp.h>
> >>>  #include <linux/phy.h>
> >>> +#include <linux/platform_data/dsa.h>
> >>>  #include <net/devlink.h>
> >>>  #include <net/switchdev.h>
> >>
> >> Hi Florian
> >>
> >> Could there be one more patch at the end which removes this?  I think
> >> it is here just as an intermediary step?
> > 
> > Yes, we can have only dsa2.c and legacy.c include that file from there
> > on, I will resubmit with that change, thanks!
> 
> We actually need to keep that include in there, because we use
> DSA_MAX_SWITCHES in net/dsa.h and splitting that define away could be a
> bit tedious since it is used by dsa_platform_data which was exposed before.

Hi Florian

O.K, so lets keep the patchset as it is.

Thanks
	Andrew
