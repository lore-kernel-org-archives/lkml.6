Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF923DC3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CF923DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbeGDIVj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:21:39 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4085 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:21:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400"; 
   d="scan'208";a="13186508"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 04 Jul 2018 01:21:36 -0700
Received: from [10.145.6.82] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Wed, 4 Jul 2018
 01:21:35 -0700
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [RFC PATCH 1/2] net: macb: Free RX ring for all queues
To:     Harini Katakam <harini.katakam@xilinx.com>,
        <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>
References: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
Message-ID: <6afc95e7-1756-41b1-38b9-e503d9016298@microchip.com>
Date:   Wed, 4 Jul 2018 11:21:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530286269-32235-1-git-send-email-harini.katakam@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.06.2018 18:31, Harini Katakam wrote:
> rx ring is allocated for all queues in macb_alloc_consistent.
> Free the same for all queues instead of just Q0.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 3e93df5..e56ffa9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1812,13 +1812,7 @@ static void macb_free_consistent(struct macb *bp)
>  	struct macb_queue *queue;
>  	unsigned int q;
>  
> -	queue = &bp->queues[0];
>  	bp->macbgem_ops.mog_free_rx_buffers(bp);
> -	if (queue->rx_ring) {
> -		dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
> -				queue->rx_ring, queue->rx_ring_dma);
> -		queue->rx_ring = NULL;
> -	}
>  
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		kfree(queue->tx_skb);
> @@ -1828,6 +1822,11 @@ static void macb_free_consistent(struct macb *bp)
>  					  queue->tx_ring, queue->tx_ring_dma);
>  			queue->tx_ring = NULL;
>  		}
> +		if (queue->rx_ring) {
> +			dma_free_coherent(&bp->pdev->dev, RX_RING_BYTES(bp),
> +					  queue->rx_ring, queue->rx_ring_dma);
> +			queue->rx_ring = NULL;
> +		}
>  	}
>  }
>  
> 
