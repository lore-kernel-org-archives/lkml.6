Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B120883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ep4AD88c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfARNWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:22:49 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60372 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfARNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:22:49 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 8956424E22F5;
        Fri, 18 Jan 2019 05:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547817768; bh=wuv6xVNTK0LxcNtfORDSZmilI4MQyhCJyxN2BTAkD/4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Ep4AD88cAQNzwMpDuk0npIRe51FjOmXWkpUC/myv9AgLN9TSL/IRoAH0YXUr7Ri2p
         78q/+HgLBGjsWdKVuPKd8VBgrgt3qBxp5QRzA6DcUoBEdlg9WffGCYdqT3JN0ew7uJ
         3nzBhlLjIZSoYJtYqFWzLYJpT0rJddc0SPgiGM/LQyViTr9x9N7qR2x843csXScSwa
         hY9Fo0f3WiIbAVwZslPdm9+l4heoI/mHUjLwPPtym6VvUicMW0jeo2NU9vVhToPSEG
         qaZFwTFQgC+IrTo6jwoNgFo+49nkCOUYaNZjK375Y+gBHSCg4TPAOv0HF4YnkWwu+1
         2aXc1W8+HUAIQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1EC0A00F9;
        Fri, 18 Jan 2019 13:22:47 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 18 Jan 2019 05:21:43 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 18 Jan 2019 14:21:40 +0100
Received: from [10.107.19.24] (10.107.19.24) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 18 Jan 2019 14:21:40 +0100
Subject: Re: [PATCH 1/1] net: stmmac: implement the SIOCGHWTSTAMP ioctl
To:     Artem Panfilov <panfilov.artyom@gmail.com>
CC:     Tema <panfilovartyom@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Jose Abreu" <jose.abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190117191536.24699-1-panfilov.artyom@gmail.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <c0404f52-e875-ffb4-dcf4-05b4b5c4579b@synopsys.com>
Date:   Fri, 18 Jan 2019 13:21:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117191536.24699-1-panfilov.artyom@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.24]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Artem,

Please specify in patch subject whether this is for -net or
-net-next. More comments inline.

On 1/17/2019 7:15 PM, Artem Panfilov wrote:
> From: Tema <panfilovartyom@gmail.com>
> 
> This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
> processes to read the current hwtstamp_config settings
> non-destructively.

I think you should only save the config structure *after*
validating the parameters. i.e. use a local config and save it in
priv only if ret == 0.

