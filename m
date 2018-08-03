Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D77C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFC321774
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ggtKs7pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFC321774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:39:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55064 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbeHCSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=xK22qJ3f5vBwv4zhi/TFCAzXLgiX15hgbETSFVJLkRY=;
        b=ggtKs7pl/GN7QIpG+ECbhyuxNOAL8SruhpxcxPxrs3wMdnBFYeUQvNTtqePiREPIqI++L3UFEOXI3SpR10UQ8Y8C8YtuzVWENQbq5Lw+huELpm6XgLroC5KmNo57PyV+dtBQbVox7vz6nt+3RX+Ls0dkb/JGNPhE4aESNC4gfo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fld9z-00007U-1U; Fri, 03 Aug 2018 18:42:39 +0200
Date:   Fri, 3 Aug 2018 18:42:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ioana.ciornei@nxp.com,
        laurentiu.tudor@nxp.com, madalin.bucur@nxp.com,
        horia.geanta@nxp.com
Subject: Re: [PATCH net-next] [RFC] dpaa2-eth: Move DPAA2 Ethernet driver
 from staging to drivers/net
Message-ID: <20180803164239.GG15029@lunn.ch>
References: <20180803161221.6322-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803161221.6322-1-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
> +{
> +	struct device *dev;
> +	struct net_device *net_dev = NULL;
> +	struct dpaa2_eth_priv *priv = NULL;
> +	int err = 0;
> +
> +	dev = &dpni_dev->dev;
> +
> +	/* Net device */
> +	net_dev = alloc_etherdev_mq(sizeof(*priv), DPAA2_ETH_MAX_TX_QUEUES);
> +	if (!net_dev) {
> +		dev_err(dev, "alloc_etherdev_mq() failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	SET_NETDEV_DEV(net_dev, dev);
> +	dev_set_drvdata(dev, net_dev);
> +
> +	priv = netdev_priv(net_dev);
> +	priv->net_dev = net_dev;
> +
> +	priv->iommu_domain = iommu_get_domain_for_dev(dev);
> +
> +	/* Obtain a MC portal */
> +	err = fsl_mc_portal_allocate(dpni_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> +				     &priv->mc_io);
> +	if (err) {
> +		if (err == -ENXIO)
> +			err = -EPROBE_DEFER;
> +		else
> +			dev_err(dev, "MC portal allocation failed\n");
> +		goto err_portal_alloc;
> +	}
> +
> +	/* MC objects initialization and configuration */
> +	err = setup_dpni(dpni_dev);
> +	if (err)
> +		goto err_dpni_setup;
> +
> +	err = setup_dpio(priv);
> +	if (err)
> +		goto err_dpio_setup;
> +
> +	setup_fqs(priv);
> +
> +	err = setup_dpbp(priv);
> +	if (err)
> +		goto err_dpbp_setup;
> +
> +	err = bind_dpni(priv);
> +	if (err)
> +		goto err_bind;
> +
> +	/* Add a NAPI context for each channel */
> +	add_ch_napi(priv);
> +
> +	/* Percpu statistics */
> +	priv->percpu_stats = alloc_percpu(*priv->percpu_stats);
> +	if (!priv->percpu_stats) {
> +		dev_err(dev, "alloc_percpu(percpu_stats) failed\n");
> +		err = -ENOMEM;
> +		goto err_alloc_percpu_stats;
> +	}
> +	priv->percpu_extras = alloc_percpu(*priv->percpu_extras);
> +	if (!priv->percpu_extras) {
> +		dev_err(dev, "alloc_percpu(percpu_extras) failed\n");
> +		err = -ENOMEM;
> +		goto err_alloc_percpu_extras;
> +	}
> +
> +	err = netdev_init(net_dev);
> +	if (err)
> +		goto err_netdev_init;

At the end of netdev_init() you call netdev_register(). From that
point on, you device is live. Its .ndo's can be called....

> +
> +	/* Configure checksum offload based on current interface flags */
> +	err = set_rx_csum(priv, !!(net_dev->features & NETIF_F_RXCSUM));
> +	if (err)
> +		goto err_csum;
> +
> +	err = set_tx_csum(priv, !!(net_dev->features &
> +				   (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)));
> +	if (err)
> +		goto err_csum;
> +
> +	err = alloc_rings(priv);
> +	if (err)
> +		goto err_alloc_rings;

How well does the device work if it has not allocated the rings yet,
when it is asked to do something?

> +
> +	net_dev->ethtool_ops = &dpaa2_ethtool_ops;
> +
> +	err = setup_irqs(dpni_dev);

How well do it work without interrupts being set up?

> +	if (err) {
> +		netdev_warn(net_dev, "Failed to set link interrupt, fall back to polling\n");
> +		priv->poll_thread = kthread_run(poll_link_state, priv,
> +						"%s_poll_link", net_dev->name);
> +		if (IS_ERR(priv->poll_thread)) {
> +			netdev_err(net_dev, "Error starting polling thread\n");
> +			goto err_poll_thread;
> +		}
> +		priv->do_link_poll = true;
> +	}

Probably the correct place to register the netdev is here.

	 Andrew
