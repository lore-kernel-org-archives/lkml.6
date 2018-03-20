Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeCTQJE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:09:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:09:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74A26607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 5/6] IB/nes: Eliminate duplicate barriers on
 weakly-ordered archs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
 <1521514068-8856-6-git-send-email-okaya@codeaurora.org>
 <20180320145413.GH19744@ziepe.ca>
 <3b96019a-2b3b-374a-453e-0553fb04c0a7@codeaurora.org>
 <20180320160151.GM19744@ziepe.ca>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <77565861-7697-699f-c876-adf36db9ab5f@codeaurora.org>
Date: Tue, 20 Mar 2018 11:08:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320160151.GM19744@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/2018 11:01 AM, Jason Gunthorpe wrote:
> On Tue, Mar 20, 2018 at 10:23:16AM -0500, Sinan Kaya wrote:
>> On 3/20/2018 9:54 AM, Jason Gunthorpe wrote:
>>> On Mon, Mar 19, 2018 at 10:47:47PM -0400, Sinan Kaya wrote:
>>>> Code includes barrier() followed by writel(). writel() already has a
>>>> barrier on some architectures like arm64.
>>>>
>>>> This ends up CPU observing two barriers back to back before executing the
>>>> register write.
>>>>
>>>> Create a new wrapper function with relaxed write operator. Use the new
>>>> wrapper when a write is following a barrier().
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>>  drivers/infiniband/hw/nes/nes.h       |  5 +++++
>>>>  drivers/infiniband/hw/nes/nes_hw.c    | 21 ++++++++++++++-------
>>>>  drivers/infiniband/hw/nes/nes_mgt.c   | 15 ++++++++++-----
>>>>  drivers/infiniband/hw/nes/nes_nic.c   |  2 +-
>>>>  drivers/infiniband/hw/nes/nes_utils.c |  3 ++-
>>>>  drivers/infiniband/hw/nes/nes_verbs.c |  5 +++--
>>>>  6 files changed, 35 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/nes.h
>>>> index 00c27291..85e007d 100644
>>>> +++ b/drivers/infiniband/hw/nes/nes.h
>>>> @@ -387,6 +387,11 @@ static inline void nes_write_indexed(struct nes_device *nesdev, u32 reg_index, u
>>>>  	spin_unlock_irqrestore(&nesdev->indexed_regs_lock, flags);
>>>>  }
>>>>  
>>>> +static inline void nes_write32_relaxed(void __iomem *addr, u32 val)
>>>> +{
>>>> +	writel_relaxed(val, addr);
>>>> +}
>>>
>>> This wrapper is pointless, let us not add more..
>>>
>>>>  static inline void nes_write32(void __iomem *addr, u32 val)
>>>>  {
>>>>  	writel(val, addr);
>>>> diff --git a/drivers/infiniband/hw/nes/nes_hw.c b/drivers/infiniband/hw/nes/nes_hw.c
>>>> index 18a7de1..568e17d 100644
>>>> +++ b/drivers/infiniband/hw/nes/nes_hw.c
>>>> @@ -1257,7 +1257,8 @@ int nes_destroy_cqp(struct nes_device *nesdev)
>>>>  
>>>>  	barrier();
>>>>  	/* Ring doorbell (5 WQEs) */
>>>> -	nes_write32(nesdev->regs+NES_WQE_ALLOC, 0x05800000 | nesdev->cqp.qp_id);
>>>> +	nes_write32_relaxed(nesdev->regs+NES_WQE_ALLOC,
>>>> +			    0x05800000 | nesdev->cqp.qp_id);
>>>
>>> barrier() is not strong enough to order writel, so this doesn't seem
>>> right?
>>>
>>> It is probably noteven strong enough for what this driver thinks it is
>>> doing..  This driver is essentially dead and broken, probably just
>>> don't change it.
>>
>> Just for the sake of other changes in netdev directory and my education...
>>
>> barrier() on ARM is a wmb(). It should be a compiler barrier on intel.
>>
>> You are saying barrier() should have been a wmb(), right?
> 
> Yes, that is my understanding.. barrier() is supposed to be a very
> weak barrier that just ensures the CPU is locally consistent with
> itself. It doesn't say anything about DMA access, or SMP cases.
> 
> I don't think it is supposed to order anything related to
> writel_relaxed()
> 
>> I have gone through similar exercise on netdev directory and changed
>>
>> barrier()
>> writel()
>>
>> to 
>>
>> barrier()
>> writel_relaxed()
>>
>> Do you see any problem with this?
> 
> Seems dangerous as a mechanical change to me, it really depends on why
> the driver author put barrier() there.

OK. I'll drop those changes.

> 
> In this case, I strongly suspect nes really intended to say wmb()

Should I change barrier() to wmb() or leave it alone? I have no idea if 
nes is actively being maintained or if it is EOL.

> 
> Jason
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
