Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeAaCSm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:18:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeAaCSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:18:40 -0500
Date: Wed, 31 Jan 2018 10:18:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: KASLR may break some kernel features (was Re: [PATCH v5 1/4]
 kaslr: add immovable_mem=nn[KMG]@ss[KMG] to specify extracting memory)
Message-ID: <20180131021835.GA1873@localhost.localdomain>
References: <20180104080219.23893-1-fanc.fnst@cn.fujitsu.com>
 <20180104080219.23893-2-fanc.fnst@cn.fujitsu.com>
 <20180104103057.GC7235@x1>
 <20180104112104.67b88e2d@redhat.com>
 <20180111090006.GA9648@localhost.localdomain>
 <CAGXu5jJvN52-Zi_meU86G7sbzQDNRqi-6jHxz-aPfkq4vXcKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJvN52-Zi_meU86G7sbzQDNRqi-6jHxz-aPfkq4vXcKoA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On 01/11/18 at 10:04am, Kees Cook wrote:
> On Thu, Jan 11, 2018 at 1:00 AM, Baoquan He <bhe@redhat.com> wrote:
> > Hi Luiz,
> >
> > On 01/04/18 at 11:21am, Luiz Capitulino wrote:
> >> Having a generic kaslr parameter to control where the kernel is extracted
> >> is one solution for this problem.
> >>
> >> The general problem statement is that KASLR may break some kernel features
> >> depending on where the kernel is extracted. Two examples are hot-plugged
> >> memory (this series) and 1GB HugeTLB pages.
> >>
> >> The 1GB HugeTLB page issue is not specific to KVM guests. It just happens
> >> that there's a bunch of people running guests with up to 5GB of memory and
> >> with that amount of memory you have one or two 1GB pages and is easier for
> >> KASLR to extract the kernel into a 1GB region and split a 1GB page. So,
> >> you may not get any 1GB pages at all when this happens. However, I can also
> >> reproduce this on bare-metal with lots of memory where I can loose a 1GB
> >> page from time to time.
> >>
> >> Having a kaslr_range= parameter solves both issues, but two major drawbacks
> >> is that it breaks existing setups and I guess users will have a very hard
> >> time choosing good ranges.
> >>
> >> Another idea would be to have a CONFIG_KASLR_RANGES, where each arch
> >> could have a list of ranges known to contain holes and/or immovable
> >> memory and only extract the kernel into those ranges.
> >
> > If add CONFIG_KASLR_RANGES, then a distro like RHEL will have this range
> > always, whether people need hugetlb or not.
> >
> > So in this case, what range do we need to avoid? Only [1G, 2G]?
> 
> Any ranges like that that need to be avoided should be known at build
> time, so they should simply be added to the mem_avoid list that is
> already present in the KASLR code...

Sorry, I might misunderstand your suggestion before. Are you suggesting to
add a specific range to mem_avoid[] by hardcoding?

I may not make the situation stated clearly, sorry for that. For this
hugepage issue, Luiz tested in a kvm guest with 4G memory. And the
hugetlb need allocate 1G with 1G aligned, so only [1G, 2G] area is good
1G huge page for allocation. The other area has no good 1G page for
usage:
[0, 1G]: BIOS reserved several pages;
[2G, 3G]: the top is reserved by system, 0x00000000bffe0000-0x00000000bfffffff
[3G, 4G]: no ram deployed by firmware
[4G, 5G]: system allocate from top to bottom

dmesg output snippet of kvm guest:
[  +0.000000] e820: BIOS-provided physical RAM map:
[  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[  +0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[  +0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

However, this only failed in this system. If Luiz setup kvm with 5G or
larger memory, you can see, there will be more than one good 1G page.
While kernel randomization can only occupy one. So if more than one good
1G page, the 1G huge page allocation failure won't occur. So it's a very
corner case, that's why I don't want to hardcode it into mem_avoid[].
Code sounds not reasonable with the change which we need avoid [1G, 2G]
area, and the code comments have to tell that we do this because system
with 4G memory can't allocate 1G huge page successfully. Other than that,
those system which don't need hugetlb feature, or have more memory, don't
have this issue at all.

These are my thinking about the current fixing way, not sure if it's
peruasive or make sense. Would like to hear any suggestion or different
idea to solve the encountered problems.

Thanks
Baoquan
