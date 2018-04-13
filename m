Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeDMNuH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:50:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32771 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbeDMNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:50:05 -0400
X-Google-Smtp-Source: AIpwx4+fDi06KPRlOT9mUjN3OXpnGlYPF/5zrTMIlCD0LvjFdu5vx6djqfDGjXAGwAzkvMrn4oP54g==
Reply-To: minyard@acm.org
Subject: Re: [PATCH ipmi/kcs_bmc v1] ipmi: kcs_bmc: optimize the data buffers
 allocation
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>, minyard@acm.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1521116452-4993-1-git-send-email-haiyue.wang@linux.intel.com>
 <dd59cf14-e269-6c00-9e33-87316cdc8e8f@gmail.com>
 <dd4e07c4-7a99-3449-fd2d-58c2b829f7b7@linux.intel.com>
 <1710edd4-277b-1d2e-5885-a070751ddd2a@linux.intel.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <1483ac91-5f41-e299-6c74-3dd31aa95ad6@gmail.com>
Date: Fri, 13 Apr 2018 08:50:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1710edd4-277b-1d2e-5885-a070751ddd2a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 02:54 AM, Wang, Haiyue wrote:
> Hi Corey,
>
> Since IPMI 2.0 just defined minimum, no maximum:
>
> ----
>
> KCS/SMIC Input : Required: 40 bytes IPMI Message, minimum
>
> KCS/SMIC Output : Required: 38 bytes IPMI Message, minimum
>

Yes, though there are practical maximums that are much smaller than 1000 
bytes.


> ----
>
> We can enlarge the block size for avoiding waste, and make our driver
>
> support most worst message size case. And I think this patch make 
> checking
>
> simple (from 3 to 1), and the code clean, this is the biggest reason I 
> want to
>
> change. The TLB is just memory management study from book, no data to
>
> support access improvement. :)

I would argue that the way it is now expresses the intent of the code better
than one allocation split into three parts.  Expressing your intent is more
important than the number of checks and a minuscule performance
improvement.  For me it makes the code easier to understand.  If you had
a tool that checked for out-of-bounds memory access, then a single 
allocation
might not find an overrun between the parts.  Smaller allocations tend
to result in less memory fragmentation.

My preference is to leave it as it is.  However, it's not that 
important, and
if you really want this patch, I can include it.

Thanks,

-corey

>
> BR,
>
> Haiyue
>
>
> On 2018-04-07 10:37, Wang, Haiyue wrote:
>>
>>
>> On 2018-04-07 05:47, Corey Minyard wrote:
>>> On 03/15/2018 07:20 AM, Haiyue Wang wrote:
>>>> Allocate a continuous memory block for the three KCS data buffers with
>>>> related index assignment.
>>>
>>> I'm finally getting to this.
>>>
>>> Is there a reason you want to do this?  In general, it's better to 
>>> not try to
>>> outsmart your base system.  Depending on the memory allocator, in this
>>> case, you might actually use more memory.  You probably won't use any
>>> less.
>>>
>> I got this idea from another code review, but that patch allocates 30 
>> more
>> the same size memory block, reducing the devm_kmalloc call will be 
>> better.
>> For KCS only have 3, may be the key point is memory waste.
>>
>>> In the original case, you allocate three 1000 byte buffers, 
>>> resulting in 3
>>> 1024 byte slab allocated.
>>>
>>> In the changed case, you will allocate a 3000 byte buffer, resulting in
>>> a single 4096 byte slab allocation, wasting 1024 more bytes of memory.
>>>
>> As the kcs has memory copy between in/out/kbuffer, put them in the same
>> page will be better ? Such as the same TLB ? (Well, I just got this 
>> from book,
>> no real experience of memory accessing performance. And also, I was told
>> that using space to save the time. :-)).
>>
>> Just my stupid thinking. I'm OK to drop this patch if it doesn't help 
>> with
>> performance, or something else.
>>
>> BR.
>> Haiyue
>>
>>> -corey
>>>
>>>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>>>> ---
>>>>   drivers/char/ipmi/kcs_bmc.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>>>> index fbfc05e..dc19c0d 100644
>>>> --- a/drivers/char/ipmi/kcs_bmc.c
>>>> +++ b/drivers/char/ipmi/kcs_bmc.c
>>>> @@ -435,6 +435,7 @@ static const struct file_operations 
>>>> kcs_bmc_fops = {
>>>>   struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int 
>>>> sizeof_priv, u32 channel)
>>>>   {
>>>>       struct kcs_bmc *kcs_bmc;
>>>> +    void *buf;
>>>>         kcs_bmc = devm_kzalloc(dev, sizeof(*kcs_bmc) + sizeof_priv, 
>>>> GFP_KERNEL);
>>>>       if (!kcs_bmc)
>>>> @@ -448,11 +449,12 @@ struct kcs_bmc *kcs_bmc_alloc(struct device 
>>>> *dev, int sizeof_priv, u32 channel)
>>>>       mutex_init(&kcs_bmc->mutex);
>>>>       init_waitqueue_head(&kcs_bmc->queue);
>>>>   -    kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, 
>>>> GFP_KERNEL);
>>>> -    kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, 
>>>> GFP_KERNEL);
>>>> -    kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>>>> -    if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
>>>> +    buf = devm_kmalloc_array(dev, 3, KCS_MSG_BUFSIZ, GFP_KERNEL);
>>>> +    if (!buf)
>>>>           return NULL;
>>>> +    kcs_bmc->data_in  = buf;
>>>> +    kcs_bmc->data_out = buf + KCS_MSG_BUFSIZ;
>>>> +    kcs_bmc->kbuffer  = buf + KCS_MSG_BUFSIZ * 2;
>>>>         kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
>>>>       kcs_bmc->miscdev.name = dev_name(dev);
>>>
>>>
>>
>
