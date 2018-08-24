Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CDB21581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CDB21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHXPKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:10:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbeHXPKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:10:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 656F3AC89;
        Fri, 24 Aug 2018 11:36:30 +0000 (UTC)
Date:   Fri, 24 Aug 2018 13:36:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
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
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180824113629.GI29735@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 19:54:19, Tetsuo Handa wrote:
[...]
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -177,16 +177,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >         up_write(&hmm->mirrors_sem);
> >  }
> > 
> > -static void hmm_invalidate_range_start(struct mmu_notifier *mn,
> > +static int hmm_invalidate_range_start(struct mmu_notifier *mn,
> >                                        struct mm_struct *mm,
> >                                        unsigned long start,
> > -                                      unsigned long end)
> > +                                      unsigned long end,
> > +                                      bool blockable)
> >  {
> >         struct hmm *hmm = mm->hmm;
> > 
> >         VM_BUG_ON(!hmm);
> > 
> >         atomic_inc(&hmm->sequence);
> > +
> > +       return 0;
> >  }
> > 
> >  static void hmm_invalidate_range_end(struct mmu_notifier *mn,
> 
> This assumes that hmm_invalidate_range_end() does not have memory
> allocation dependency. But hmm_invalidate_range() from
> hmm_invalidate_range_end() involves
> 
>         down_read(&hmm->mirrors_sem);
>         list_for_each_entry(mirror, &hmm->mirrors, list)
>                 mirror->ops->sync_cpu_device_pagetables(mirror, action,
>                                                         start, end);
>         up_read(&hmm->mirrors_sem);
> 
> sequence. What is surprising is that there is no in-tree user who assigns
> sync_cpu_device_pagetables field.

Yes HMM doesn't have any in tree user yet.

>   $ grep -Fr sync_cpu_device_pagetables *
>   Documentation/vm/hmm.rst:     /* sync_cpu_device_pagetables() - synchronize page tables
>   include/linux/hmm.h: * will get callbacks through sync_cpu_device_pagetables() operation (see
>   include/linux/hmm.h:    /* sync_cpu_device_pagetables() - synchronize page tables
>   include/linux/hmm.h:    void (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
>   include/linux/hmm.h: * hmm_mirror_ops.sync_cpu_device_pagetables() callback, so that CPU page
>   mm/hmm.c:               mirror->ops->sync_cpu_device_pagetables(mirror, action,
> 
> That is, this API seems to be currently used by only out-of-tree users. Since
> we can't check that nobody has memory allocation dependency, I think that
> hmm_invalidate_range_start() should return -EAGAIN if blockable == false for now.

The code expects that the invalidate_range_end doesn't block if
invalidate_range_start hasn't blocked. That is the reason why the end
callback doesn't have blockable parameter. If this doesn't hold then the
whole scheme is just fragile because those two calls should pair.

-- 
Michal Hocko
SUSE Labs
