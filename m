Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805A820873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805A820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeK0RpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:45:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbeK0RpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:45:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DB9280F7B;
        Tue, 27 Nov 2018 06:48:20 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CAE816E3B;
        Tue, 27 Nov 2018 06:48:19 +0000 (UTC)
Date:   Tue, 27 Nov 2018 14:48:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bp@alien8.de, mingo@kernel.org, tglx@linutronix.de,
        k-hagio@ab.jp.nec.com, anderson@redhat.com, james.morse@arm.com,
        osandov@fb.com, x86@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181127064816.GE1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
 <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 27 Nov 2018 06:48:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 at 01:01am, Bhupesh Sharma wrote:
> > But it's not live debugging feature of makedumpfile. Makedumpfile can't be
> > used to live debug. The feature is called '--mem-usage' in makedumpfile,
> > in fact it's used to estimate how big the vmcore could be so that customer
> > can deply an appropriate size of storage space to store it. Because both
> > kcore and vmcore are all elf files which the 1st kernel's memory is
> > mapped to, even though they are different, kcore is dynamically changing.
> > This is more likely a precision in order of of magnitude. This is a feature
> > required by redhat customer.
> 
> Indeed this is a live debugging feature - see we are running this in
> the primary kernel
> context, not in kdump context. We are trying to debug a kernel we are
> presently running (in this case determining the page mapping)
> hence the term live debugging.

Thanks for redefining '--mem-usage' of makedumpfile as a live debugging
feature. I am the author of this feature, I don't know it has this
awesome attribute. Can you post patch to refresh it's doc or man page
about this live debugging thing? I think it's important, I am
astonished. I noticed Boris said you are adding this to support live
debug, just not sure if he is misled by you, or he also think this
vmcore size estimating feature of makedumpfile is live debugging
feature. 

> 
> Also, this feature is not limited to redhat - we are talking in
> upstream makedumpfile context here - it is used by other projects as
> well which can have even a simple busybox rootfs configuration (e.g.
> qemu).

Yes, it's not limited to redhat, I am just saying its origin.

> 
> > I thought you are talking about using DaveA's crash utility to live
> > debug the running kernel, like we usually do with gdb.
> >
> >         gdb vmlinux /proc/kcore
> >
> > Yes, this gdb live debugging is broken because of KASLR. We have bug about
> > this, while it has not been fixed. Using Crash utility to replace gdb is
> > one way if Crash code is adjusted.

......

> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > index 4c8acdfdc5a7..6161d77c5bfb 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> > >       VMCOREINFO_SYMBOL(init_top_pgt);
> > >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> > >                       pgtable_l5_enabled());
> > > +#ifdef CONFIG_RANDOMIZE_BASE
> >
> > Finally, embracing it into CONFIG_RANDOMIZE_BASE ifdefery seems not
> > right. The latest kernel is using page_offset_base to do the dynamic
> > memory layout between level4 and level5 changing. This may not work in
> > 5-level system with CONFIG_RANDOMIZE_BASE=n.
> 
> I think you missed the v2 change log and the build-bot error on v1
> (see here: <https://patchwork.kernel.org/patch/10657933/#22291691>).
> With .config files which have CONFIG_RANDOMIZE_BASE=n, we get the
> following compilation error
> without the #ifdef jugglery:

Which line of your v2 change log did I miss?

Ask again, what if I set
CONFIG_DYNAMIC_MEMORY_LAYOUT=y && CONFIG_RANDOMIZE_MEMORY=n
in a kernel with LEVEL5 enabled to make kernel be able to switch
into l4 and l5 dynamically?

Is there anything wrong if I add it like this:

#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
	VMCOREINFO_SYMBOL(node_data);
#endif

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
EXPORT_SYMBOL(page_offset_base);
...
#endif

config DYNAMIC_MEMORY_LAYOUT
        bool
        ---help---
          This option makes base addresses of vmalloc and vmemmap as well as
          __PAGE_OFFSET movable during boot.

config RANDOMIZE_MEMORY
        bool "Randomize the kernel memory sections"
        depends on X86_64
        depends on RANDOMIZE_BASE
        select DYNAMIC_MEMORY_LAYOUT
        default RANDOMIZE_BASE
        ---help---
           Randomizes the base virtual address of kernel memory sections
           (physical memory mapping, vmalloc & vmemmap). This security feature
           makes exploits relying on predictable memory locations less reliable.

           The order of allocations remains unchanged. Entropy is generated in
           the same way as RANDOMIZE_BASE. Current implementation in the optimal
           configuration have in average 30,000 different possible virtual
           addresses for each memory section.

           If unsure, say Y.

> 
>  arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
>  arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
> `page_offset_base'
>  arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
> `page_offset_base'
> 
> Anyways, with Kazu's and Boris's comments on the v2, I understand that
> adding 'page_offset_base' variable to vmcoreinfo is useful for x86
> kernel.

Please notice that the makedumpfile '--mem-usage' bug has been fixed by
below commit. Adding 'page_offset_base' into vmcoreinfo is 50:50 to
me. Adding it to vmcoreinfo to expose, or deducing it from kcore/vmcore
program segment, both is fine to me since both has pro and con. Adding
it you have to give a good log, based on good understanding, but
not those confusing self invented term and the useless test results,
and wrong code.

commit 1ea989bf6a93db377689c16b61e9c2c6a9bafa17 (HEAD -> devel, origin/devel)
Author: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Date:   Wed Nov 21 13:57:31 2018 -0500

    [PATCH] x86_64: fix failure of getting kcore vmcoreinfo on kernel 4.19

> I will now work on the v3 to take into account review comments and
> also work with Lianbo to get the same added to the overall vmcoreinfo
> documentation he is preparing for x86.

So please do not post new version directly without replying to confirm if
we have agreement on concerns, then saying that is requested by me or
other people.

Thanks
Baoquan
