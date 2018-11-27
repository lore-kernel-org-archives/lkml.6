Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B10C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77682133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="At9BTUEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77682133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeK0SqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:46:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42697 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeK0SqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:46:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so18135579edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=K+hwhRQbtFrWQFqTn6T/jv0euH/QggHE+ezb2jMjYFc=;
        b=At9BTUEjadwzyCCyanuIMRFlACbBAhsjdMoBi0BRWFldJ8s9oG72GA/hd1kn4Y3t1i
         W6D0I5v8tppgJFPeG2CLIEmUerbJCK65vRRoxUUaQr7xShSbTUgljd7oBxJKAduDdv4T
         OCEvLz2mXFpdrU7kittFK8imkjHDsdt95hTJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=K+hwhRQbtFrWQFqTn6T/jv0euH/QggHE+ezb2jMjYFc=;
        b=Y+dCaHoZc+2DWRUkdnmO/TiEXvSfJJDUEP7gOzuz0T+oWhTFyU4zh6xu3BuEobhd+I
         /G9lUQ7l49XfG9+UVqL4jM/DS07E1xn3dhMlLeRcvZ9BeE3FV3gJA4USDW1PRpdDy9QM
         sdauKaADgCpx6GWTDQ6VEy7xTWKlTmEqESbJT4NhLj0fJJq9xlXbwpemgwzWAkfJH36M
         CWD+2gjs3k4C6uj7PwoB/10kLwxzQJi3HUDjXq6F/HWQq0BeWMa67Frfl179whFrgmvx
         OHaup2NR1Q6pnWh1fzHiLGrdpPWf4PFViDWAJvfa8t4iydbP0pJFUHDfOY9+uAX/OzxY
         hdgg==
X-Gm-Message-State: AA+aEWYYXAa4HsFpEyeTWTLyqoJGDfankjHJC44MGdZevIaiPLyBTpmn
        IKRW11SN/GcFtZMeXtgqcVOxlK0uyg8=
X-Google-Smtp-Source: AFSGD/XELXjK0MTveap/0aR2UQIiFpy6Kkfh52rXBjsvetIGaSe5Ry12HYU08ofiGI/0UYxI4SJRmA==
X-Received: by 2002:a50:f415:: with SMTP id r21mr8338320edm.110.1543304961991;
        Mon, 26 Nov 2018 23:49:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i46sm784960ede.62.2018.11.26.23.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 23:49:20 -0800 (PST)
Date:   Tue, 27 Nov 2018 08:49:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/3] mm, notifier: Add a lockdep map for
 invalidate_range_start
Message-ID: <20181127074918.GT4266@phenom.ffwll.local>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181122165106.18238-4-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 05:51:06PM +0100, Daniel Vetter wrote:
> This is a similar idea to the fs_reclaim fake lockdep lock. It's
> fairly easy to provoke a specific notifier to be run on a specific
> range: Just prep it, and then munmap() it.
> 
> A bit harder, but still doable, is to provoke the mmu notifiers for
> all the various callchains that might lead to them. But both at the
> same time is really hard to reliable hit, especially when you want to
> exercise paths like direct reclaim or compaction, where it's not
> easy to control what exactly will be unmapped.
> 
> By introducing a lockdep map to tie them all together we allow lockdep
> to see a lot more dependencies, without having to actually hit them
> in a single challchain while testing.
> 
> Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> this out for the invaliate_range_start callback. If there's
> interest, we should probably roll this out to all of them. But my
> undestanding of core mm is seriously lacking, and I'm not clear on
> whether we need a lockdep map for each callback, or whether some can
> be shared.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Any comments on this one here? This is really the main ingredient for
catching deadlocks in mmu notifier callbacks. The other two patches are
more the icing on the cake.

Thanks, Daniel

> ---
>  include/linux/mmu_notifier.h | 7 +++++++
>  mm/mmu_notifier.c            | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 9893a6432adf..a39ba218dbbe 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -12,6 +12,10 @@ struct mmu_notifier_ops;
>  
>  #ifdef CONFIG_MMU_NOTIFIER
>  
> +#ifdef CONFIG_LOCKDEP
> +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> +#endif
> +
>  /*
>   * The mmu notifier_mm structure is allocated and installed in
>   * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> @@ -267,8 +271,11 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
>  static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>  				  unsigned long start, unsigned long end)
>  {
> +	mutex_acquire(&__mmu_notifier_invalidate_range_start_map, 0, 0,
> +		      _RET_IP_);
>  	if (mm_has_notifiers(mm))
>  		__mmu_notifier_invalidate_range_start(mm, start, end, true);
> +	mutex_release(&__mmu_notifier_invalidate_range_start_map, 1, _RET_IP_);
>  }
>  
>  static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 4d282cfb296e..c6e797927376 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -23,6 +23,13 @@
>  /* global SRCU for all MMs */
>  DEFINE_STATIC_SRCU(srcu);
>  
> +#ifdef CONFIG_LOCKDEP
> +struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
> +	.name = "mmu_notifier_invalidate_range_start"
> +};
> +EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start_map);
> +#endif
> +
>  /*
>   * This function allows mmu_notifier::release callback to delay a call to
>   * a function that will free appropriate resources. The function must be
> -- 
> 2.19.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
