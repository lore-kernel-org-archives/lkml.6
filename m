Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C293CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6242159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6242159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHXPHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbeHXPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CE0BB03B;
        Fri, 24 Aug 2018 11:32:50 +0000 (UTC)
Date:   Fri, 24 Aug 2018 13:32:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        David Rientjes <rientjes@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180824113248.GH29735@dhcp22.suse.cz>
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
> Two more worries for this patch.
> 
> 
> 
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > @@ -178,12 +178,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
> >   *
> >   * @amn: our notifier
> >   */
> > -static void amdgpu_mn_read_lock(struct amdgpu_mn *amn)
> > +static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
> >  {
> > -       mutex_lock(&amn->read_lock);
> > +       if (blockable)
> > +               mutex_lock(&amn->read_lock);
> > +       else if (!mutex_trylock(&amn->read_lock))
> > +               return -EAGAIN;
> > +
> >         if (atomic_inc_return(&amn->recursion) == 1)
> >                 down_read_non_owner(&amn->lock);
> 
> Why don't we need to use trylock here if blockable == false ?
> Want comment why it is safe to use blocking lock here.

Hmm, I am pretty sure I have checked the code but it was quite confusing
so I might have missed something. Double checking now, it seems that
this read_lock is not used anywhere else and it is not _the_ lock we are
interested about. It is the amn->lock (amdgpu_mn_lock) which matters as
it is taken in exclusive mode for expensive operations.

Is that correct Christian? If this is correct then we need to update the
locking here. I am struggling to grasp the ref counting part. Why cannot
all readers simply take the lock rather than rely on somebody else to
take it? 1ed3d2567c800 didn't really help me to understand the locking
scheme here so any help would be appreciated.

I am wondering why we cannot do
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index e55508b39496..93034178673d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -180,14 +180,11 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
  */
 static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
 {
-	if (blockable)
-		mutex_lock(&amn->read_lock);
-	else if (!mutex_trylock(&amn->read_lock))
-		return -EAGAIN;
-
-	if (atomic_inc_return(&amn->recursion) == 1)
-		down_read_non_owner(&amn->lock);
-	mutex_unlock(&amn->read_lock);
+	if (!down_read_trylock(&amn->lock)) {
+		if (!blockable)
+			return -EAGAIN;
+		down_read(amn->lock);
+	}
 
 	return 0;
 }
@@ -199,8 +196,7 @@ static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
  */
 static void amdgpu_mn_read_unlock(struct amdgpu_mn *amn)
 {
-	if (atomic_dec_return(&amn->recursion) == 0)
-		up_read_non_owner(&amn->lock);
+	up_read(&amn->lock);
 }
 
 /**

-- 
Michal Hocko
SUSE Labs
