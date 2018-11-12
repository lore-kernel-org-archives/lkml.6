Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F511224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F511224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeKMBV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:21:56 -0500
Received: from opengridcomputing.com ([72.48.214.68]:42858 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729488AbeKMBV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:21:56 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id F2E3E2260D;
        Mon, 12 Nov 2018 09:28:12 -0600 (CST)
Reply-To: swise@chelsio.com
Subject: Re: [PATCH] infiniband/hw/cxgb3/cxio_hal.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     jrdr.linux@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
References: <5be5bad9.1c69fb81.db750.d226@mx.google.com>
From:   Steve Wise <swise@chelsio.com>
Message-ID: <64f11e41-1472-e687-7209-0d254f7cc03d@chelsio.com>
Date:   Mon, 12 Nov 2018 09:28:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5be5bad9.1c69fb81.db750.d226@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2018 10:50 AM, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
> index dcb4bba..df4f7a3 100644
> --- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
> +++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
> @@ -291,13 +291,12 @@ int cxio_create_qp(struct cxio_rdev *rdev_p, u32 kernel_domain,
>  	if (!wq->sq)
>  		goto err3;
>  
> -	wq->queue = dma_alloc_coherent(&(rdev_p->rnic_info.pdev->dev),
> +	wq->queue = dma_zalloc_coherent(&(rdev_p->rnic_info.pdev->dev),
>  					     depth * sizeof(union t3_wr),
>  					     &(wq->dma_addr), GFP_KERNEL);
>  	if (!wq->queue)
>  		goto err4;
>  
> -	memset(wq->queue, 0, depth * sizeof(union t3_wr));
>  	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
>  	wq->doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
>  	if (!kernel_domain)
> 

Acked-by: Steve Wise <swise@opengridcomputing.com>
