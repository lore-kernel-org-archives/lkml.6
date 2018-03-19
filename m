Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCSISF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:18:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39174 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753013AbeCSIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:17:59 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37933055"
Date: Mon, 19 Mar 2018 16:17:39 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: Baoquan He <bhe@redhat.com>
CC: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <lcapitulino@redhat.com>, <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
Message-ID: <20180319081739.GA24159@localhost.localdomain>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
 <20180312093557.gxypr66vrbftz3v3@gmail.com>
 <20180312101031.GH18656@localhost.localdomain>
 <20180312105727.mzrtjvnyxgyz7jn7@gmail.com>
 <20180312120415.GC8547@localhost.localdomain>
 <20180319072446.GE8389@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180319072446.GE8389@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 5C6CB486A78C.ACB06
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:24:46PM +0800, Baoquan He wrote:
>On 03/12/18 at 08:04pm, Chao Fan wrote:
>> On Mon, Mar 12, 2018 at 11:57:27AM +0100, Ingo Molnar wrote:
>> >
>> >* Baoquan He <bhe@redhat.com> wrote:
>> >
>> >> Hi Ingo,
>> >> 
>> >> On 03/12/18 at 10:35am, Ingo Molnar wrote:
>> >> > 
>> >> > * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> >> > 
>> >> > > Long time no reply, rebase the patchset, change the parameter name
>> >> > > from 'kaslr_mem' to 'kaslr_boot_mem'. There's no more code change.
>> >> > > 
>> >> > > ***Background:
>> >> > > People reported that kaslr may randomly chooses some positions
>> >> > > which are located in movable memory regions. This will break memory
>> >> > > hotplug feature.
>> >> > 
>> >> > [...]
>> >> > 
>> >> > > ***Solutions:
>> >> > > Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
>> >> > > specify the memory regions where kernel can be allowed to randomize
>> >> > > safely.
>> >> > 
>> >> > Manual solutions like that are pretty suboptimal to users, aren't they?
>> >> > 
>> >> > In what way does memory hotplug feature 'break'? Does it crash or misbehave? Or 
>> >> > simply does it not allow the movement of the affected memory region, while still 
>> >> > allowing the rest to be moved?
>> >> 
>> >> AFAIT, if kernel is randomized into the movable memory region, the
>> >> affected memory region can not be hot added/removed since it has kernel
>> >> data. Surely, the system can still work, the unaffected part still can
>> >> be moved. Still it will cause regression on memory hotplug.
>> >> 
>> >> Mainly we parse SRAT table to get the ranges of memory provided by
>> >> hot-added memory devices in initmem_init(), that's very late. During boot,
>> >> we don't know it. Chao ever posted patches to grab SRAT at decompressing
>> >> stage, the code is very complicated and not elegant, ACPI maintainer
>> >> NACKed that.
>
>Hi Chao,
>
>Seems Ingo prefers the handling in kaslr boot code. Maybe you can try
>to optimize and split your below patch and post anouther round?
>
>I will see how to sove the hugepage in boot/compressed/kaslr.c . 

Yes, seems that I need to pick up the old patch and try to optimize it.

Thanks,
Chao Fan

>
>Thanks
>Baoquan
>
>> 
>> Thanks for Ingo's suggestion and Baoquan's explaination.
>> 
>> Yes, I did ever try to dig SRAT table in boot period in early RFC PATCH:
>> https://lkml.org/lkml/2017/9/3/77
>> But the change is too huge so made this patchset to avoid this bug in a
>> small change, which will not make the code looks messy.
>> 
>> Thanks,
>> Chao Fan
>> 
>> >
>> >So there's apparently a mis-design here:
>> >
>> > - KASLR needs to be done very early on during bootup: - it's not realistic to 
>> >   expect KASLR to be done with a booted up kernel, because pointers to various 
>> >   KASLR-ed objects are already widely spread out in memory.
>> >
>> > - But for some unfathomable reason the memory hotplug attribute of memory
>> >   regions is not part of the regular memory map but part of late-init ACPI data
>> >   structures.
>> >
>> >The right solution would be _not_ to fudge the KASLR location, but to provide the 
>> >memory hotplug information to early code, preferably via the primary memory map. 
>> >KASLR can then make use of it and avoid those regions, just like it avoids other 
>> >memory regions already.
>> >
>> >In addition to that hardware makers (including virtualized hardware) should also 
>> >fix their systems to provide memory hotplug information to early code.
>> >
>> >Thanks,
>> >
>> >	Ingo
>> >
>> >
>> 
>> 
>
>
