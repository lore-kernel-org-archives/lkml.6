Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7720815
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE7720815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeKMBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:25:34 -0500
Received: from opengridcomputing.com ([72.48.214.68]:42976 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbeKMBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:25:33 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 115582267C;
        Mon, 12 Nov 2018 09:31:50 -0600 (CST)
Subject: Re: [PATCH] infiniband/hw/cxgb4/qp.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     jrdr.linux@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
References: <5be99a9e.1c69fb81.87c65.4ec2@mx.google.com>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <53589711-602e-1a0f-9036-ff0d0c30bf57@opengridcomputing.com>
Date:   Mon, 12 Nov 2018 09:31:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5be99a9e.1c69fb81.87c65.4ec2@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2018 9:21 AM, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 13478f3..5a8030b 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2564,13 +2564,12 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  	wq->rqt_abs_idx = (wq->rqt_hwaddr - rdev->lldi.vr->rq.start) >>
>  		T4_RQT_ENTRY_SHIFT;
>  
> -	wq->queue = dma_alloc_coherent(&rdev->lldi.pdev->dev,
> +	wq->queue = dma_zalloc_coherent(&rdev->lldi.pdev->dev,
>  				       wq->memsize, &wq->dma_addr,
>  			GFP_KERNEL);
>  	if (!wq->queue)
>  		goto err_free_rqtpool;
>  
> -	memset(wq->queue, 0, wq->memsize);
>  	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
>  
>  	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, CXGB4_BAR2_QTYPE_EGRESS,
> 

Acked-by: Steve Wise <swise@opengridcomputing.com>
