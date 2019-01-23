Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6BDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964E221855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfAWVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:48:11 -0500
Received: from opengridcomputing.com ([72.48.214.68]:52744 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbfAWVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:48:11 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 7102D22774;
        Wed, 23 Jan 2019 15:48:10 -0600 (CST)
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
 <20190123214415.GA20648@ziepe.ca>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <6493ca88-32d8-0ad7-51b5-06e011506a37@opengridcomputing.com>
Date:   Wed, 23 Jan 2019 15:48:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123214415.GA20648@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2019 3:44 PM, Jason Gunthorpe wrote:
> On Sun, Jan 20, 2019 at 02:27:13AM +0100, Nicholas Mc Guire wrote:
>> The kmalloc is called with  | __GFP_NOFAIL  so there is no point in
>> checking the return value - it either returns valid storage or it would
>> hang/terminate there. But it is not possible to say if the use of
>> __GFP_NOFAIL is really needed and the check should be removed or
>> vice-versa (use of __GFP_NOFAIL should be only in exceptional
>> cases as I understand it and alloc_srq_queue() is called in quite
>> a few places)
>> In either way it would need fixing.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
>> ---
> 
> As per steve's remarkes I revised this to the below and applied it to
> for-next
> 
>>From 4b2d4262ee2ea58df867de1928bf208795344432 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Sun, 20 Jan 2019 02:27:13 +0100
> Subject: [PATCH] RDMA/iw_cxgb4: Drop __GFP_NOFAIL
> 
> There is no reason for this __GFP_NOFAIL, none of the other routines in
> this file use it, and there is an error unwind here. NOFAIL should be
> reserved for special cases, not used by network drivers.
> 
> Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
> Reported-by: Nicholas Mc Guire <hofrat@osadl.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> index 03f4c66c265946..c00a4114412694 100644
> --- a/drivers/infiniband/hw/cxgb4/qp.c
> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> @@ -2597,7 +2597,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>  	/* build fw_ri_res_wr */
>  	wr_len = sizeof(*res_wr) + sizeof(*res);
>  
> -	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> +	skb = alloc_skb(wr_len, GFP_KERNEL);
>  	if (!skb)
>  		goto err_free_queue;
>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
> 

Thanks Jason!
