Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeCLK5d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:57:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51427 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeCLK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:57:32 -0400
X-Google-Smtp-Source: AG47ELszO0OcqCOS2AI64E2tFsbVaZQWoQh/9VbM8n+yoffxGt5/O8in3+QI9QugRfc8i/1C65boPw==
Date: Mon, 12 Mar 2018 11:57:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        keescook@chromium.org, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, lcapitulino@redhat.com
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
Message-ID: <20180312105727.mzrtjvnyxgyz7jn7@gmail.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
 <20180312093557.gxypr66vrbftz3v3@gmail.com>
 <20180312101031.GH18656@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312101031.GH18656@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> Hi Ingo,
> 
> On 03/12/18 at 10:35am, Ingo Molnar wrote:
> > 
> > * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> > 
> > > Long time no reply, rebase the patchset, change the parameter name
> > > from 'kaslr_mem' to 'kaslr_boot_mem'. There's no more code change.
> > > 
> > > ***Background:
> > > People reported that kaslr may randomly chooses some positions
> > > which are located in movable memory regions. This will break memory
> > > hotplug feature.
> > 
> > [...]
> > 
> > > ***Solutions:
> > > Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
> > > specify the memory regions where kernel can be allowed to randomize
> > > safely.
> > 
> > Manual solutions like that are pretty suboptimal to users, aren't they?
> > 
> > In what way does memory hotplug feature 'break'? Does it crash or misbehave? Or 
> > simply does it not allow the movement of the affected memory region, while still 
> > allowing the rest to be moved?
> 
> AFAIT, if kernel is randomized into the movable memory region, the
> affected memory region can not be hot added/removed since it has kernel
> data. Surely, the system can still work, the unaffected part still can
> be moved. Still it will cause regression on memory hotplug.
> 
> Mainly we parse SRAT table to get the ranges of memory provided by
> hot-added memory devices in initmem_init(), that's very late. During boot,
> we don't know it. Chao ever posted patches to grab SRAT at decompressing
> stage, the code is very complicated and not elegant, ACPI maintainer
> NACKed that.

So there's apparently a mis-design here:

 - KASLR needs to be done very early on during bootup: - it's not realistic to 
   expect KASLR to be done with a booted up kernel, because pointers to various 
   KASLR-ed objects are already widely spread out in memory.

 - But for some unfathomable reason the memory hotplug attribute of memory
   regions is not part of the regular memory map but part of late-init ACPI data
   structures.

The right solution would be _not_ to fudge the KASLR location, but to provide the 
memory hotplug information to early code, preferably via the primary memory map. 
KASLR can then make use of it and avoid those regions, just like it avoids other 
memory regions already.

In addition to that hardware makers (including virtualized hardware) should also 
fix their systems to provide memory hotplug information to early code.

Thanks,

	Ingo
