Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798BC20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfA3DDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:03:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbfA3DDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:03:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8B1180511;
        Wed, 30 Jan 2019 03:03:20 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91BEB176AF;
        Wed, 30 Jan 2019 03:03:19 +0000 (UTC)
Date:   Tue, 29 Jan 2019 22:03:17 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190130030317.GC10462@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-10-jglisse@redhat.com>
 <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
 <20190129193123.GF3176@redhat.com>
 <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
 <20190129212150.GP3176@redhat.com>
 <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 30 Jan 2019 03:03:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:32:56PM -0800, Dan Williams wrote:
> On Tue, Jan 29, 2019 at 1:21 PM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Jan 29, 2019 at 12:51:25PM -0800, Dan Williams wrote:
> > > On Tue, Jan 29, 2019 at 11:32 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > >
> > > > On Tue, Jan 29, 2019 at 10:41:23AM -0800, Dan Williams wrote:
> > > > > On Tue, Jan 29, 2019 at 8:54 AM <jglisse@redhat.com> wrote:
> > > > > >
> > > > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > > >
> > > > > > This add support to mirror vma which is an mmap of a file which is on
> > > > > > a filesystem that using a DAX block device. There is no reason not to
> > > > > > support that case.
> > > > > >
> > > > >
> > > > > The reason not to support it would be if it gets in the way of future
> > > > > DAX development. How does this interact with MAP_SYNC? I'm also
> > > > > concerned if this complicates DAX reflink support. In general I'd
> > > > > rather prioritize fixing the places where DAX is broken today before
> > > > > adding more cross-subsystem entanglements. The unit tests for
> > > > > filesystems (xfstests) are readily accessible. How would I go about
> > > > > regression testing DAX + HMM interactions?
> > > >
> > > > HMM mirror CPU page table so anything you do to CPU page table will
> > > > be reflected to all HMM mirror user. So MAP_SYNC has no bearing here
> > > > whatsoever as all HMM mirror user must do cache coherent access to
> > > > range they mirror so from DAX point of view this is just _exactly_
> > > > the same as CPU access.
> > > >
> > > > Note that you can not migrate DAX memory to GPU memory and thus for a
> > > > mmap of a file on a filesystem that use a DAX block device then you can
> > > > not do migration to device memory. Also at this time migration of file
> > > > back page is only supported for cache coherent device memory so for
> > > > instance on OpenCAPI platform.
> > >
> > > Ok, this addresses the primary concern about maintenance burden. Thanks.
> > >
> > > However the changelog still amounts to a justification of "change
> > > this, because we can". At least, that's how it reads to me. Is there
> > > any positive benefit to merging this patch? Can you spell that out in
> > > the changelog?
> >
> > There is 3 reasons for this:
> 
> Thanks for this.
> 
> >     1) Convert ODP to use HMM underneath so that we share code between
> >     infiniband ODP and GPU drivers. ODP do support DAX today so i can
> >     not convert ODP to HMM without also supporting DAX in HMM otherwise
> >     i would regress the ODP features.
> >
> >     2) I expect people will be running GPGPU on computer with file that
> >     use DAX and they will want to use HMM there too, in fact from user-
> >     space point of view wether the file is DAX or not should only change
> >     one thing ie for DAX file you will never be able to use GPU memory.
> >
> >     3) I want to convert as many user of GUP to HMM (already posted
> >     several patchset to GPU mailing list for that and i intend to post
> >     a v2 of those latter on). Using HMM avoids GUP and it will avoid
> >     the GUP pin as here we abide by mmu notifier hence we do not want to
> >     inhibit any of the filesystem regular operation. Some of those GPU
> >     driver do allow GUP on DAX file. So again i can not regress them.
> 
> Is this really a GUP to HMM conversion, or a GUP to mmu_notifier
> solution? It would be good to boil this conversion down to the base
> building blocks. It seems "HMM" can mean several distinct pieces of
> infrastructure. Is it possible to replace some GUP usage with an
> mmu_notifier based solution without pulling in all of HMM?

Kind of both, some of the GPU driver i am converting will use HMM for
more than just this GUP reason. But when and for what hardware they
will use HMM for is not something i can share (it is up to each vendor
to announce their hardware and feature on their own timeline).

So yes you could do the mmu notifier solution without pulling HMM
mirror (note that you do not need to pull all of HMM, HMM as many
kernel config option and for this you only need to use HMM mirror).
But if you are not using HMM then you will just be duplicating the
same code as HMM mirror. So i believe it is better to share this
code and if we want to change core mm then we only have to update
HMM while keeping the API/contract with device driver intact. This
is one of the motivation behind HMM ie have it as an impedence layer
between mm and device drivers so that mm folks do not have to under-
stand every single device driver but only have to understand the
contract HMM has with all device driver that uses it.

Also having each driver duplicating this code increase the risk of
one getting a little detail wrong. The hope is that sharing same
HMM code with all the driver then everyone benefit from debugging
the same code (i am hopping i do not have many bugs left :))


> > > > Bottom line is you just have to worry about the CPU page table. What
> > > > ever you do there will be reflected properly. It does not add any
> > > > burden to people working on DAX. Unless you want to modify CPU page
> > > > table without calling mmu notifier but in that case you would not
> > > > only break HMM mirror user but other thing like KVM ...
> > > >
> > > >
> > > > For testing the issue is what do you want to test ? Do you want to test
> > > > that a device properly mirror some mmap of a file back by DAX ? ie
> > > > device driver which use HMM mirror keep working after changes made to
> > > > DAX.
> > > >
> > > > Or do you want to run filesystem test suite using the GPU to access
> > > > mmap of the file (read or write) instead of the CPU ? In that case any
> > > > such test suite would need to be updated to be able to use something
> > > > like OpenCL for. At this time i do not see much need for that but maybe
> > > > this is something people would like to see.
> > >
> > > In general, as HMM grows intercept points throughout the mm it would
> > > be helpful to be able to sanity check the implementation.
> >
> > I usualy use a combination of simple OpenCL programs and hand tailor direct
> > ioctl hack to force specific code path to happen. I should probably create
> > a repository with a set of OpenCL tests so that other can also use them.
> > I need to clean those up into something not too ugly so i am not ashame
> > of them.
> 
> That would be great, even it is messy.

I will clean them up a put something together that i am not too ashame to
push :) I am on PTO for next couple weeks so it will probably not happens
before i am back. I still should have email access.

Cheers,
Jérôme