> 
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 77 ++++++++++++-------
>  2 files changed, 52 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 63e1064b27a2..f9b42b0c20f4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -28,6 +28,7 @@
>  #include <linux/pci.h>
>  #include "common.h"
>  #include <linux/ptp_clock_kernel.h>
> +#include <linux/net_tstamp.h>
>  #include <linux/reset.h>
>  
>  struct stmmac_resources {
> @@ -174,6 +175,7 @@ struct stmmac_priv {
>  	unsigned int mode;
>  	unsigned int chain_mode;
>  	int extend_desc;
> +	struct hwtstamp_config tstamp_config;
>  	struct ptp_clock *ptp_clock;
>  	struct ptp_clock_info ptp_clock_ops;
>  	unsigned int default_addend;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5afba69981cf..a6dc40a70428 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -534,7 +534,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>  }
>  
>  /**
> - *  stmmac_hwtstamp_ioctl - control hardware timestamping.
> + *  stmmac_hwtstamp_set - control hardware timestamping.
>   *  @dev: device pointer.
>   *  @ifr: An IOCTL specific structure, that can contain a pointer to
>   *  a proprietary structure used to pass information to the driver.
> @@ -544,10 +544,10 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>   *  Return Value:
>   *  0 on success and an appropriate -ve integer on failure.
>   */
> -static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
> +static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> -	struct hwtstamp_config config;
> +	struct hwtstamp_config *config =  &priv->tstamp_config;
>  	struct timespec64 now;
>  	u64 temp = 0;
>  	u32 ptp_v2 = 0;
> @@ -572,31 +572,31 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (copy_from_user(&config, ifr->ifr_data,
> +	if (copy_from_user(config, ifr->ifr_data,
>  			   sizeof(struct hwtstamp_config)))

Please use "sizeof(*config)" instead. It makes the code more
readable and occupy less characters.

>  		return -EFAULT;
>  
>  	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> -		   __func__, config.flags, config.tx_type, config.rx_filter);
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
>  
>  	/* reserved for future extensions */
> -	if (config.flags)
> +	if (config->flags)
>  		return -EINVAL;
>  
> -	if (config.tx_type != HWTSTAMP_TX_OFF &&
> -	    config.tx_type != HWTSTAMP_TX_ON)
> +	if (config->tx_type != HWTSTAMP_TX_OFF &&
> +	    config->tx_type != HWTSTAMP_TX_ON)
>  		return -ERANGE;
>  
>  	if (priv->adv_ts) {
> -		switch (config.rx_filter) {
> +		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:
>  			/* time stamp no incoming packet at all */
> -			config.rx_filter = HWTSTAMP_FILTER_NONE;
> +			config->rx_filter = HWTSTAMP_FILTER_NONE;
>  			break;
>  
>  		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>  			/* PTP v1, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>  			/* take time stamp for all event messages */
>  			if (xmac)
>  				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
> @@ -609,7 +609,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>  			/* PTP v1, UDP, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
>  			/* take time stamp for SYNC messages only */
>  			ts_event_en = PTP_TCR_TSEVNTENA;
>  
> @@ -619,7 +619,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>  			/* PTP v1, UDP, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
>  			/* take time stamp for Delay_Req messages only */
>  			ts_master_en = PTP_TCR_TSMSTRENA;
>  			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -630,7 +630,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>  			/* PTP v2, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for all event messages */
>  			if (xmac)
> @@ -644,7 +644,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>  			/* PTP v2, UDP, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for SYNC messages only */
>  			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -655,7 +655,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>  			/* PTP v2, UDP, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for Delay_Req messages only */
>  			ts_master_en = PTP_TCR_TSMSTRENA;
> @@ -667,7 +667,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_EVENT:
>  			/* PTP v2/802.AS1 any layer, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for all event messages */
>  			if (xmac)
> @@ -682,7 +682,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_SYNC:
>  			/* PTP v2/802.AS1, any layer, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for SYNC messages only */
>  			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -694,7 +694,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  
>  		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>  			/* PTP v2/802.AS1, any layer, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			/* take time stamp for Delay_Req messages only */
>  			ts_master_en = PTP_TCR_TSMSTRENA;
> @@ -708,7 +708,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  		case HWTSTAMP_FILTER_NTP_ALL:
>  		case HWTSTAMP_FILTER_ALL:
>  			/* time stamp any incoming packet */
> -			config.rx_filter = HWTSTAMP_FILTER_ALL;
> +			config->rx_filter = HWTSTAMP_FILTER_ALL;
>  			tstamp_all = PTP_TCR_TSENALL;
>  			break;
>  
> @@ -716,18 +716,18 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  			return -ERANGE;
>  		}
>  	} else {
> -		switch (config.rx_filter) {
> +		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:
> -			config.rx_filter = HWTSTAMP_FILTER_NONE;
> +			config->rx_filter = HWTSTAMP_FILTER_NONE;
>  			break;
>  		default:
>  			/* PTP v1, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>  			break;
>  		}
>  	}
> -	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
> -	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
> +	priv->hwts_rx_en = ((config->rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
> +	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
>  
>  	if (!priv->hwts_tx_en && !priv->hwts_rx_en)
>  		stmmac_config_hw_tstamping(priv, priv->ptpaddr, 0);
> @@ -765,7 +765,28 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
>  				(u32)now.tv_sec, now.tv_nsec);
>  	}
>  
> -	return copy_to_user(ifr->ifr_data, &config,
> +	return copy_to_user(ifr->ifr_data, config,
> +			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;

sizeof(*config) also.

> +}
> +
> +/**
> + *  stmmac_hwtstamp_get - read hardware timestamping.
> + *  @dev: device pointer.
> + *  @ifr: An IOCTL specific structure, that can contain a pointer to
> + *  a proprietary structure used to pass information to the driver.
> + *  Description:
> + *  This function obtain the current hardware timestamping settings
> +    as requested.
> + */
> +static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
> +{
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +	struct hwtstamp_config *config = &priv->tstamp_config;
> +
> +	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
> +		return -EOPNOTSUPP;
> +
> +	return copy_to_user(ifr->ifr_data, config,
>  			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;

sizeof(*config).

>  }
>  
> @@ -3767,7 +3788,9 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  		ret = phy_mii_ioctl(dev->phydev, rq, cmd);
>  		break;
>  	case SIOCSHWTSTAMP:
> -		ret = stmmac_hwtstamp_ioctl(dev, rq);
> +		ret = stmmac_hwtstamp_set(dev, rq);

Missing break.

Thanks,
Jose Miguel Abreu

> +	case SIOCGHWTSTAMP:
> +		ret = stmmac_hwtstamp_get(dev, rq);
>  		break;
>  	default:
>  		break;
> 
