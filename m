Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BA520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p8DXKR64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BA520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGZUe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:34:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47651 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbeGZUe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FfIm3EGN80aIQEswZWoeOYgZBtilNtr7DfNX//kVTYI=;
        b=p8DXKR64SVrK+haxElzLH0WR4ZlLYIel5lS7ebGhaZKRyr/bk/eGatfN8l2DoEtHJ8TAVNP4qpC7MsVOiOzldPE1nc0WQ/yZ29eWUc6PFdjGgrPCiT+e1UeeVUZGL9eljuff7pMFdco6rvZBVXbZeN2CLPSbGsmXXg5gdTmSoyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1filkb-0005HY-92; Thu, 26 Jul 2018 21:16:37 +0200
Date:   Thu, 26 Jul 2018 21:16:37 +0200
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
Subject: Re: [PATCH 6/7] net: phy: Add pm support to Broadcom iProc mdio mux
 driver
Message-ID: <20180726191637.GI10686@lunn.ch>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:36:23AM -0700, Arun Parameswaran wrote:
> Add support for suspend and resume to the Broadcom iProc mdio
> mux driver.

> +#ifdef CONFIG_PM_SLEEP
> +static int mdio_mux_iproc_suspend(struct device *dev)
> +{
> +	int i;
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
> +		md->restore_regs[i] = readl(md->base +
> +					    restore_reg_offsets[i]);
> +
> +	return 0;
> +}
> +
> +static int mdio_mux_iproc_resume(struct device *dev)
> +{
> +	int i;
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
> +		writel(md->restore_regs[i],
> +		       md->base + restore_reg_offsets[i]);
> +
> +	return 0;
> +}

Hi Arun

Would it not be simpler to just call mdio_mux_iproc_config_clk() on
resume?

	Andrew
