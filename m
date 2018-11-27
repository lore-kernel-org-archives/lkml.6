Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90054C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516A920659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JNAjZG/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516A920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbeK1Ehw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:37:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40489 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbeK1Ehw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:37:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so19720304edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sqzm5xsTimMxJ268T1BBbr9FBv4mPMIcZWlKkUkTEVU=;
        b=JNAjZG/qd0O6CmxpXft8tIz4N1Dl2RRP9cEJtPsKog64XBB6IwatE81j+Bv3+TUw7R
         Tf/sQCD/fpop/ejzCWAidzMU7+oj7ve2y7ZntJ4JArhld/wg92blfgUnn4wHFa88B4Lc
         9gh7q5siYgK0Y9+kQ4DawLeEPKN84dxg5NGWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sqzm5xsTimMxJ268T1BBbr9FBv4mPMIcZWlKkUkTEVU=;
        b=Qch0UrwxOQP8lmHmEGjhLc7J3t1CCJ09JN2y3UPsqjp6a/llzOVp2pcDhVkdbQJYSh
         ru2TcwJnc7v2/EFp2jfd7jvRqsuITxLwkbxWRSjeXazgUHMqdntYitr+rP8+WE8CRQBy
         ljtj3qYgpagtlGIciMzd6N4+Grxd9pAbiJMG4PGIlae4QcAk5W/w2vnepukUuAVqKvkv
         kIGarkDHj5kxn5UWS8K+yDjteMaOtJpMN8v6BXipcQR10k7P96buCO32RTZv6N0986sK
         SarqlngxwwV0dwe6P+2OsDpMWEMEPe1gVTDFVxOo3DgqGJieeVzwFYuUgtBMuuxGZiVb
         y7zQ==
X-Gm-Message-State: AGRZ1gKPqN+JlED+q9XmMSduQvIlw+jb6ucr4A/T1M2LGEGnHZFheCLz
        Duh+eA1W+uP7TlFhqdY9jeI3yA==
X-Google-Smtp-Source: AJdET5cBJyQUwvJzIyWN1zK3Y83bEMcphR/j94kpvEihFsnQMmuAD/2rXWfVxtfQ/JGYRgJFi7i+WQ==
X-Received: by 2002:a17:906:2972:: with SMTP id x18-v6mr24746087ejd.28.1543340351858;
        Tue, 27 Nov 2018 09:39:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i24sm1088936edq.0.2018.11.27.09.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 09:39:10 -0800 (PST)
Date:   Tue, 27 Nov 2018 18:39:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [Intel-gfx] [PATCH 3/3] mm, notifier: Add a lockdep map for
 invalidate_range_start
Message-ID: <20181127173908.GC4266@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-4-daniel.vetter@ffwll.ch>
 <20181127074918.GT4266@phenom.ffwll.local>
 <154333737908.11623.17864230889834398136@skylake-alporthouse-com>
 <CAKMK7uGSP7wWHSRFsCv90qCyHiSBS+o9CK1BPUXbGj6Crcy_Cg@mail.gmail.com>
 <154334003817.11623.5449603736660799102@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154334003817.11623.5449603736660799102@skylake-alporthouse-com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:33:58PM +0000, Chris Wilson wrote:
> Quoting Daniel Vetter (2018-11-27 17:28:43)
> > On Tue, Nov 27, 2018 at 5:50 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > Quoting Daniel Vetter (2018-11-27 07:49:18)
> > > > On Thu, Nov 22, 2018 at 05:51:06PM +0100, Daniel Vetter wrote:
> > > > > This is a similar idea to the fs_reclaim fake lockdep lock. It's
> > > > > fairly easy to provoke a specific notifier to be run on a specific
> > > > > range: Just prep it, and then munmap() it.
> > > > >
> > > > > A bit harder, but still doable, is to provoke the mmu notifiers for
> > > > > all the various callchains that might lead to them. But both at the
> > > > > same time is really hard to reliable hit, especially when you want to
> > > > > exercise paths like direct reclaim or compaction, where it's not
> > > > > easy to control what exactly will be unmapped.
> > > > >
> > > > > By introducing a lockdep map to tie them all together we allow lockdep
> > > > > to see a lot more dependencies, without having to actually hit them
> > > > > in a single challchain while testing.
> > > > >
> > > > > Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> > > > > this out for the invaliate_range_start callback. If there's
> > > > > interest, we should probably roll this out to all of them. But my
> > > > > undestanding of core mm is seriously lacking, and I'm not clear on
> > > > > whether we need a lockdep map for each callback, or whether some can
> > > > > be shared.
> > > > >
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: David Rientjes <rientjes@google.com>
> > > > > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > > Cc: "Christian König" <christian.koenig@amd.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > > > Cc: linux-mm@kvack.org
> > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > >
> > > > Any comments on this one here? This is really the main ingredient for
> > > > catching deadlocks in mmu notifier callbacks. The other two patches are
> > > > more the icing on the cake.
> > > >
> > > > Thanks, Daniel
> > > >
> > > > > ---
> > > > >  include/linux/mmu_notifier.h | 7 +++++++
> > > > >  mm/mmu_notifier.c            | 7 +++++++
> > > > >  2 files changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > > > > index 9893a6432adf..a39ba218dbbe 100644
> > > > > --- a/include/linux/mmu_notifier.h
> > > > > +++ b/include/linux/mmu_notifier.h
> > > > > @@ -12,6 +12,10 @@ struct mmu_notifier_ops;
> > > > >
> > > > >  #ifdef CONFIG_MMU_NOTIFIER
> > > > >
> > > > > +#ifdef CONFIG_LOCKDEP
> > > > > +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> > > > > +#endif
> > > > > +
> > > > >  /*
> > > > >   * The mmu notifier_mm structure is allocated and installed in
> > > > >   * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> > > > > @@ -267,8 +271,11 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
> > > > >  static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> > > > >                                 unsigned long start, unsigned long end)
> > > > >  {
> > > > > +     mutex_acquire(&__mmu_notifier_invalidate_range_start_map, 0, 0,
> > > > > +                   _RET_IP_);
> > >
> > > Would not lock_acquire_shared() be more appropriate, i.e. treat this as
> > > a rwsem_acquire_read()?
> > 
> > read lock critical sections can't create any dependencies against any
> > other read lock critical section of the same lock. Switching this to a
> > read lock would just render the annotation pointless (if you don't
> > include at least some write lock critical section somewhere, but I
> > have no idea where you'd do that). A read lock that you only ever take
> > for reading essentially doesn't do anything at all.
> > 
> > So not clear on why you're suggesting this?
> 
> Just that it's not acting as a mutex, so emulating one looks wrong.

Ok, I think switching to lock_map_acquire/release should address that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
