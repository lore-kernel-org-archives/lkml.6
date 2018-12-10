Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B43EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544448483;
	bh=8y/wS72TrQnG6ceV2uN0AYUwEqq0tkxIHOzdds83f4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tEdSvFxCs1xM2EMLlMPN91SIAtMpuwpmXyldncKJIwlapC9UXSoJVypimFsdxZNNd
	 sFlq2UXNRWemrqWPkewpybF9QwnFftXVpTQ/hgUzt85KoMZLNryHnk8FZu8neeBZdN
	 DS10l+vXvhtqx4Gcd7BbEb1VOrXG3IqOjE5LEGMg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD11720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeLJN2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:28:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbeLJN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:28:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65A55AE0B;
        Mon, 10 Dec 2018 13:28:00 +0000 (UTC)
Date:   Mon, 10 Dec 2018 14:27:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20181210132759.GP1286@dhcp22.suse.cz>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210103641.31259-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 11:36:38, Daniel Vetter wrote:
> Just a bit of paranoia, since if we start pushing this deep into
> callchains it's hard to spot all places where an mmu notifier
> implementation might fail when it's not allowed to.
> 
> Inspired by some confusion we had discussing i915 mmu notifiers and
> whether we could use the newly-introduced return value to handle some
> corner cases. Until we realized that these are only for when a task
> has been killed by the oom reaper.
> 
> An alternative approach would be to split the callback into two
> versions, one with the int return value, and the other with void
> return value like in older kernels. But that's a lot more churn for
> fairly little gain I think.
> 
> Summary from the m-l discussion on why we want something at warning
> level: This allows automated tooling in CI to catch bugs without
> humans having to look at everything. If we just upgrade the existing
> pr_info to a pr_warn, then we'll have false positives. And as-is, no
> one will ever spot the problem since it's lost in the massive amounts
> of overall dmesg noise.

OK, fair enough. If this is going to help with testing then I do not
have any objections of course.

> v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> the problematic case (Michal Hocko).

Thanks!

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  mm/mmu_notifier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 5119ff846769..ccc22f21b735 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -190,6 +190,9 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>  				pr_info("%pS callback failed with %d in %sblockable context.\n",
>  						mn->ops->invalidate_range_start, _ret,
>  						!blockable ? "non-" : "");
> +				if (blockable)
> +					pr_warn("%pS callback failure not allowed\n",
> +						mn->ops->invalidate_range_start);
>  				ret = _ret;
>  			}
>  		}
> -- 
> 2.20.0.rc1
> 

-- 
Michal Hocko
SUSE Labs
