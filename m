Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DB9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eAk6Whgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBC92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeLKSwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:52:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45246 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeLKSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eBoBIBoRrHRYuOOgMw9n2Hqx0rIngU7nMXfR6hoP2bs=; b=eAk6Whgz68y96T21vvB7GB8zt
        bl/0bFzg/eK780cco2XZfeGAb9qqYOX/x9cZRaIb3WBBAXx3PfEor6GbCbF6WRDFgXL7vSu2/BTiQ
        KUFPTS7KFfJi073MY4A+I+kO3x1GsqCTcvzdZ7N7vjp1TgHBkQNssIUxN2CmE+i6wRMng=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60956)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gWn8T-0008S5-Do; Tue, 11 Dec 2018 18:52:01 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gWn8Q-0003nl-AB; Tue, 11 Dec 2018 18:51:58 +0000
Date:   Tue, 11 Dec 2018 18:51:56 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: 10G modes aren't supported on all ports
Message-ID: <20181211185156.GH30658@n2100.armlinux.org.uk>
References: <20181211163228.26130-1-antoine.tenart@bootlin.com>
 <20181211163635.GG30658@n2100.armlinux.org.uk>
 <877egg6jbt.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877egg6jbt.fsf@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 07:53:42PM +0200, Baruch Siach wrote:
> That is, something like this, right?
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 125ea99418df..04cb0241ca2b 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4404,13 +4404,18 @@ static void mvpp2_phylink_validate(struct net_device *dev,
>  	switch (state->interface) {
>  	case PHY_INTERFACE_MODE_10GKR:
>  	case PHY_INTERFACE_MODE_XAUI:
> +		if (port->gop_id != 0)
> +			goto empty_set;
> +		/* Fall-through */
>  	case PHY_INTERFACE_MODE_NA:
> -		phylink_set(mask, 10000baseCR_Full);
> -		phylink_set(mask, 10000baseSR_Full);
> -		phylink_set(mask, 10000baseLR_Full);
> -		phylink_set(mask, 10000baseLRM_Full);
> -		phylink_set(mask, 10000baseER_Full);
> -		phylink_set(mask, 10000baseKR_Full);
> +		if (port->gop_id == 0) {
> +			phylink_set(mask, 10000baseCR_Full);
> +			phylink_set(mask, 10000baseSR_Full);
> +			phylink_set(mask, 10000baseLR_Full);
> +			phylink_set(mask, 10000baseLRM_Full);
> +			phylink_set(mask, 10000baseER_Full);
> +			phylink_set(mask, 10000baseKR_Full);
> +		}
>  		/* Fall-through */
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> 

Yep, looks fine to me, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
