Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742A921945
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742A921945
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbeHFOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:38:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:38:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 052DA80D;
        Mon,  6 Aug 2018 05:29:33 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.Emea.Arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137C63F2EA;
        Mon,  6 Aug 2018 05:29:27 -0700 (PDT)
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
References: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin>
 <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
 <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
 <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
 <68689fcb-3cb8-4685-58ef-0bec84be2047@arm.com>
 <CAKfTPtADSDJJaPr17zD8ZNtS7CQGBwfU6JDGRwssLN20zyW7Nw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1cac0d16-9f50-ed30-2460-340b077faa57@arm.com>
Date:   Mon, 6 Aug 2018 14:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtADSDJJaPr17zD8ZNtS7CQGBwfU6JDGRwssLN20zyW7Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 12:33 PM, Vincent Guittot wrote:
> On Mon, 6 Aug 2018 at 12:08, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/06/2018 10:40 AM, Vincent Guittot wrote:
>>> On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
>>>>
>>>> On Friday 03 Aug 2018 at 15:49:24 (+0200), Vincent Guittot wrote:
>>>>> On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
>>>>>>
>>>>>> On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
>>>>>>> On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
>>
>> [...]
>>
>>>> I think we're discussing two different things right now:
>>>>       1. Should forkees go in find_energy_efficient_cpu() ?
>>>>       2. Should forkees have 0 of initial util_avg when EAS is enabled ?
>>>
>>> It's the same topic: How EAS should consider a newly created task ?
>>>
>>> For now, we let the "performance" mode selects a CPU. This CPU will
>>> most probably be worst CPU from a EAS pov because it's the idlest CPU
>>> in the idlest group which is the opposite of what EAS tries to do
>>>
>>> The current behavior is :
>>> For every new task, the cpu selection is done assuming it's a heavy
>>> task with the max possible load_avg,  and it looks for the idlest cpu.
>>> This means that if the system is lightly loaded, scheduler will select
>>> most probably a idle big core.
>>
>> AFAICS, task load doesn't seem to be used for find_idlest_cpu() (
>> find_idlest_group() and find_idlest_group_cpu()). So the forkee
>> (SD_BALANCE_FORK) is placed independently of his task load.
> 
> hmm ... so what is used if load or runnable load are not used ?
> find_idlest_group() uses load and runnable load but skip spare
> capacity in case of fork

Yes, runnable load and load are used, but from the cpus, not from the task.

[...]
