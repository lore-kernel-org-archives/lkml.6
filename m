Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D86020685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HKMS0QbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D86020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409810AbeKWXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:22:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33518 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405500AbeKWXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:22:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id r27so10183279eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UNrljjau3KO0/J7Hyd5EnSwFQOS33GEQC70JOxYWgn4=;
        b=HKMS0QbVhrA1oRzV5xjSPLNy+N4GA3qqLhZFzaBnVllgawmGriGL0gLfLYlB9Ledzs
         pFcGX9Pt0PDVW7xlDVyerS3jfS8vMDOohODd16ULhYOEbyAYoufjZHjlY2DnYDLHyk3Q
         29v1py9R4FmsAttDG9f32+oTz7KicNeG2Urd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UNrljjau3KO0/J7Hyd5EnSwFQOS33GEQC70JOxYWgn4=;
        b=qTkRKMzJvEhxHyhrxxBbesqutujPogLi5F7waTW1LIO0IjFgDTsPb2rbE5tTMzD25e
         FcyZDmH1wtUfS8gkmhNiw+t47W+VI8BwGFaoOjk+twE5FMpue6ToMX9N4etggPUKrszc
         iIa0AEJPBh6KvIxI6hghcnSztNfAebe0x6B0SwyM7dzoBEyGG0iFcz13hSE8p/KVDEui
         U1shodJx1RuRuBEnj4OAT8mi8iBrWdxm+uYnkl3gli3L1dkAQsAYbUnxBoKH+lrYVhBI
         r3pMZscGicImLHgaejnaMCqx4w2O2RS/dAo8mgSRT3s1vWSjKQxi1KG++eFgGxiPgUHD
         y2tQ==
X-Gm-Message-State: AA+aEWaTEts1g3luf4m1r778tvxAA6I98JgYUhrQUxudXmXqWW6Mc0jj
        yjfPmr5ls74Fhge40RomlCJ16g==
X-Google-Smtp-Source: AFSGD/UC/RJKwIoJtaSgylPEL6U0S//auiaTaq5/AXEzOrGK6y4NMUeCYGS9+2mdc/zPi4I8kRPATA==
X-Received: by 2002:a50:9849:: with SMTP id h9mr12393010edb.36.1542976721480;
        Fri, 23 Nov 2018 04:38:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p36sm5313409edc.78.2018.11.23.04.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:38:40 -0800 (PST)
Date:   Fri, 23 Nov 2018 13:38:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20181123123838.GL4266@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
 <20181123111237.GE8625@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123111237.GE8625@dhcp22.suse.cz>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:12:37PM +0100, Michal Hocko wrote:
> On Thu 22-11-18 17:51:05, Daniel Vetter wrote:
> > We need to make sure implementations don't cheat and don't have a
> > possible schedule/blocking point deeply burried where review can't
> > catch it.
> > 
> > I'm not sure whether this is the best way to make sure all the
> > might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> > But it gets the job done.
> 
> Yeah, it is quite ugly. Especially because it makes DEBUG config
> bahavior much different. So is this really worth it? Has this already
> discovered any existing bug?

Given that we need an oom trigger to hit this we're not hitting this in CI
(oom is just way to unpredictable to even try). I'd kinda like to also add
some debug interface so I can provoke an oom kill of a specially prepared
process, to make sure we can reliably exercise this path without killing
the kernel accidentally. We do similar tricks for our shrinker already.

There's been patches floating with this kind of bug I think, and the call
chains we're dealing with a fairly deep. I don't trust review to reliably
catch this kind of fail, that's why I'm looking into tools to better
validat this stuff to augment review.

And yes it's ugly :-/

Wrt the behavior difference: I guess we could put another counter into the
task struct, and change might_sleep() to check it. All under
CONFIG_DEBUG_ATOMIC_SLEEP only ofc. That would avoid the preempt-disable
sideeffect. My worry with that is that people will spot it, and abuse it
in creative ways that do affect semantics. See horrors like
drm_can_sleep() (and I'm sure gfx folks are not the only ones who
seriously lacked taste here).

Up to the experts really how to best paint this shed I think.

Thanks, Daniel

> 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  mm/mmu_notifier.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index 59e102589a25..4d282cfb296e 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -185,7 +185,13 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> >  	id = srcu_read_lock(&srcu);
> >  	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
> >  		if (mn->ops->invalidate_range_start) {
> > -			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> > +			int _ret;
> > +
> > +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
> > +				preempt_disable();
> > +			_ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> > +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
> > +				preempt_enable();
> >  			if (_ret) {
> >  				pr_info("%pS callback failed with %d in %sblockable context.\n",
> >  						mn->ops->invalidate_range_start, _ret,
> > -- 
> > 2.19.1
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
