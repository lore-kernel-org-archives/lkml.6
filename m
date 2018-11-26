Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00164C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52E7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52E7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeK0G1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:27:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40066 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeK0G1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:27:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so14461998lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAK2f93RbkoelmjiKQh6IJGkzwNjlajJKYQeBPHVu4Y=;
        b=qa7eyb0dax28xfxKHH0Adr9q5Qi5nSJ+t1jHiw+97wtIwFxImAs3cVjpRUPVehc9pG
         qgmwwiqY3aSm0jBZ0vhbfRWF5jHBhamdQZ4jNTBSo7bdGSUzs33+eZzZCk/KerliNHCd
         +AN4UQMG4fxoeGu9FA1n/B0OnpOVim0KA6vi+TChHd4i+ZhAwrX5rGjsJhAtKJemqVLq
         RG15oUpEKUQQw7dD0tCVQ2vJW2z5iE/e3i3Qi/3rPduJ5cpA7VTCwihn/gMCr3QaUKb3
         dYzMtB/TfDaqsnA7/7xFGJ5dYcwqR9skHMRkHFcKd6RQ/qVR8Rj33adBP9EpI+Qltaq1
         u/Kw==
X-Gm-Message-State: AGRZ1gIpY6lZG81ul0TW5VxLzcKk+FEv5VUSTplZbyzCd+tNI3CwqIdc
        8CqaWS79/3WqjR7tG1vpBvy+ZgLK/BcARjAdTl3Jlg==
X-Google-Smtp-Source: AJdET5f62uFVwXkxsQ95s2oYNF6ar5UwKNQg7M2AvcU8E50w56hMsaDPTn9TiMvS5l+opEzE3YVbmmtFlAEb4QTmlco=
X-Received: by 2002:a19:d857:: with SMTP id p84mr16303917lfg.44.1543260721755;
 Mon, 26 Nov 2018 11:32:01 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com> <20181126012824.GB1824@MiWiFi-R3L-srv>
In-Reply-To: <20181126012824.GB1824@MiWiFi-R3L-srv>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 27 Nov 2018 01:01:49 +0530
Message-ID: <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     bhe@redhat.com
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bp@alien8.de, mingo@kernel.org, tglx@linutronix.de,
        k-hagio@ab.jp.nec.com, anderson@redhat.com, james.morse@arm.com,
        osandov@fb.com, x86@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 6:58 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/16/18 at 03:17am, Bhupesh Sharma wrote:
> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
> >
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> > details), whose live debugging feature is broken with newer kernels
>
> I think this paragraph explained why KCORE_REMAP adding caused the
> mistake of page_offset calculation in makedumpfile. It can prove the
> advantage of appending 'page_offset_base' to vmcoreinfo. The old way I
> took in makedumpfile could be impacted by kernel code change, adding it
> to vmcoreinfo can make it stable. The example is KCORE_REMAP adding, and
> later it's removed.
>
> But it's not live debugging feature of makedumpfile. Makedumpfile can't be
> used to live debug. The feature is called '--mem-usage' in makedumpfile,
> in fact it's used to estimate how big the vmcore could be so that customer
> can deply an appropriate size of storage space to store it. Because both
> kcore and vmcore are all elf files which the 1st kernel's memory is
> mapped to, even though they are different, kcore is dynamically changing.
> This is more likely a precision in order of of magnitude. This is a feature
> required by redhat customer.

Indeed this is a live debugging feature - see we are running this in
the primary kernel
context, not in kdump context. We are trying to debug a kernel we are
presently running (in this case determining the page mapping)
hence the term live debugging.

Also, this feature is not limited to redhat - we are talking in
upstream makedumpfile context here - it is used by other projects as
well which can have even a simple busybox rootfs configuration (e.g.
qemu).

> I thought you are talking about using DaveA's crash utility to live
> debug the running kernel, like we usually do with gdb.
>
>         gdb vmlinux /proc/kcore
>
> Yes, this gdb live debugging is broken because of KASLR. We have bug about
> this, while it has not been fixed. Using Crash utility to replace gdb is
> one way if Crash code is adjusted.
>
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
> ...
> > Testing:
> > -------
>
> This one vmcoreinfo entry adding won't impact kernel performance. And
> page_offset_base need be got during makedumpfile initialization, it
> won't impact makedumpfile efficiency either, especially compared with
> the later page filterring and writting out to storage space. I don't
> think there's any need to provide a detailed test result here. If
> possible, just mention it works in this way, maybe it's better in some
> aspects, such as code simplicity, etc.
>
> >  - I tested this patch (rebased on 'linux-next') on a x86_64 machine
> >    using the modified 'makedumpfile' user-space code (see [3] for my
> >    github tree which contains the same) for determining how many pages
> >    are dumpable when different dump_level is specified (which is
> >    one use-case of live-debugging via 'makedumpfile').
> >  - I tested both the KASLR and non-KASLR boot cases with this patch.
> >  - Here is one sample log (for KASLR boot case) on my x86_64 machine:
> >
> >    < snip..>
> >    The kernel doesn't support mmap(),read() will be used instead.
> >
> >    TYPE               PAGES                   EXCLUDABLE      DESCRIPTION
> >    ----------------------------------------------------------------------
> >    ZERO               21299                   yes             Pages filled
> >    with zero
> >    NON_PRI_CACHE      91785                   yes             Cache
> >    pages without private flag
> >    PRI_CACHE  1                       yes             Cache pages with
> >    private flag
> >    USER               14057                   yes             User process
> >    pages
> >    FREE               740346                  yes             Free pages
> >    KERN_DATA  58152                   no              Dumpable kernel
> >    data
> >
> >    page size:         4096
> >    Total pages on system:     925640
> >    Total size on system:      3791421440       Byte
> >
> ...
>
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 4c8acdfdc5a7..6161d77c5bfb 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >       VMCOREINFO_SYMBOL(init_top_pgt);
> >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >                       pgtable_l5_enabled());
> > +#ifdef CONFIG_RANDOMIZE_BASE
>
> Finally, embracing it into CONFIG_RANDOMIZE_BASE ifdefery seems not
> right. The latest kernel is using page_offset_base to do the dynamic
> memory layout between level4 and level5 changing. This may not work in
> 5-level system with CONFIG_RANDOMIZE_BASE=n.

I think you missed the v2 change log and the build-bot error on v1
(see here: <https://patchwork.kernel.org/patch/10657933/#22291691>).
With .config files which have CONFIG_RANDOMIZE_BASE=n, we get the
following compilation error
without the #ifdef jugglery:

 arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
 arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
`page_offset_base'
 arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
`page_offset_base'

Anyways, with Kazu's and Boris's comments on the v2, I understand that
adding 'page_offset_base' variable to vmcoreinfo is useful for x86
kernel.
I will now work on the v3 to take into account review comments and
also work with Lianbo to get the same added to the overall vmcoreinfo
documentation he is preparing for x86.

Thanks,
Bhupesh


> > +     VMCOREINFO_NUMBER(page_offset_base);
> > +#endif
> >
> >  #ifdef CONFIG_NUMA
> >       VMCOREINFO_SYMBOL(node_data);
> > --
> > 2.7.4
> >
