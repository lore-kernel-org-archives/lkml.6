Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBADA13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D4920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D4920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeG3QFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:05:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeG3QFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A3E515A2;
        Mon, 30 Jul 2018 07:30:31 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.Emea.Arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7443E3F5BA;
        Mon, 30 Jul 2018 07:30:29 -0700 (PDT)
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
 <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
 <98eb0daf-4467-3790-ec80-90b746807392@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7bad2238-369c-f61c-0a51-eb14204e0429@arm.com>
Date:   Mon, 30 Jul 2018 16:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <98eb0daf-4467-3790-ec80-90b746807392@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 07:14 PM, Valentin Schneider wrote:
> Hi,
> 
> On 09/07/18 16:08, Morten Rasmussen wrote:
>> On Fri, Jul 06, 2018 at 12:18:27PM +0200, Vincent Guittot wrote:
>>> Hi Morten,
>>>
>>> On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:

[...]

> With that out of the way, I did some lmbench runs:
>> lat_mem_rd 10 1024
> 
> With ASYM_PACKING, I still see lmbench tasks remaining on LITTLE CPUs while
> bigs are free, because ASYM_PACKING only does explicit active balancing on
> CPU_NEWLY_IDLE balancing - otherwise it'll rely on the nr_balance_failed counter.
> 
> However, that counter can be reset before it reaches the threshold at which
> active balance is done, which can lead to huge upmigration delays (almost a
> full second). I also see the same kind of issues on Juno r0.
> 
> This could be resolved by extending ASYM_PACKING active balancing to
> non NEWLY_IDLE cases, but then we'd be thrashing everything. That's another
> argument for basing upmigration on task load-tracking signals, as we can
> determine which tasks need active balancing much faster than the
> nr_balance_failed counter way while not active balancing the world.

The task layout of the test looks like n=85 always running tasks (each 
for ~ 1.25ms on big or little) and they all get created and run one 
after the other. So on a big cpu, their util values go from 512 to 1024 
and from 223 to 446 on little cpu (Juno board). Latter thanks to 
Quentin's 'sched/fair: Fix util_avg of new tasks for asymmetric systems'.

root@juno:~# cat /sys/devices/system/cpu/cpu[01]/cpu_capacity
446
1024

> (lat_mem_rd 10 1024) with ASYM_PACKING:

...
> 4.0 148.66   <-----
> 4.5 10.191
...
> 7.5 10.203
> 8.0 154.354   <-----

I ran the test affine to big, little and all cpus on tip/sched/core w/o 
ASYM_PACKING or Misfit:

cputype:     big  little     all
cpumask:    0x06    0x39    0xff

mem size   <---- latency  ---->

  0.00098   3.668   3.595   3.669
  0.00195   3.668   3.594   3.594
  0.00293   3.668   3.593   3.595
  0.00391   3.669   3.596   3.595
  ...
  3.75000  58.687 121.934 122.293
  4.00000  57.054 121.771 120.489
  4.50000  56.914 121.851  56.729
  5.00000  57.347 121.777  56.975
  5.50000  57.705 121.738  68.981
  6.00000  57.935 121.728  57.542
  6.50000  58.119 121.694 121.799
  7.00000  58.194 121.502  57.844
  7.50000  58.258 121.684  58.050
  8.00000  58.293 121.725  58.030
  9.00000  58.309 121.793  58.188
10.00000  58.561 122.252 122.078

There is no diff between big and little cpus with small memory sizes, 
just with the MB range.
If I look into the trace for 'all' it turns out that their are cases in 
which, even if the task only run for ~15% of the time on big, the 
latency value is printed as when it was running affine to big. So using 
the latency value as an indicator where the task was scheduled is IMHO 
not really possible.
