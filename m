Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BE21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5BE21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHXQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:08:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:43432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbeHXQIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:08:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E9D2ADEF;
        Fri, 24 Aug 2018 12:33:43 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:33:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Cc:     kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
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
Message-ID: <20180824123341.GN29735@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 14:18:44, Christian König wrote:
> Am 24.08.2018 um 14:03 schrieb Michal Hocko:
> > On Fri 24-08-18 13:57:52, Christian König wrote:
> > > Am 24.08.2018 um 13:52 schrieb Michal Hocko:
> > > > On Fri 24-08-18 13:43:16, Christian König wrote:
> > [...]
> > > > > That won't work like this there might be multiple
> > > > > invalidate_range_start()/invalidate_range_end() pairs open at the same time.
> > > > > E.g. the lock might be taken recursively and that is illegal for a
> > > > > rw_semaphore.
> > > > I am not sure I follow. Are you saying that one invalidate_range might
> > > > trigger another one from the same path?
> > > No, but what can happen is:
> > > 
> > > invalidate_range_start(A,B);
> > > invalidate_range_start(C,D);
> > > ...
> > > invalidate_range_end(C,D);
> > > invalidate_range_end(A,B);
> > > 
> > > Grabbing the read lock twice would be illegal in this case.
> > I am sorry but I still do not follow. What is the context the two are
> > called from?
> 
> I don't have the slightest idea.
> 
> > Can you give me an example. I simply do not see it in the
> > code, mostly because I am not familiar with it.
> 
> I'm neither.
> 
> We stumbled over that by pure observation and after discussing the problem
> with Jerome came up with this solution.
> 
> No idea where exactly that case comes from, but I can confirm that it indeed
> happens.

Thiking about it some more, I can imagine that a notifier callback which
performs an allocation might trigger a memory reclaim and that in turn
might trigger a notifier to be invoked and recurse. But notifier
shouldn't really allocate memory. They are called from deep MM code
paths and this would be extremely deadlock prone. Maybe Jerome can come
up some more realistic scenario. If not then I would propose to simplify
the locking here. We have lockdep to catch self deadlocks and it is
always better to handle a specific issue rather than having a code
without a clear indication how it can recurse.
-- 
Michal Hocko
SUSE Labs
