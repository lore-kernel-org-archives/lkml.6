Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965969AbeBMWRJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:17:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965900AbeBMWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:17:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Feb 2018 14:17:07 -0800
From: Sodagudi Prasad <psodagud@codeaurora.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Raghavendra Rao Ananta <rananta@codeaurora.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
In-Reply-To: <20180213182351.GQ25201@hirez.programming.kicks-ass.net>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
 <20180213182351.GQ25201@hirez.programming.kicks-ass.net>
Message-ID: <7d3d97fafa654c30b4ca776180760cb3@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-13 10:23, Peter Zijlstra wrote:
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
> 
> This is horrible.. and you seem to have forgotten to explain why you
> care about offline CPUs.
Hi Peter,

Up to 4.9 kernel, drivers can register cpu hotplug notfiters and drivers 
are able to create perf events dynamically based cpu notifies callback 
events.
As cpu hot plug is converted to state machine approach from hot plug 
notifiers,  every driver need to define a cpuhp state and registers with 
cpu hotplug state machine for creating perf events dynamically.

Qualcomm have use cases to monitor the cpu cycles and other hw events 
continuously on all cpus from kernel and profiling tools.
So we are thinking that there could be other soc vendors, who are 
interested in perf events preserving across cpu hot plug and perf events 
creation on hot plugged cores.

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
