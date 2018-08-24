Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA4B2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA4B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeHXRGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:06:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeHXRGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:06:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07764AF3C;
        Fri, 24 Aug 2018 13:32:10 +0000 (UTC)
Date:   Fri, 24 Aug 2018 15:32:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180824133207.GR29735@dhcp22.suse.cz>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113629.GI29735@dhcp22.suse.cz>
 <103b1b33-1a1d-27a1-dcf8-5c8ad60056a6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103b1b33-1a1d-27a1-dcf8-5c8ad60056a6@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-08-18 22:02:23, Tetsuo Handa wrote:
> On 2018/08/24 20:36, Michal Hocko wrote:
> >> That is, this API seems to be currently used by only out-of-tree users. Since
> >> we can't check that nobody has memory allocation dependency, I think that
> >> hmm_invalidate_range_start() should return -EAGAIN if blockable == false for now.
> > 
> > The code expects that the invalidate_range_end doesn't block if
> > invalidate_range_start hasn't blocked. That is the reason why the end
> > callback doesn't have blockable parameter. If this doesn't hold then the
> > whole scheme is just fragile because those two calls should pair.
> > 
> That is
> 
>   More worrisome part in that patch is that I don't know whether using
>   trylock if blockable == false at entry is really sufficient.
> 
> . Since those two calls should pair, I think that we need to determine whether
> we need to return -EAGAIN at start call by evaluating both calls.

Yes, and I believe I have done that audit. Module my misunderstanding of
the code.

> Like mn_invl_range_start() involves schedule_delayed_work() which could be
> blocked on memory allocation under OOM situation,

It doesn't because that code path is not invoked for the !blockable
case.

> I worry that (currently
> out-of-tree) users of this API are involving work / recursion.

I do not give a slightest about out-of-tree modules. They will have to
accomodate to the new API. I have no problems to extend the
documentation and be explicit about this expectation.
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 133ba78820ee..698e371aafe3 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -153,7 +153,9 @@ struct mmu_notifier_ops {
 	 *
 	 * If blockable argument is set to false then the callback cannot
 	 * sleep and has to return with -EAGAIN. 0 should be returned
-	 * otherwise.
+	 * otherwise. Please note that if invalidate_range_start approves
+	 * a non-blocking behavior then the same applies to
+	 * invalidate_range_end.
 	 *
 	 */
 	int (*invalidate_range_start)(struct mmu_notifier *mn,


> And hmm_release() says that
> 
> 	/*
> 	 * Drop mirrors_sem so callback can wait on any pending
> 	 * work that might itself trigger mmu_notifier callback
> 	 * and thus would deadlock with us.
> 	 */
> 
> and keeps "all operations protected by hmm->mirrors_sem held for write are
> atomic". This suggests that "some operations protected by hmm->mirrors_sem held
> for read will sleep (and in the worst case involves memory allocation
> dependency)".

Yes and so what? The clear expectation is that neither of the range
notifiers do not sleep in !blocking mode. I really fail to see what you
are trying to say.

-- 
Michal Hocko
SUSE Labs
