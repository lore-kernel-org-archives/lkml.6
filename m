Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFDD21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFDD21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHXSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:44:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbeHXSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C39887DAC9;
        Fri, 24 Aug 2018 15:09:02 +0000 (UTC)
Received: from redhat.com (ovpn-125-224.rdu2.redhat.com [10.10.125.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9863510073B5;
        Fri, 24 Aug 2018 15:09:00 +0000 (UTC)
Date:   Fri, 24 Aug 2018 11:08:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <20180824150858.GB4244@redhat.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824123341.GN29735@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 24 Aug 2018 15:09:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 24 Aug 2018 15:09:03 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:33:41PM +0200, Michal Hocko wrote:
> On Fri 24-08-18 14:18:44, Christian König wrote:
> > Am 24.08.2018 um 14:03 schrieb Michal Hocko:
> > > On Fri 24-08-18 13:57:52, Christian König wrote:
> > > > Am 24.08.2018 um 13:52 schrieb Michal Hocko:
> > > > > On Fri 24-08-18 13:43:16, Christian König wrote:
> > > [...]
> > > > > > That won't work like this there might be multiple
> > > > > > invalidate_range_start()/invalidate_range_end() pairs open at the same time.
> > > > > > E.g. the lock might be taken recursively and that is illegal for a
> > > > > > rw_semaphore.
> > > > > I am not sure I follow. Are you saying that one invalidate_range might
> > > > > trigger another one from the same path?
> > > > No, but what can happen is:
> > > > 
> > > > invalidate_range_start(A,B);
> > > > invalidate_range_start(C,D);
> > > > ...
> > > > invalidate_range_end(C,D);
> > > > invalidate_range_end(A,B);
> > > > 
> > > > Grabbing the read lock twice would be illegal in this case.
> > > I am sorry but I still do not follow. What is the context the two are
> > > called from?
> > 
> > I don't have the slightest idea.
> > 
> > > Can you give me an example. I simply do not see it in the
> > > code, mostly because I am not familiar with it.
> > 
> > I'm neither.
> > 
> > We stumbled over that by pure observation and after discussing the problem
> > with Jerome came up with this solution.
> > 
> > No idea where exactly that case comes from, but I can confirm that it indeed
> > happens.
> 
> Thiking about it some more, I can imagine that a notifier callback which
> performs an allocation might trigger a memory reclaim and that in turn
> might trigger a notifier to be invoked and recurse. But notifier
> shouldn't really allocate memory. They are called from deep MM code
> paths and this would be extremely deadlock prone. Maybe Jerome can come
> up some more realistic scenario. If not then I would propose to simplify
> the locking here. We have lockdep to catch self deadlocks and it is
> always better to handle a specific issue rather than having a code
> without a clear indication how it can recurse.

Multiple concurrent mmu notifier, for overlapping range or not, is
common (each concurrent threads can trigger some). So you might have
multiple invalidate_range_start() in flight for same mm and thus might
complete in different order (invalidate_range_end()). IIRC this is
what this lock was trying to protect against.

I can't think of a reason for recursive mmu notifier call right now.
I will ponder see if i remember something about it.

Cheers,
Jérôme
