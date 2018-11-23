Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65050C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9C020685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9C020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440259AbeKXCOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:14:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436632AbeKXCOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:14:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B411C35CD;
        Fri, 23 Nov 2018 07:29:31 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3C3A3F5AF;
        Fri, 23 Nov 2018 07:29:30 -0800 (PST)
Subject: Re: dw_mmc: IDMAC Invalidate cache after read
To:     JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
Date:   Fri, 23 Nov 2018 15:29:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

[repeating some of the discussion from your other thread for the benefit 
of the MMC audience]

On 21/11/2018 07:42, JABLONSKY Jan wrote:
> CPU may not see most up-to-date and correct copy of DMA buffer, when
> internal DMA controller is in use.
> Problem appears on The Altera SoC FPGA (uses integrated DMA controller),
> during higher CPU and system memory load
> 
> Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 80dc2fd..63873d9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -499,8 +499,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
>   
>   	dev_vdbg(host->dev, "DMA complete\n");
>   
> -	if ((host->use_dma == TRANS_MODE_EDMAC) &&
> -	    data && (data->flags & MMC_DATA_READ))
> +	if (data && (data->flags & MMC_DATA_READ))
>   		/* Invalidate cache after read */
>   		dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
>   				    data->sg,

It looks very dubious whether this is actually the right thing to do. 
Just considering this driver, edma has an complementary sync_sg call in 
its .start method, so if idma needed this one, logically shouldn't it 
also need the other one as well?

However, from a DMA API point of view, these syncs make no sense either 
way - the very next thing we do here is call host->dma_ops->cleanup(), 
which calls dma_unmap_sg(), which will perform the appropriate cache 
maintenance anyway. Thus I can't see why this code is even here to begin 
with. Similarly on the request path - the sg list really shouldn't have 
been touched since being mapped in dw_mci_pre_dma_transfer(), so that 
sync should also be an effective no-op unless it's papering over some 
race condition elsewhere.

Shawn - do you remember why these syncs were added in 3fc7eaef44dbc? 
Were you seeing actual coherency issues on RK31xx SoCs, or was it 
perhaps just some leftover or misunderstanding which missed getting 
cleaned up?

Robin.
