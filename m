Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8FC2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cMZ4L+c/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8FC2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeJ2VQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:16:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45367 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeJ2VQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mlhFBjYEJ4qZFxhWGInYFWHCrWJV1KVxTy8D8wqdViw=;
        b=cMZ4L+c/xm2EOBX2HMdLcI/5dq53jaGs0zS9XZ2XO+IfSfW1zwHZPU2jgUBv1uUBUKXgHVNP7nDWhJsgKIUUuXpQKzhXKxYE0z0nIv9YjtXausEMFADIC6in2kdyH1Rc5rM32W+1PF9CQEeMBcQq9dbLlHE00F1kTFoWelcVsKw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gH6dn-0002Um-KL; Mon, 29 Oct 2018 13:27:31 +0100
Date:   Mon, 29 Oct 2018 13:27:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        sean.wang@mediatek.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
Message-ID: <20181029122731.GA9174@lunn.ch>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
 <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int mt2712_config_dt(struct mediatek_dwmac_plat_data *plat)
> +{
> +	u32 mac_timings[4];
> +
> +	plat->peri_regmap = syscon_regmap_lookup_by_compatible("mediatek,mt2712-pericfg");
> +	if (IS_ERR(plat->peri_regmap)) {
> +		dev_err(plat->dev, "Failed to get pericfg syscon\n");
> +		return PTR_ERR(plat->peri_regmap);
> +	}
> +
> +	if (!of_property_read_u32_array(plat->np, "mac-delay", mac_timings,
> +					ARRAY_SIZE(mac_timings))) {
> +		plat->mac_delay.tx_delay = mac_timings[0];
> +		plat->mac_delay.rx_delay = mac_timings[1];
> +		plat->mac_delay.tx_inv = mac_timings[2];
> +		plat->mac_delay.rx_inv = mac_timings[3];
> +	}
> +
> +	plat->fine_tune = of_property_read_bool(plat->np, "fine-tune");
> +
> +	plat->rmii_rxc = of_property_read_bool(plat->np, "rmii-rxc");

Please add document for these properties in the binding.

Ideally, you should reuse the binding that some of the other stmmac
glue layer uses. e.g. there is already allwinner,tx-delay-ps,
allwinner,rx-delay-ps.

       Thanks
              Andrew
