Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108FCC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993F23F04
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUgxZFwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A993F23F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeGFKSn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:18:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56216 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeGFKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:18:39 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so15836371itl.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvYXy6L/AR/W5i/s3KFm6c4dlA3bSjXeUIjAm4Oxcak=;
        b=JUgxZFwdvJthO5ny3hnAQ5IRzuleF7RXzP9Bv0uEG3/8jxa9nrIXabispHY3RE035C
         V47J4rGzoZ5/I6EdB49CtadRjlE2q/aMzzPHNqjVeRqtRF2znT64tAqELr7sK1BH7JjZ
         jx4Wr/LrbPe/ilMZH6P9S98d+nreGtgsAWY50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvYXy6L/AR/W5i/s3KFm6c4dlA3bSjXeUIjAm4Oxcak=;
        b=CU+cZ8MOqgkzpanPg9/VZmLirv1jWRwfejYIQSUzK4y9E/5G0oJfdPMmUjUMmN95tu
         QtimgXA+D5tkpGfAFa3rVIjtlIMpBvTau5vUJa47ZWVl3WGsXK/Pjs8eJDu1gAOQwmNV
         XNU6qwfdEXco/oS6UAwDeh+zKPVu4Kd2XnaE39Dgjtrc56v5HK8yKsLnvDc48YPZCNl3
         3yS/RkeJH+uorfI38W+DowYHstFa9y6r6Bcnv8xaCm2NRwm3kyhTDTkDzgUiphyoEtPt
         BaUCejAeJh4aWYwfc+ePASg4Nm/YJO+j31J6+GWxSHxSzod9G26ULjcb0i1/z32HX+3C
         +P5g==
X-Gm-Message-State: APt69E3+yKEmSFHm5jiybVFxryrHUIcp1hRcSho5dIJ/6RULMB/rR64R
        Ub5OhJUWRXusQVs7u6kVmDOruEVI1ilBzM1XqlXNaQ==
X-Google-Smtp-Source: AAOMgpdbyt00JIwpRzhXi9rinnMoBnX+ss8vROLa5VxWL8F9w3ZyqDAVqGuH0dq0hz0eqTNzQr0DO5CEOS5y/JSgpcY=
X-Received: by 2002:a24:99c4:: with SMTP id a187-v6mr7449140ite.148.1530872318719;
 Fri, 06 Jul 2018 03:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Jul 2018 12:18:27 +0200
Message-ID: <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten,

On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> On asymmetric cpu capacity systems (e.g. Arm big.LITTLE) it is crucial
> for performance that cpu intensive tasks are aggressively migrated to
> high capacity cpus as soon as those become available. The capacity
> awareness tweaks already in the wake-up path can't handle this as such
> tasks might run or be runnable forever. If they happen to be placed on a
> low capacity cpu from the beginning they are stuck there forever while
> high capacity cpus may have become available in the meantime.
>
> To address this issue this patch set introduces a new "misfit"
> load-balancing scenario in periodic/nohz/newly idle balance which tweaks
> the load-balance conditions to ignore load per capacity in certain
> cases. Since misfit tasks are commonly running alone on a cpu, more
> aggressive active load-balancing is needed too.
>
> The fundamental idea of this patch set has been in Android kernels for a
> long time and is absolutely essential for consistent performance on
> asymmetric cpu capacity systems.
>

As already said , I'm not convinced by the proposal which seems quite
complex and also adds some kind of arbitrary and fixed power
management policy by deciding which tasks can or not go on big cores
whereas there are other frameworks to take such decision like EAS or
cgroups. Furthermore, there is already something similar in the kernel
with SD_ASYM_PACKING and IMO, it would be better to improve this
feature (if needed) instead of adding a new one which often do similar
things.
I have rerun your tests and got same results than misfit task patchset
on my hikey960 with SD_ASYM_PACKING feature for legacy b.L topology
and fake dynamiQ topology. And it give better performance when the
pinned tasks are short and scheduler has to wait for the task to
increase their utilization before getting a chance to migrate on big
core.
Then, I have tested SD_ASYM_PACKING with EAS patchset and they work
together for b/L and dynamiQ topology

> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
>
> Test case:
> Big cpus are always kept busy. Pin a shorter running sysbench tasks to
> big cpus, while creating a longer running set of unpinned sysbench
> tasks.
>
>     REQUESTS=1000
>     BIGS="1 2"
>     LITTLES="0 3 4 5"
>
>     # Don't care about the score for those, just keep the bigs busy
>     for i in $BIGS; do
>         taskset -c $i sysbench --max-requests=$((REQUESTS / 4)) \
>         --test=cpu  run &>/dev/null &
>     done
>
>     for i in $LITTLES; do
>         sysbench --max-requests=$REQUESTS --test=cpu run \
>         | grep "total time:" &
>     done
>
>     wait
>
> Results:
> Single runs with completion time of each task
> Juno (tip)
>     total time:                          1.2608s
>     total time:                          1.2995s
>     total time:                          1.5954s
>     total time:                          1.7463s
>
> Juno (misfit)
>     total time:                          1.2575s
>     total time:                          1.3004s
>     total time:                          1.5860s
>     total time:                          1.5871s
>
> Hikey960 (tip)
>     total time:                          1.7431s
>     total time:                          2.2914s
>     total time:                          2.5976s
>     total time:                          1.7280s
>
> Hikey960 (misfit)
>     total time:                          1.7866s
>     total time:                          1.7513s
>     total time:                          1.6918s
>     total time:                          1.6965s
>
> 10 run summary (tracking longest running task for each run)
>         Juno            Hikey960
>         avg     max     avg     max
> tip     1.7465  1.7469  2.5997  2.6131
> misfit  1.6016  1.6192  1.8506  1.9666
>
> Changelog:
> v4
> - Added check for empty cpu_map in sd_init().
> - Added patch to disable SD_ASYM_CPUCAPACITY for root_domains that don't
>   observe capacity asymmetry if the system as a whole is asymmetric.
> - Added patch to disable SD_PREFER_SIBLING on the sched_domain level below
>   SD_ASYM_CPUCAPACITY.
> - Rebased against tip/sched/core.
> - Fixed uninitialised variable introduced in update_sd_lb_stats.
> - Added patch to do a slight variable initialisation cleanup in update_sd_lb_stats.
> - Removed superfluous type changes for temp variables assigned to root_domain->overload.
> - Reworded commit for the patch setting rq->rd->overload when misfit.
> - v3 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
>
> v3
> - Fixed locking around static_key.
> - Changed group per-cpu capacity comparison to be based on max rather
>   than min capacity.
> - Added patch to prevent occasional pointless high->low capacity
>   migrations.
> - Changed type of group_misfit_task_load and misfit_task_load to
>   unsigned long.
> - Changed fbq() to pick the cpu with highest misfit_task_load rather
>   than breaking when the first is found.
> - Rebased against tip/sched/core.
> - v2 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
>
> v2
> - Removed redudant condition in static_key enablement.
> - Fixed logic flaw in patch #2 reported by Yi Yao <yi.yao@intel.com>
> - Dropped patch #4 as although the patch seems to make sense no benefit
>   has been proven.
> - Dropped root_domain->overload renaming
> - Changed type of root_domain->overload to int
> - Wrapped accesses of rq->rd->overload with READ/WRITE_ONCE
> - v1 Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>
>
> Chris Redpath (1):
>   sched/fair: Don't move tasks to lower capacity cpus unless necessary
>
> Morten Rasmussen (6):
>   sched: Add static_key for asymmetric cpu capacity optimizations
>   sched/fair: Add group_misfit_task load-balance type
>   sched: Add sched_group per-cpu max capacity
>   sched/fair: Consider misfit tasks when load-balancing
>   sched/core: Disable SD_ASYM_CPUCAPACITY for root_domains without
>     asymmetry
>   sched/core: Disable SD_PREFER_SIBLING on asymmetric cpu capacity
>     domains
>
> Valentin Schneider (5):
>   sched/fair: Kick nohz balance if rq->misfit_task_load
>   sched/fair: Change prefer_sibling type to bool
>   sched: Change root_domain->overload type to int
>   sched: Wrap rq->rd->overload accesses with READ/WRITE_ONCE
>   sched/fair: Set rq->rd->overload when misfit
>
>  kernel/sched/fair.c     | 161 +++++++++++++++++++++++++++++++++++++++++-------
>  kernel/sched/sched.h    |  16 +++--
>  kernel/sched/topology.c |  53 ++++++++++++++--
>  3 files changed, 199 insertions(+), 31 deletions(-)
>
> --
> 2.7.4
>
