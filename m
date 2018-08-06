Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5617821A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5617821A01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeHFNCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:02:24 -0400
Received: from foss.arm.com ([217.140.101.70]:36262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeHFNCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:02:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD9818A;
        Mon,  6 Aug 2018 03:53:53 -0700 (PDT)
Received: from [10.4.12.39] (e113632-lin.emea.arm.com [10.4.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 806763F5D4;
        Mon,  6 Aug 2018 03:53:52 -0700 (PDT)
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
 <20180706143139.GE8596@e105550-lin.cambridge.arm.com>
 <CAKfTPtB1YGoYwNyXXs5_+0Lc3KiDZ1g=5nXsa_Y03pJEbQ+jgg@mail.gmail.com>
 <fd8c6bc2-3a1c-3572-7082-bc51c8f87ae9@arm.com>
 <CAKfTPtA3_yBf-NjPJcZUw=ijhq-HBa0A9U=Djcc_K1XQz45EPQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <b7c78d65-ab85-36ce-6da6-d10e5113c4a3@arm.com>
Date:   Mon, 6 Aug 2018 11:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA3_yBf-NjPJcZUw=ijhq-HBa0A9U=Djcc_K1XQz45EPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/08/18 11:20, Vincent Guittot wrote:
> Hi Valentin,
> 
> On Tue, 31 Jul 2018 at 14:33, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> Hi,
>>
>> On 31/07/18 13:17, Vincent Guittot wrote:
>> [...]
>>>>
>>>> This can easily happen with SD_PREFER_SIBLING enabled too so I wouldn't
>>>> say that this patch breaks anything that isn't broken already. In fact
>>>> we this happening with and without this patch applied.
>>>
>>> At least for the use case  above, this doesn't happen when
>>> SD_PREFER_SIBLING is set
>>>
>>
>> On my HiKey960 I can see coscheduling on a big CPU while a LITTLE is free
>> with **and** without SD_PREFER_SIBLING. Having it set only means that in
>> some cases the imbalance will be re-classified as group_overloaded instead
>> of group_misfit_task, so we'll skip the misfit logic when we shouldn't (this
>> happens on Juno for instance).
> 
> Can you give more details about your test case ?
> 

I've been running the same test case as presented in the cover letter on
my HiKey960 but with sched_switch tracing and with no tasksets. I've just
re-run the testcase with tasksets and I get similar results (i.e. a big
with coscheduling while a LITTLE is free) with or without the flag.

>>
>> It does nothing for the "1 task per CPU" problem that Morten described above.
>> When you have this little amount of tasks, load isn't very relevant, but it
>> skews the load-balancer into thinking the LITTLE CPUs are more busy than
>> the bigs even though there's an idle one in the lot.
>>
>>>>
>>>> Morten
