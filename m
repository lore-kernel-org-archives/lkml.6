Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeBLRmd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:42:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeBLRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:42:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A3F960246
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
From: Raghavendra Rao Ananta <rananta@codeaurora.org>
Message-ID: <53408020-8638-4947-90f6-87dbc4c2c4e5@codeaurora.org>
Date: Mon, 12 Feb 2018 09:42:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180212094357.GD5821@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thank you for the response.

Does perf tool has its own check to see if the CPU was offline during 
the lifetime of an event? If so, it might ignore these type of events.

Initially, I tested the same using perf tool and found similar results.
Then I debugged further and found that the perf core was actually 
sending data to the userspace (copy_to_user()) and the corresponding 
count for the data. Hence, I tested this further by writing my own 
userspace application, and I was able to read the count through this,
even when the CPU was made offline and back online.

Do you think we also have to modify the perf tool accordingly?

Find an inline comment.

On 02/12/2018 01:43 AM, Jiri Olsa wrote:
> On Fri, Feb 09, 2018 at 03:07:00PM -0800, Raghavendra Rao Ananta wrote:
>> Perf framework doesn't allow creation of hardware events if
>> the requested CPU is offline. However, creation of an event
>> is achievable if the event is attached to the PMU as soon
>> as the CPU is online again.
>>
>> So, introducing a feature that could allow to create events
>> even when the CPU is offline and return a success to the caller.
>> If, during the time of event creation, the CPU is found offline,
>> the event is moved to a new state (PERF_EVENT_STATE_DORMANT). As
>> and when the CPU is know to be woken up (through hotplug notifiers),
>> all the dormant events would be attached to the PMU (by
>> perf_install_in_context()). If during the life time of the event,
>> the CPU hasn't come online, the dormant event would just be freed.
>>
>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> 
> hum, I tried and for some reason I'm getting zero counts/times
> when the cpu 1 is set back online (in 9.second)
> 
> [root@ibm-x3650m4-02 perf]# ./perf stat -C 1 -e sched:sched_switch -v -I 1000
> failed to read counter sched:sched_switch
> #           time             counts unit events
>       1.000921624      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       2.001725364      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       3.002685350      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       4.003463851      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       5.004651601      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       6.005338294      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       7.006351155      <not counted>      sched:sched_switch
> failed to read counter sched:sched_switch
>       8.007239698      <not counted>      sched:sched_switch
> sched:sched_switch: 0 0 0
>       9.008665621      <not counted>      sched:sched_switch
> sched:sched_switch: 0 0 0
>      10.009570492      <not counted>      sched:sched_switch
> sched:sched_switch: 0 0 0
>      11.010811591      <not counted>      sched:sched_switch
> sched:sched_switch: 0 0 0
>      12.011614182      <not counted>      sched:sched_switch
> sched:sched_switch: 0 0 0
>      13.012299851      <not counted>      sched:sched_switch
> 
> looks like the dormant event wasn't scheduled in properly
> 
> also while at it, could we also handle cpu going offline case,
> so the event would survive until it's back online
Sure, I have a plan for that one as well, but wondering how this goes first.
> 
> jirka
> 

Thank you.

Raghavendra

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
