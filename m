Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44842C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AF32086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tq7fFjTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AF32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeKQKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:44:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38110 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQKok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Y7JSsbq0MZGpCQYQtsWxuLUSdYbZhK6iNVORXlOAYns=;
        b=Tq7fFjTapBUJ+38szHm3sMYmZ3zMOHj/zN/MJXa4QUeSOwB0+Ha9UixAf5LmFtBwekK6plFQEVJk5hLS6vPGpK180Ja2jkzuUYP5IS8vpdD99t7Cs5ziGV8DAjoUq2lmkYuEkO1GDraQKbN3vw9ji3uNZfESOY2cdwdk0hbgkH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNoUs-0000Yx-UJ; Sat, 17 Nov 2018 01:30:02 +0100
Date:   Sat, 17 Nov 2018 01:30:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru.marginean@nxp.com,
        catalin.horghidan@nxp.com
Subject: Re: [PATCH net-next 1/4] enetc: Introduce basic PF and VF ENETC
 ethernet drivers
Message-ID: <20181117003002.GC752@lunn.ch>
References: <1542298436-23422-1-git-send-email-claudiu.manoil@nxp.com>
 <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542298436-23422-2-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config FSL_ENETC
> +	tristate "ENETC PF driver"
> +	depends on PCI && PCI_MSI && ARCH_LAYERSCAPE

It would be good to add COMPILE_TEST.

> +	help
> +	  This driver supports NXP ENETC gigabit ethernet controller PCIe
> +	  physical function (PF) devices, managing ENETC Ports at a privileged
> +	  level.
> +
> +	  If compiled as module (M), the module name is fsl-enetc.
> +
> +config FSL_ENETC_VF
> +	tristate "ENETC VF driver"
> +	depends on PCI && PCI_MSI && ARCH_LAYERSCAPE

and here. 

> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/* Copyright 2017-2018 NXP */
> +
> +#include "enetc.h"
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/of_mdio.h>
> +
> +static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb);
> +static void enetc_unmap_tx_buff(struct enetc_bdr *tx_ring,
> +				struct enetc_tx_swbd *tx_swbd);
> +static int enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int budget);
> +
> +static struct sk_buff *enetc_map_rx_buff_to_skb(struct enetc_bdr *rx_ring,
> +						int i, u16 size);
> +static void enetc_add_rx_buff_to_skb(struct enetc_bdr *rx_ring, int i,
> +				     u16 size, struct sk_buff *skb);
> +static void enetc_process_skb(struct enetc_bdr *rx_ring, struct sk_buff *skb);
> +static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
> +			       struct napi_struct *napi, int work_limit);
> +

Please try to avoid forward declarations. Move the code around so you
don't need them.

