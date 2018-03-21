Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeCUVBz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:01:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeCUVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:01:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABBA760C54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 3/6] RDMA/i40iw: Eliminate duplicate barriers on
 weakly-ordered archs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-4-git-send-email-okaya@codeaurora.org>
 <20180321200253.GA21453@ziepe.ca>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <596af6f5-3668-2545-4d79-b7b8c6713444@codeaurora.org>
Date: Wed, 21 Mar 2018 16:01:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321200253.GA21453@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/2018 3:02 PM, Jason Gunthorpe wrote:
> On Mon, Mar 19, 2018 at 10:47:45PM -0400, Sinan Kaya wrote:
>> diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
>> index 8afa5a6..7f0ebed 100644
>> +++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
>> @@ -723,7 +723,7 @@ static void i40iw_cq_request_notification(struct i40iw_cq_uk *cq,
>>  
>>  	wmb(); /* make sure WQE is populated before valid bit is set */
>>  
>> -	writel(cq->cq_id, cq->cqe_alloc_reg);
>> +	writel_relaxed(cq->cq_id, cq->cqe_alloc_reg);
>>  }
> 
> Ah, this one is probably not OK, i40iw_cq_request_notification is
> called here:
> 
> 	spin_lock_irqsave(&iwcq->lock, flags);
> 	ukcq->ops.iw_cq_request_notification(ukcq, cq_notify);
> 	spin_unlock_irqrestore(&iwcq->lock, flags);
> 
> So this needs to add mmmiomb(); to keep the same semantics.
> 
> Generally I think you need to be very careful to ensure that any
> conversion to _relaxed isn't contained by a spinlock, or the mmiomb()
> is present.
> 
> Maybe even do a first series with this obviously correct pattern:
> 
>  wmb();
>  writel() -> writel_relaxed()
>  writel() -> writel_relaxed()
>  [..]
>  mmiowmb();

Good catch. I changed it as follows:

+++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
@@ -723,7 +723,8 @@ static void i40iw_cq_request_notification(struct i40iw_cq_uk *cq,

        wmb(); /* make sure WQE is populated before valid bit is set */

-       writel(cq->cq_id, cq->cqe_alloc_reg);
+       writel_relaxed(cq->cq_id, cq->cqe_alloc_reg);
+       mmiowb();
 }


> 
> Jason
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
