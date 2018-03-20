Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeCTPao (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:30:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCTPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:30:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96807602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 1/6] RDMA/bnxt_re: Eliminate duplicate barriers on
 weakly-ordered archs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-2-git-send-email-okaya@codeaurora.org>
 <20180320144801.GE19744@ziepe.ca>
 <d31c062b-5629-62b8-c291-c656e23c6f82@codeaurora.org>
 <20180320152043.GK19744@ziepe.ca>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <dbfd4127-d6d5-eccc-4b7b-0ea3bf51a699@codeaurora.org>
Date: Tue, 20 Mar 2018 10:30:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320152043.GK19744@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/2018 10:20 AM, Jason Gunthorpe wrote:
> On Tue, Mar 20, 2018 at 10:00:49AM -0500, Sinan Kaya wrote:
>> On 3/20/2018 9:48 AM, Jason Gunthorpe wrote:
>>> On Mon, Mar 19, 2018 at 10:47:43PM -0400, Sinan Kaya wrote:
>>>> Code includes wmb() followed by writel(). writel() already has a barrier on
>>>> some architectures like arm64.
>>>>
>>>> This ends up CPU observing two barriers back to back before executing the
>>>> register write.
>>>>
>>>> Since code already has an explicit barrier call, changing writel() to
>>>> writel_relaxed().
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
>>>> index 8329ec6..4a6b981 100644
>>>> +++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
>>>> @@ -181,10 +181,10 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
>>>>  
>>>>  	/* ring CMDQ DB */
>>>>  	wmb();
>>>> -	writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
>>>> -	       rcfw->cmdq_bar_reg_prod_off);
>>>> -	writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
>>>> -	       rcfw->cmdq_bar_reg_trig_off);
>>>> +	writel_relaxed(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
>>>> +		       rcfw->cmdq_bar_reg_prod_off);
>>>> +	writel_relaxed(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
>>>> +		       rcfw->cmdq_bar_reg_trig_off);
>>>
>>> Woah, this may not be safe..
>>>
>>> The definition of writel_relaxed() is that it is fully unordered, so
>>> the above two writes may change order now. Broadcom guys would have to
>>> ack if that it is OK or not for their hardware.
>>>
>>> In general this is not an OK approach for a mechanical
>>> conversion.. Only the first writel can be convereted.
>>>
>>> You need to check all your patches to make sure there are no
>>> subsequent writel's in the places touched.
>>
>> I paid special attention to this one and went to check the barriers
>> document. According to the document, writes (whether it is relaxed or not)
>> are always observed by the HW inorder with respect to each other.
> 
> Oh interesting, that document got revised to make writel_relaxed less
> relaxed a few years ago, didn't know that. Thanks.
> 
> However, this is still not OK, the full code is:
> 
>         /* ring CMDQ DB */
>         wmb();
>         writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
>                rcfw->cmdq_bar_reg_prod_off);
>         writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
>                rcfw->cmdq_bar_reg_trig_off);
> done:
>         spin_unlock_irqrestore(&cmdq->lock, flags);
> 
> 
> And the definition of _relaxed allows the writes to order outside the
> spinlock region, which is very likely to be wrong in this driver.
> 
> I'm not sure adding a mmiowb() just to use a writel_relaxed is any
> sort of win though?

I'd prefer this. 

mmiowb() on ARM64 is empty. mmiowb() guarantees that code also works for PPC too.

I'll switch to this instead so it works for everybody.

> 
> Jason
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
