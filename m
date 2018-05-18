Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeERL2q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:28:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbeERL2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:28:43 -0400
Date: Fri, 18 May 2018 19:28:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180518112836.GS24627@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180518070046.GA18660@gmail.com>
 <20180518074359.GR24627@MiWiFi-R3L-srv>
 <20180518081919.GB11379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518081919.GB11379@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/18 at 10:19am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > OK, I realized my saying above is misled because I didn't explain the
> > background clearly. Let me add it:
> > 
> > Previously, FJ reported the movable_node issue that KASLR will put
> > kernel into movable_node. That cause those movable_nodes can't be hot
> > plugged any more. So finally we plannned to solve it by adding a new
> > kernel parameter :
> > 
> > 	kaslr_boot_mem=nn[KMG]@ss[KMG]
> > 
> > We want customer to specify memory regions which KASLR can make use to
> > randomize kernel into.
> 
> *WHY* should the "customer" care?
> 
> This is a _bug_: movable, hotpluggable zones of physical memory should not be 
> randomized into.

Yes, for movable zones, agreed.

But for huge pages, it's only related to memory layout.

> 
> > [...] Outside of the specified regions, we need avoid to put kernel into those 
> > regions even though they are also available RAM. As for movable_node issue, we 
> > can add immovable regions into kaslr_boot_mem=nn[KMG]@ss[KMG].
> > 
> > During this hotplug issue reviewing, Luiz's team reported this 1GB hugepages
> > regression bug, I reproduced the bug and found out the root cause, then
> > realized that I can utilize kaslr_boot_mem=nn[KMG]@ss[KMG] parameter to
> > fix it too. E.g the KVM guest with 4GB RAM, we have a good 1GB huge
> > page, then we can add "kaslr_boot_mem=1G@0, kaslr_boot_mem=3G@2G" to
> > kernel command-line, then the good 1GB region [1G, 2G) won't be taken
> > into account for kernel physical randomization.
> > 
> > Later, you pointed out that 'kaslr_boot_mem=' way need user to specify
> > memory region manually, it's not good, suggested to solve them by
> > getting information and solving them in KASLR boot code. So they are two
> > issues now, for the movable_node issue, we need get hotplug information
> > from SRAT table and then avoid them; for this 1GB hugepage issue, we
> > need get information from kernel command-line, then avoid them.
> > 
> > This patch is for the hugepage issue only. Since FJ reported the hotplug
> > issue and they assigned engineers to work on it, I would like to wait
> > for them to post according to your suggestion.
> 
> All of this is handling it the wrong way about. This is *not* primarily about 
> KASLR at all, and the user should not be required to specify some weird KASLR 
> parameters.
> 
> This is a basic _memory map enumeration_ problem in both cases:
> 
>  - in the hotplug case KASLR doesn't know that it's a movable zone and relocates 
>    into it,

Yes, in boot KASLR, we haven't parsed ACPI table to get hotplug
information. If decide to read SRAT table, we can get if memory region
is hotpluggable, then avoid them. This can be consistent with the later
code after entering kernel.

> 
>  - and in the KVM case KASLR doesn't know that it's a valuable 1GB page that
>    shouldn't be broken up.
> 
> Note that it's not KASLR specific: if we had some other kernel feature that tried 
> to allocate a piece of memory from what appears to be perfectly usable generic RAM 
> we'd have the same problems!

Hmm, this may not be the situation for 1GB huge pages. For 1GB huge
pages, the bug is that on KVM guest with 4GB ram, when user adds
'default_hugepagesz=1G hugepagesz=1G hugepages=1' to kernel
command-line, if 'nokaslr' is specified, they can get 1GB huge page
allocated successfully. If remove 'nokaslr', namely KASLR is enabled,
the 1GB huge page allocation failed.

In hugetlb_nrpages_setup(), you can see that the current huge page code
relies on memblock to get 1GB huge pages. Below is the e820 memory
map from Luiz's bug report. In fact there are two good 1GB huge pages,
one is [0x40000000, 0x7fffffff], the 2nd one is
[0x100000000, 0x13fffffff]. by default memblock will allocate top-down
if movable_node is set, then [0x100000000, 0x13fffffff] will be broken
when system initialization goes into hugetlb_nrpages_setup() invocation.
So normally huge page can only get one good 1GB huge page, whether KASLR
is enanled or not. This is not bug, but decided by the current huge page
implementation. In this case, KASLR boot code can see two good 1GB huge
pages, and try to avoid them. Besides, if it's a good 1GB huge page,
it's not defined in memory map and also not attribute. It's only decided
by the memory layout and also decided by the memory usage situation in
the running system. If want to keep all good 1GB huge pages untouched,
we may need to adjust the current memblock allocation code, to avoid
any possibility to step into good 1GB huge pages before huge page
allocation. However this comes to the improvement area of huge pages
implementation, not related to KASLR.

[  +0.000000] e820: BIOS-provided physical RAM map:
[  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[  +0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[  +0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

Furthermore, on bare-metal with large memory, e.g with 100GB memory, if
user specifies 'default_hugepagesz=1G hugepagesz=1G hugepages=2' to only
expect two 1GB huge pages reserved, if we save all those tens of good
1GB huge pages untouched, it seems to be over reactive.

Not sure if I understand your point correctly, this is my thought about
the huge page issue, please help to point out anything wrong if any.

Thanks
Baoquan
> 
> We need to fix the real root problem, which is lack of knowledge about crutial 
> attributes of physical memory. Once that knowledge is properly represented at this 
> early boot stage both KASLR and other memory allocators can make use of it to 
> avoid those regions.
> 
> Thanks,
> 
> 	Ingo
