Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB01C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B15208D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iouFstuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B15208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeHXRDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:03:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42250 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbeHXRDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=c0GKwGgJ1LlURubCzM2qWe06aj9h0nQD8eqwLckRuAg=;
        b=iouFstuWVNbtwgu9LEOicnQNhHGq6086muNjWjll7wQIwwpQ1KMGg5f4NB/VPB1q2mzDMa2HftqMDeuuKrNeZiC3Uutl0wY2KqUGgAXp3HGlSUK/ZCPPA/v6P+OQA71jH/KB7WeIchsYnCL1LC3REyffk4MPI2dE9o8GXPPKR+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftC93-0000cu-8h; Fri, 24 Aug 2018 15:28:57 +0200
Date:   Fri, 24 Aug 2018 15:28:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "lipeng (Y)" <lipeng321@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for
 1000M half
Message-ID: <20180824132857.GA1999@lunn.ch>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
 <20180824034119.GA29111@lunn.ch>
 <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:39:36PM +0800, lipeng (Y) wrote:
> 
> 
> On 2018/8/24 11:41, Andrew Lunn wrote:
> >On Fri, Aug 24, 2018 at 11:42:23AM +0800, Peng Li wrote:
> >>Hisilicon hip05 and hip06 board network card do not support
> >>1000M half configuration. Driver can not config gmac as
> >>1000M half.
> >>
> >>Signed-off-by: Peng Li <lipeng321@huawei.com>
> >Hi Peng
> >
> >Does the driver remove SUPPORTED_1000baseT_Half from
> >phydev->supported?  If you do that, the PHY should never negotiate
> >this speed.
> >
> >    Andrew
> Hi, Andrew,
> 
> The driver has removed SUPPORTED_1000baseT_Half from
> 
> phydev->supported.
> 
> the code is :
> #define MAC_GMAC_SUPPORTED \
> 	(SUPPORTED_10baseT_Half \
> 	| SUPPORTED_10baseT_Full \
> 	| SUPPORTED_100baseT_Half \
> 	| SUPPORTED_100baseT_Full \
> 	| SUPPORTED_Autoneg)
>  h->if_support = MAC_GMAC_SUPPORTED;
>  h->if_support |= SUPPORTED_1000baseT_Full;
> phydev->supported &= h->if_support;
> 
> As gmac do not support 1000M half, we add this patch to
> make sure that no users can set 1000M half in any case.

Well, not quite. What this patch does is protect the hardware when it
is asked to change to an unsupported mode. This patch has nothing to
do with user APIs.

The user API for setting link modes is hns_nic_set_link_ksettings().

What you do have is 

                if (speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
                        return -EINVAL;

which should stop somebody setting up a fixed speed link at 1000Half.

But you don't do anything with cmd->link_modes.advertising. However,
when you call phy_ethtool_ksettings_set(), it gets AND'ed with
phydev->supported, which you have already removed 1000Half from.

So is this a patch for a theoretical problem? Or have you seen it
happen? If it did happen, how did the user configure it to cause this
problem? That user API needs to prevent it.

	 Andrew
