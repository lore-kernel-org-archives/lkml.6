Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDUVIf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 17:08:35 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37832 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDUVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 17:08:33 -0400
X-Google-Smtp-Source: AIpwx49eP7nhXHotgUkqnEtez4vlmMTclZqI8M5NATt2l79PnnlHUVBOQRlznzOErpP4PYZvEQKiYU6ajrl9nw+0nJE=
MIME-Version: 1.0
In-Reply-To: <20180410200514.GA793541@devbig577.frc2.facebook.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-5-patrick.bellasi@arm.com> <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 <20180410171612.GJ14248@e110439-lin> <20180410200514.GA793541@devbig577.frc2.facebook.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Sat, 21 Apr 2018 14:08:30 -0700
Message-ID: <CAEi0qNmwT0h0R5GM0X71CzYyd_VmykxgrT0rPZgnGBw3pSQJNQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] sched/core: uclamp: add utilization clamping to the
 CPU controller
To: Tejun Heo <tj@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Tue, Apr 10, 2018 at 1:05 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Tue, Apr 10, 2018 at 06:16:12PM +0100, Patrick Bellasi wrote:
>> > I'm not too enthusiastic about util_min/max given that it can easily
>> > be read as actual utilization based bandwidth control when what's
>> > actually implemented, IIUC, is affecting CPU frequency selection.
>>
>> Right now we are basically affecting the frequency selection.
>> However, the next step is to use this same interface to possibly bias
>> task placement.
>>
>> The idea is that:
>>
>> - the util_min value can be used to possibly avoid CPUs which have
>>   a (maybe temporarily) limited capacity, for example, due to thermal
>>   pressure.
>>
>> - a util_max value can use used to possibly identify tasks which can
>>   be co-scheduled together in a (maybe) limited capacity CPU since
>>   they are more likely "less important" tasks.
>>
>> Thus, since this is a new user-space API, we would like to find a
>> concept which is generic enough to express the current requirement but
>> also easily accommodate future extensions.
>
> I'm not sure we can overload the meanings like that on the same
> interface.  Right now, it doesn't say anything about bandwidth (or
> utilization) allocation.  It just limits the frequency range the
> particular cpu that the task ended up on can be in and what you're
> describing above is the third different thing.  It doesn't seem clear
> that they're something which can be overloaded onto the same
> interface.

Actually no, its not about overloading them. What's Patrick is
defining here is a property/attribute. What that attribute is used for
(the algorithms that use it) are a different topic. Like, it can be
used by the frequency selection algorithms or the task placement
algorithm. There are multiple algorithms that can use the property. To
me, this part of the patch makes sense. Maybe it should really be
called "task_size" or something, since that's what it really is.

[...]
>> > > Tasks on a subgroup can only be more boosted and/or capped, which is
>> >
>> > Less boosted.  .low at a parent level must set the upper bound of .low
>> > that all its descendants can have.
>>
>> Is that a mandatory requirement? Or based on a proper justification
>> you can also accept what I'm proposing?
>>
>> I've always been more of the idea that what I'm proposing could make
>> more sense for a general case but perhaps I just need to go back and
>> better check the use-cases we have on hand to see if it's really
>> required or not.
>
> Yeah, I think we want to stick to that semantics.  That's what memory
> controller does and it'd be really confusing to flip the directions on
> different controllers.
>

What about the .high ? I think there was some confusion about how to
define that for subgroups. It could perhaps be such that the .high of
parent is the lower bound of the .high on child but then I'm not sure
if that fits well with the delegation policies...

thanks,

- Joel
