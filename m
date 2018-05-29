Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936967AbeE2RSk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:18:40 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39827 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936622AbeE2RSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:18:37 -0400
X-Google-Smtp-Source: ADUXVKIK4O+x5Zk0vP5P67th0HkVxRTyy02j2gm852Tfsl68JiRJrioMMSXJ873+DbAe9v7A+m3cP0qKAmTrlUE5jnE=
MIME-Version: 1.0
In-Reply-To: <d2c843d2-a15c-e4c3-899d-ef5c26678016@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com> <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com> <20180529150823.GD17159@arm.com>
 <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com> <d2c843d2-a15c-e4c3-899d-ef5c26678016@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 19:18:35 +0200
X-Google-Sender-Auth: QwHp4dUt7aVZEJd-rOh-WfuwIb8
Message-ID: <CAMuHMdVJdpd_60bN=sxZeqUyPuxfLWFCMPZWyZQ37GAQkGb37g@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>,
        austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
        wangxiongfeng2@huawei.com, vkilari@codeaurora.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, jhugo@codeaurora.org,
        Morten.Rasmussen@arm.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        Al Stone <ahs3@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, May 29, 2018 at 7:08 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 29/05/18 16:51, Geert Uytterhoeven wrote:
>> On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
>>>> On 29/05/18 12:56, Geert Uytterhoeven wrote:
>>>>> On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com>
>>>>> wrote:
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
> Do you have CONFIG_NUMA enabled? On a hunch I've managed to reproduce what
> looks like the same thing on a Juno board with NUMA=n; going in with
> external debug it seems to be stuck in the loop in
> init_sched_groups_capacity(), with an approximate stack trace of:

CONFIG_NUMA is not set.
I'm basically using renesas_defconfig from
https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git/log/?h=topic/renesas-defconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
