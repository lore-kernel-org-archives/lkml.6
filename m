Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312420879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547167494;
	bh=WG/P66XN4qR7HG2MSq1KjFJ2CkSzkKRidv2c1nBua0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m8I7sDxyjXQWx1EX7t1TKH48hESqY5vdx7DY96qq673YTc1/Hh3TEzchZ40+GdJcS
	 xqqqe5pZhe/oLtQhuVeWkDufMg0R1xZf5nnlM5/c+LGAxP4TcMqHyZCBYrYTM8PUgw
	 PieF8Py+p1W6gcN0Uub5QnibF+3Z5r2Qeo69GDH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfAKAox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:44:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbfAKAox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:44:53 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCC6218AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547167492;
        bh=WG/P66XN4qR7HG2MSq1KjFJ2CkSzkKRidv2c1nBua0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0wOYoZuyhSTuDfZfYOyUUB5GM/qZ9DSk4fNQHanVxK9hh7E3mLxhPcUrcR2SZRW5d
         b4nTmZ8zHmhPcBKNilb5lTl8kgLtNby3D7Z2g4CMUfmtAEdq9iQ09l2y1lGM8zpxvr
         u+8m/v/cCMoB1KoBZpIdHeGMzLrLmVjZfj6FClYE=
Received: by mail-wr1-f43.google.com with SMTP id u4so13427928wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:44:51 -0800 (PST)
X-Gm-Message-State: AJcUukeMnVPiKJTl2uUodOWhIz0ViLwWsPxcEwOcR8nQNe4Idefd8nfG
        NWTps816LHRNSzxkKcosxF0dYKGk/KMRbfHW7/nymw==
X-Google-Smtp-Source: ALg8bN60rjZn/1Q52Wpgpv3aehK6m/VINba8FysQCwVaafrup3TKLXCoz60PhAHZrTKREhmOAYAfPLnIcp9KWcYR5Gc=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr10938341wro.77.1547167488414;
 Thu, 10 Jan 2019 16:44:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547153058.git.khalid.aziz@oracle.com> <CAGXu5jKS8XSw7nByaeXqgPbmRRw01E_zUYxLCk7zFepAVSw_aQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKS8XSw7nByaeXqgPbmRRw01E_zUYxLCk7zFepAVSw_aQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Jan 2019 16:44:36 -0800
X-Gmail-Original-Message-ID: <CALCETrVWjdo6C53eFz8Gc99q4HFsGpwf4kDXR5OG8E96t-gSLw@mail.gmail.com>
Message-ID: <CALCETrVWjdo6C53eFz8Gc99q4HFsGpwf4kDXR5OG8E96t-gSLw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame Ownership
To:     Kees Cook <keescook@chromium.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liran.alon@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        kanth.ghatraju@oracle.com,
        Joao Martins <joao.m.martins@oracle.com>,
        Jim Mattson <jmattson@google.com>, pradeep.vincent@oracle.com,
        John Haxby <john.haxby@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, steven.sistare@oracle.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 10, 2019 at 1:10 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> > I implemented a solution to reduce performance penalty and
> > that has had large impact. When XPFO code flushes stale TLB entries,
> > it does so for all CPUs on the system which may include CPUs that
> > may not have any matching TLB entries or may never be scheduled to
> > run the userspace task causing TLB flush. Problem is made worse by
> > the fact that if number of entries being flushed exceeds
> > tlb_single_page_flush_ceiling, it results in a full TLB flush on
> > every CPU. A rogue process can launch a ret2dir attack only from a
> > CPU that has dual mapping for its pages in physmap in its TLB. We
> > can hence defer TLB flush on a CPU until a process that would have
> > caused a TLB flush is scheduled on that CPU. I have added a cpumask
> > to task_struct which is then used to post pending TLB flush on CPUs
> > other than the one a process is running on. This cpumask is checked
> > when a process migrates to a new CPU and TLB is flushed at that
> > time. I measured system time for parallel make with unmodified 4.20
> > kernel, 4.20 with XPFO patches before this optimization and then
> > again after applying this optimization. Here are the results:

I wasn't cc'd on the patch, so I don't know the exact details.

I'm assuming that "ret2dir" means that you corrupt the kernel into
using a direct-map page as its stack.  If so, then I don't see why the
task in whose context the attack is launched needs to be the same
process as the one that has the page mapped for user access.

My advice would be to attempt an entirely different optimization: try
to avoid putting pages *back* into the direct map when they're freed
until there is an actual need to use them for kernel purposes.

How are you handing page cache?  Presumably MAP_SHARED PROT_WRITE
pages are still in the direct map so that IO works.
