Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38538C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF41120843
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF41120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeH2NBm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:01:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44888 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbeH2NBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:01:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EB336206F6; Wed, 29 Aug 2018 11:05:45 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD691207B1;
        Wed, 29 Aug 2018 11:05:45 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] net: mvneta: fix rx_offset_correction set and usage
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162706.24111f9c@xhacker.debian>
Date:   Wed, 29 Aug 2018 11:05:45 +0200
In-Reply-To: <20180829162706.24111f9c@xhacker.debian> (Jisheng Zhang's message
        of "Wed, 29 Aug 2018 16:27:06 +0800")
Message-ID: <87efehk0eu.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,
 
 On mer., août 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> The rx_offset_correction is RX packet offset correction for platforms,
> it's not related with SW BM, instead, it's only related with the
> platform's NET_SKB_PAD.
>

But if I undrestood well, the value of rx_offset_correction has an
influence only when we use HW BM.

However since d93277b9839b ("Revert "arm64: Increase the max granular
size""), NET_SKB_PAD is 64 for arm64, so in the end rx_offset_correction
is always 0 for recent kernels.

Gregory


> Fix the issue by reverting to the original behavior.
>
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index bc80a678abc3..0ce94f6587a5 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2899,21 +2899,18 @@ static void mvneta_rxq_hw_init(struct mvneta_port *pp,
>  	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
>  	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
>  
> +	/* Set Offset */
> +	mvneta_rxq_offset_set(pp, rxq, NET_SKB_PAD - pp->rx_offset_correction);
> +
>  	/* Set coalescing pkts and time */
>  	mvneta_rx_pkts_coal_set(pp, rxq, rxq->pkts_coal);
>  	mvneta_rx_time_coal_set(pp, rxq, rxq->time_coal);
>  
>  	if (!pp->bm_priv) {
> -		/* Set Offset */
> -		mvneta_rxq_offset_set(pp, rxq, 0);
>  		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
>  		mvneta_rxq_bm_disable(pp, rxq);
>  		mvneta_rxq_fill(pp, rxq, rxq->size);
>  	} else {
> -		/* Set Offset */
> -		mvneta_rxq_offset_set(pp, rxq,
> -				      NET_SKB_PAD - pp->rx_offset_correction);
> -
>  		mvneta_rxq_bm_enable(pp, rxq);
>  		/* Fill RXQ with buffers from RX pool */
>  		mvneta_rxq_long_pool_set(pp, rxq);
> @@ -4547,7 +4544,13 @@ static int mvneta_probe(struct platform_device *pdev)
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  
>  	pp->id = global_port_id++;
> -	pp->rx_offset_correction = 0; /* not relevant for SW BM */
> +
> +	/* Set RX packet offset correction for platforms, whose
> +	 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
> +	 * platforms and 0B for 32-bit ones.
> +	 */
> +	pp->rx_offset_correction =
> +		max(0, NET_SKB_PAD - MVNETA_RX_PKT_OFFSET_CORRECTION);
>  
>  	/* Obtain access to BM resources if enabled and already initialized */
>  	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
> @@ -4562,13 +4565,6 @@ static int mvneta_probe(struct platform_device *pdev)
>  				pp->bm_priv = NULL;
>  			}
>  		}
> -		/* Set RX packet offset correction for platforms, whose
> -		 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
> -		 * platforms and 0B for 32-bit ones.
> -		 */
> -		pp->rx_offset_correction = max(0,
> -					       NET_SKB_PAD -
> -					       MVNETA_RX_PKT_OFFSET_CORRECTION);
>  	}
>  	of_node_put(bm_node);
>  
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
