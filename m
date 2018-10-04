Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFECC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612B42082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ua8MR0q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612B42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJDWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:16:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53857 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeJDWQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tgpXLdfLLG4hLj1cneF7OCFoP4BlAXy1rzfT9rCcAUY=;
        b=Ua8MR0q+ocXQgkjGu6JI8BMPO2lKFIYD+Puq08S3QexImnC5+7zQmIMu8ron0OQCXt8EVnqoBbp62FFT/MrbjUnIdAoAkR9HWa2jPVQ1UWL+pHdLXWRJYPGAoN0jJkJrBY3zPZBAylA51OXEpuZEb9YLTkq/efenPUv6gjMbUbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g85SX-0007HT-P4; Thu, 04 Oct 2018 17:22:37 +0200
Date:   Thu, 4 Oct 2018 17:22:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next v2 2/6] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20181004152237.GF4730@lunn.ch>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
 <20181004124728.9821-3-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004124728.9821-3-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:47:24PM +0200, Quentin Schulz wrote:

Hi Quentin

> +static u64 vsc85xx_get_stat(struct phy_device *phydev, int i)
> +{
> +	struct vsc8531_private *priv = phydev->priv;
> +	int val, oldpage;
> +	u64 ret;
> +
> +	oldpage = phy_select_page(phydev, priv->hw_stats[i].page);
> +
> +	val = __phy_read(phydev, priv->hw_stats[i].reg);
> +	if (val < 0) {
> +		ret = U64_MAX;
> +		goto out;
> +	}

phy_read_paged() should work here as well.

> +
> +	val = val & priv->hw_stats[i].mask;
> +	priv->stats[i] += val;
> +	ret = priv->stats[i];

Otherwise this looks good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
