Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1351C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BD120831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sl20t1O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BD120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeKTBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:44:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40590 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbeKTBo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=tTPSbqk0TFAddQdHOQ4A4Zytx5Yn1KivqWYTQk/I+mc=;
        b=Sl20t1O88zCI2JZIh9Oz7NaMozm0CllbUcOZmTCdkDRblV4Gr7JWKOSxoT8grtLbVUsqsbi/Fzf/PNv/ZFsb9xm5DAApgwOWqq+1md/r2ZTw+UmFBP339fjFb3/bVYxoA4qwN4ukEBF/Lk5eh1fy9S48YtbQf4Y+w3J9Zcl18tg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOlLh-0007ii-Gl; Mon, 19 Nov 2018 16:20:29 +0100
Date:   Mon, 19 Nov 2018 16:20:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Catalin Horghidan <catalin.horghidan@nxp.com>
Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Message-ID: <20181119152029.GD26852@lunn.ch>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
 <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
 <20181117003002.GC752@lunn.ch>
 <VI1PR04MB48809F132A5DFFC71DA5F6BD96D80@VI1PR04MB4880.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB48809F132A5DFFC71DA5F6BD96D80@VI1PR04MB4880.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb);
> >> +static void enetc_unmap_tx_buff(struct enetc_bdr *tx_ring,
> >> +				struct enetc_tx_swbd *tx_swbd);
> >> +static int enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int budget);
> >> +
> >> +static struct sk_buff *enetc_map_rx_buff_to_skb(struct enetc_bdr *rx_ring,
> >> +						int i, u16 size);
> >> +static void enetc_add_rx_buff_to_skb(struct enetc_bdr *rx_ring, int i,
> >> +				     u16 size, struct sk_buff *skb);
> >> +static void enetc_process_skb(struct enetc_bdr *rx_ring, struct sk_buff *skb);
> >> +static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
> >> +			       struct napi_struct *napi, int work_limit);
> >> +
> >
> >Please try to avoid forward declarations. Move the code around so you
> >don't need them.
> >
> 
> Maybe I could drop some of these, but...
> For some performance critical functions on the datapath this would be an
> attempt to improve icache hit rate by having the caller function located in
> memory just before it's children (callees).

That is kind of the point of moving the functions. GCC can only inline
a function when it has already seen it, at least as far as i know. So
by having the functions in the correct order, you increase the
likelihood gcc inlines it, making the icache layout better, no
function calls, etc.

Try building the code both ways, and then disassemble it. See which
looks better.

> >> +static bool enetc_tx_csum(struct sk_buff *skb, union enetc_tx_bd *txbd)
> >> +{
> >> +	int l3_start, l3_hsize;
> >> +	u16 l3_flags, l4_flags;
> >> +
> >> +	if (skb->ip_summed != CHECKSUM_PARTIAL)
> >> +		return false;
> >> +
> >> +	switch (skb->csum_offset) {
> >> +	case offsetof(struct tcphdr, check):
> >> +		l4_flags = ENETC_TXBD_L4_TCP;
> >> +		break;
> >> +	case offsetof(struct udphdr, check):
> >> +		l4_flags = ENETC_TXBD_L4_UDP;
> >> +		break;
> >> +	default:
> >> +		skb_checksum_help(skb);
> >> +		return false;
> >> +	}
> >> +
> >> +	l3_start = skb_network_offset(skb);
> >> +	l3_hsize = skb_network_header_len(skb);
> >> +
> >> +	l3_flags = 0;
> >> +	if (skb->protocol == htons(ETH_P_IPV6))
> >> +		l3_flags = ENETC_TXBD_L3_IPV6;
> >
> >Is there no need to do anything with IPv4?
> >
> 
> No, 0 for this bit means IPv4. Only UDP and TCP over IPv4 and IPv6 supported.

Ah, O.K. Some i assume there is some way to tell it this is actually
an IP packet, not an IPX packet, etc.

> This code path is also reached by the VF driver (via the open() hook which is common to both
> PF and VF drivers, and VFs don't manage PHYs). 
> Also,  the driver may be exercised in MAC loopback mode (ethtool -K loopback on), when the
> PHY nodes are removed.  And it's always good to be able to run the driver on a simulator or
> an emulator without having to modify it.

O.K, that is fine.

> >> +int enetc_pci_probe(struct pci_dev *pdev, const char *name, int sizeof_priv)
> >> +{
> >> +	struct enetc_si *si, *p;
> >> +	struct enetc_hw *hw;
> >> +	size_t alloc_size;
> >> +	int err, len;
> >> +
> >> +	err = pci_enable_device_mem(pdev);
> >> +	if (err) {
> >> +		dev_err(&pdev->dev, "device enable failed\n");
> >> +		return err;
> >> +	}
> >> +
> >> +	/* set up for high or low dma */
> >> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >> +	if (err) {
> >> +		err = dma_set_mask_and_coherent(&pdev->dev,
> >DMA_BIT_MASK(32));
> >> +		if (err) {
> >> +			dev_err(&pdev->dev,
> >> +				"DMA configuration failed: 0x%x\n", err);
> >> +			goto err_dma;
> >> +		}
> >> +	}
> >
> >Humm, i thought drivers were not supposed to do this. The architecture
> >code should be setting masks. But i've not followed all those
> >conversations...
> >
> 
> Documentation/DMA-API-HOWTO.txt still states:
> " For correct operation, you must interrogate the kernel in your device
> probe routine to see if the DMA controller on the machine can properly
> support the DMA addressing limitation your device has.  It is good
> style to do this even if your device holds the default setting, [...]"

O.K, thanks for the reference.

     Andrew