> +static bool enetc_tx_csum(struct sk_buff *skb, union enetc_tx_bd *txbd)
> +{
> +	int l3_start, l3_hsize;
> +	u16 l3_flags, l4_flags;
> +
> +	if (skb->ip_summed != CHECKSUM_PARTIAL)
> +		return false;
> +
> +	switch (skb->csum_offset) {
> +	case offsetof(struct tcphdr, check):
> +		l4_flags = ENETC_TXBD_L4_TCP;
> +		break;
> +	case offsetof(struct udphdr, check):
> +		l4_flags = ENETC_TXBD_L4_UDP;
> +		break;
> +	default:
> +		skb_checksum_help(skb);
> +		return false;
> +	}
> +
> +	l3_start = skb_network_offset(skb);
> +	l3_hsize = skb_network_header_len(skb);
> +
> +	l3_flags = 0;
> +	if (skb->protocol == htons(ETH_P_IPV6))
> +		l3_flags = ENETC_TXBD_L3_IPV6;

Is there no need to do anything with IPv4?

> +
> +	/* write BD fields */
> +	txbd->l3_csoff = enetc_txbd_l3_csoff(l3_start, l3_hsize, l3_flags);
> +	txbd->l4_csoff = l4_flags;
> +
> +	return true;
> +}
> +
> +static int enetc_setup_irqs(struct enetc_ndev_priv *priv)
> +{
> +	struct pci_dev *pdev = priv->si->pdev;
> +	int i, j, err;
> +
> +	for (i = 0; i < priv->bdr_int_num; i++) {
> +		int irq = pci_irq_vector(pdev, ENETC_BDR_INT_BASE_IDX + i);
> +		struct enetc_int_vector *v = priv->int_vector[i];
> +		int entry = ENETC_BDR_INT_BASE_IDX + i;
> +		struct enetc_hw *hw = &priv->si->hw;
> +
> +		sprintf(v->name, "%s-rxtx%d", priv->ndev->name, i);

I would not be too surprised if static analyser people complain that
you can in theory overflow name. You might want to use snprintf() to
prevent this.

> +		err = request_irq(irq, enetc_msix, 0, v->name, v);
> +		if (err) {
> +			dev_err(priv->dev, "request_irq() failed!\n");
> +			goto irq_err;
> +		}
> +
> +		v->tbier_base = hw->reg + ENETC_BDR(TX, 0, ENETC_TBIER);
> +		v->rbier = hw->reg + ENETC_BDR(RX, i, ENETC_RBIER);
> +
> +		enetc_wr(hw, ENETC_SIMSIRRV(i), entry);
> +
> +		for (j = 0; j < v->count_tx_rings; j++) {
> +			int idx = v->tx_ring[j].index;
> +
> +			enetc_wr(hw, ENETC_SIMSITRV(idx), entry);
> +		}
> +	}
> +
> +	return 0;
> +
> +irq_err:
> +	while (i--)
> +		free_irq(pci_irq_vector(pdev, ENETC_BDR_INT_BASE_IDX + i),
> +			 priv->int_vector[i]);
> +
> +	return err;
> +}

> +static void adjust_link(struct net_device *ndev)
> +{
> +	struct phy_device *phydev = ndev->phydev;
> +
> +	phy_print_status(phydev);

You normally need more than that. Maybe later patches add to this?

> +static int enetc_phy_connect(struct net_device *ndev)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct phy_device *phydev;
> +
> +	if (!priv->phy_node)
> +		return 0; /* phy-less mode */

What are your user-cases for phy-less? If you don't have a PHY it is
mostly because you are connected to an Ethernet switch. In that case
you use fixed-link, which gives you a phy.

> +
> +	phydev = of_phy_connect(ndev, priv->phy_node, &adjust_link,
> +				0, priv->if_mode);
> +	if (!phydev) {
> +		dev_err(&ndev->dev, "could not attach to PHY\n");
> +		return -ENODEV;
> +	}
> +
> +	phy_attached_info(phydev);
> +
> +	return 0;
> +}
> +

> +int enetc_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	return -EINVAL;
> +}
> +

I think EOPNOTSUPP is more normal. But it should be O.K, to not have
an ioctl handler at all.

> +int enetc_pci_probe(struct pci_dev *pdev, const char *name, int sizeof_priv)
> +{
> +	struct enetc_si *si, *p;
> +	struct enetc_hw *hw;
> +	size_t alloc_size;
> +	int err, len;
> +
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "device enable failed\n");
> +		return err;
> +	}
> +
> +	/* set up for high or low dma */
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"DMA configuration failed: 0x%x\n", err);
> +			goto err_dma;
> +		}
> +	}

Humm, i thought drivers were not supposed to do this. The architecture
code should be setting masks. But i've not followed all those
conversations...

> +static int enetc_get_reglen(struct net_device *ndev)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_hw *hw = &priv->si->hw;
> +	int len;
> +
> +	len = ARRAY_SIZE(enetc_si_regs);
> +	len += ARRAY_SIZE(enetc_txbdr_regs) * priv->num_tx_rings;
> +	len += ARRAY_SIZE(enetc_rxbdr_regs) * priv->num_rx_rings;
> +
> +	if (hw->port)
> +		len += ARRAY_SIZE(enetc_port_regs);
> +
> +	len *= sizeof(u32) * 2; /* store 2 etries per reg: addr and value */

entries

> +
> +	return len;
> +}
> +

  Andrew
