Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F1C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5839A21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545407632;
	bh=cVDMhmSl+kIYJ4WM6suphplwoGhjn9u2xJm8q7BeoV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KcxOrAZ0JJIz6tJijwiM6VFdJpyPpNpFl1nUN1kpkH66f8EQIdlJpRnCH4l8AukIh
	 M084LVBrXJTtnOIPuoyUCM21aOZ4ANr2Gub24+UX4q/QHlg3upyJSH3BMZFBUhSEdV
	 Cw0uFE4Q6eUYdi+iu6spEQEihejgBkGOt9dYiCKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbeLUPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:53:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:37060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeLUPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:53:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F244EACA2;
        Fri, 21 Dec 2018 15:53:48 +0000 (UTC)
Date:   Fri, 21 Dec 2018 16:53:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Arun KS <arunks@codeaurora.org>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: vmalloc: do not allow kzalloc to fail
Message-ID: <20181221155347.GF6410@dhcp22.suse.cz>
References: <1545337437-673-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545337437-673-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 21:23:57, Nicholas Mc Guire wrote:
> While this is in a very early stage of the system boot and if memory
> were exhausted the system has a more serious problem anyway - but still
> the kzalloc here seems unsafe. Looking at the history it was previously
> switched from alloc_bootmem() to kzalloc() using GFP_NOWAIT flag but
> there never seems to have been a check for NULL return. So if this is
> expected to never fail should it not be using | __GFP_NOFAIL here ?
> Or put differently - what is the rational for GFP_NOWAIT to be safe here ?

Is there an actual problem you are trying to solve? GFP_NOWAIT|
__GFP_NOFAIL is a terrible idea. If this is an early allocation then
what would break this allocation out of the loop? There is nothing to
reclaim, there is nothing to kill. The allocation failure check would be
nice but what can you do except for BUG_ON?

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes 43ebdac42f16 ("vmalloc: use kzalloc() instead of alloc_bootmem()")

So no, this is definitely not the right thing to do.
Nacked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> Problem was found by an experimental coccinelle script
> 
> Patch was only compile tested for x86_64_defconfig
> 
> Patch is against v4.20-rc7 (localversion-next next-20181220)
> 
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 871e41c..1c118d7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1258,7 +1258,7 @@ void __init vmalloc_init(void)
>  
>  	/* Import existing vmlist entries. */
>  	for (tmp = vmlist; tmp; tmp = tmp->next) {
> -		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
> +		va = kzalloc(sizeof(*va), GFP_NOWAIT | __GFP_NOFAIL);
>  		va->flags = VM_VM_AREA;
>  		va->va_start = (unsigned long)tmp->addr;
>  		va->va_end = va->va_start + tmp->size;
> -- 
> 2.1.4
> 

-- 
Michal Hocko
SUSE Labs
