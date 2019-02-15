Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F89C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE34B2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H2KM1Vsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfBORMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:12:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37324 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfBORMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Iz+nfd7FPuznHeYf8X10n/rCEH6/CYwMozxzU8KFc0=; b=H2KM1Vsyj+uUoS402LlIVp8SC
        4YABC15MLkKk3dyPkM2XJie0pq2UefEQkETp3VQl550Hri/bbn/5RCd5aLNleuM10pw+c8bjMl1a+
        iPhvPK89uFHBHdsk7Xs4jV4jNRMRDG58V+yx9TsqF9y0U+RPcz/ZT32WXtOyahf4/PFxUyMDhp3W8
        icuSxBV2M08HpsUi/n5+h890VMAWffNAyOrbdtf1OY9TRxZOaLuMwcpZU2OiQcsS7qT5D0vEAOtP2
        sbt9F7EYHjhSPwrXkkKS2Fn3c//sprUE/9ByNYc9O8WwUIDVt6Fpe5/z6bZNBuQnrafbT3d7VSgPo
        h5mLA9x9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51138)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1guh2J-0004HA-PZ; Fri, 15 Feb 2019 17:12:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1guh2G-0004ke-VD; Fri, 15 Feb 2019 17:12:24 +0000
Date:   Fri, 15 Feb 2019 17:12:24 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 10/13] net: mvpp2: reset the XPCS while
 reconfiguring the serdes lanes
Message-ID: <20190215171224.sjfrid5csseywuks@shell.armlinux.org.uk>
References: <20190215153241.6857-1-antoine.tenart@bootlin.com>
 <20190215153241.6857-11-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215153241.6857-11-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:32:38PM +0100, Antoine Tenart wrote:
> The documentation advises to set the XPCS in reset while reconfiguring
> the serdes lanes. This seems to be a good thing to do, but the PPv2
> driver wasn't doing it. This patch fixes it.

Hmm.  That statment seems to have some ambiguity in it - we do two
"reconfigurations" - one may be upon initialisation, where the lane
is already configured for 10Gbase-KR, and we're re-initialising it
for the same mode.  The other case is when we're switching between
10Gbase-KR and SGMII, or as will be the case with 2.5G support for
the Alaska PHYs, 2500base-X.

Does this apply to reconfiguration of the serdes lane between
10Gbase-KR and slower modes?

> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 1 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 21ddcac1ceea..7380bddc53b8 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -481,6 +481,7 @@
>  /* XPCS registers. PPv2.2 only */
>  #define MVPP22_XPCS_BASE(port)			(0x7400 + (port) * 0x1000)
>  #define MVPP22_XPCS_CFG0			0x0
> +#define     MVPP22_XPCS_CFG0_RESET_DIS		BIT(0)
>  #define     MVPP22_XPCS_CFG0_PCS_MODE(n)	((n) << 3)
>  #define     MVPP22_XPCS_CFG0_ACTIVE_LANE(n)	((n) << 5)
>  
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 4a18f8e54c90..5d05306e79a8 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1016,13 +1016,19 @@ static void mvpp22_gop_init_10gkr(struct mvpp2_port *port)
>  	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
>  	u32 val;
>  
> -	/* XPCS */
> +	/* XPCS : Reset the XPCS when reconfiguring the lanes */
> +	val = readl(xpcs + MVPP22_XPCS_CFG0);
> +	writel(val & ~MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
> +
>  	val = readl(xpcs + MVPP22_XPCS_CFG0);
>  	val &= ~(MVPP22_XPCS_CFG0_PCS_MODE(0x3) |
>  		 MVPP22_XPCS_CFG0_ACTIVE_LANE(0x3));
>  	val |= MVPP22_XPCS_CFG0_ACTIVE_LANE(2);
>  	writel(val, xpcs + MVPP22_XPCS_CFG0);
>  
> +	val = readl(xpcs + MVPP22_XPCS_CFG0);
> +	writel(val | MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
> +
>  	/* MPCS */
>  	val = readl(mpcs + MVPP22_MPCS_CTRL);
>  	val &= ~MVPP22_MPCS_CTRL_FWD_ERR_CONN;
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
