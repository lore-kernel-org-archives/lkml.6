Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF43C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9860E244C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9860E244C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933862AbeFVPYw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:24:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933291AbeFVPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:24:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87E0BAF6E;
        Fri, 22 Jun 2018 15:24:46 +0000 (UTC)
Date:   Fri, 22 Jun 2018 17:24:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180622152444.GC10465@dhcp22.suse.cz>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <0aa9f695-5702-6704-9462-7779cbfdb3fd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aa9f695-5702-6704-9462-7779cbfdb3fd@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 17:13:02, Christian König wrote:
> Hi Michal,
> 
> [Adding Felix as well]
> 
> Well first of all you have a misconception why at least the AMD graphics
> driver need to be able to sleep in an MMU notifier: We need to sleep because
> we need to wait for hardware operations to finish and *NOT* because we need
> to wait for locks.
> 
> I'm not sure if your flag now means that you generally can't sleep in MMU
> notifiers any more, but if that's the case at least AMD hardware will break
> badly. In our case the approach of waiting for a short time for the process
> to be reaped and then select another victim actually sounds like the right
> thing to do.

Well, I do not need to make the notifier code non blocking all the time.
All I need is to ensure that it won't sleep if the flag says so and
return -EAGAIN instead.

So here is what I do for amdgpu:

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > index 83e344fbb50a..d138a526feff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > @@ -136,12 +136,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
> >    *
> >    * Take the rmn read side lock.
> >    */
> > -static void amdgpu_mn_read_lock(struct amdgpu_mn *rmn)
> > +static int amdgpu_mn_read_lock(struct amdgpu_mn *rmn, bool blockable)
> >   {
> > -	mutex_lock(&rmn->read_lock);
> > +	if (blockable)
> > +		mutex_lock(&rmn->read_lock);
> > +	else if (!mutex_trylock(&rmn->read_lock))
> > +		return -EAGAIN;
> > +
> >   	if (atomic_inc_return(&rmn->recursion) == 1)
> >   		down_read_non_owner(&rmn->lock);
> >   	mutex_unlock(&rmn->read_lock);
> > +
> > +	return 0;
> >   }
> >   /**
> > @@ -197,10 +203,11 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
> >    * We block for all BOs between start and end to be idle and
> >    * unmap them by move them into system domain again.
> >    */
> > -static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> > +static int amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> >   						 struct mm_struct *mm,
> >   						 unsigned long start,
> > -						 unsigned long end)
> > +						 unsigned long end,
> > +						 bool blockable)
> >   {
> >   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
> >   	struct interval_tree_node *it;
> > @@ -208,7 +215,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> >   	/* notification is exclusive, but interval is inclusive */
> >   	end -= 1;
> > -	amdgpu_mn_read_lock(rmn);
> > +	/* TODO we should be able to split locking for interval tree and
> > +	 * amdgpu_mn_invalidate_node
> > +	 */
> > +	if (amdgpu_mn_read_lock(rmn, blockable))
> > +		return -EAGAIN;
> >   	it = interval_tree_iter_first(&rmn->objects, start, end);
> >   	while (it) {
> > @@ -219,6 +230,8 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> >   		amdgpu_mn_invalidate_node(node, start, end);
> >   	}
> > +
> > +	return 0;
> >   }
> >   /**
> > @@ -233,10 +246,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> >    * necessitates evicting all user-mode queues of the process. The BOs
> >    * are restorted in amdgpu_mn_invalidate_range_end_hsa.
> >    */
> > -static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> > +static int amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> >   						 struct mm_struct *mm,
> >   						 unsigned long start,
> > -						 unsigned long end)
> > +						 unsigned long end,
> > +						 bool blockable)
> >   {
> >   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
> >   	struct interval_tree_node *it;
> > @@ -244,7 +258,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> >   	/* notification is exclusive, but interval is inclusive */
> >   	end -= 1;
> > -	amdgpu_mn_read_lock(rmn);
> > +	if (amdgpu_mn_read_lock(rmn, blockable))
> > +		return -EAGAIN;
> >   	it = interval_tree_iter_first(&rmn->objects, start, end);
> >   	while (it) {
> > @@ -262,6 +277,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> >   				amdgpu_amdkfd_evict_userptr(mem, mm);
> >   		}
> >   	}
> > +
> > +	return 0;
> >   }
> >   /**
-- 
Michal Hocko
SUSE Labs
