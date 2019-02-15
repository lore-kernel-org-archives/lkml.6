Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC1D2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WoDsiNTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBORGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:06:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37200 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBORGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dv7LtgPL2ZPfcYO9rJEvtn0Vb1HNklXbvnnueyU9Nt0=; b=WoDsiNTUeA7U8uDvyTpLnFPkb
        95nI1ZVIOhl3Kl3Ki50x8mzInXx80Mpd1A5BUG+6If5MJeMk/JhukwHg2jlGQfaimhPb/gtHXK3nP
        w3EsrTkamKrkRWvvOlHRa9C7DiK2tl4WCLoTpCpaMHClQJUliasuy6NNMFiUisHIWvTpLF4LeIK+f
        I5bPLXKokPFXsIz8p24ZgGrUdA5W5+lnXK7QfHUU4pPTr9+jveyZ1S1K585biZe6ozsD8WPMaQHPM
        iIUzKTPdZXnuyfJitsnNLTBeFBgRMpU0HebWEJxb+bje1v3wsfWavQM0c5F1jDq646lqAcnQtr4Rb
        v64GBASOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51136)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gugw0-0004EW-EU; Fri, 15 Feb 2019 17:05:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gugvx-0004jd-S8; Fri, 15 Feb 2019 17:05:53 +0000
Date:   Fri, 15 Feb 2019 17:05:53 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 01/13] net: mvpp2: do not call
 phylink_mac_change if there is no event
Message-ID: <20190215170553.ur725djxoudtnjne@shell.armlinux.org.uk>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-2-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215153241.6857-2-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:32:29PM +0100, Antoine Tenart wrote:
> This patch makes the link interrupt handler to avoid calling
> phylink_mac_change when there are no event.

The reasoning being?

> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index b42189260670..857b079f1a29 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -2477,14 +2477,14 @@ static irqreturn_t mvpp2_link_status_isr(int irq, void *dev_id)
>  		}
>  	}
>  
> +	if (!netif_running(dev) || !event)
> +		goto handled;
> +
>  	if (port->phylink) {
>  		phylink_mac_change(port->phylink, link);
>  		goto handled;
>  	}
>  
> -	if (!netif_running(dev) || !event)
> -		goto handled;
> -
>  	if (link) {
>  		mvpp2_interrupts_enable(port);
>  
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
