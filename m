Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63CB20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZAZeEI+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63CB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeK1Uji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:39:38 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59698 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeK1Uji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:39:38 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7DB2124E1ECC;
        Wed, 28 Nov 2018 01:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543397917; bh=ZJ6MuWitLQAt71zByfOaNQaDK5Vv61OzwMKAH8+1A80=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=ZAZeEI+0OhI56e7Z101x0H7j8BOm0MgSaQKORt0a4hWFNzYXaAop0otCvqMuO/2RR
         c5Zc1QpFDt+mUHQpCwct+IpnOafJKXD+Kr2Pzw0vm5v7zc3aeJwRIhaKQ39ZvbxwM/
         OY0Ny/NsMEW5jjDzA9my6I6qCdcbQ/TARvwv5E8Uzb0JVRYn3zDuE0iavxFF3l2jPI
         jIatVq+tWRYWWfFxU/FExAy/R65bZGtOjMdgGeR0grSw5BB4nZiGEbvuZaglWrKVIt
         Ntg4UQS2CtEz2oQrTfuFoEsK15eAAMbmAWr8ckQDTUwPkFH19r5nnumHpj853jDHFS
         2drPVW8o60AMw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 23F3B5839;
        Wed, 28 Nov 2018 01:38:37 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 28 Nov 2018 01:38:37 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 28 Nov 2018 10:38:34 +0100
Received: from [10.0.2.15] (10.107.19.26) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 28 Nov
 2018 10:38:34 +0100
Subject: Re: [PATCH v2] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
To:     Thierry Reding <thierry.reding@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <20181127132143.10473-1-thierry.reding@gmail.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <jose.abreu@synopsys.com>, <netdev@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <316d6a25-cb61-32d8-9792-8ffcc2122d8a@synopsys.com>
Date:   Wed, 28 Nov 2018 09:38:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181127132143.10473-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.26]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-2018 13:21, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Setting up and tearing down debugfs is current unbalanced, as seen by
> this error during resume from suspend:
>
>     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
>     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration
>
> The imbalance happens because the driver creates the debugfs hierarchy
> when the device is opened and tears it down when the device is closed.
> There's little gain in that, and it could be argued that it is even
> surprising because it's not usually done for other devices. Fix the
> imbalance by moving the debugfs creation and teardown to the driver's
> ->probe() and ->remove() implementations instead.
>
> Note that the ring descriptors cannot be read while the interface is
> down, so make sure to return an empty file when the descriptors_status
> debugfs file is read.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This applies on top of net-next.
>
> Changes in v2:
> - avoid access to ring descriptors when interface is down
>
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 076a8be18d67..5551fead8f66 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2550,12 +2550,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
>  			netdev_warn(priv->dev, "PTP init failed\n");
>  	}
>  
> -#ifdef CONFIG_DEBUG_FS
> -	ret = stmmac_init_fs(dev);
> -	if (ret < 0)
> -		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
> -			    __func__);
> -#endif
>  	priv->tx_lpi_timer = STMMAC_DEFAULT_TWT_LS;
>  
>  	if (priv->use_riwt) {
> @@ -2756,10 +2750,6 @@ static int stmmac_release(struct net_device *dev)
>  
>  	netif_carrier_off(dev);
>  
> -#ifdef CONFIG_DEBUG_FS
> -	stmmac_exit_fs(dev);
> -#endif
> -
>  	stmmac_release_ptp(priv);
>  
>  	return 0;
> @@ -3899,6 +3889,9 @@ static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
>  	u32 tx_count = priv->plat->tx_queues_to_use;
>  	u32 queue;
>  
> +	if ((dev->flags & IFF_UP) == 0)

I tried looking for an helper to check if interface is open but
couldn't find one so I guess this is the right thing to do.

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks and Best Regards,
Jose Miguel Abreu

> +		return 0;
> +
>  	for (queue = 0; queue < rx_count; queue++) {
>  		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
>  
> @@ -4397,6 +4390,13 @@ int stmmac_dvr_probe(struct device *device,
>  		goto error_netdev_register;
>  	}
>  
> +#ifdef CONFIG_DEBUG_FS
> +	ret = stmmac_init_fs(ndev);
> +	if (ret < 0)
> +		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
> +			    __func__);
> +#endif
> +
>  	return ret;
>  
>  error_netdev_register:
> @@ -4432,6 +4432,9 @@ int stmmac_dvr_remove(struct device *dev)
>  
>  	netdev_info(priv->dev, "%s: removing driver", __func__);
>  
> +#ifdef CONFIG_DEBUG_FS
> +	stmmac_exit_fs(ndev);
> +#endif
>  	stmmac_stop_all_dma(priv);
>  
>  	stmmac_mac_set(priv, priv->ioaddr, false);

