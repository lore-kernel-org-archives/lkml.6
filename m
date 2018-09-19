Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7EECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A55214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A55214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeISOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:16:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeISOQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:16:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 584EBB70C67F3;
        Wed, 19 Sep 2018 16:39:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 16:39:47 +0800
Subject: Re: [PATCH 5/5] scsi: libsas: fix a race condition when smp task
 timeout
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20180912082946.34814-1-yanaijie@huawei.com>
 <20180912082946.34814-6-yanaijie@huawei.com>
 <357ad1d1-1675-4479-c0c3-c872b5f71892@huawei.com>
 <5BA1B922.5010208@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhaohongjiang@huawei.com>, <hare@suse.com>,
        <dan.j.williams@intel.com>, <jthumshirn@suse.de>, <hch@lst.de>,
        <huangdaode@hisilicon.com>, <chenxiang66@hisilicon.com>,
        <miaoxie@huawei.com>, Ewan Milne <emilne@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e87ee725-6b0e-9d8c-d66a-fd3affba6b17@huawei.com>
Date:   Wed, 19 Sep 2018 09:39:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5BA1B922.5010208@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 03:49, Jason Yan wrote:
>
>
> On 2018/9/17 17:47, John Garry wrote:
>> On 12/09/2018 09:29, Jason Yan wrote:
>>> When the lldd is processing the complete sas task in interrupt and set
>>> the task stat as SAS_TASK_STATE_DONE, the smp timeout timer is able to
>>> be triggered at the same time. And smp_task_timedout() will complete the
>>> task wheter the SAS_TASK_STATE_DONE is set or not. Then the sas task may
>>> freed before lldd end the interrupt process. Thus a use-after-free will
>>> happen.
>>>
>>> Fix this by calling the complete() only when SAS_TASK_STATE_DONE is not
>>> set. And remove the check of the return value of the del_timer().
>>>
>>
>> Hi Jason,
>>
>> Please mention that once the LLDD sets DONE, it must call task->done(),
>> which will call smp_task_done()->complete()
>>
>
> OK
>
>>> Reported-by: chenxiang <chenxiang66@hisilicon.com>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> CC: John Garry <john.garry@huawei.com>
>>> CC: Johannes Thumshirn <jthumshirn@suse.de>
>>> CC: Ewan Milne <emilne@redhat.com>
>>> CC: Christoph Hellwig <hch@lst.de>
>>> CC: Tomas Henzl <thenzl@redhat.com>
>>> CC: Dan Williams <dan.j.williams@intel.com>
>>> CC: Hannes Reinecke <hare@suse.com>
>>> ---
>>>  drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_expander.c
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index 52222940d398..0d1f72752ca2 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -48,17 +48,16 @@ static void smp_task_timedout(struct timer_list *t)
>>>      unsigned long flags;
>>>
>>>      spin_lock_irqsave(&task->task_state_lock, flags);
>>> -    if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
>>> +    if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>>>          task->task_state_flags |= SAS_TASK_STATE_ABORTED;
>>> +        complete(&task->slow_task->completion);
>>
>> Nit: for consistency with any other time we use this lock, can we call
>> complete() outside the lock? Maybe just use a flag variable for this.
>>
>
> Is it necessary to add a variable just for consistency with other places?

Actually other places don't only check/set bits in the flag, so it's ok

>
>>> +    }
>>>      spin_unlock_irqrestore(&task->task_state_lock, flags);
>>> -
>>> -    complete(&task->slow_task->completion);
>>>  }
>>>
>>>  static void smp_task_done(struct sas_task *task)
>>>  {
>>> -    if (!del_timer(&task->slow_task->timer))
>>> -        return;
>>> +    del_timer(&task->slow_task->timer);
>>>      complete(&task->slow_task->completion);
>>>  }
>>
>> Do we also need this change or similar:
>> static int smp_execute_task_sg(struct domain_device *dev,
>>      if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
>>          SAS_DPRINTK("smp task timed out or aborted\n");
>>          i->dft->lldd_abort_task(task);
>> -        if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
>> -            SAS_DPRINTK("SMP task aborted and not done\n");
>> -            break;
>> -        }
>> +        break;
>>
>> To me, the ABORTED and DONE states are mutually exclusive.
>>
>
> This changes the logic a bit.

Does it really? According to above change, if state ABORTED set then 
should not have DONE set also.

Anyway, according to my analysis, this suggestion in affect only removes 
the print, which holds true.

Thanks,
John

To be safe, maybe we shall do this with
> another patch after some tests.



>
>>>
>>>
>>
>> Thanks,
>> John
>>
>>
>>
>> .
>>
>
>
> .
>


