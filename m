Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7200C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85C1208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85C1208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbeJAViL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:38:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34523 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbeJAViL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:38:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8CCA120A90; Mon,  1 Oct 2018 16:59:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5C455206FF;
        Mon,  1 Oct 2018 16:59:45 +0200 (CEST)
Date:   Mon, 1 Oct 2018 16:59:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
Message-ID: <20181001145946.GD2967@piout.net>
References: <20181001095714.26024-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181001095714.26024-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2018 11:57:14+0200, Antoine Ténart wrote:
> This patch adds support for the NETIF_F_RXFCS feature in the Mscc
> Ethernet driver. This feature is disabled by default and allow an user
> to request the driver not to drop the FCS and to extract it into the skb
> for debugging purposes.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/ethernet/mscc/ocelot.c       | 2 +-
>  drivers/net/ethernet/mscc/ocelot_board.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 1a4f2bb48ead..eb5119e7e60b 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -1606,7 +1606,7 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
>  	dev->ethtool_ops = &ocelot_ethtool_ops;
>  	dev->switchdev_ops = &ocelot_port_switchdev_ops;
>  
> -	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
>  	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  
>  	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index 3cdf63e35b53..245452a0f244 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -126,11 +126,16 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
>  			len += sz;
>  		} while (len < buf_len);
>  
> -		/* Read the FCS and discard it */
> +		/* Read the FCS */
>  		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
>  		/* Update the statistics if part of the FCS was read before */
>  		len -= ETH_FCS_LEN - sz;
>  
> +		if (unlikely(dev->features & NETIF_F_RXFCS)) {
> +			buf = (u32 *)skb_put(skb, ETH_FCS_LEN);
> +			*buf = val;
> +		}
> +
>  		if (sz < 0) {
>  			err = sz;
>  			break;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
