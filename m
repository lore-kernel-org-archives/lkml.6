Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965353AbeBMSDH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:03:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:03:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F0AF60A26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
To: Jiri Olsa <jolsa@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
 <20180212094357.GD5821@krava>
 <53408020-8638-4947-90f6-87dbc4c2c4e5@codeaurora.org>
 <20180212210442.GA32093@krava> <20180212212101.GA15817@krava>
 <6aab2b36-0fe6-7a3d-2106-d4c93ec95a8a@codeaurora.org>
 <20180213160826.GA9121@krava>
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
Message-ID: <3745120e-8884-c958-54b4-d1a86253dd0d@codeaurora.org>
Date: Tue, 13 Feb 2018 10:03:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180213160826.GA9121@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/13/2018 08:08 AM, Jiri Olsa wrote:
> On Mon, Feb 12, 2018 at 02:22:30PM -0800, Raghavendra Rao Ananta wrote:
>>
>>
>> On 02/12/2018 01:21 PM, Jiri Olsa wrote:
>>> On Mon, Feb 12, 2018 at 10:04:42PM +0100, Jiri Olsa wrote:
>>>> On Mon, Feb 12, 2018 at 09:42:05AM -0800, Raghavendra Rao Ananta wrote:
>>>>> Hi Jiri,
>>>>>
>>>>> Thank you for the response.
>>>>>
>>>>> Does perf tool has its own check to see if the CPU was offline during the
>>>>> lifetime of an event? If so, it might ignore these type of events.
>>>>
>>>> nope, we don't check on that
>>>>
>>>>>
>>>>> Initially, I tested the same using perf tool and found similar results.
>>>>> Then I debugged further and found that the perf core was actually sending
>>>>> data to the userspace (copy_to_user()) and the corresponding count for the
>>>>> data. Hence, I tested this further by writing my own userspace application,
>>>>> and I was able to read the count through this,
>>>>> even when the CPU was made offline and back online.
>>>>>
>>>>> Do you think we also have to modify the perf tool accordingly?
>>>>
>>>> hum, I wonder what's wrong.. will check
>>>
>>> I think the user space needs to enable the event once the
>>> cpu gets online.. which we dont do and your app does..?
>>>
>>> maybe we could add perf_event_attr::enable_on_online ;-)
>>>
>>> I'll check what we can do in user space, I guess we can
>>> monitor the cpu state and enable event accordingly
>>>
>>> jirka
>>>
>> Yes, probably that's the reason.
>>
>> In order for an event to get scheduled-in, it expects the event to be at
>> least in PERF_EVENT_STATE_INACTIVE state. If you notice, in my patch,
>> when the cpu wakes up, we are initializing the state of the event
>> (perf_event__state_init()) and then trying to schedule-in. Since the event
>> was created with a disabled state, it seems that the same this is followed
>> and the state gets initialized to PERF_EVENT_STATE_OFF. Unfortunately,
>> events in this state could not be scheduled.
>>
>> One way for things to get working is, instead of calling
>> perf_event__state_init() before the event is scheduled-in (when the cpu
>> wakes up), we can do something like:
>> perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
> 
> could you add check in ioctl call that set the inactive state
> on the dormant event.. that would start it once the cpu is
> online.. as requested

I am a little confused. When you say "check", do you mean a new ioctl 
command?

So the flow (from the user-space perspective) would go something like this?

1. // CPU offline

2. perf_event_open(); // event started as disabled --> added to dormant 
list in the kernel

3. ioctl(SET_INACTIVE); // change the state of the event to inactive

4. // CPU woken up!

5. // schedule the (inactive) event by traversing the dormant list

Is this what you were trying to mention, or am I missing something?

Raghavendra
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
