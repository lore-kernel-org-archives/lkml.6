Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeDXWQV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:16:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61281 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDXWQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:16:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,324,1520870400";
   d="scan'208";a="173301547"
Subject: Re: [PATCH v5 0/2] perf: riscv: Preliminary Perf Event Support on
 RISC-V
To: Palmer Dabbelt <palmer@sifive.com>
Cc: "alankao@andestech.com" <alankao@andestech.com>,
        "albert@sifive.com" <albert@sifive.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com"
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sols@sifive.com" <sols@sifive.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "greentime@andestech.com" <greentime@andestech.com>,
        "nickhu@andestech.com" <nickhu@andestech.com>
References: <mhng-355dc09a-ef4a-4cb0-b7fe-c2ac57a04a5c@palmer-si-x1c4>
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <054df682-c002-23ba-075b-a38c9085260c@wdc.com>
Date: Tue, 24 Apr 2018 15:16:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-355dc09a-ef4a-4cb0-b7fe-c2ac57a04a5c@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/18 12:44 PM, Palmer Dabbelt wrote:
> On Tue, 24 Apr 2018 12:27:26 PDT (-0700), atish.patra@wdc.com wrote:
>> On 4/24/18 11:07 AM, Atish Patra wrote:
>>> On 4/19/18 4:28 PM, Alan Kao wrote:
>>>> This implements the baseline PMU for RISC-V platforms.
>>>>
>>>> To ease future PMU portings, a guide is also written, containing
>>>> perf concepts, arch porting practices and some hints.
>>>>
>>>> Changes in v5:
>>>>     - Fix patch errors from checkpatch.pl.
>>>>
>>>> Changes in v4:
>>>>     - Fix several compilation errors.  Sorry for that.
>>>>     - Raise a warning in the write_counter body.
>>>>
>>>> Changes in v3:
>>>>     - Fix typos in the document.
>>>>     - Change the initialization routine from statically assigning PMU to
>>>>       device-tree-based methods, and set default to the PMU proposed in
>>>>       this patch.
>>>>
>>>> Changes in v2:
>>>>     - Fix the bug reported by Alex, which was caused by not sufficient
>>>>       initialization.  Check https://lkml.org/lkml/2018/3/31/251 for the
>>>>       discussion.
>>>>
>>>> Alan Kao (2):
>>>>      perf: riscv: preliminary RISC-V support
>>>>      perf: riscv: Add Document for Future Porting Guide
>>>>
>>>>     Documentation/riscv/pmu.txt         | 249 ++++++++++++++
>>>>     arch/riscv/Kconfig                  |  13 +
>>>>     arch/riscv/include/asm/perf_event.h |  79 ++++-
>>>>     arch/riscv/kernel/Makefile          |   1 +
>>>>     arch/riscv/kernel/perf_event.c      | 485 ++++++++++++++++++++++++++++
>>>>     5 files changed, 823 insertions(+), 4 deletions(-)
>>>>     create mode 100644 Documentation/riscv/pmu.txt
>>>>     create mode 100644 arch/riscv/kernel/perf_event.c
>>>>
>>> Most of the perf tests either pass or fail because of unsupported
>>> event/trace point which is fine.
>>>
>>> However, I got an rcu-stall for the test "47: Event times".
>>> # ./perf test -v 47
>>> 47: Event times                                :
>>> --- start ---
>>> test child forked, pid 2774
>>> attaching to spawned child, enable on exec
>>>       OK    : ena 2243000, run 2243000
>>> attaching to current thread as enabled
>>>       OK    : ena 19000, run 19000
>>> attaching to current thread as disabled
>>>       OK    : ena 5000, run 5000
>>> attaching to CPU 0 as enabled
>>> [ 1001.466578] INFO: rcu_sched self-detected stall on CPU
>>> [ 1001.470947]  4-....: (29999 ticks this GP) idle=5fa/140000000000001/0
>>> softirq=19762/19762 fqs=14602
>>> [ 1001.480053]   (t=30001 jiffies g=3471 c=3470 q=125)
>>> [ 1001.484917] Task dump for CPU 4:
>>> [ 1001.488129] perf            R  running task        0  2774   2773
>>> 0x00000008
>>> [ 1001.495161] Call Trace:
>>> [ 1001.497606] [<000000006a3d4f87>] walk_stackframe+0x0/0xc0
>>> [ 1001.502980] [<000000004b4b0780>] show_stack+0x3c/0x46
>>> [ 1001.508024] [<0000000060c96ab8>] sched_show_task+0xd0/0x122
>>> [ 1001.513573] [<000000007d8bd54e>] dump_cpu_task+0x50/0x5a
>>> [ 1001.518870] [<0000000053990e11>] rcu_dump_cpu_stacks+0x98/0xd2
>>> [ 1001.524685] [<00000000fe94c593>] rcu_check_callbacks+0x614/0x822
>>> [ 1001.530680] [<0000000057688dd3>] update_process_times+0x38/0x6a
>>> [ 1001.536585] [<0000000063a96de0>] tick_periodic+0x58/0xd8
>>> [ 1001.541876] [<0000000013d712f1>] tick_handle_periodic+0x2e/0x7c
>>> [ 1001.547780] [<000000009e2ef428>] riscv_timer_interrupt+0x34/0x3c
>>> [ 1001.553774] [<00000000ff6b1f18>] riscv_intc_irq+0xbc/0xe0
>>> [ 1001.559153] [<00000000c8614c3b>] ret_from_exception+0x0/0xc
>>>
>>> It is quite possible that we don't support some dependency
>>> infrastructure. I am looking into it.
>>>
>>> Regards,
>>> Atish
>>>
>>>
>>>
>>>
>>>
>>
>> Got it working. The test tries to attach the event to CPU0 which doesn't
>> exist in HighFive Unleashed. Changing it to cpu1 works.
>>
>> diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
>> index 1a2686f..eb11632f 100644
>> --- a/tools/perf/tests/event-times.c
>> +++ b/tools/perf/tests/event-times.c
>> @@ -113,9 +113,9 @@ static int attach__cpu_disabled(struct perf_evlist
>> *evlist)
>>           struct cpu_map *cpus;
>>           int err;
>>
>> -       pr_debug("attaching to CPU 0 as enabled\n");
>> +       pr_debug("attaching to CPU 1 as disabled\n");
>>
>> -       cpus = cpu_map__new("0");
>> +       cpus = cpu_map__new("1");
>>           if (cpus == NULL) {
>>                   pr_debug("failed to call cpu_map__new\n");
>>                   return -1;
>> @@ -142,9 +142,9 @@ static int attach__cpu_enabled(struct perf_evlist
>> *evlist)
>>           struct cpu_map *cpus;
>>           int err;
>>
>> -       pr_debug("attaching to CPU 0 as enabled\n");
>> +       pr_debug("attaching to CPU 1 as enabled\n");
>>
>> -       cpus = cpu_map__new("0");
>> +       cpus = cpu_map__new("1");
>>           if (cpus == NULL) {
>>                   pr_debug("failed to call cpu_map__new\n");
>>                   return -1;
>>
>>
>> Palmer,
>> Would it be better to officially document it somewhere that CPU0 doesn't
>> exist in the HighFive Unleashed board ?
>> I fear that there will be other standard tests/code path that may fail
>> because of inherent assumption of cpu0 presence.
> 
> I think the best way to fix this is to just have BBL (or whatever the
> bootloader is) renumber the CPUs so they're contiguous and begin with 0.

Do you mean BBL will update the device tree that kernel eventually parse 
and set the hart id?
Sounds good to me unless it acts as a big hack in future boot loaders.

> Documenting it it just a way to tell people their code needs to be changed,
> it'll still break.
> 
Agreed.
