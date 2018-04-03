Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDCSpP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:45:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36363 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDCSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:45:14 -0400
X-Google-Smtp-Source: AIpwx49pzRllxHbXBEzwbJNHhqeHOYEva87Ww0u/RlYiRUwPlnwygss0p9qINI8LTmz0nzviS9jjYA==
Reply-To: minyard@acm.org
Subject: Re: [PATCH ipmi/kcs_bmc v1] ipmi: kcs_bmc: optimize the data buffers
 allocation
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1521116452-4993-1-git-send-email-haiyue.wang@linux.intel.com>
 <50ba7cd8-0e14-d8b7-a10c-5dee17946722@linux.intel.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <143afdd1-bdde-fb9b-d21c-8dc8eeb24e6c@acm.org>
Date: Tue, 3 Apr 2018 13:45:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <50ba7cd8-0e14-d8b7-a10c-5dee17946722@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 01:00 AM, Wang, Haiyue wrote:
> Hi Corey,
>
> The 4.17 merge window is opened now, this patch is not yet in 
> linux-next tree,
>
> so it will be merged into 4.18 ?
>

Yeah, this came in kind of late, and I had some other critical
things I was having to focus on, so I've been kind of out of the loop.

If it's urgent, I can work on getting it into 4.17 later, but I'd rather
wait on 4.18.

-corey

> Thanks & Regards,
>
> Haiyue
>
> On 2018-03-15 20:20, Haiyue Wang wrote:
>> Allocate a continuous memory block for the three KCS data buffers with
>> related index assignment.
>>
>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> ---
>>   drivers/char/ipmi/kcs_bmc.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
>> index fbfc05e..dc19c0d 100644
>> --- a/drivers/char/ipmi/kcs_bmc.c
>> +++ b/drivers/char/ipmi/kcs_bmc.c
>> @@ -435,6 +435,7 @@ static const struct file_operations kcs_bmc_fops = {
>>   struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, 
>> u32 channel)
>>   {
>>       struct kcs_bmc *kcs_bmc;
>> +    void *buf;
>>         kcs_bmc = devm_kzalloc(dev, sizeof(*kcs_bmc) + sizeof_priv, 
>> GFP_KERNEL);
>>       if (!kcs_bmc)
>> @@ -448,11 +449,12 @@ struct kcs_bmc *kcs_bmc_alloc(struct device 
>> *dev, int sizeof_priv, u32 channel)
>>       mutex_init(&kcs_bmc->mutex);
>>       init_waitqueue_head(&kcs_bmc->queue);
>>   -    kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> -    kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> -    kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> -    if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
>> +    buf = devm_kmalloc_array(dev, 3, KCS_MSG_BUFSIZ, GFP_KERNEL);
>> +    if (!buf)
>>           return NULL;
>> +    kcs_bmc->data_in  = buf;
>> +    kcs_bmc->data_out = buf + KCS_MSG_BUFSIZ;
>> +    kcs_bmc->kbuffer  = buf + KCS_MSG_BUFSIZ * 2;
>>         kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
>>       kcs_bmc->miscdev.name = dev_name(dev);
>
