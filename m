Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC4214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CC4214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeHBLJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:09:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeHBLJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:09:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A3E80D;
        Thu,  2 Aug 2018 02:19:28 -0700 (PDT)
Received: from [10.1.39.188] (desktop-vlo843j.cambridge.arm.com [10.1.39.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C8C3F5D0;
        Thu,  2 Aug 2018 02:19:27 -0700 (PDT)
Subject: Re: [PATCH v2] net: fec: check DMA addressing limitations
To:     Stefan Agner <stefan@agner.ch>, fugang.duan@nxp.com,
        davem@davemloft.net
Cc:     krzk@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802084250.26489-1-stefan@agner.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e03a908e-4c0d-a295-90a7-2da11c8fead5@arm.com>
Date:   Thu, 2 Aug 2018 10:19:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802084250.26489-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 9:42 AM, Stefan Agner wrote:
> Check DMA addressing limitations as suggested by the DMA API
> how-to. This does not fix a particular issue seen but is
> considered good style.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>   drivers/net/ethernet/freescale/fec_main.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c729665107f5..cdf2f5447910 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3136,6 +3136,7 @@ static int fec_enet_init(struct net_device *ndev)
>   	unsigned dsize = fep->bufdesc_ex ? sizeof(struct bufdesc_ex) :
>   			sizeof(struct bufdesc);
>   	unsigned dsize_log2 = __fls(dsize);
> +	int ret;
>   
>   	WARN_ON(dsize != (1 << dsize_log2));
>   #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> @@ -3146,6 +3147,13 @@ static int fec_enet_init(struct net_device *ndev)
>   	fep->tx_align = 0x3;
>   #endif
>   
> +	/* Check mask of the streaming and coherent API */
> +	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
> +		return ret;
> +	}
> +
>   	fec_enet_alloc_queue(ndev);
>   
>   	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
> 
