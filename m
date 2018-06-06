Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5vXkxkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E128C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeFFKC7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:02:59 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44033 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbeFFKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:02:57 -0400
X-Google-Smtp-Source: ADUXVKJBeEx3v3dJpUIwnzMpB2GJmHxRdmdMh/xXTX168/CO9DqU3Ct9ldzqBjx2lpMD0tStH8PmsiBITZRGvz8CYds=
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB4YJm=8dqf=9_o+jkL2fjShPtwyO-8tDAKCp9pW0Y3jQ@mail.gmail.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net> <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
 <20180605141809.GV12180@hirez.programming.kicks-ass.net> <20180606094409.GA10870@e108498-lin.cambridge.arm.com>
 <CAKfTPtB4YJm=8dqf=9_o+jkL2fjShPtwyO-8tDAKCp9pW0Y3jQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Jun 2018 12:02:35 +0200
Message-ID: <CAKfTPtD8RHXjfoT80ZEfH3k31tAFx_aipe==o9RG5wZgubhUiQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
To: Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 June 2018 at 11:59, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> On 6 June 2018 at 11:44, Quentin Perret <quentin.perret@arm.com> wrote:
>> On Tuesday 05 Jun 2018 at 16:18:09 (+0200), Peter Zijlstra wrote:

[snip]

>>>
>>> > As you mentioned, scale_rt_capacity give the remaining capacity for
>>> > cfs and it will behave like cfs util_avg now that it uses PELT. So as
>>> > long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
>>> > we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
>>> > OPP because we have remaining spare capacity but if  cfs util_avg ==
>>> > scale_rt_capacity, we make sure to use max OPP.
>>>
>>> Good point, when cfs-util < cfs-cap then there is idle time and the util
>>> number is 'right', when cfs-util == cfs-cap we're overcommitted and
>>> should go max.
>>>
>>> Since the util and cap values are aligned that should track nicely.

I have re run my tests and and the results seem to be ok so far.

I'm going to clean up a bit the code used for the test and sent a new
version of the proposal

>>
>> So Vincent proposed to have a margin between cfs util and cfs cap to be
>> sure there is a little bit of idle time. This is _exactly_ what the
>> overutilized flag in EAS does. That would actually make a lot of sense
>> to use that flag in schedutil. The idea is basically to say, if there
>> isn't enough idle time on all CPUs, the util signal are kinda wrong, so
>> let's not make any decisions (task placement or OPP selection) based on
>> that. If overutilized, go to max freq. Does that make sense ?
>
> Yes it's similar to the overutilized except that
> - this is done per cpu and whereas overutilization is for the whole system
> - the test is done at every freq update and not only during some cfs
> event and it uses the last up to date value and not a periodically
> updated snapshot of the value
> - this is done also without EAS
>
> Then for the margin, it has to be discussed if it is really needed or not
>
>>
>> Thanks,
>> Quentin
