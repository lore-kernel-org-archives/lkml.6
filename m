Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeBLJoB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:44:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933099AbeBLJoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:44:00 -0500
Date: Mon, 12 Feb 2018 10:43:57 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <20180212094357.GD5821@krava>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 03:07:00PM -0800, Raghavendra Rao Ananta wrote:
> Perf framework doesn't allow creation of hardware events if
> the requested CPU is offline. However, creation of an event
> is achievable if the event is attached to the PMU as soon
> as the CPU is online again.
> 
> So, introducing a feature that could allow to create events
> even when the CPU is offline and return a success to the caller.
> If, during the time of event creation, the CPU is found offline,
> the event is moved to a new state (PERF_EVENT_STATE_DORMANT). As
> and when the CPU is know to be woken up (through hotplug notifiers),
> all the dormant events would be attached to the PMU (by
> perf_install_in_context()). If during the life time of the event,
> the CPU hasn't come online, the dormant event would just be freed.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>

hum, I tried and for some reason I'm getting zero counts/times
when the cpu 1 is set back online (in 9.second)

[root@ibm-x3650m4-02 perf]# ./perf stat -C 1 -e sched:sched_switch -v -I 1000
failed to read counter sched:sched_switch
#           time             counts unit events
     1.000921624      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     2.001725364      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     3.002685350      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     4.003463851      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     5.004651601      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     6.005338294      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     7.006351155      <not counted>      sched:sched_switch                                          
failed to read counter sched:sched_switch
     8.007239698      <not counted>      sched:sched_switch                                          
sched:sched_switch: 0 0 0
     9.008665621      <not counted>      sched:sched_switch                                          
sched:sched_switch: 0 0 0
    10.009570492      <not counted>      sched:sched_switch                                          
sched:sched_switch: 0 0 0
    11.010811591      <not counted>      sched:sched_switch                                          
sched:sched_switch: 0 0 0
    12.011614182      <not counted>      sched:sched_switch                                          
sched:sched_switch: 0 0 0
    13.012299851      <not counted>      sched:sched_switch                                          

looks like the dormant event wasn't scheduled in properly

also while at it, could we also handle cpu going offline case,
so the event would survive until it's back online

jirka
