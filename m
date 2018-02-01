Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeBAMzv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:55:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeBAMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:55:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 197BB60A26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
Reply-To: shankerd@codeaurora.org
Subject: Re: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in
 gic_raise_softirq()
To: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>
References: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
 <20180201103337.GA13705@arm.com>
From: Shanker Donthineni <shankerd@codeaurora.org>
Message-ID: <88d418ff-db83-c690-618e-69df3e3bb272@codeaurora.org>
Date: Thu, 1 Feb 2018 06:55:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180201103337.GA13705@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Thanks for your quick reply.

On 02/01/2018 04:33 AM, Will Deacon wrote:
> Hi Shanker,
> 
> On Wed, Jan 31, 2018 at 06:03:42PM -0600, Shanker Donthineni wrote:
>> A DMB instruction can be used to ensure the relative order of only
>> memory accesses before and after the barrier. Since writes to system
>> registers are not memory operations, barrier DMB is not sufficient
>> for observability of memory accesses that occur before ICC_SGI1R_EL1
>> writes.
>>
>> A DSB instruction ensures that no instructions that appear in program
>> order after the DSB instruction, can execute until the DSB instruction
>> has completed.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index b56c3e2..980ae8e 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  	 * Ensure that stores to Normal memory are visible to the
>>  	 * other CPUs before issuing the IPI.
>>  	 */
>> -	smp_wmb();
>> +	wmb();
> 
> I think this is the right thing to do and the smp_wmb() was accidentally
> pulled in here as a copy-paste from the GICv2 driver where it is sufficient
> in practice.
> 
> Did you spot this by code inspection, or did the DMB actually cause
> observable failures? (trying to figure out whether or not this need to go
> to -stable).
> 

We've inspected the code because kernel was causing failures in scheduler/IPI_RESCHDULE.
After some time of debugging, we landed in GIC driver and found that the issue was due
to the DMB barrier. 

Side note, we're also missing synchronization barriers in GIC driver after writing some
of the ICC_XXX system registers. I'm planning to post those changes for comments.

e.g: gic_write_sgi1r(val) and gic_write_eoir(irqnr);
 

> Anyway:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Cheers,
> 
> Will
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
