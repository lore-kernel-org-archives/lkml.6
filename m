Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934506AbeBMQIb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:08:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933764AbeBMQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:08:30 -0500
Date: Tue, 13 Feb 2018 17:08:26 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] perf: Add support for creating offline events
Message-ID: <20180213160826.GA9121@krava>
References: <1518217620-28458-1-git-send-email-rananta@codeaurora.org>
 <20180212094357.GD5821@krava>
 <53408020-8638-4947-90f6-87dbc4c2c4e5@codeaurora.org>
 <20180212210442.GA32093@krava>
 <20180212212101.GA15817@krava>
 <6aab2b36-0fe6-7a3d-2106-d4c93ec95a8a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aab2b36-0fe6-7a3d-2106-d4c93ec95a8a@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:22:30PM -0800, Raghavendra Rao Ananta wrote:
> 
> 
> On 02/12/2018 01:21 PM, Jiri Olsa wrote:
> > On Mon, Feb 12, 2018 at 10:04:42PM +0100, Jiri Olsa wrote:
> > > On Mon, Feb 12, 2018 at 09:42:05AM -0800, Raghavendra Rao Ananta wrote:
> > > > Hi Jiri,
> > > > 
> > > > Thank you for the response.
> > > > 
> > > > Does perf tool has its own check to see if the CPU was offline during the
> > > > lifetime of an event? If so, it might ignore these type of events.
> > > 
> > > nope, we don't check on that
> > > 
> > > > 
> > > > Initially, I tested the same using perf tool and found similar results.
> > > > Then I debugged further and found that the perf core was actually sending
> > > > data to the userspace (copy_to_user()) and the corresponding count for the
> > > > data. Hence, I tested this further by writing my own userspace application,
> > > > and I was able to read the count through this,
> > > > even when the CPU was made offline and back online.
> > > > 
> > > > Do you think we also have to modify the perf tool accordingly?
> > > 
> > > hum, I wonder what's wrong.. will check
> > 
> > I think the user space needs to enable the event once the
> > cpu gets online.. which we dont do and your app does..?
> > 
> > maybe we could add perf_event_attr::enable_on_online ;-)
> > 
> > I'll check what we can do in user space, I guess we can
> > monitor the cpu state and enable event accordingly
> > 
> > jirka
> > 
> Yes, probably that's the reason.
> 
> In order for an event to get scheduled-in, it expects the event to be at
> least in PERF_EVENT_STATE_INACTIVE state. If you notice, in my patch,
> when the cpu wakes up, we are initializing the state of the event
> (perf_event__state_init()) and then trying to schedule-in. Since the event
> was created with a disabled state, it seems that the same this is followed
> and the state gets initialized to PERF_EVENT_STATE_OFF. Unfortunately,
> events in this state could not be scheduled.
> 
> One way for things to get working is, instead of calling
> perf_event__state_init() before the event is scheduled-in (when the cpu
> wakes up), we can do something like:
> perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);

could you add check in ioctl call that set the inactive state
on the dormant event.. that would start it once the cpu is
online.. as requested

jirka
