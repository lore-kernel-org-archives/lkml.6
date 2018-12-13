Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF915C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F420645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pkOwiKnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724F420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeLMMd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:33:56 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46301 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeLMMdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=UrmuoJqKFGKpV/RldOB6vPOUSOJxY3/IhP0qkRWMASc=;
        b=pkOwiKnl+wQK1hdyss1GUSqWvWEohA7LOnbMBxofBEJFY3c4MK35Om2k18keCGEASgHeENVy5bgewY54tx44jng0t16v9lzdDuxHyWVFKqDsbQ4XczNlw/qvStOo54UzFoxfv/h9IN5i9hNWBgSII4e7xHwAIb8Ghdsx2359lIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gXQBW-0002ps-G0; Thu, 13 Dec 2018 13:33:46 +0100
Date:   Thu, 13 Dec 2018 13:33:46 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        liguo.zhang@mediatek.com, mark.rutland@arm.com,
        nelson.chang@mediatek.com, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for
 mt2712
Message-ID: <20181213123346.GF1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biao

> +	case PHY_INTERFACE_MODE_RGMII:
> +		/* the PHY is not responsible for inserting any internal
> +		 * delay by itself in PHY_INTERFACE_MODE_RGMII case,
> +		 * so Ethernet MAC will insert delays for both transmit
> +		 * and receive path here.
> +		 */

What if the PCB designed has decided to do a kink in the clock to add
the delays? I don't think any of these delays should depend on the PHY
interface mode. It is up to the device tree writer to set both the PHY
delay and the MAC delay, based on knowledge of the board, including
any kicks in the tracks. The driver should then do what it is told.

> +	if (!of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps)) {
> +		if (tx_delay_ps < plat->variant->tx_delay_max) {
> +			mac_delay->tx_delay = tx_delay_ps;
> +		} else {
> +			dev_err(plat->dev, "Invalid TX clock delay: %dps\n", tx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps)) {
> +		if (rx_delay_ps < plat->variant->rx_delay_max) {
> +			mac_delay->rx_delay = rx_delay_ps;
> +		} else {
> +			dev_err(plat->dev, "Invalid RX clock delay: %dps\n", rx_delay_ps);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
> +	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> +	mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");

Why is fine tune needed? If the requested delay can be done using fine
tune, it should use fine tune. If not, it should use rough tune. The
driver can work this out itself.

       Thanks
	Andrew
