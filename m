Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935421AbeE2PXX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935327AbeE2PXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:20 -0400
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <Will.Deacon@arm.com>, linux-riscv@lists.infradead.org,
        Morten.Rasmussen@arm.com, vkilari@codeaurora.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, jhugo@codeaurora.org,
        Al Stone <ahs3@redhat.com>, Len Brown <lenb@kernel.org>,
        John Garry <john.garry@huawei.com>, wangxiongfeng2@huawei.com,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b08eee2a-6fe5-763f-f2e1-2dec05e14ef4@arm.com>
Date: Tue, 29 May 2018 10:23:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/29/2018 08:18 AM, Sudeep Holla wrote:
> 
> 
> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>> Hi Sudeep,
>>
>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>>>> On Thu, May 17, 2018 at 7:05 PM, Catalin Marinas
>>>> <catalin.marinas@arm.com> wrote:
>>>>> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
>>>>>> Jeremy Linton (12):
>>>>>>    drivers: base: cacheinfo: move cache_setup_of_node()
>>>>>>    drivers: base: cacheinfo: setup DT cache properties early
>>>>>>    cacheinfo: rename of_node to fw_token
>>>>>>    arm64/acpi: Create arch specific cpu to acpi id helper
>>>>>>    ACPI/PPTT: Add Processor Properties Topology Table parsing
>>>>>>    ACPI: Enable PPTT support on ARM64
>>>>>>    drivers: base cacheinfo: Add support for ACPI based firmware tables
>>>>>>    arm64: Add support for ACPI based firmware tables
>>>>>>    arm64: topology: rename cluster_id
>>>>>>    arm64: topology: enable ACPI/PPTT based CPU topology
>>>>>>    ACPI: Add PPTT to injectable table list
>>>>>>    arm64: topology: divorce MC scheduling domain from core_siblings
>>>>>
>>>>> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
>>>>> patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
>>>>> can add it separately).
>>>>
>>>> This is now commit 37c3ec2d810f87ea ("arm64: topology: divorce MC
>>>> scheduling domain from core_siblings") in arm64/for-next/core, causing
>>>> system suspend on big.LITTLE systems to hang after shutting down the first
>>>> CPU:
>>>>
>>>>      $ echo mem > /sys/power/state
>>>>      PM: suspend entry (deep)
>>>>      PM: Syncing filesystems ... done.
>>>>      Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>      OOM killer disabled.
>>>>      Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>>      Disabling non-boot CPUs ...
>>>>      CPU1: shutdown
>>>>      psci: CPU1 killed.
>>>>
>>>
>>> Is it OK to assume the suspend failed just after shutting down one CPU
>>> or it's failing during resume ? It depends on whether you had console
>>> disabled or not.
>>
>> I have no-console-suspend enabled.
>> It's failing during suspend, the next lines should be:
>>
>>      CPU2: shutdown
>>      psci: CPU2 killed.
>>      ...
>>
> 
> OK, I was hoping to be something during resume as this patch has nothing
> executed during suspend. Do you see any change in topology before and
> after this patch applied. I am interested in the output of:
> 
> $ grep "" /sys/devices/system/cpu/cpu*/topology/*
> 
>>>> For me, it fails on the following big.LITTLE systems:
>>>>
>>>>      R-Car H3 ES2.0 (4xCA57 + 4xCA53)
>>>>      R-Car M3-W (2xCA57 + 4xCA53)
>>>>
>>>
>>> Interesting, is it PSCI based system suspend ?
>>
>> Yes it is.
>>
>> Suspend-to-idle, which doesn't offline CPUs, still works.
>>
> 
>  From DT, I guess this platform doesn't have any idle states.
> Does this use genpd power domains ? I see power-domains in the DT, so
> asking to get more info. Do you have any out of tree patches especially
> if they are depending on some topology cpumasks ?
> 
>>>> System supend still works fine on systems with big cores only:
>>>>
>>>>      R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>>>>      R-Car M3-N (2xCA57)
>>>>
>>>> Reverting this commit fixes the issue for me.
>>>
>>> I can't find anything that relates to system suspend in these patches
>>> unless they are messing with something during CPU hot plug-in back
>>> during resume.
>>
>> It's only the last patch that introduces the breakage.
>>
> 
> As specified in the commit log, it won't change any behavior for DT
> systems if it's non-NUMA or single node system. So I am still wondering
> what could trigger this regression.
> 

So, presumably the problem is that the numa mask is smaller than the 
normal core_siblings...

I would verify that that there is a behavior change with something like 
/proc/schedstat | cut -d ' ' -f-2

There might be something odd happening with whether you have CONFIG_NUMA 
set (looking at that right now).

So, a couple quick todo's, see if the schedstat domains are changing 
with/without the last patch, and also see if they are changing if you 
enable/disable NUMA.

Why any of that matters for suspend isn't clear at the moment.
