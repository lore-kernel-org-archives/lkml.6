Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755545AbeDYQjL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:39:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38348 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754654AbeDYQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:39:06 -0400
X-Google-Smtp-Source: AB8JxZpUzaBCJEC015IR879quu/Bg5iRJiu4w6fxhPmONmiGpQ+vJlRet7x83ghpK6pdZNvgSI5D8A==
Date: Wed, 25 Apr 2018 09:39:04 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Apr 2018 09:34:44 PDT (-0700)
Subject: Re: [PATCH v5 0/2] perf: riscv: Preliminary Perf Event Support on RISC-V
In-Reply-To: <20180425031936.GA7303@andestech.com>
CC: atish.patra@wdc.com, sols@sifive.com, nickhu@andestech.com,
        corbet@lwn.net, peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        albert@sifive.com, namhyung@kernel.org,
        linux-riscv@lists.infradead.org, jolsa@redhat.com,
        greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com
Message-ID: <mhng-aec39091-7a3b-4def-99f3-577e023c6919@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 20:19:36 PDT (-0700), alankao@andestech.com wrote:
> Hi Atish, Palmer,
>
> On Tue, Apr 24, 2018 at 06:15:49PM -0700, Atish Patra wrote:
>> On 4/24/18 5:29 PM, Palmer Dabbelt wrote:
>> >On Tue, 24 Apr 2018 15:16:16 PDT (-0700), atish.patra@wdc.com wrote:
>> >>On 4/24/18 12:44 PM, Palmer Dabbelt wrote:
>> >>>On Tue, 24 Apr 2018 12:27:26 PDT (-0700), atish.patra@wdc.com wrote:
>> >>>>On 4/24/18 11:07 AM, Atish Patra wrote:
>> >>>>>On 4/19/18 4:28 PM, Alan Kao wrote:
>> >>>>>However, I got an rcu-stall for the test "47: Event times".
>> >>>>># ./perf test -v 47
>> >>>>Got it working. The test tries to attach the event to CPU0 which doesn't
>> >>>>exist in HighFive Unleashed. Changing it to cpu1 works.
>> >>>>
>> >>>>diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
>> >>>>index 1a2686f..eb11632f 100644
>> >>>>--- a/tools/perf/tests/event-times.c
>> >>>>+++ b/tools/perf/tests/event-times.c
>> >>>>@@ -113,9 +113,9 @@ static int attach__cpu_disabled(struct perf_evlist
>> >>>>*evlist)
>> >>>>           struct cpu_map *cpus;
>> >>>>           int err;
>> >>>>
>> >>>>-       pr_debug("attaching to CPU 0 as enabled\n");
>> >>>>+       pr_debug("attaching to CPU 1 as disabled\n");
>> >>>>
>> >>>>-       cpus = cpu_map__new("0");
>> >>>>+       cpus = cpu_map__new("1");
>> >>>>           if (cpus == NULL) {
>> >>>>                   pr_debug("failed to call cpu_map__new\n");
>> >>>>                   return -1;
>> >>>>@@ -142,9 +142,9 @@ static int attach__cpu_enabled(struct perf_evlist
>> >>>>*evlist)
>> >>>>           struct cpu_map *cpus;
>> >>>>           int err;
>> >>>>
>> >>>>-       pr_debug("attaching to CPU 0 as enabled\n");
>> >>>>+       pr_debug("attaching to CPU 1 as enabled\n");
>> >>>>
>> >>>>-       cpus = cpu_map__new("0");
>> >>>>+       cpus = cpu_map__new("1");
>> >>>>           if (cpus == NULL) {
>> >>>>                   pr_debug("failed to call cpu_map__new\n");
>> >>>>                   return -1;
>> >>>>
>> >>>>
>> >>>>Palmer,
>> >>>>Would it be better to officially document it somewhere that CPU0 doesn't
>> >>>>exist in the HighFive Unleashed board ?
>> >>>>I fear that there will be other standard tests/code path that may fail
>> >>>>because of inherent assumption of cpu0 presence.
>> >>>
>> >>>I think the best way to fix this is to just have BBL (or whatever the
>> >>>bootloader is) renumber the CPUs so they're contiguous and begin with 0.
>> >>
>> >>Do you mean BBL will update the device tree that kernel eventually parse
>> >>and set the hart id?
>> >>Sounds good to me unless it acts as a big hack in future boot loaders.
>> >
>> >Right now the machine-mode and supervisor-mode hart IDs are logically separate:
>> >the bootloader just provides the hart ID as a register argument when starting
>> >the kernel.
>>
>> Yes.
>>
>>   BBL already needs to enumerate the harts by looking through the
>> >device tree for various other reasons (at least to mask off the harts that
>> >Linux doesn't support), so it's not that much effort to just maintain a mapping
>> >from supervisor-mode hart IDs to machine-mode hart IDs.
>> >
>>
>> But Linux also parses the device tree to get hart ID in
>> riscv_of_processor_hart(). This is used to setup the possible/present cpu
>> map in setup_smp().
>>
>> Thus, Linux also need to see a device tree with cpu0-3 instead of cpu1-4.
>> Otherwise, present cpu map will be incorrect. Isn't it ?
>>
>> >I have some patches floating around that do this, but appear to do it
>> >incorrectly enough that nothing boots so maybe I'm missing something that makes
>> >this complicated :).
>> >
>>
>> Just a wild guess: May be the because of the above reason ;)
>>
>
> Thanks for the test and discussion.  It looks like am implementation issue from
> Unleash, so ... is there anything I should fix and provide a further patch?

You're welcome to fix BBL if you want, but that's unrelated to this patch set.  
I'm going to look over the code again as soon as I get a chance to, thanks for 
submitting the patches!
