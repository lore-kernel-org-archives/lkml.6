Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeERHAw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:00:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40407 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeERHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:00:50 -0400
X-Google-Smtp-Source: AB8JxZpFFqM3dIBt/tOFW/oaQ7ruhcu4AuEEyIq16aVIcAj6nFFP5PxrhH2ZB2vz2Kr7fMVygRSTiw==
Date: Fri, 18 May 2018 09:00:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180518070046.GA18660@gmail.com>
References: <20180516100532.14083-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516100532.14083-1-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> This is a regression bug fix. Luiz's team reported that 1GB huge page
> allocation will get one less 1GB page randomly when KASLR is enabled. On
> their KVM guest with 4GB RAM, which only has one good 1GB huge page,
> they found the 1GB huge page allocation sometime failed with below
> kernel option adding.
> 
>   default_hugepagesz=1G hugepagesz=1G hugepages=1
> 
> This is because kernel may be randomized into those good 1GB huge pages.
> 
> I ever thought to solve this by specifying available memory regions
> which kernel KASLR can be randomized into to avoid those good 1GB huge
> pages. Chao's patches can be used to fix it:
> https://lkml.org/lkml/2018/2/28/217
> 
> Later, Ingo suggested avoiding them in boot KASLR code.
> https://lkml.org/lkml/2018/3/12/312

Yes, but these patches don't appear to implement what I suggested:

> So there's apparently a mis-design here:
>
> - KASLR needs to be done very early on during bootup: - it's not realistic to 
>   expect KASLR to be done with a booted up kernel, because pointers to various 
>   KASLR-ed objects are already widely spread out in memory.
>
> - But for some unfathomable reason the memory hotplug attribute of memory
>   regions is not part of the regular memory map but part of late-init ACPI data
>   structures.
>
> The right solution would be _not_ to fudge the KASLR location, but to provide 
> the memory hotplug information to early code, preferably via the primary memory 
> map. KASLR can then make use of it and avoid those regions, just like it avoids 
> other memory regions already.
>
> In addition to that hardware makers (including virtualized hardware) should also 
> fix their systems to provide memory hotplug information to early code.

So my question: why don't we pass in the information that these are hotplug pages 
that should not be KASLR randomized into?

If that attribute of memory regions was present then KASLR could simply skip the 
hotplug regions!

Thanks,

	Ingo
