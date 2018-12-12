Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA62FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFA42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeLLWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeLLWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:14:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA72030AAD67;
        Wed, 12 Dec 2018 22:14:51 +0000 (UTC)
Received: from redhat.com (ovpn-124-14.rdu2.redhat.com [10.10.124.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E449960C46;
        Wed, 12 Dec 2018 22:14:48 +0000 (UTC)
Date:   Wed, 12 Dec 2018 17:14:46 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181212221446.GI5037@redhat.com>
References: <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <514cc9e1-dc4d-b979-c6bc-88ac503c098d@nvidia.com>
 <20181212220418.GH5037@redhat.com>
 <311cd7a7-6727-a298-964e-ad238a30bdef@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <311cd7a7-6727-a298-964e-ad238a30bdef@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Dec 2018 22:14:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:11:58PM -0800, John Hubbard wrote:
> On 12/12/18 2:04 PM, Jerome Glisse wrote:
> > On Wed, Dec 12, 2018 at 01:56:00PM -0800, John Hubbard wrote:
> >> On 12/12/18 1:30 PM, Jerome Glisse wrote:
> >>> On Wed, Dec 12, 2018 at 08:27:35AM -0800, Dan Williams wrote:
> >>>> On Wed, Dec 12, 2018 at 7:03 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >>>>>
> >>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> >>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> >>>>>>> Another crazy idea, why not treating GUP as another mapping of the page
> >>>>>>> and caller of GUP would have to provide either a fake anon_vma struct or
> >>>>>>> a fake vma struct (or both for PRIVATE mapping of a file where you can
> >>>>>>> have a mix of both private and file page thus only if it is a read only
> >>>>>>> GUP) that would get added to the list of existing mapping.
> >>>>>>>
> >>>>>>> So the flow would be:
> >>>>>>>     somefunction_thatuse_gup()
> >>>>>>>     {
> >>>>>>>         ...
> >>>>>>>         GUP(_fast)(vma, ..., fake_anon, fake_vma);
> >>>>>>>         ...
> >>>>>>>     }
> >>>>>>>
> >>>>>>>     GUP(vma, ..., fake_anon, fake_vma)
> >>>>>>>     {
> >>>>>>>         if (vma->flags == ANON) {
> >>>>>>>             // Add the fake anon vma to the anon vma chain as a child
> >>>>>>>             // of current vma
> >>>>>>>         } else {
> >>>>>>>             // Add the fake vma to the mapping tree
> >>>>>>>         }
> >>>>>>>
> >>>>>>>         // The existing GUP except that now it inc mapcount and not
> >>>>>>>         // refcount
> >>>>>>>         GUP_old(..., &nanonymous, &nfiles);
> >>>>>>>
> >>>>>>>         atomic_add(&fake_anon->refcount, nanonymous);
> >>>>>>>         atomic_add(&fake_vma->refcount, nfiles);
> >>>>>>>
> >>>>>>>         return nanonymous + nfiles;
> >>>>>>>     }
> >>>>>>
> >>>>>> Thanks for your idea! This is actually something like I was suggesting back
> >>>>>> at LSF/MM in Deer Valley. There were two downsides to this I remember
> >>>>>> people pointing out:
> >>>>>>
> >>>>>> 1) This cannot really work with __get_user_pages_fast(). You're not allowed
> >>>>>> to get necessary locks to insert new entry into the VMA tree in that
> >>>>>> context. So essentially we'd loose get_user_pages_fast() functionality.
> >>>>>>
> >>>>>> 2) The overhead e.g. for direct IO may be noticeable. You need to allocate
> >>>>>> the fake tracking VMA, get VMA interval tree lock, insert into the tree.
> >>>>>> Then on IO completion you need to queue work to unpin the pages again as you
> >>>>>> cannot remove the fake VMA directly from interrupt context where the IO is
> >>>>>> completed.
> >>>>>>
> >>>>>> You are right that the cost could be amortized if gup() is called for
> >>>>>> multiple consecutive pages however for small IOs there's no help...
> >>>>>>
> >>>>>> So this approach doesn't look like a win to me over using counter in struct
> >>>>>> page and I'd rather try looking into squeezing HMM public page usage of
> >>>>>> struct page so that we can fit that gup counter there as well. I know that
> >>>>>> it may be easier said than done...
> >>>>>
> >>>>> So i want back to the drawing board and first i would like to ascertain
> >>>>> that we all agree on what the objectives are:
> >>>>>
> >>>>>     [O1] Avoid write back from a page still being written by either a
> >>>>>          device or some direct I/O or any other existing user of GUP.
> >>>>>          This would avoid possible file system corruption.
> >>>>>
> >>>>>     [O2] Avoid crash when set_page_dirty() is call on a page that is
> >>>>>          considered clean by core mm (buffer head have been remove and
> >>>>>          with some file system this turns into an ugly mess).
> >>>>>
> >>>>>     [O3] DAX and the device block problems, ie with DAX the page map in
> >>>>>          userspace is the same as the block (persistent memory) and no
> >>>>>          filesystem nor block device understand page as block or pinned
> >>>>>          block.
> >>>>>
> >>>>> For [O3] i don't think any pin count would help in anyway. I believe
> >>>>> that the current long term GUP API that does not allow GUP of DAX is
> >>>>> the only sane solution for now.
> >>>>
> >>>> No, that's not a sane solution, it's an emergency hack.
> >>>>
> >>>>> The real fix would be to teach file-
> >>>>> system about DAX/pinned block so that a pinned block is not reuse
> >>>>> by filesystem.
> >>>>
> >>>> We already have taught filesystems about pinned dax pages, see
> >>>> dax_layout_busy_page(). As much as possible I want to eliminate the
> >>>> concept of "dax pages" as a special case that gets sprinkled
> >>>> throughout the mm.
> >>>
> >>> So thinking on O3 issues what about leveraging the recent change i
> >>> did to mmu notifier. Add a event for truncate or any other file
> >>> event that need to invalidate the file->page for a range of offset.
> >>>
> >>> Add mmu notifier listener to GUP user (except direct I/O) so that
> >>> they invalidate they hardware mapping or switch the hardware mapping
> >>> to use a crappy page. When such event happens what ever user do to
> >>> the page through that driver is broken anyway. So it is better to
> >>> be loud about it then trying to make it pass under the radar.
> >>>
> >>> This will put the burden on broken user and allow you to properly
> >>> recycle your DAX page.
> >>>
> >>> Think of it as revoke through mmu notifier.
> >>>
> >>> So patchset would be:
> >>>     enum mmu_notifier_event {
> >>> +       MMU_NOTIFY_TRUNCATE,
> >>>     };
> >>>
> >>> +   Change truncate code path to emit MMU_NOTIFY_TRUNCATE
> >>>
> >>
> >> That part looks good.
> >>
> >>> Then for each user of GUP (except direct I/O or other very short
> >>> term GUP):
> >>
> >> but, why is there a difference between how we handle long- and
> >> short-term callers? Aren't we just leaving a harder-to-reproduce race
> >> condition, if we ignore the short-term gup callers?
> >>
> >> So, how does activity (including direct IO and other short-term callers)
> >> get quiesced (stopped, and guaranteed not to restart or continue), so 
> >> that truncate or umount can continue on?
> > 
> > The fs would delay block reuse to after refcount is gone so it would
> > wait for that. It is ok to do that only for short term user in case of
> > direct I/O this should really not happen as it means that the application
> > is doing something really stupid. So the waiting on short term user
> > would be a rare event.
> 
> OK, I think that sounds like there are no race conditions left.
> 
> > 
> > 
> >>>     Patch 1: register mmu notifier
> >>>     Patch 2: listen to MMU_NOTIFY_TRUNCATE and MMU_NOTIFY_UNMAP
> >>>              when that happens update the device page table or
> >>>              usage to point to a crappy page and do put_user_page
> >>>              on all previously held page
> >>
> >> Minor point, this sequence should be done within a wrapper around existing 
> >> get_user_pages(), such as get_user_pages_revokable() or something.
> > 
> > No we want to teach everyone to abide by the rules, if we add yet another
> > GUP function prototype people will use the one where they don;t have to
> > say they abide by the rules. It is time we advertise the fact that GUP
> > should not be use willy nilly for anything without worrying about the
> > implication it has :)
> 
> Well, the best way to do that is to provide a named function call that 
> implements the rules. That also makes it easy to grep around and see which
> call sites still need upgrades, and which don't.
> 
> > 
> > So i would rather see a consolidation in the number of GUP prototype we
> > have than yet another one.
> 
> We could eventually get rid of the older GUP prototypes, once we're done
> converting. Having a new, named function call will *without question* make
> the call site conversion go much easier, and the end result is also better:
> the common code is in a central function, rather than being at all the call
> sites.
> 

Then last patch in the patchset must remove all GUP prototype except
ones with the right API :)

Cheers,
Jérôme
