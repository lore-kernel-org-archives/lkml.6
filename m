Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E72C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887FC218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sPIFgt6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfAXAAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:00:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46359 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfAXAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:00:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so3371991oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 16:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rpP/0N8IbDs89n8LEoHdcPYBMTkV8MXEOUkDVjHKx1E=;
        b=sPIFgt6mf/MIVELnlkxPQvAWnaLeYl5UwbNxfpdRhKn6kqQS3SsikKsrdPcq4QgmYC
         GMh/PT3pWTpAXr7c50jmmbCHibKyQe9IcHc9QgipXtasVIZXY07nyyAV4+leQjipIw4R
         7cYfA4hrW+gIpu83Q3wgMfQ6+M4lOw13h3s33wOL0hoWe/ZICQcSKSDqhHXMmQ4TB4zd
         DwWxN5cR0lqpAR+0fB2Giz1uM2tAFc+UvwGOLDTHTjdBjbs16DnvRk8BtyUhiai2DUZW
         56qF7+vPd4ISuy3nXpyCxFBG5PG642P6IuzMVZVHeovipm5zR4PrN8POdD4IH3Epckcj
         sUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpP/0N8IbDs89n8LEoHdcPYBMTkV8MXEOUkDVjHKx1E=;
        b=QJWZGKNeJsAILZVH/yFmgunakgGe0qlB1s4X6md2grpOq1FPwgliJXiarH2MHGAMrL
         juiRk1bUM/wl1QQulKdHkJk1RszcFN66NYj/VMz3QjSUdXhSvnFG1POr4deaupG1ZJe5
         mfsKWQE2WEHZnMLKOM8/hxRQ0U/cOeq+doPhFMHTQm9qFOI+FJt1n4j32UZM8NY2P31R
         3OwET5ikIhJxlDVPWPI0aOuPxm2ud7BjTMlVFrcnpsGQtzZUMJPc+PDB9r9dKlsU+QD0
         6Y71cH8iWjRtGxHCZhDxb3hDfiQw7UO/MvUdglK7nvfZAmCPcEj0LUfbrGvLB1PlJOF1
         070A==
X-Gm-Message-State: AJcUukfIsxiMs2uJxyUqhtUO9RdCwLtgqX6Ygdo0RyqZ+NCPuBUGzhN6
        Tl12WB+IOOxfDKn7T16W34TP0w8no+yVG4FSbU5Uww==
X-Google-Smtp-Source: ALg8bN7gocapdWlDuMxCMzOUkT08yZ0mDyICKGp1Ug3fEDQ+F9y73yh31xTG9r9DQbg5Qkm1gE2RU8ScZbB4cgsamcw=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr2810213oih.244.1548288048338;
 Wed, 23 Jan 2019 16:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20190123222315.1122-1-jglisse@redhat.com> <CAPcyv4i9_T9779ZyaYt2T3b20-wQTaWA4P63+49TM=a=twtDVw@mail.gmail.com>
 <20190123230447.GC1257@redhat.com>
