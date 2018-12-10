Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ECE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ECE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeLJRGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:06:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeLJRGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:06:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9A91596;
        Mon, 10 Dec 2018 09:06:20 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FAC93F6A8;
        Mon, 10 Dec 2018 09:06:18 -0800 (PST)
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     Steven Sistare <steven.sistare@oracle.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Rik van Riel <riel@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <CAKfTPtBuAsbF2r8wSigM=ckpKCqj0hcHbi+y3ZAaC7dqYcFY2g@mail.gmail.com>
 <df0197ac-d4eb-437e-1176-dbc9b23a94bb@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6dd38557-149b-bdea-a544-cde2dcf563ae@arm.com>
Date:   Mon, 10 Dec 2018 17:06:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <df0197ac-d4eb-437e-1176-dbc9b23a94bb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2018 16:29, Steven Sistare wrote:
[...]
>> I have run some hackbench tests on my hikey arm64 octo cores with your
>> patchset. My original intent was to send a tested-by but I have some
>> performances regressions.
>> This hikey is the smp one and not the asymetric hikey960 that Valentin
>> used for his tests
>> The sched domain topology is
>> domain-0: span=0-3 level=MC  and domain-0: span=4-7 level=MC
>> domain-1: span=0-7 level=DIE
>>
>> I have run 12 times hackbench -g $j -P -l 2000 with j equals to 1 2 3 4 8
>>
>> grps  time
>> 1      1.396
>> 2      2.699
>> 3      3.617
>> 4      4.498
>> 8      7.721
>>
>> Then after disabling STEAL in sched_feature with echo NO_STEAL >
>> /sys/kernel/debug/sched_features , the results become:
>> grps  time
>> 1      1.217
>> 2      1.973
>> 3      2.855
>> 4      3.932
>> 8      7.674
>>
>> I haven't looked in details about some possible reasons of such
>> difference yet and haven't collected the stats that you added with
>> patch 10.
>> Have you got a script to collect and post process them ?
>>

I used the script that Steve sent just before LPC [1] - I probably should
have given that a try sooner...


Running the base "hackseries" on my H960 gave me this:

          --- base --    --- new ---
groups    time %stdev    time %stdev  %speedup
     1   1.021    9.1   1.214    9.1     -15.9
     2   1.066    4.3   1.232    7.1     -13.5
     3   1.140    9.3   1.247    3.0      -8.6
     4   1.207    5.4   1.246    6.2      -3.2


Now that board struggles with thermal, so I swapped the order of testing
(STEAL enabled first, then NO_STEAL) out of curiosity:

          --- base --    --- new ---
groups    time %stdev    time %stdev  %speedup
     1   0.986    8.6   1.218    4.9     -19.1
     2   1.096    5.5   1.290    6.2     -15.1
     3   1.124    5.5   1.237    8.1      -9.2
     4   1.181    8.7   1.238    5.9      -4.7


And actually running the same test twice with NO_STEAL gives me:

          --- base --    --- new ---
groups    time %stdev    time %stdev  %speedup
     1   1.005    8.3   1.225    5.5     -18.0
     2   1.126    6.4   1.220    7.1      -7.8
     3   1.199    5.8   1.264    3.2      -5.2
     4   1.167    4.6   1.314    8.5     -11.2


We might need some other benchmark to test this. Or a much bigger fan...

[1]: https://lore.kernel.org/lkml/0eaa3ee9-64d6-4739-eec9-e28befa0e97f@oracle.com/

>> Regards,
>> Vincent
> 
> Thanks Vincent.  What is the value of /proc/sys/kernel/sched_wakeup_granularity_ns?
> Try 15000000.  Your 8-core system is heavily overloaded with 40 * groups tasks,
> and I suspect preemptions are killing performance.
> 

While hackbench is not super representative of "real life", I wonder if we
shouldn't do something about the default if using stealing suggests it
(wild speculation here).

> I have a python script to post-process schedstat files, but it does many things
> and is large and I am not ready to share it.  I can write a short bash script if
> that would help.
> 
> - Steve
> 
