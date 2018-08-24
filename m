Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262BF208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262BF208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHXP0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:26:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbeHXP0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F021B049;
        Fri, 24 Aug 2018 11:52:28 +0000 (UTC)
Date:   Fri, 24 Aug 2018 13:52:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     christian.koenig@amd.com
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180824115226.GK29735@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 13:43:16, Christian König wrote:
> Am 24.08.2018 um 13:32 schrieb Michal Hocko:
> > On Fri 24-08-18 19:54:19, Tetsuo Handa wrote:
> > > Two more worries for this patch.
> > > 
> > > 
> > > 
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > > > @@ -178,12 +178,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
> > > >    *
> > > >    * @amn: our notifier
> > > >    */
> > > > -static void amdgpu_mn_read_lock(struct amdgpu_mn *amn)
> > > > +static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
> > > >   {
> > > > -       mutex_lock(&amn->read_lock);
> > > > +       if (blockable)
> > > > +               mutex_lock(&amn->read_lock);
> > > > +       else if (!mutex_trylock(&amn->read_lock))
> > > > +               return -EAGAIN;
> > > > +
> > > >          if (atomic_inc_return(&amn->recursion) == 1)
> > > >                  down_read_non_owner(&amn->lock);
> > > Why don't we need to use trylock here if blockable == false ?
> > > Want comment why it is safe to use blocking lock here.
> > Hmm, I am pretty sure I have checked the code but it was quite confusing
> > so I might have missed something. Double checking now, it seems that
> > this read_lock is not used anywhere else and it is not _the_ lock we are
> > interested about. It is the amn->lock (amdgpu_mn_lock) which matters as
> > it is taken in exclusive mode for expensive operations.
> 
> The write side of the lock is only taken in the command submission IOCTL.
> 
> So you actually don't need to change anything here (even the proposed
> changes are overkill) since we can't tear down the struct_mm while an IOCTL
> is still using.

I am not so sure. We are not in the mm destruction phase yet. This is
mostly about the oom context which might fire right during the IOCTL. If
any of the path which is holding the write lock blocks for unbound
amount of time or even worse allocates a memory then we are screwed. So
we need to back of when blockable = false.

> > Is that correct Christian? If this is correct then we need to update the
> > locking here. I am struggling to grasp the ref counting part. Why cannot
> > all readers simply take the lock rather than rely on somebody else to
> > take it? 1ed3d2567c800 didn't really help me to understand the locking
> > scheme here so any help would be appreciated.
> 
> That won't work like this there might be multiple
> invalidate_range_start()/invalidate_range_end() pairs open at the same time.
> E.g. the lock might be taken recursively and that is illegal for a
> rw_semaphore.

I am not sure I follow. Are you saying that one invalidate_range might
trigger another one from the same path?
-- 
Michal Hocko
SUSE Labs
