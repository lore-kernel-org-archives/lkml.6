Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19042C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E2A20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n48sKoTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E2A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbeGZUpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:45:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47694 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbeGZUpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=n1Ds1kRmOLpQCbXRs6qD02lDHBfSFwSdJMg7LzarIZo=;
        b=n48sKoTNcPCPqbyafK8sNAubiT3lL1dsvg1/SIjQ0I2xeQZfLXsINKs+L5f8l/B8+lCtrVQVa1bqSbpSf8vb8RRmeFnieoOCleINehZqTNCBJEjdpswJ/K0i7zO8zPSJNinfrs3LgtWU9LaJjavWDMFiEjgeQ52aCO37UkIlY/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1filuV-0005Yt-3e; Thu, 26 Jul 2018 21:26:51 +0200
Date:   Thu, 26 Jul 2018 21:26:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 5/7] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
Message-ID: <20180726192651.GK10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532630184-29450-6-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
> +{
> +	u32 val;
> +	u32 divisor;
> +
> +	if (md->core_clk) {
> +		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;

/**
 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 * 		  This is only valid once the clock source has been enabled.
 * @clk: clock source
 */
unsigned long clk_get_rate(struct clk *clk);

It is generally good practice to call clk_prepare_enable() sometime
before clk_get_rate() to ensure the clock is ticking, and to show this
driver is making use of the clock, so it does not get turned off.

> +		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
> +		val = divisor;
> +		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
> +		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
> +		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
> +	}
> +}
