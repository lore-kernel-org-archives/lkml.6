Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966896AbeE2Usk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:48:40 -0400
Received: from foss.arm.com ([217.140.101.70]:47702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966175AbeE2Usi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:48:38 -0400
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
 <20180529150823.GD17159@arm.com>
 <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
 <20180529201623.GA591@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <18579a87-0154-ff90-5ee6-02453c97c47b@arm.com>
Date: Tue, 29 May 2018 15:48:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529201623.GA591@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 03:16 PM, Will Deacon wrote:
> Hi Geert,
> 
> On Tue, May 29, 2018 at 05:51:29PM +0200, Geert Uytterhoeven wrote:
>> On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
>>>> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>>>>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>>> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>>>>>>> System supend still works fine on systems with big cores only:
>>>>>>>
>>>>>>>      R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>>>>>>>      R-Car M3-N (2xCA57)
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
>>> I wonder if we're somehow giving an uninitialised/invalid NUMA configuration
>>> to the scheduler, although I can't see how this would happen.
>>>
>>> Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff below
>>> do you see anything shouting in dmesg?
>>
>> Thanks, but unfortunately it doesn't help.
>> I added some debug code to print cpumask, but so far I don't see anything
>> suspicious.
> 
> Damn, sorry for wasting your time. For the record, Catalin's been seeing
> boot failures under KVM on a non-big/LITTLE machine that bisect reliably
> to this patch, but we've also not been able to explain them. Worse, adding
> so much as a printk makes the problem disappear.



I was about to post a patch to remove the numa check if CONFIG_NUMA 
disabled. But that seems pointless if the its happening with numa 
enabled. So assuming, its the removal of the core from the numa mask 
which is causing problems. It looks like numa_clear_node() might cause 
similar problems when numa is enabled. In my case the problem I see is 
NULL dereference in __bitmap_intersect called from select_task_rq_fair. 
That said, I only see the problem when CONFIG_NUMA isn't set.

So, I've also got another work around which caches the numa node to the 
cpu_topology and then only builds it when store_cpu_topology() is 
called. That should stabilize the numa mask, and assure that the bit 
maps are correct when the scheduler requests them.

Do you guys want that patch, or are we looking for a deeper root cause?
