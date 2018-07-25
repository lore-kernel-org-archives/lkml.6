Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380EDC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3220685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeGYLBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:01:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbeGYLBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:01:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1C315A2;
        Wed, 25 Jul 2018 02:50:48 -0700 (PDT)
Received: from [10.37.10.30] (unknown [10.37.10.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0DC3F237;
        Wed, 25 Jul 2018 02:50:47 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] coresight: perf: Remove set_buffer call back
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-10-git-send-email-suzuki.poulose@arm.com>
 <20180719203630.GC9421@xps15> <a68cff9d-51d3-7d86-0a73-c1d3cbbaced3@arm.com>
 <CANLsYkyN_+uTJZh7YEBPtMPvb8uQNwXvCwn_N4+D12xOVc=MNg@mail.gmail.com>
 <2f646ecb-8150-d184-4d94-d2855ddfafd1@arm.com>
 <CANLsYkzjgZUBw6Ku7YSdmRE7c7PTRKTCObeg+yHXzNpQGTVyqA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b320f8f7-0c6a-0580-6dea-9c201780a7b6@arm.com>
Date:   Wed, 25 Jul 2018 10:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkzjgZUBw6Ku7YSdmRE7c7PTRKTCObeg+yHXzNpQGTVyqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 09:08 PM, Mathieu Poirier wrote:
> On Mon, 23 Jul 2018 at 16:27, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Mathieu,
>>
>> On 07/23/2018 07:22 PM, Mathieu Poirier wrote:
>>> On Fri, 20 Jul 2018 at 03:04, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>>>>
>>>> Mathieu,
>>>>
>>>> On 19/07/18 21:36, Mathieu Poirier wrote:
>>>>> On Tue, Jul 17, 2018 at 06:11:40PM +0100, Suzuki K Poulose wrote:
>>>>>> In coresight perf mode, we need to prepare the sink before
>>>>>> starting a session, which is done via set_buffer call back.
>>>>>> We then proceed to enable the tracing. If we fail to start
>>>>>> the session successfully, we leave the sink configuration
>>>>>> unchanged. This was fine for the existing backends as they
>>>>>> don't have any state associated with the buffers. But with
>>>>>> ETR, we need to keep track of the buffer details and need
>>>>>> to be cleaned up if we fail. In order to make the operation
>>>>>> atomic and to avoid yet another call back, we get rid of
>>>>>> the "set_buffer" call back and pass the buffer details
>>>>>> via enable() call back to the sink.
>>>>>
>>>>> Suzuki,
>>>>>
>>>>> I'm not sure I understand the problem you're trying to fix there.  From the
>>>>> implementation of tmc_enable_etr_sink_perf() in the next patch, wouldn't the
>>>>> same result been achievable using a callback?
>>>>
>>>> We can definitely achieve the results using "set_buffer". But for ETR,
>>>> we track the "perf_buf" in drvdata->perf_data when we do "set_buffer".
>>>> But if we failed to enable_path(), we leave the drvdata->perf_data
>>>> and doesn't clean it up. Now when another session is about to set_buf,
>>>> we check if perf_data is empty and WARNs otherwise.
>>>> Because we can't be sure if it belongs to an abandoned session or
>>>> another active session and we completely messed somewhere in the driver.
>>>> So, we need a clear_buffer call back if the enable fails, something
>>>> not really worth. Anyways, there is no point in separating set_buffer
>>>> and enabling the sink, as the error handling becomes cumbersome as explained
>>>> above.
>>>>
>>>>>
>>>>> I'm fine with this patch and supportive of getting rid of callbacks if we can, I
>>>>> just need to understand the exact problem you're after.  From looking a your
>>>>> code (and the current implementation), if we succeed in setting the memory for
>>>>> the sink but fail in any of the subsequent steps i.e, enabling the rest of the
>>>>> compoment on the path or the source, the sink is left unchanged.
>>>>
>>>> Yes, thats right. And we should WARN (which I missed in this version) if
>>>> there is a perf_data already for a disabled ETR. Please see my response to the
>>>> next patch.
>>>
>>> The changelog for this patch states the following: "But with ETR, we
>>> need to keep track of the buffer details and need to be cleaned up if
>>> we fail."
>>>
>>> I did a deep dive in the code and in the current implementation if the
>>> source fails to be enabled in etm_event_start() the path and the sink
>>> remains unchanged.  With your patchset this get fixed because a goto
>>> was added to disable the path when such condition occur.  As such each
>>> component in the path will see its ->disable() callback invoked.  In
>>> tmc_disable_etr_sink(), drvdata->perf_data is set to NULL in
>>> tmc_etr_disable_hw(), so the cleanup on error condition is done
>>> properly.  As such we wouldn't need a clean_buffer() callback.
>>
>> All of this is right. But we still have a case. e.g, if the ETR is
>> enabled in sysfs mode, coresight_enable_path() will fail after we
>> have set the buffer. And since we don't try to disable the path
>> when we fail at SINK (which is the right thing to do, as we could
>> be potentially disabling the ETR operated in sysfs mode), we leave
>> the perf_data around. And the next session finds a non-empty data.
> 
> We are in total agreement :o)
> 
> All I hoping for is to see the sentence "But with ETR, we need to keep
> track of the buffer details and need to be cleaned up if we fail."
> removed from the changelog.  To me that sounds like you're adding
> cleanup work in enable() which isn't the case.  On the flip side you
> are making the sink configuration atomic and that is the important
> part.

:-), I will update the change log accordingly.

> 
>>
>>>
>>> As I said I'm in favour of removing the set_buffer() callback but I
>>> wouldn't associated it with ETR state cleanup.  If the code can be
>>> rearranged in a way that code can be removed then that alone is enough
>>> to ju


>>>>>> +    if (coresight_enable_path(path, CS_MODE_PERF, handle))
>>>>>
>>>>> Here we already have a handle on "event_data".  As such I think this is what we
>>>>> should feed to coresight_enable_path() rather than the handle.  That way we
>>>>> don't need to call etm_perf_sink_config(), we just use the data.
>>>>
>>>> The advantage of passing on the handle is, we could get all the way upto the
>>>> "perf_event" for the given session. Passing the event_data will loose that
>>>> information.
>>>>
>>>> i.e, perf_event-> |perf_ouput_handle | -> |event_data | -> sink_config
>>>>                      |  <-event         |    |           |
>>>>
>>>> The purpose of the wrapper "etm_perf_sink_config()" is to abstract the way we
>>>> handle the information under the event_data. i.e, if we decide to make some
>>>> changes in the way we store event_data, we need to spill the changes every
>>>> where. But the perf_ouput_handle has much more stable ABI than event_data,
>>>> hence the choice of passing handle.
>>>
>>> I agree that etm_perf_sink_config() has value but it should take a
>>> void * as parameter (i.e what gets returned from perf_get_aux())
>>> rather than a perf_output_handle *.
>>
>> Ok, did you mean :
>>
>>          sink_config = etm_perf_sink_config(perf_get_aux(handle)); ?
>>
>> Or do you want to change the parameter passed to the enable_sink() as
>> well ?
> 
> I've been thinking further on this and keeping things the way you've
> implemented them is probably best at this time.  I'm currently adding
> support for PMU HW configuration and in the end we may need the
> information conveyed by event->hw.drv_config [1].  When it's all said
> and done we can clean things up if need be.

Ok.


Thanks for the review.

Cheers
Suzuki