In-Reply-To: <20190123230447.GC1257@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Jan 2019 16:00:37 -0800
Message-ID: <CAPcyv4iJGLqh6-Wio_3408tRa62z-Ug_8BV6PuQV=ZAGcXo5TA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mmu notifier provide context informations
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, KVM list <kvm@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 3:05 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Jan 23, 2019 at 02:54:40PM -0800, Dan Williams wrote:
> > On Wed, Jan 23, 2019 at 2:23 PM <jglisse@redhat.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > >
> > > Hi Andrew, i see that you still have my event patch in you queue [1].
> > > This patchset replace that single patch and is broken down in further
> > > step so that it is easier to review and ascertain that no mistake wer=
e
> > > made during mechanical changes. Here are the step:
> > >
> > >     Patch 1 - add the enum values
> > >     Patch 2 - coccinelle semantic patch to convert all call site of
> > >               mmu_notifier_range_init to default enum value and also
> > >               to passing down the vma when it is available
> > >     Patch 3 - update many call site to more accurate enum values
> > >     Patch 4 - add the information to the mmu_notifier_range struct
> > >     Patch 5 - helper to test if a range is updated to read only
> > >
> > > All the remaining patches are update to various driver to demonstrate
> > > how this new information get use by device driver. I build tested
> > > with make all and make all minus everything that enable mmu notifier
> > > ie building with MMU_NOTIFIER=3Dno. Also tested with some radeon,amd
> > > gpu and intel gpu.
> > >
> > > If they are no objections i believe best plan would be to merge the
> > > the first 5 patches (all mm changes) through your queue for 5.1 and
> > > then to delay driver update to each individual driver tree for 5.2.
> > > This will allow each individual device driver maintainer time to more
> > > thouroughly test this more then my own testing.
> > >
> > > Note that i also intend to use this feature further in nouveau and
> > > HMM down the road. I also expect that other user like KVM might be
> > > interested into leveraging this new information to optimize some of
> > > there secondary page table invalidation.
> >
> > "Down the road" users should introduce the functionality they want to
> > consume. The common concern with preemptively including
> > forward-looking infrastructure is realizing later that the
> > infrastructure is not needed, or needs changing. If it has no current
> > consumer, leave it out.
>
> This patchset already show that this is useful, what more can i do ?
> I know i will use this information, in nouveau for memory policy we
> allocate our own structure for every vma the GPU ever accessed or that
> userspace hinted we should set a policy for. Right now with existing
> mmu notifier i _must_ free those structure because i do not know if
> the invalidation is an munmap or something else. So i am loosing
> important informations and unecessarly free struct that i will have
> to re-allocate just couple jiffies latter. That's one way i am using
> this.

Understood, but that still seems to say stage the core support when
the nouveau enabling is ready.

> The other way is to optimize GPU page table update just like i
> am doing with all the patches to RDMA/ODP and various GPU drivers.

Yes.

>
>
> > > Here is an explaination on the rational for this patchset:
> > >
> > >
> > > CPU page table update can happens for many reasons, not only as a res=
ult
> > > of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but als=
o
> > > as a result of kernel activities (memory compression, reclaim, migrat=
ion,
> > > ...).
> > >
> > > This patch introduce a set of enums that can be associated with each =
of
> > > the events triggering a mmu notifier. Latter patches take advantages =
of
> > > those enum values.
> > >
> > > - UNMAP: munmap() or mremap()
> > > - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
> > > - PROTECTION_VMA: change in access protections for the range
> > > - PROTECTION_PAGE: change in access protections for page in the range
> > > - SOFT_DIRTY: soft dirtyness tracking
> > >
> > > Being able to identify munmap() and mremap() from other reasons why t=
he
> > > page table is cleared is important to allow user of mmu notifier to
> > > update their own internal tracking structure accordingly (on munmap o=
r
> > > mremap it is not longer needed to track range of virtual address as i=
t
> > > becomes invalid).
> >
> > The only context information consumed in this patch set is
> > MMU_NOTIFY_PROTECTION_VMA.
> >
> > What is the practical benefit of these "optimize out the case when a
> > range is updated to read only" optimizations? Any numbers to show this
> > is worth the code thrash?
>
> It depends on the workload for instance if you map to RDMA a file
> read only like a log file for export, all write back that would
> disrupt the RDMA mapping can be optimized out.
>
> See above for more reasons why it is beneficial (knowing when it is
> an munmap/mremap versus something else).
>
> I would have not thought that passing down information as something
> that controversial. Hopes this help you see the benefit of this.

I'm not asserting that it is controversial. I am asserting that
whenever a changelog says "optimize" it also includes concrete data
about the optimization scenario. Maybe the scenarios you have
optimized are clear to the driver owners, they just weren't
immediately clear to me.
