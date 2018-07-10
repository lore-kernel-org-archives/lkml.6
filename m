Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6CE208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6CE208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbeGJPBM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:01:12 -0400
Received: from foss.arm.com ([217.140.101.70]:48298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933383AbeGJPBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:01:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D0880D;
        Tue, 10 Jul 2018 08:01:11 -0700 (PDT)
Received: from [10.37.9.109] (unknown [10.37.9.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B320D3F589;
        Tue, 10 Jul 2018 08:01:09 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] arm64: perf: Support for chained counters
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, julien.thierry@arm.com, robin.murphy@arm.com
References: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
 <20180710143105.GC9022@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <50b0107c-b01d-956a-bd85-d588bf9869ee@arm.com>
Date:   Tue, 10 Jul 2018 16:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180710143105.GC9022@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 03:31 PM, Will Deacon wrote:
> Hi Suzuki,
> 
> On Tue, Jul 10, 2018 at 09:57:57AM +0100, Suzuki K Poulose wrote:
>> This series adds support for counting PMU events using 64bit counters
>> for arm64 PMU.
>>
>> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
>> (low even and hig odd counters) to count a given "event" in 64bit mode.
>> This series adds the support for 64bit events in the core arm_pmu driver
>> infrastructure and adds the support for armv8 64bit kernel PMU to use
>> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
>> counter in 64bit mode, only when requested. If the cycle counter is not
>> available, we fall back to chaining the counters.
>>
>> Tested on Juno, Fast models. Applies on 4.18-rc4
> 
> Thanks, this looks pretty good to me. How far did you get with the perf
> fuzzer?

Hi Will,

I ran perf_fuzzer on Juno and the fuzzer hung with RCU stalls.
However, this was reproducible without the series. I am yet to
investigate the RCU stall.

Log below (from 4.18-rc3, without the series).

[445885.968489] perf_fuzzer     R  running task        0 11468   4397 
0x00000003
[445885.975568] Call trace:
[445885.978084]  ret_from_fork+0x0/0x1c
[445963.841606] INFO: rcu_preempt self-detected stall on CPU
[445963.845814] INFO: rcu_preempt detected stalls on CPUs/tasks:
[445963.846957] 	2-....: (1 GPs behind) idle=376/1/4611686018427387908 
softirq=57145/57145 fqs=54519307
[445963.852649] 	
[445963.861784] 	2-....: (1 GPs behind) idle=376/1/4611686018427387908 
softirq=57145/57145 fqs=54519307
[445963.861787]  (t=109254007 jiffies g=61092 c=61091 q=1517144)
[445963.878244] 	
[445963.878245] Task dump for CPU 2:
[445963.878250] perf_fuzzer     R
[445963.879897] (detected by 0, t=109254007 jiffies, g=61092, c=61091, 
q=1517144)
[445963.883167]   running task        0 11468   4397 0x00000003
[445963.898932] Call trace:
[445963.901439]  dump_backtrace+0x0/0x1e0
[445963.905149]  show_stack+0x24/0x30
[445963.908516]  sched_show_task+0x220/0x2c0
[445963.912484]  dump_cpu_task+0x48/0x58
[445963.916109]  rcu_dump_cpu_stacks+0xa0/0xe0
[445963.920250]  rcu_check_callbacks+0xa40/0xc20
[445963.924564]  update_process_times+0x34/0x60
[445963.928791]  tick_sched_handle.isra.5+0x44/0x68
[445963.933361]  tick_sched_timer+0x50/0xa0
[445963.937244]  __hrtimer_run_queues+0x19c/0x6d0
[445963.941644]  hrtimer_interrupt+0xec/0x248
[445963.945699]  arch_timer_handler_phys+0x3c/0x50
[445963.950184]  handle_percpu_devid_irq+0xcc/0x4a0
[445963.954754]  generic_handle_irq+0x34/0x50
[445963.958808]  __handle_domain_irq+0x68/0xc0
[445963.962948]  gic_handle_irq+0x60/0xb8
[445963.966657]  el1_irq+0xb4/0x130
[445963.969851]  __do_softirq+0xcc/0x5c4
[445963.973475]  irq_exit+0x12c/0x138
[445963.976841]  __handle_domain_irq+0x6c/0xc0
[445963.980981]  gic_handle_irq+0x60/0xb8
[445963.984691]  el0_irq_naked+0x50/0x5c
[445963.988316] Task dump for CPU 2:
[445963.991601] perf_fuzzer     R  running task        0 11468   4397 
0x00000003
[445963.998679] Call trace:
[445964.001194]  ret_from_fork+0x0/0x1c
root@localhost:~# uname -a
Linux localhost.localdomain 4.18.0-rc3 #117 SMP PREEMPT Thu Jul 5 
11:47:12 BST 2018 aarch64 aarch64 aarch64 GNU/Linux

Suzuki
