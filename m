Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeDMIrB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:47:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbeDMIqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:46:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 397F96076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: Query:Regarding percpu_counter debug object destroy
To: Nikolay Borisov <nborisov@suse.com>, tj@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
References: <0754201b-2051-3f1c-7a09-ed1be96a0260@codeaurora.org>
 <cfd4c608-2662-2338-0ce7-4c90e193bd3c@suse.com>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <219c8a35-49ac-1dbf-7816-95be0be46a1a@codeaurora.org>
Date: Fri, 13 Apr 2018 14:16:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cfd4c608-2662-2338-0ce7-4c90e193bd3c@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolay,

Thanks for the comment.

I agree ,like timer , hrtimer we have to mark inactive in destroy function and finally freeing the debug object

after destruction of percpu_counter.

But i am still not sure that this double freeing with same address may create race or not in debug_object list.

Regards

Gaurav

On 4/13/2018 1:12 PM, Nikolay Borisov wrote:

>
> On 13.04.2018 10:32, Kohli, Gaurav wrote:
>> Hi ,
>>
>> I have checked below code and it seems we are calling debug_object_free
>> twice, ideally we should deactivate and later we
>> have to destroy.
>>
>> 1st call -> percpu_counter_destroy->debug_percpu_counter_deactivate ->
>> debug_object_free
>> 2nd call ->
>> debug_object_free
>>
>>
>>
>> static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state
>> state)
>> {
>>          struct percpu_counter *fbc = addr;
>>
>>          switch (state) {
>>          case ODEBUG_STATE_ACTIVE:
>>                  percpu_counter_destroy(fbc);  -> first call
>>                  debug_object_free(fbc, &percpu_counter_debug_descr); 2nd
>
> Having looked at the code I'd say this is indeed buggy. I'd say it
> stemmed from same cargo culting since timer_fixup_free follows the same
> structure of code, except that in del_timer_sync there is no code which
> does debug_object_free. The situation is similar in work_fixup_free.
>
> So at this point I guess the question is whether we want to leave the
> debug_object_free call in percpu_counter_fixup_free and just remove
> debug_percpu_counter_deactivate and open-code the call to
> debug_object_deactivate in percpu_counter_destroy. Or remove the
> explicit call in percpu_counter_fixup_free and leave
> debug_percpu_counter_deactivate.
>
>
> In the end it's a matter of style, so perhaps Tejun, as the maintainer,
> has the final say what style he prefers. Personally, I'd go for the
> former solution so that the percpu follows the style of the rest of the
> kernel.
>
>> call
>>                  return true;
>>          default:
>>                  return false;
>>          }
>> }
>>
>>
>> We are seeing one issue, where one list contain garbage data in
>> obj_hash, just before element of that is percpu_counter but
>> still not sure as it is very difficult to reproduce.
>>
>> Can some one please review above code or can we remove one instance of
>> debug_object_free from above code.
>>
>> Regards
>> Gaurav
>>
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
