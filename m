Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBBECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293DD2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293DD2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeGQInc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:43:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729621AbeGQInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:43:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1015AD1A;
        Tue, 17 Jul 2018 08:12:06 +0000 (UTC)
Date:   Tue, 17 Jul 2018 10:12:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180717081201.GB16803@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <20180716161249.c76240cd487c070fb271d529@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161249.c76240cd487c070fb271d529@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-07-18 16:12:49, Andrew Morton wrote:
> On Mon, 16 Jul 2018 13:50:58 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There are several blockable mmu notifiers which might sleep in
> > mmu_notifier_invalidate_range_start and that is a problem for the
> > oom_reaper because it needs to guarantee a forward progress so it cannot
> > depend on any sleepable locks.
> > 
> > Currently we simply back off and mark an oom victim with blockable mmu
> > notifiers as done after a short sleep. That can result in selecting a
> > new oom victim prematurely because the previous one still hasn't torn
> > its memory down yet.
> > 
> > We can do much better though. Even if mmu notifiers use sleepable locks
> > there is no reason to automatically assume those locks are held.
> > Moreover majority of notifiers only care about a portion of the address
> > space and there is absolutely zero reason to fail when we are unmapping an
> > unrelated range. Many notifiers do really block and wait for HW which is
> > harder to handle and we have to bail out though.
> > 
> > This patch handles the low hanging fruid. __mmu_notifier_invalidate_range_start
> > gets a blockable flag and callbacks are not allowed to sleep if the
> > flag is set to false. This is achieved by using trylock instead of the
> > sleepable lock for most callbacks and continue as long as we do not
> > block down the call chain.
> 
> I assume device driver developers are wondering "what does this mean
> for me".  As I understand it, the only time they will see
> blockable==false is when their driver is being called in response to an
> out-of-memory condition, yes?  So it is a very rare thing.

Yes, this is the case right now. Maybe we will grow other users in
future. Those other potential users is the reason why I used blockable
rather than oom parameter name.

> Any suggestions regarding how the driver developers can test this code
> path?  I don't think we presently have a way to fake an oom-killing
> event?  Perhaps we should add such a thing, given the problems we're
> having with that feature.

The simplest way is to wrap an userspace code which uses these notifiers
into a memcg and set the hard limit to hit the oom. This can be done
e.g. after the test faults in all the mmu notifier managed memory and
set the hard limit to something really small. Then we are looking for a
proper process tear down.

> > I think we can improve that even further because there is a common
> > pattern to do a range lookup first and then do something about that.
> > The first part can be done without a sleeping lock in most cases AFAICS.
> > 
> > The oom_reaper end then simply retries if there is at least one notifier
> > which couldn't make any progress in !blockable mode. A retry loop is
> > already implemented to wait for the mmap_sem and this is basically the
> > same thing.
> > 
> > ...
> >
> > +static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
> > +				  unsigned long start, unsigned long end)
> > +{
> > +	int ret = 0;
> > +	if (mm_has_notifiers(mm))
> > +		ret = __mmu_notifier_invalidate_range_start(mm, start, end, false);
> > +
> > +	return ret;
> >  }
> 
> nit,
> 
> {
> 	if (mm_has_notifiers(mm))
> 		return __mmu_notifier_invalidate_range_start(mm, start, end, false);
> 	return 0;
> }
> 
> would suffice.

Sure. Fixed
 
> > 
> > ...
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3074,7 +3074,7 @@ void exit_mmap(struct mm_struct *mm)
> >  		 * reliably test it.
> >  		 */
> >  		mutex_lock(&oom_lock);
> > -		__oom_reap_task_mm(mm);
> > +		(void)__oom_reap_task_mm(mm);
> >  		mutex_unlock(&oom_lock);
> 
> What does this do?

There is no error to be returned here as the comment above explains
		 * Nothing can be holding mm->mmap_sem here and the above call
		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
		 * __oom_reap_task_mm() will not block.
-- 
Michal Hocko
SUSE Labs
