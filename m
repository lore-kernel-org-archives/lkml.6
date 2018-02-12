Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeBLWWn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:22:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5B2160F6C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rananta@codeaurora.org
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
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
Message-ID: <6aab2b36-0fe6-7a3d-2106-d4c93ec95a8a@codeaurora.org>
Date: Mon, 12 Feb 2018 14:22:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180212212101.GA15817@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2018 01:21 PM, Jiri Olsa wrote:
> On Mon, Feb 12, 2018 at 10:04:42PM +0100, Jiri Olsa wrote:
>> On Mon, Feb 12, 2018 at 09:42:05AM -0800, Raghavendra Rao Ananta wrote:
>>> Hi Jiri,
>>>
>>> Thank you for the response.
>>>
>>> Does perf tool has its own check to see if the CPU was offline during the
>>> lifetime of an event? If so, it might ignore these type of events.
>>
>> nope, we don't check on that
>>
>>>
>>> Initially, I tested the same using perf tool and found similar results.
>>> Then I debugged further and found that the perf core was actually sending
>>> data to the userspace (copy_to_user()) and the corresponding count for the
>>> data. Hence, I tested this further by writing my own userspace application,
>>> and I was able to read the count through this,
>>> even when the CPU was made offline and back online.
>>>
>>> Do you think we also have to modify the perf tool accordingly?
>>
>> hum, I wonder what's wrong.. will check
> 
> I think the user space needs to enable the event once the
> cpu gets online.. which we dont do and your app does..?
> 
> maybe we could add perf_event_attr::enable_on_online ;-)
> 
> I'll check what we can do in user space, I guess we can
> monitor the cpu state and enable event accordingly
> 
> jirka
> 
Yes, probably that's the reason.

In order for an event to get scheduled-in, it expects the event to be at 
least in PERF_EVENT_STATE_INACTIVE state. If you notice, in my patch,
when the cpu wakes up, we are initializing the state of the event 
(perf_event__state_init()) and then trying to schedule-in. Since the 
event was created with a disabled state, it seems that the same this is 
followed and the state gets initialized to PERF_EVENT_STATE_OFF. 
Unfortunately, events in this state could not be scheduled.

One way for things to get working is, instead of calling 
perf_event__state_init() before the event is scheduled-in (when the cpu 
wakes up), we can do something like:
perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);

I made this change and ran the same test as yours, and I see things 
working out for us:

# ./perf stat -C 1 -e sched:sched_switch -v -I 1000
failed to read counter sched:sched_switch
#           time             counts unit events
      1.000115547      <not counted>      sched:sched_switch 

failed to read counter sched:sched_switch
      2.000265492      <not counted>      sched:sched_switch 

failed to read counter sched:sched_switch
      3.000379462      <not counted>      sched:sched_switch 

failed to read counter sched:sched_switch
      4.000523872      <not counted>      sched:sched_switch 

failed to read counter sched:sched_switch
      5.000614808      <not counted>      sched:sched_switch

/* CPU bought ONLINE here */

sched:sched_switch: 541 284808940 284808940
      6.000767761                541      sched:sched_switch 

sched:sched_switch: 180 1000119686 1000119686
      7.000907234                180      sched:sched_switch 

sched:sched_switch: 248 1000129929 1000129929
      8.001026518                248      sched:sched_switch 

sched:sched_switch: 253 1000173050 1000173050
      9.001203689                253      sched:sched_switch 

sched:sched_switch: 620 1000113378 1000113378
     10.001323334                620      sched:sched_switch 

sched:sched_switch: 366 1000121839 1000121839
     11.001448354                366      sched:sched_switch 

sched:sched_switch: 327 1000147664 1000147664
     12.001591432                327      sched:sched_switch 

^Csched:sched_switch: 272 488810681 488810681
     12.490414290                272      sched:sched_switch 

sched:sched_switch: 6 75893 75893

Yes, so as you mentioned adding something like 
perf_event_attr::enable_on_online gives us a control as to put the event 
in INACTIVE state.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
