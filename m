Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4FEC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB852080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB852080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeLNDB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:01:27 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34294 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726453AbeLNDB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:01:27 -0500
X-UUID: 668773d20f06480fbc8b31b94cf94e2d-20181214
X-UUID: 668773d20f06480fbc8b31b94cf94e2d-20181214
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 342136261; Fri, 14 Dec 2018 11:01:19 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 11:01:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 11:01:17 +0800
Message-ID: <1544756477.24219.164.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for
 mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <nelson.chang@mediatek.com>, <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>
Date:   Fri, 14 Dec 2018 11:01:17 +0800
In-Reply-To: <20181213123346.GF1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
         <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
         <20181213123346.GF1605@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,
	Thanks for your comments.

On Thu, 2018-12-13 at 13:33 +0100, Andrew Lunn wrote:
> Hi Biao
> 
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +		/* the PHY is not responsible for inserting any internal
> > +		 * delay by itself in PHY_INTERFACE_MODE_RGMII case,
> > +		 * so Ethernet MAC will insert delays for both transmit
> > +		 * and receive path here.
> > +		 */
> 
> What if the PCB designed has decided to do a kink in the clock to add
> the delays? I don't think any of these delays should depend on the PHY
> interface mode. It is up to the device tree writer to set both the PHY
> delay and the MAC delay, based on knowledge of the board, including
> any kicks in the tracks. The driver should then do what it is told.
> 
Originally, we recommend equal trace length on PCB, which means that
RGMII delay by PCB traces is not recommended. so only PHY/MAC delay is
taken into account in the transmit/receive path.

as you described above, maybe the equal PCB trace length assumption is
not reasonable, and we'll only handle MAC delay-ps in our driver based
on the device tree information no matter which rgmii is selected.

Since David already applied this patch, I'll send another patch to fix
this issue.
> > +	if (!of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps)) {
> > +		if (tx_delay_ps < plat->variant->tx_delay_max) {
> > +			mac_delay->tx_delay = tx_delay_ps;
> > +		} else {
> > +			dev_err(plat->dev, "Invalid TX clock delay: %dps\n", tx_delay_ps);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	if (!of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps)) {
> > +		if (rx_delay_ps < plat->variant->rx_delay_max) {
> > +			mac_delay->rx_delay = rx_delay_ps;
> > +		} else {
> > +			dev_err(plat->dev, "Invalid RX clock delay: %dps\n", rx_delay_ps);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
> > +	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> > +	mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
> 
> Why is fine tune needed? If the requested delay can be done using fine
> tune, it should use fine tune. If not, it should use rough tune. The
> driver can work this out itself.

find tune here represents a more accurate delay circuit than coarse
tune, and it's a parallel circuit of coarse tune.
For most delay, both fine and coarse tune can meet the requirement.
It's up to the user to select which one.

But only one of them can work at the same time, so we need a switch
flag(fine_tune here) to indicate which one is valid.
Driver can hardly work out which one is working according to delay-ps.

Please correct me if any misunderstanding.

> 
>        Thanks
> 	Andrew


