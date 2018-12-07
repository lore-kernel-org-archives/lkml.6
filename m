Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C35CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7702081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7702081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLGUaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:30:08 -0500
Received: from foss.arm.com ([217.140.101.70]:53880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGUaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:30:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C9E15AB;
        Fri,  7 Dec 2018 12:30:07 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1CF3F614;
        Fri,  7 Dec 2018 12:30:05 -0800 (PST)
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e9ba0a93-4799-c230-8dcb-6580f6c00635@arm.com>
Date:   Fri, 7 Dec 2018 20:30:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 06/12/2018 21:28, Steve Sistare wrote:
> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> find a task, then attempt to steal a task from an overloaded CPU in the
> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> identify candidates.  To minimize search time, steal the first migratable
> task that is found when the bitmap is traversed.  For fairness, search
> for migratable tasks on an overloaded CPU in order of next to run.
> 
> This simple stealing yields a higher CPU utilization than idle_balance()
> alone, because the search is cheap, so it may be called every time the CPU
> is about to go idle.  idle_balance() does more work because it searches
> widely for the busiest queue, so to limit its CPU consumption, it declines
> to search if the system is too busy.  Simple stealing does not offload the
> globally busiest queue, but it is much better than running nothing at all.
> 
> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
> reduce cache contention vs the usual bitmap when many threads concurrently
> set, clear, and visit elements.
> 
> Patch 1 defines the sparsemask type and its operations.
> 
> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
> 
> Patches 5 and 6 refactor existing code for a cleaner merge of later
>   patches.
> 
> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
> 
> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
> time being because of performance regressions that are not due to stealing
> per-se.  See the patch description for details.
> 
> Patch 10 adds schedstats for comparing the new behavior to the old, and
>   provided as a convenience for developers only, not for integration.
> 
[...]

I've run my usual tests ([1]) on my HiKey960 with 

- Just stealing (only misfit tests)
- Stealing rebased on top of EAS (misfit + EAS tests), and with stealing
  gated by:

----->8-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 17ab4db..8b5172f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7152,7 +7152,8 @@ done: __maybe_unused;
        rq_idle_stamp_update(rq);
 
        new_tasks = idle_balance(rq, rf);
-       if (new_tasks == 0)
+       if (new_tasks == 0 &&
+           (!static_key_unlikely(&sched_energy_present) || READ_ONCE(rq->rd->overutilized))
                new_tasks = try_steal(rq, rf);
 
        if (new_tasks)
-----8<-----

It all looks good from my end - if things were to go wrong on big.LITTLE
platforms it'd be here. It might be a convoluted way of using this tag,
but you can have my

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

as a "it doesn't break my stuff" seal.



As far as the patches go, with my last comments in mind it looks good to me
so you can also have:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

for patches [2-8]. I haven't delved on the sparsemask details. As for patch
9, you might want to run other benchmarks (Peter suggested specjbb) to see
if it is truly need.

[1]: https://github.com/ARM-software/lisa/tree/next/lisa/tests/kernel/scheduler
