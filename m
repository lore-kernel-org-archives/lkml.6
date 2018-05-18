Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeERHoG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:44:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeERHoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:44:05 -0400
Date: Fri, 18 May 2018 15:43:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180518074359.GR24627@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180518070046.GA18660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518070046.GA18660@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/18 at 09:00am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > This is a regression bug fix. Luiz's team reported that 1GB huge page
> > allocation will get one less 1GB page randomly when KASLR is enabled. On
> > their KVM guest with 4GB RAM, which only has one good 1GB huge page,
> > they found the 1GB huge page allocation sometime failed with below
> > kernel option adding.
> > 
> >   default_hugepagesz=1G hugepagesz=1G hugepages=1
> > 
> > This is because kernel may be randomized into those good 1GB huge pages.
> > 
> > I ever thought to solve this by specifying available memory regions
> > which kernel KASLR can be randomized into to avoid those good 1GB huge
> > pages. Chao's patches can be used to fix it:
> > https://lkml.org/lkml/2018/2/28/217
> > 
> > Later, Ingo suggested avoiding them in boot KASLR code.
> > https://lkml.org/lkml/2018/3/12/312
> 
> Yes, but these patches don't appear to implement what I suggested:
> 
> > So there's apparently a mis-design here:
> >
> > - KASLR needs to be done very early on during bootup: - it's not realistic to 
> >   expect KASLR to be done with a booted up kernel, because pointers to various 
> >   KASLR-ed objects are already widely spread out in memory.
> >
> > - But for some unfathomable reason the memory hotplug attribute of memory
> >   regions is not part of the regular memory map but part of late-init ACPI data
> >   structures.
> >
> > The right solution would be _not_ to fudge the KASLR location, but to provide 
> > the memory hotplug information to early code, preferably via the primary memory 
> > map. KASLR can then make use of it and avoid those regions, just like it avoids 
> > other memory regions already.
> >
> > In addition to that hardware makers (including virtualized hardware) should also 
> > fix their systems to provide memory hotplug information to early code.
> 
> So my question: why don't we pass in the information that these are hotplug pages 
> that should not be KASLR randomized into?
> 
> If that attribute of memory regions was present then KASLR could simply skip the 
> hotplug regions!

OK, I realized my saying above is misled because I didn't explain the
background clearly. Let me add it:

Previously, FJ reported the movable_node issue that KASLR will put
kernel into movable_node. That cause those movable_nodes can't be hot
plugged any more. So finally we plannned to solve it by adding a new
kernel parameter :

	kaslr_boot_mem=nn[KMG]@ss[KMG]

We want customer to specify memory regions which KASLR can make use to
randomize kernel into. Outside of the specified regions, we need avoid
to put kernel into those regions even though they are also available
RAM. As for movable_node issue, we can add immovable regions into
kaslr_boot_mem=nn[KMG]@ss[KMG].

During this hotplug issue reviewing, Luiz's team reported this 1GB hugepages
regression bug, I reproduced the bug and found out the root cause, then
realized that I can utilize kaslr_boot_mem=nn[KMG]@ss[KMG] parameter to
fix it too. E.g the KVM guest with 4GB RAM, we have a good 1GB huge
page, then we can add "kaslr_boot_mem=1G@0, kaslr_boot_mem=3G@2G" to
kernel command-line, then the good 1GB region [1G, 2G) won't be taken
into account for kernel physical randomization.

Later, you pointed out that 'kaslr_boot_mem=' way need user to specify
memory region manually, it's not good, suggested to solve them by
getting information and solving them in KASLR boot code. So they are two
issues now, for the movable_node issue, we need get hotplug information
from SRAT table and then avoid them; for this 1GB hugepage issue, we
need get information from kernel command-line, then avoid them.

This patch is for the hugepage issue only. Since FJ reported the hotplug
issue and they assigned engineers to work on it, I would like to wait
for them to post according to your suggestion.

I will add this to cover letter of v2 post.

Thanks
Baoquan
