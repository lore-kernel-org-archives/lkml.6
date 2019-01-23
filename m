Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FECC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7121855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAWSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:45:10 -0500
Received: from opengridcomputing.com ([72.48.214.68]:50846 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbfAWSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:45:08 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 7D59F21EC0;
        Wed, 23 Jan 2019 12:45:07 -0600 (CST)
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
 <20190123183008.GA15698@ziepe.ca>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <91af1982-e309-476e-cfa4-2f6ef1ee598b@opengridcomputing.com>
Date:   Wed, 23 Jan 2019 12:45:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123183008.GA15698@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2019 12:30 PM, Jason Gunthorpe wrote:
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
> Steve? It seems weird to have NOFAIL and then have an error unwind
> path, what is the deal here?
> 
>> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
>> index 917ce5c..c2a12ba 100644
>> --- a/drivers/infiniband/hw/cxgb4/qp.c
>> +++ b/drivers/infiniband/hw/cxgb4/qp.c
>> @@ -2597,8 +2597,6 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
>>  	wr_len = sizeof(*res_wr) + sizeof(*res);
>>  
>>  	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
>> -	if (!skb)
>> -		goto err_free_queue;
>>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
>>  
>>  	res_wr = (struct fw_ri_res_wr *)__skb_put(skb, wr_len);
>> -- 
>> 2.1.4
>>

The other queue allocations in qp.c don't use __GFP_NOFAIL.  So either
leave it and remove the error check as per this patch, or remove the
NOFAIL and leave the check.

I suggest you remove the __GFP_NOFAIL, since I have a recollection that
using it was frowned upon.  In this case, if there is no memory
available it is reasonable to return that error to the user creating the
srq...


Steve.
