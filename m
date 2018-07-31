Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A13C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F0520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F0520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeGaONw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:13:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732198AbeGaONw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:13:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 147AB80D;
        Tue, 31 Jul 2018 05:33:45 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D47373F5D0;
        Tue, 31 Jul 2018 05:33:43 -0700 (PDT)
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
 <20180706143139.GE8596@e105550-lin.cambridge.arm.com>
 <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <fd8c6bc2-3a1c-3572-7082-bc51c8f87ae9@arm.com>
Date:   Tue, 31 Jul 2018 13:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/07/18 13:17, Vincent Guittot wrote:
> On Fri, 6 Jul 2018 at 16:31, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>>
>> On Fri, Jul 06, 2018 at 12:18:17PM +0200, Vincent Guittot wrote:
>>> [...]
>>
>> Scheduling one task per cpu when n_task == n_cpus on asymmetric
>> topologies is generally broken already and this patch set doesn't fix
>> that problem.
>>
>> SD_PREFER_SIBLING might seem to help in very specific cases:
>> n_litte_cpus == n_big_cpus. In that case the little group might
>> classified as overloaded. It doesn't guarantee that anything gets pulled
>> as the grp_load/grp_capacity in the imbalance calculation on some system
>> still says the little cpus are more loaded than the bigs despite one of
>> them being idle. That depends on the little cpu capacities.
>>
>> On systems where n_little_cpus != n_big_cpus SD_PREFER_SIBLING is broken
>> as it assumes the group_weight to be the same. This is the case on Juno
>> and several other platforms.
>>
>> IMHO, SD_PREFER_SIBLING isn't the solution to this problem. It might
> 
> I agree but this patchset creates a regression in the scheduling behavior
> 
>> help for a limited subset of topologies/capacities but the right
>> solution is to change the imbalance calculation. As the name says, it is
> 
> Yes that what does the prototype that I came with.
> 
>> meant to spread tasks and does so unconditionally. For asymmetric
>> systems we would like to consider cpu capacity before migrating tasks.
>>
>>> When running the tests of your cover letter, 1 long
>>> running task is often co scheduled on a big core whereas short pinned
>>> tasks are still running and a little core is idle which is not an
>>> optimal scheduling decision
>>
>> This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
>> say that this patch breaks anything that isn't broken already. In fact
>> we this happening with and without this patch applied.
> 
> At least for the use case  above, this doesn't happen when
> SD_PREFER_SIBLING is set
> 

On my HiKey960 I can see coscheduling on a big CPU while a LITTLE is free
with **and** without SD_PREFER_SIBLING. Having it set only means that in
some cases the imbalance will be re-classified as group_overloaded instead
of group_misfit_task, so we'll skip the misfit logic when we shouldn't (this
happens on Juno for instance).

It does nothing for the "1 task per CPU" problem that Morten described above.
When you have this little amount of tasks, load isn't very relevant, but it
skews the load-balancer into thinking the LITTLE CPUs are more busy than
the bigs even though there's an idle one in the lot.

>>
>> Morten
