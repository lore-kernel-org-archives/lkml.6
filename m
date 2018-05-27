Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeE0Vhn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:37:43 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:32837 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeE0Vhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:37:41 -0400
X-Google-Smtp-Source: ADUXVKIwd7OzHOHXP+WXv7lEDQ1qMKl9f7K6QrRtb1buhCOLtHVRrW+Br8RJtexZOZGe0hpo3Y89Qj17ZdObmOl1o6w=
MIME-Version: 1.0
In-Reply-To: <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
 <20180527200707.GC6349@zn.tnic> <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Sun, 27 May 2018 23:37:10 +0200
Message-ID: <CAEJqkghcHAvxqh0i1hLPY9mwD7_7QFsZr2QZpsu8WDLo0pL1Ow@mail.gmail.com>
Subject: Re: smpboot seems to be confused on dual EPYC system
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

( sorry I didn't noticed google changed here something , resending to
the list as plain text)

2018-05-27 23:22 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>
> 2018-05-27 22:07 GMT+02:00 Borislav Petkov <bp@alien8.de>:
>>
>> On Sun, May 20, 2018 at 03:23:32PM +0200, Gabriel C wrote:
>> > Hello,
>> >
>> > I have an H11DSi-NT board with 2 *  EPYC 7281 16C/32T CPUs.
>> >
>> > On that box for some reason spmboot things '4' logical packages
>> > are possible.
>>
>> First of all, which kernel?
>
>
>   That box runs right now 4.16.11
>>
>>
>> > Max CPUs can be 128 ( 2 * 32C/64T ), however only 2 CPUs are possible
>> > not 4 and therefor there is no way to add other 64 hotplug CPUs.
>> > ( not even sure cpu hotplug will work here )
>> >
>> > $ dmesg | egrep "smpboot|NR_CPUS|CPUs"
>> > [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
>>
>> Your BIOS is made to support 32-Core CPUs too.
>
>
>   128 CPUs are maximal possible however there is no way to have
>   2 CPUs fully populated , in this case 64C and have another 64 hotplug CPUs
>
>   That would mean that's an s4 system while impossible with EPYCs.
>>
>>
>> > [    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:128
>> > nr_cpu_ids:128 nr_node_ids:8
>> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128,
>> > Nodes=8
>> > [    0.000000]  RCU restricting CPUs from NR_CPUS=8192 to
>> > nr_cpu_ids=128.
>> > [    0.037000] smpboot: CPU0: AMD EPYC 7281 16-Core Processor (family:
>> > 0x17, model: 0x1, stepping: 0x2)
>>
>> That says 2 * 16C * 2T = 64T.
>
>
> That says whole topology is set to 128 no ?
> Eg to max possible but not to what the system runs now.
>
>>
>>
>> > [    0.048005] smp: Bringing up secondary CPUs ...
>> > [    0.055042] .... node  #0, CPUs:          #1   #2   #3
>> > [    0.079029] .... node  #1, CPUs:     #4   #5   #6   #7
>> > [    0.111049] .... node  #2, CPUs:     #8   #9  #10  #11
>> > [    0.143050] .... node  #3, CPUs:    #12  #13  #14  #15
>> > [    0.175031] .... node  #4, CPUs:    #16  #17  #18  #19
>> > [    0.217031] .... node  #5, CPUs:    #20  #21  #22  #23
>> > [    0.249062] .... node  #6, CPUs:    #24  #25  #26  #27
>> > [    0.281058] .... node  #7, CPUs:    #28  #29  #30  #31
>> > [    0.313028] .... node  #0, CPUs:    #32  #33  #34  #35
>> > [    0.345028] .... node  #1, CPUs:    #36  #37  #38  #39
>> > [    0.377046] .... node  #2, CPUs:    #40  #41  #42  #43
>> > [    0.409043] .... node  #3, CPUs:    #44  #45  #46  #47
>> > [    0.441028] .... node  #4, CPUs:    #48  #49  #50  #51
>> > [    0.473029] .... node  #5, CPUs:    #52  #53  #54  #55
>> > [    0.505060] .... node  #6, CPUs:    #56  #57  #58  #59
>> > [    0.537052] .... node  #7, CPUs:    #60  #61  #62  #63
>> > [    0.562171] smp: Brought up 8 nodes, 64 CPUs
>> > [    0.562171] smpboot: Max logical packages: 4
>> > [    0.562171] smpboot: Total of 64 processors activated (268089.53
>> > BogoMIPS)
>>
>> You have 64 logical CPUs.
>>
>> So what is the problem?
>>
>
>  The problem is that being wrong ..
>
>   >[    0.562171] smpboot: Max logical packages: 4
>
>   These are max 2 not 4.
>
> Regards
>
