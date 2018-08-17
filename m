Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE4213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAE4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHQScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:32:51 -0400
Received: from mleia.com ([178.79.152.223]:60112 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeHQScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:32:51 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 92A6440FC3B;
        Fri, 17 Aug 2018 16:29:02 +0100 (BST)
Subject: Re: [PATCH 2/2] ethernet: lpc_eth: Use NULL to compare with
 pointer-typed value rather than 0
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     slemieux.tyco@gmail.com, keescook@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534511933-39236-1-git-send-email-zhongjiang@huawei.com>
 <1534511933-39236-3-git-send-email-zhongjiang@huawei.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <edc2f14f-8694-3160-47b1-ccb5be8a3484@mleia.com>
Date:   Fri, 17 Aug 2018 18:29:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1534511933-39236-3-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180817_162902_619470_4DD05F32 
X-CRM114-Status: GOOD (  16.88  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhong jiang,

On 08/17/2018 04:18 PM, zhong jiang wrote:
> We should use NULL to compare with pointer-typed value rather than 0.
> The issue is detected with the help of Coccinelle.
> ---
>  drivers/net/ethernet/nxp/lpc_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> index 08381ef..04d9e62 100644
> --- a/drivers/net/ethernet/nxp/lpc_eth.c
> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> @@ -1350,7 +1350,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
>  				"IRAM not big enough for net buffers, using SDRAM instead.\n");
>  	}
>  
> -	if (pldat->dma_buff_base_v == 0) {
> +	if (pldat->dma_buff_base_v == NULL) {

That's a valid finding, but please use a common 0 and NULL comparison in form of

	if (!pldat->dma_buff_base_v)

To the change above please feel free to add my

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

>  		ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (ret)
>  			goto err_out_free_irq;
> 

