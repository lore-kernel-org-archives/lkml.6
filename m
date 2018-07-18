Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F22ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04020856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdKzAwGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A04020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGRVCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:02:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33650 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbeGRVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:02:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so2541090plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f5qdJwLTCi+4ek9OB51GMsKHPcAJziGy2JSdaeClDCQ=;
        b=JdKzAwGrzJ4ESdnayxI9UYxAEIphlSbcf1p03nKSf6M/bDF5IbmRIQ/67qUGx18AmM
         RfUkJPHxK6eUqeEKjMQX/xV6bKDVVW1yUwvoWcjgbTKv4QOg2V+M6TSDQCh0D64/QYPB
         6KEnus7QJWY447jWKbdC1QmK5xEQIgZrob2opkAMhWl4bImL9ExNw8caBlcKzzLnw3fL
         0dToQxrBpCDLjy69ykZCRbZxr2Ub52SUIh92OYT26L3IxvWh5wg+zFmpkaVyzA5Q1/AG
         UZWWwnfnnOcrF61NgLBCZ+WaLQcHBhMQLHmSUvOzQXk9BxDdSzY5IAqS+weAW57/oqZ8
         lgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f5qdJwLTCi+4ek9OB51GMsKHPcAJziGy2JSdaeClDCQ=;
        b=pg1C91vOjyW/BOzVzDh+EPEAn/uWvDanvThlxctlgH9ii8xQqEGGl3XD1rLhuNKn/m
         geVx0FhuYxfBo54/Ok0n1Nu7iar/1zbKDz5fsFzfw7GhWFdH3ArXcDdXPaVC+U+flQpf
         ao++Cl4BH/1LN98QgHwOtbC2u5u05uW6b26KB3soXvNW56jZF3MOyNxW94+m23OLXKLz
         AwByfQMgrIep8ICXRuA+hRbrhz5FWGOshqI0pT3gxvKnt99JWOQNAcd538iawXSMq0eS
         Hp9cD/jJ/W7k2T95+vE7Mu6D1zTHit4olkYgHd2aamCgD0RAgNQgGu6q1Me3tTlb0dwo
         zLiw==
X-Gm-Message-State: AOUpUlH3rpVYY3KMVtNO3tYfb6HSZ8MaaOQrULws+V83gritx9JUKXEx
        I4jx+XCx93W8eIpeSdRwdX4mlg==
X-Google-Smtp-Source: AAOMgpckIQ37agrGY5fKErXibYU8pgcwbADIP9D+UucSc8tu8BplPcWodprQkjt5bU5Cf6a1rbI1SA==
X-Received: by 2002:a17:902:9345:: with SMTP id g5-v6mr7322530plp.10.1531945365616;
        Wed, 18 Jul 2018 13:22:45 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t63-v6sm6363051pgt.57.2018.07.18.13.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 13:22:44 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:22:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Tetsuo Handa wrote:

> > diff --git a/mm/mmap.c b/mm/mmap.c
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3059,25 +3059,28 @@ void exit_mmap(struct mm_struct *mm)
> >  	if (unlikely(mm_is_oom_victim(mm))) {
> >  		/*
> >  		 * Manually reap the mm to free as much memory as possible.
> > -		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > -		 * this mm from further consideration.  Taking mm->mmap_sem for
> > -		 * write after setting MMF_OOM_SKIP will guarantee that the oom
> > -		 * reaper will not run on this mm again after mmap_sem is
> > -		 * dropped.
> > -		 *
> >  		 * Nothing can be holding mm->mmap_sem here and the above call
> >  		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> >  		 * __oom_reap_task_mm() will not block.
> > -		 *
> > -		 * This needs to be done before calling munlock_vma_pages_all(),
> > -		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> > -		 * reliably test it.
> >  		 */
> >  		mutex_lock(&oom_lock);
> >  		__oom_reap_task_mm(mm);
> >  		mutex_unlock(&oom_lock);
> >  
> > -		set_bit(MMF_OOM_SKIP, &mm->flags);
> > +		/*
> > +		 * Now, set MMF_UNSTABLE to avoid racing with the oom reaper.
> > +		 * This needs to be done before calling munlock_vma_pages_all(),
> > +		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> > +		 * reliably test for it.  If the oom reaper races with
> > +		 * munlock_vma_pages_all(), this can result in a kernel oops if
> > +		 * a pmd is zapped, for example, after follow_page_mask() has
> > +		 * checked pmd_none().
> > +		 *
> > +		 * Taking mm->mmap_sem for write after setting MMF_UNSTABLE will
> > +		 * guarantee that the oom reaper will not run on this mm again
> > +		 * after mmap_sem is dropped.
> > +		 */
> > +		set_bit(MMF_UNSTABLE, &mm->flags);
> 
> Since MMF_UNSTABLE is set by __oom_reap_task_mm() from exit_mmap() before start reaping
> (because the purpose of MMF_UNSTABLE is to "tell all users of get_user/copy_from_user
> etc... that the content is no longer stable"), it cannot be used for a flag for indicating
> that the OOM reaper can't work on the mm anymore.
> 

Why?  It should be able to be set by exit_mmap() since nothing else should 
be accessing this mm in the first place.  There is no reason to wait for 
the oom reaper and the following down_write();up_write(); cycle will 
guarantee it is not operating on the mm before munlocking.

> If the oom_lock serialization is removed, the OOM reaper will give up after (by default)
> 1 second even if current thread is immediately after set_bit(MMF_UNSTABLE, &mm->flags) from
> __oom_reap_task_mm() from exit_mmap(). Thus, this patch and the other patch which removes
> oom_lock serialization should be dropped.
> 

No, it shouldn't, lol.  The oom reaper may give up because we have entered 
__oom_reap_task_mm() by way of exit_mmap(), there's no other purpose for 
it acting on the mm.  This is very different from giving up by setting 
MMF_OOM_SKIP, which it will wait for oom_free_timeout_ms to do unless the 
thread can make forward progress here in exit_mmap().

> >  		down_write(&mm->mmap_sem);
> >  		up_write(&mm->mmap_sem);
> >  	}
> 
> > @@ -637,25 +649,57 @@ static int oom_reaper(void *unused)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Millisecs to wait for an oom mm to free memory before selecting another
> > + * victim.
> > + */
> > +static u64 oom_free_timeout_ms = 1000;
> >  static void wake_oom_reaper(struct task_struct *tsk)
> >  {
> > -	/* tsk is already queued? */
> > -	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
> > +	/*
> > +	 * Set the reap timeout; if it's already set, the mm is enqueued and
> > +	 * this tsk can be ignored.
> > +	 */
> > +	if (cmpxchg(&tsk->signal->oom_mm->oom_free_expire, 0UL,
> > +			jiffies + msecs_to_jiffies(oom_free_timeout_ms)))
> >  		return;
> 
> "expire" must not be 0 in order to avoid double list_add(). See
> https://lore.kernel.org/lkml/201807130620.w6D6KiAJ093010@www262.sakura.ne.jp/T/#u .
> 

We should not allow oom_free_timeout_ms to be 0 for sure, I assume 1000 is 
the sane minimum since we need to allow time for some memory freeing and 
this will not be radically different from what existed before the patch 
for the various backoffs.  Or maybe you meant something else for "expire" 
here?
