Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeE2LO1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:14:27 -0400
Received: from foss.arm.com ([217.140.101.70]:37648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932949AbeE2LOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:14:22 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
Date: Tue, 29 May 2018 12:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/18 11:48, Geert Uytterhoeven wrote:
> Hi Catalin, Jeremy,
> 
> On Thu, May 17, 2018 at 7:05 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
>>> Jeremy Linton (12):
>>>   drivers: base: cacheinfo: move cache_setup_of_node()
>>>   drivers: base: cacheinfo: setup DT cache properties early
>>>   cacheinfo: rename of_node to fw_token
>>>   arm64/acpi: Create arch specific cpu to acpi id helper
>>>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>>>   ACPI: Enable PPTT support on ARM64
>>>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>>>   arm64: Add support for ACPI based firmware tables
>>>   arm64: topology: rename cluster_id
>>>   arm64: topology: enable ACPI/PPTT based CPU topology
>>>   ACPI: Add PPTT to injectable table list
>>>   arm64: topology: divorce MC scheduling domain from core_siblings
>>
>> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
>> patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
>> can add it separately).
> 
> This is now commit 37c3ec2d810f87ea ("arm64: topology: divorce MC
> scheduling domain from core_siblings") in arm64/for-next/core, causing
> system suspend on big.LITTLE systems to hang after shutting down the first
> CPU:
> 
>     $ echo mem > /sys/power/state
>     PM: suspend entry (deep)
>     PM: Syncing filesystems ... done.
>     Freezing user space processes ... (elapsed 0.001 seconds) done.
>     OOM killer disabled.
>     Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>     Disabling non-boot CPUs ...
>     CPU1: shutdown
>     psci: CPU1 killed.
> 

Is it OK to assume the suspend failed just after shutting down one CPU
or it's failing during resume ? It depends on whether you had console
disabled or not.

> For me, it fails on the following big.LITTLE systems:
> 
>     R-Car H3 ES2.0 (4xCA57 + 4xCA53)
>     R-Car M3-W (2xCA57 + 4xCA53)
> 

Interesting, is it PSCI based system suspend ?

> System supend still works fine on systems with big cores only:
> 
>     R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>     R-Car M3-N (2xCA57)
> 
> Reverting this commit fixes the issue for me.
> 

I can't find anything that relates to system suspend in these patches
unless they are messing with something during CPU hot plug-in back
during resume.

-- 
Regards,
Sudeep
