Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeE3NY7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:24:59 -0400
Received: from foss.arm.com ([217.140.101.70]:56106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeE3NYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:24:55 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com,
        vkilari@codeaurora.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        jhugo@codeaurora.org, Al Stone <ahs3@redhat.com>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        wangxiongfeng2@huawei.com, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Jeremy Linton <jeremy.linton@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
 <20180529150823.GD17159@arm.com>
 <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
 <a79f5acc-51f2-cd7c-5abf-c7c1df8064a1@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <fdbf86f6-38b8-adc6-20a8-6c450963fb62@arm.com>
Date: Wed, 30 May 2018 14:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a79f5acc-51f2-cd7c-5abf-c7c1df8064a1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/18 22:52, Jeremy Linton wrote:
> Hi,
> 
> On 05/29/2018 10:51 AM, Geert Uytterhoeven wrote:
>> Hi Will,
>>
>> On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
>>>> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>>>>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla
>>>>> <sudeep.holla@arm.com> wrote:
>>>>>> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>>>>>>> System supend still works fine on systems with big cores only:
>>>>>>>
>>>>>>>      R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>>>>>>>      R-Car M3-N (2xCA57)
>>>>>>>
>>>>>>> Reverting this commit fixes the issue for me.
>>>>>>
>>>>>> I can't find anything that relates to system suspend in these patches
>>>>>> unless they are messing with something during CPU hot plug-in back
>>>>>> during resume.
>>>>>
>>>>> It's only the last patch that introduces the breakage.
>>>>>
>>>>
>>>> As specified in the commit log, it won't change any behavior for DT
>>>> systems if it's non-NUMA or single node system. So I am still wondering
>>>> what could trigger this regression.
>>>
>>> I wonder if we're somehow giving an uninitialised/invalid NUMA
>>> configuration
>>> to the scheduler, although I can't see how this would happen.
>>>
>>> Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff
>>> below
>>> do you see anything shouting in dmesg?
>>
>> Thanks, but unfortunately it doesn't help.
>> I added some debug code to print cpumask, but so far I don't see anything
>> suspicious.
> 
> I suspect most of the problem is related to the node mask changing at
> unexpected times (particularly cores being removed from the mask). Once
> I understand that more, there may be a simpler patch.
> 
> OTOH, I've been testing with this, and with it, I can't seem to
> duplicate the problem with CONFIG_NUMA disabled I found.
> 

I am also giving it a run on my Juno(defconfig - CONFIG_NUMA) and CPU
hotplug tests are fine with this change.

-- 
Regards,
Sudeep
