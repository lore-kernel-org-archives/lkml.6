Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeERITc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:19:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36000 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeERITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:19:24 -0400
X-Google-Smtp-Source: AB8JxZpqWNrmi9m626+XMruiaOzZzMsNDTdcdQHsVTtWvv8Idk1ytVWP8e1d0a+C5QfEq1OvVQUVBg==
Date: Fri, 18 May 2018 10:19:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180518081919.GB11379@gmail.com>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180518070046.GA18660@gmail.com>
 <20180518074359.GR24627@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074359.GR24627@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> OK, I realized my saying above is misled because I didn't explain the
> background clearly. Let me add it:
> 
> Previously, FJ reported the movable_node issue that KASLR will put
> kernel into movable_node. That cause those movable_nodes can't be hot
> plugged any more. So finally we plannned to solve it by adding a new
> kernel parameter :
> 
> 	kaslr_boot_mem=nn[KMG]@ss[KMG]
> 
> We want customer to specify memory regions which KASLR can make use to
> randomize kernel into.

*WHY* should the "customer" care?

This is a _bug_: movable, hotpluggable zones of physical memory should not be 
randomized into.

> [...] Outside of the specified regions, we need avoid to put kernel into those 
> regions even though they are also available RAM. As for movable_node issue, we 
> can add immovable regions into kaslr_boot_mem=nn[KMG]@ss[KMG].
> 
> During this hotplug issue reviewing, Luiz's team reported this 1GB hugepages
> regression bug, I reproduced the bug and found out the root cause, then
> realized that I can utilize kaslr_boot_mem=nn[KMG]@ss[KMG] parameter to
> fix it too. E.g the KVM guest with 4GB RAM, we have a good 1GB huge
> page, then we can add "kaslr_boot_mem=1G@0, kaslr_boot_mem=3G@2G" to
> kernel command-line, then the good 1GB region [1G, 2G) won't be taken
> into account for kernel physical randomization.
> 
> Later, you pointed out that 'kaslr_boot_mem=' way need user to specify
> memory region manually, it's not good, suggested to solve them by
> getting information and solving them in KASLR boot code. So they are two
> issues now, for the movable_node issue, we need get hotplug information
> from SRAT table and then avoid them; for this 1GB hugepage issue, we
> need get information from kernel command-line, then avoid them.
> 
> This patch is for the hugepage issue only. Since FJ reported the hotplug
> issue and they assigned engineers to work on it, I would like to wait
> for them to post according to your suggestion.

All of this is handling it the wrong way about. This is *not* primarily about 
KASLR at all, and the user should not be required to specify some weird KASLR 
parameters.

This is a basic _memory map enumeration_ problem in both cases:

 - in the hotplug case KASLR doesn't know that it's a movable zone and relocates 
   into it,

 - and in the KVM case KASLR doesn't know that it's a valuable 1GB page that
   shouldn't be broken up.

Note that it's not KASLR specific: if we had some other kernel feature that tried 
to allocate a piece of memory from what appears to be perfectly usable generic RAM 
we'd have the same problems!

We need to fix the real root problem, which is lack of knowledge about crutial 
attributes of physical memory. Once that knowledge is properly represented at this 
early boot stage both KASLR and other memory allocators can make use of it to 
avoid those regions.

Thanks,

	Ingo
