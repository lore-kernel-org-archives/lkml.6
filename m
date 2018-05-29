Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934800AbeE2OGR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:06:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934316AbeE2OGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:06:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63F0F60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2] remoteproc: Introduce prepare/unprepare ops for rproc
 coredump
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180521184559.20864-1-sibis@codeaurora.org>
 <20180529050523.GG2259@tuxbook-pro>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <58528924-0ca1-fe23-741c-ad3d2c1d4388@codeaurora.org>
Date: Tue, 29 May 2018 19:36:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180529050523.GG2259@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review.


On 05/29/2018 10:35 AM, Bjorn Andersson wrote:
> On Mon 21 May 11:45 PDT 2018, Sibi Sankar wrote:
> 
>> In some occasions the remoteproc device might need to
>> prepare some hardware before the coredump can be performed
>> and cleanup the state afterwards.
>>
>> Q6V5 modem requires the mba to be loaded before the
>> coredump and some cleanup of the resources afterwards.
>>
> 
> This describes two different changes, so please put it in two+ patches.
>


The second change just describes an example of a remoteproc device
that requires remoteproc coredump prepare and unprepare but sure
with restructuring required in msa it definitely will require 2+
patches.


> [..]
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index dfdaede9139e..010819e01279 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -333,6 +333,8 @@ struct firmware;
>>    * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>>    * @da_to_va:	optional platform hook to perform address translations
>>    * @load_rsc_table:	load resource table from firmware image
>> + * @prepare_coredump:	prepare function, called before coredump
>> + * @unprepare_coredump:	unprepare function, called post coredump
> 
> I believe there will be other cases where we will need driver-specific
> logic to extract the memory content of the segments, e.g. through custom
> hardware sequences or non-mmio reads.
> 
> To support this I think we should extend the struct rproc_dump_segment
> to carry an optional "dump" function that if specified will be used
> instead of the memcpy in rproc_coredump(). Drivers can then for each
> segment specify this function, if needed.
> 

In q6 modem mba needs to unlocked just once for all the segments to
be dumped but as you say other remote processors may need it for each
segment. This logic should be internal to the dump function anyway. So
will use the dump function approach. What about the cleanup path, can we
still reserve it till the coredump is done?



> Through some restructuring in the msa driver and your patch you should
> be able to implement this using such a mechanism instead - and it would
> be useful to these other cases as well.
> 
> 
> PS. I hope we can get away from some of the conditionals in your patch
> through some restructuring of the code.
> 


Thought you might preferred the conditionals with the least amount of
code addition/change but having prepare and unprepare coredump again
calling q6v5_start/stop respectively seemed a little hacky anyway.
Sure will restructure msa as needed :)


> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
