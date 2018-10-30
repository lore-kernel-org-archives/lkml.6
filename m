Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3137DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1D72082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D72082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJ3QE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:04:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:29191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726154AbeJ3QEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:04:25 -0400
X-UUID: 9c32585e50a5430fb9e55472fc83f575-20181030
X-UUID: 9c32585e50a5430fb9e55472fc83f575-20181030
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 825455708; Tue, 30 Oct 2018 15:11:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 30 Oct
 2018 15:11:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Oct 2018 15:11:52 +0800
Message-ID: <1540883512.26982.10.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>
Date:   Tue, 30 Oct 2018 15:11:52 +0800
In-Reply-To: <20181029122731.GA9174@lunn.ch>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
         <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
         <20181029122731.GA9174@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your kindly comments.
On Mon, 2018-10-29 at 13:27 +0100, Andrew Lunn wrote:
> > +static int mt2712_config_dt(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +	u32 mac_timings[4];
> > +
> > +	plat->peri_regmap = syscon_regmap_lookup_by_compatible("mediatek,mt2712-pericfg");
> > +	if (IS_ERR(plat->peri_regmap)) {
> > +		dev_err(plat->dev, "Failed to get pericfg syscon\n");
> > +		return PTR_ERR(plat->peri_regmap);
> > +	}
> > +
> > +	if (!of_property_read_u32_array(plat->np, "mac-delay", mac_timings,
> > +					ARRAY_SIZE(mac_timings))) {
> > +		plat->mac_delay.tx_delay = mac_timings[0];
> > +		plat->mac_delay.rx_delay = mac_timings[1];
> > +		plat->mac_delay.tx_inv = mac_timings[2];
> > +		plat->mac_delay.rx_inv = mac_timings[3];
> > +	}
> > +
> > +	plat->fine_tune = of_property_read_bool(plat->np, "fine-tune");
> > +
> > +	plat->rmii_rxc = of_property_read_bool(plat->np, "rmii-rxc");
> 
> Please add document for these properties in the binding.
ok, I forgot these properties.
> 
> Ideally, you should reuse the binding that some of the other stmmac
> glue layer uses. e.g. there is already allwinner,tx-delay-ps,
> allwinner,rx-delay-ps.
take it, seems that tx-delay/rx-delay will be more readable than
mac-delay in dts. will be changed in next patch.
> 
>        Thanks
>               Andrew


