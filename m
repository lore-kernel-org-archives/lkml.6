Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tad/gsN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeLKQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:37:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43558 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeLKQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i0Tb4T5hOwuBH0MhAO9p02a6+O9AC6bc2c+kU/cM4qY=; b=Tad/gsN/RgKrxCGwjJFZw+foQ
        xVUCGprIiqqdhLJGNF2PvDHDrhpN1lC+fwNPp6I6vX52BuslkRqXNX9zxb6rV5Qb6JuLKdzDJFMy8
        v+HUul30vgwSb519eQLkcmCFopE/hk+JdlCd9k8LCEK+frj6OUR6MVFVFzb8h/vaSfA9o=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:59334)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gWl1f-0007kp-O7; Tue, 11 Dec 2018 16:36:51 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gWl1W-0002GZ-Gg; Tue, 11 Dec 2018 16:36:42 +0000
Date:   Tue, 11 Dec 2018 16:36:36 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Message-ID: <20181211163635.GG30658@n2100.armlinux.org.uk>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211163228.26130-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:32:28PM +0100, Antoine Tenart wrote:
> The mvpp2_phylink_validate() function sets all modes that are
> supported by a given PPv2 port. A recent change made all ports to
> advertise they support 10G modes in certain cases. This is not true,
> as only the port #0 can do so. This patch fixes it.
> 
> Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 125ea99418df..88aa488054a8 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4405,12 +4405,14 @@ static void mvpp2_phylink_validate(struct net_device *dev,
>  	case PHY_INTERFACE_MODE_10GKR:
>  	case PHY_INTERFACE_MODE_XAUI:

Are these modes supported on anything except port 0?  If not, you
should be rejecting these, rather than just treating them as RGMII.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
