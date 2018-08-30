Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157A920658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157A920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeH3WnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:43:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbeH3WnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:43:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362B240216F9;
        Thu, 30 Aug 2018 18:39:46 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BCE963F4A;
        Thu, 30 Aug 2018 18:39:45 +0000 (UTC)
Date:   Thu, 30 Aug 2018 14:39:44 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-rdma@vger.kernel.org,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180830183944.GE3529@redhat.com>
References: <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
 <20180829181424.GB3784@redhat.com>
 <20180829183906.GF10223@dhcp22.suse.cz>
 <20180829211106.GC3784@redhat.com>
 <20180830105616.GD2656@dhcp22.suse.cz>
 <20180830140825.GA3529@redhat.com>
 <20180830161800.GJ2656@dhcp22.suse.cz>
 <20180830165751.GD3529@redhat.com>
 <e0c0c966-6706-4ca2-4077-e79322756a9b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0c0c966-6706-4ca2-4077-e79322756a9b@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 18:39:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 18:39:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:05:16AM -0700, Mike Kravetz wrote:
> On 08/30/2018 09:57 AM, Jerome Glisse wrote:
> > On Thu, Aug 30, 2018 at 06:19:52PM +0200, Michal Hocko wrote:
> >> On Thu 30-08-18 10:08:25, Jerome Glisse wrote:
> >>> On Thu, Aug 30, 2018 at 12:56:16PM +0200, Michal Hocko wrote:
> >>>> On Wed 29-08-18 17:11:07, Jerome Glisse wrote:
> >>>>> On Wed, Aug 29, 2018 at 08:39:06PM +0200, Michal Hocko wrote:
> >>>>>> On Wed 29-08-18 14:14:25, Jerome Glisse wrote:
> >>>>>>> On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
> >>>>>> [...]
> >>>>>>>> What would be the best mmu notifier interface to use where there are no
> >>>>>>>> start/end calls?
> >>>>>>>> Or, is the best solution to add the start/end calls as is done in later
> >>>>>>>> versions of the code?  If that is the suggestion, has there been any change
> >>>>>>>> in invalidate start/end semantics that we should take into account?
> >>>>>>>
> >>>>>>> start/end would be the one to add, 4.4 seems broken in respect to THP
> >>>>>>> and mmu notification. Another solution is to fix user of mmu notifier,
> >>>>>>> they were only a handful back then. For instance properly adjust the
> >>>>>>> address to match first address covered by pmd or pud and passing down
> >>>>>>> correct page size to mmu_notifier_invalidate_page() would allow to fix
> >>>>>>> this easily.
> >>>>>>>
> >>>>>>> This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
> >>>>>>> with an invalid one (either poison, migration or swap) inside the
> >>>>>>> function. So anyone racing would synchronize on those special entry
> >>>>>>> hence why it is fine to delay mmu_notifier_invalidate_page() to after
> >>>>>>> dropping the page table lock.
> >>>>>>>
> >>>>>>> Adding start/end might the solution with less code churn as you would
> >>>>>>> only need to change try_to_unmap_one().
> >>>>>>
> >>>>>> What about dependencies? 369ea8242c0fb sounds like it needs work for all
> >>>>>> notifiers need to be updated as well.
> >>>>>
> >>>>> This commit remove mmu_notifier_invalidate_page() hence why everything
> >>>>> need to be updated. But in 4.4 you can get away with just adding start/
> >>>>> end and keep around mmu_notifier_invalidate_page() to minimize disruption.
> >>>>
> >>>> OK, this is really interesting. I was really worried to change the
> >>>> semantic of the mmu notifiers in stable kernels because this is really
> >>>> a hard to review change and high risk for anybody running those old
> >>>> kernels. If we can keep the mmu_notifier_invalidate_page and wrap them
> >>>> into the range scope API then this sounds like the best way forward.
> >>>>
> >>>> So just to make sure we are at the same page. Does this sounds goo for
> >>>> stable 4.4. backport? Mike's hugetlb pmd shared fixup can be applied on
> >>>> top. What do you think?
> >>>
> >>> You need to invalidate outside page table lock so before the call to
> >>> page_check_address(). For instance like below patch, which also only
> >>> do the range invalidation for huge page which would avoid too much of
> >>> a behavior change for user of mmu notifier.
> >>
> >> Right. I would rather not make this PageHuge special though. So the
> >> fixed version should be.
> > 
> > Why not testing for huge ? Only huge is broken and thus only that
> > need the extra range invalidation. Doing the double invalidation
> > for single page is bit overkill.
> 
> I am a bit confused, and hope this does not add to any confusion by others.
> 
> IIUC, the patch below does not attempt to 'fix' anything.  It is simply
> there to add the start/end notifiers to the v4.4 version of this routine
> so that a subsequent patch can use them (with modified ranges) to handle
> unmapping a shared pmd huge page.  That is the mainline fix which started
> this thread.
> 
> Since we are only/mostly interested in fixing the shared pmd issue in
> 4.4, how about just adding the start/end notifiers to the very specific
> case where pmd sharing is possible?
> 
> I can see the value in trying to back port dependent patches such as this
> so that stable releases look more like mainline.  However, I am not sure of
> the value in this case as this patch was part of a larger set changing
> notifier semantics.

For all intents and purposes this is not a backport of the original
patch so maybe we should just drop the commit reference and just
explains that it is there to fix mmu notifier in respect to huge page
migration.

The original patches fix more than this case because newer featurers
like THP migration, THP swapping, ... added more cases where things
would have been wrong. But in 4.4 frame there is only huge tlb fs
migration.

Cheers,
Jérôme
